module.exports = mixinDiscovery;

function mixinDiscovery(SAPHANA) {
    var async = require('async');

    function paginateSQL(sql, orderBy, options) {
        options = options || {};
        var limit = '';
        if (options.limit || options.skip || options.offset) {
            limit = ' LIMIT ' + options.limit;
            if (options.offset) {
                limit = limit + ' OFFSET ' + (options.offset || options.skip || 0); // Offset starts from 0
            }
        }
        if (orderBy) {
            sql += ' ORDER BY ' + orderBy;
        }
        return sql + limit;
    }

    /**
     * Build sql for listing tables
     *
     * @param options {all: for all owners, owner: for a given owner}
     * @returns {string} The sql statement
     */
    function queryTables(options) {
        var sqlTables = null;
        var owner = options.owner || options.schema;

        if (options.all && !owner) {
            sqlTables = paginateSQL('SELECT \'table\' AS "type", table_name AS "name", schema_name AS "owner"'
                + ' FROM SYS.TABLES', 'schema_name, table_name', options);
        } else if (owner) {
            sqlTables = paginateSQL('SELECT \'table\' AS "type", table_name AS "name", schema_name AS "owner"'
                + ' FROM SYS.TABLES WHERE schema_name = \'' + owner + '\'', 'schema_name, table_name', options);
        } else {
            sqlTables = paginateSQL('SELECT \'table\' AS "type", table_name AS "name",'
                    + ' schema_name AS "owner" FROM SYS.TABLES WHERE schema_name = current_schema',
                'table_name', options);
        }
        return sqlTables;
    }

    /**
     * Build sql for listing views
     *
     * @param options {all: for all owners, owner: for a given owner}
     * @returns {string} The sql statement
     */
    function queryViews(options) {
        var sqlViews = null;
        if (options.views) {

            var owner = options.owner || options.schema;

            if (options.all && !owner) {
                sqlViews = paginateSQL('SELECT \'view\' AS "type", view_name AS "name",'
                        + ' schema_name AS "owner" FROM SYS.VIEWS',
                    'schema_name, view_name', options);
            } else if (owner) {
                sqlViews = paginateSQL('SELECT \'view\' AS "type", view_name AS "name",'
                        + ' schema_name AS "owner" FROM SYS.VIEWS WHERE schema_name = \'' + owner + '\'',
                    'schema_name, view_name', options);
            } else {
                sqlViews = paginateSQL('SELECT \'view\' AS "type", view_name AS "name",'
                        + ' current_schema AS "owner" FROM SYS.VIEWS',
                    'view_name', options);
            }
        }
        return sqlViews;
    }

    /**
     * Discover model definitions
     *
     * @param {Object} options Options for discovery
     * @param {Function} [cb] The callback function
     */
    SAPHANA.prototype.discoverModelDefinitions = function (options, cb) {
        if (!cb && typeof options === 'function') {
            cb = options;
            options = {};
        }
        options = options || {};

        var self = this;
        var calls = [function (callback) {
            self.query(queryTables(options), callback);
        }];

        if (options.views) {
            calls.push(function (callback) {
                self.query(queryViews(options), callback);
            });
        }
        async.parallel(calls, function (err, data) {
            if (err) {
                cb(err, data);
            } else {
                var merged = [];
                merged = merged.concat(data.shift());
                if (data.length) {
                    merged = merged.concat(data.shift());
                }
                cb(err, merged);
            }
        });
    };

    /**
     * Normalize the arguments
     *
     * @param table string, required
     * @param options object, optional
     * @param cb function, optional
     */
    function getArgs(table, options, cb) {
        if ('string' !== typeof table || !table) {
            throw new Error('table is a required string argument: ' + table);
        }
        options = options || {};
        if (!cb && 'function' === typeof options) {
            cb = options;
            options = {};
        }
        if (typeof options !== 'object') {
            throw new Error('options must be an object: ' + options);
        }
        return {
            owner: options.owner || options.schema,
            table: table,
            options: options,
            cb: cb
        };
    }

    /**
     * Build the sql statement to query columns for a given table
     *
     * @param owner
     * @param table
     * @returns {String} The sql statement
     */
    function queryColumns(owner, table) {
        var sql = null;
        if (owner) {
            sql = paginateSQL('SELECT schema_name AS "owner", table_name AS "tableName", column_name AS "columnName", data_type_name AS "dataType",'
                    + ' length AS "dataLength", scale AS "dataScale", is_nullable AS "nullable"'
                    + ' FROM SYS.TABLE_COLUMNS'
                    + ' WHERE schema_name = \'' + owner + '\''
                    + (table ? ' AND table_name=\'' + table + '\'' : ''),
                'table_name, position', {});
        } else {
            sql = paginateSQL('SELECT current_schema AS "owner", table_name AS "tableName", column_name AS "columnName", data_type_name AS "dataType",'
                    + ' length AS "dataLength", scale AS "dataScale", is_nullable AS "nullable"'
                    + ' FROM SYS.TABLE_COLUMNS'
                    + (table ? ' WHERE table_name = \'' + table + '\'' : ''),
                'table_name, position', {});
        }
        return sql;
    }

    /**
     * Discover model properties from a table
     *
     * @param {String} table The table name
     * @param {Object} options The options for discovery
     * @param {Function} [cb] The callback function
     *
     */
    SAPHANA.prototype.discoverModelProperties = function (table, options, cb) {
        var args = getArgs(table, options, cb);
        var owner = args.owner;
        table = args.table;
        options = args.options;
        cb = args.cb;

        var sql = queryColumns(owner, table);
        var callback = function (err, results) {
            if (err) {
                cb(err, results);
            } else {
                results.map(function (r) {
                    r.type = hdbDataTypeToJSONType(r.dataType, r.dataLength);
                });
                cb(err, results);
            }
        };
        this.query(sql, callback);
    };

    /**
     * Build the sql statement for querying primary keys of a given table
     *
     * @param owner
     * @param table
     * @returns {string}
     */
    function queryForPrimaryKeys(owner, table) {
        var sql = 'SELECT kc.schema_name AS "owner", '
            + 'kc.table_name AS "tableName", kc.column_name AS "columnName",'
            + ' kc.position AS "keySeq",'
            + ' kc.constraint_name AS "pkName" FROM'
            + ' SYS.CONSTRAINTS kc'
            + ' WHERE kc.is_primary_key = \'TRUE\'';

        if (owner) {
            sql += ' AND kc.schema_name = \'' + owner + '\'';
        }
        if (table) {
            sql += ' AND kc.table_name = \'' + table + '\'';
        }
        sql += ' ORDER BY kc.schema_name, kc.table_name, kc.position';
        return sql;
    }

    /**
     * Discover primary keys for a given table
     *
     * @param {String} table The table name
     * @param {Object} options The options for discovery
     * @param {Function} [cb] The callback function
     */
    SAPHANA.prototype.discoverPrimaryKeys = function (table, options, cb) {
        var args = getArgs(table, options, cb);
        var owner = args.owner;
        table = args.table;
        options = args.options;
        cb = args.cb;

        var sql = queryForPrimaryKeys(owner, table);
        this.query(sql, cb);
    };

    /**
     * Build the sql statement for querying foreign keys of a given table
     *
     * @param owner
     * @param table
     * @returns {string}
     */
    function queryForeignKeys(owner, table) {
        var sql =
            'SELECT rc.referenced_schema_name AS "fkOwner", rc.constraint_name AS "fkName", rc.referenced_table_name AS "fkTableName",'
            + ' rc.referenced_column_name AS "fkColumnName", tc.position AS "keySeq",'
            + ' rc.schema_name AS "pkOwner", \'PK\' AS "pkName", '
            + ' rc.table_name AS "pkTableName", rc.column_name AS "pkColumnName"'
            + ' FROM SYS.REFERENTIAL_CONSTRAINTS rc'
            + ' LEFT JOIN SYS.TABLE_COLUMNS AS tc'
            + ' ON rc.schema_name = tc.schema_name';
        if (owner) {
            sql += ' WHERE rc.schema_name =\'' + owner + '\'';
        } else {
            sql += ' WHERE rc.schema_name = current_schema';
        }
        if (table) {
            sql += ' AND rc.table_name = \'' + table + '\'';
        }
        return sql;
    }

    /**
     * Discover foreign keys for a given table
     *
     * @param {String} table The table name
     * @param {Object} options The options for discovery
     * @param {Function} [cb] The callback function
     */
    SAPHANA.prototype.discoverForeignKeys = function (table, options, cb) {
        var args = getArgs(table, options, cb);
        var owner = args.owner;
        table = args.table;
        options = args.options;
        cb = args.cb;

        var sql = queryForeignKeys(owner, table);
        this.query(sql, cb);
    };

    function hdbDataTypeToJSONType(hdbType, dataLength) {
        var type = hdbType.toUpperCase();
        switch (type) {
            case 'BOOLEAN':
                return 'Boolean';
            case 'CHARACTER VARYING':
            case 'VARCHAR':
            case 'CHARACTER':
            case 'TEXT':
                return 'String';
            case 'BYTEA':
                return 'Binary';
            case 'SMALLINT':
            case 'INTEGER':
            case 'BIGINT':
            case 'DECIMAL':
            case 'NUMERIC':
            case 'REAL':
            case 'DOUBLE PRECISION':
            case 'SERIAL':
            case 'BIGSERIAL':
                return 'Number';
            case 'DATE':
            case 'TIMESTAMP':
            case 'TIME':
                return 'Date';
            case 'POINT':
                return 'GeoPoint';
            default:
                return 'String';
        }
    }
}