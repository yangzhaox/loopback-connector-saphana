/*!
 * SAP HANA connector for LoopBack
 */
var hdb = require('hdb');
var SqlConnector = require('loopback-connector').SqlConnector;
var util = require('util');
var async = require('async');
var debug = require('debug')('loopback:connector:hdb');

/**
 * Initialize the SAP HANA connector for the gavin data source
 *
 * @param {DataSource} dataSource The loopback-datasource-juggler dataSource
 * @callback {Function} [callback] The callback function
 */
exports.initialize = function initializeDataSource(dataSource, callback) {
    if (!hdb) {
        return;
    }

    var settings = dataSource.settings || {};
    settings.host = settings.host || settings.hostname || 'localhost';
    settings.user = settings.user || settings.username;
    settings.debug = settings.debug || debug.enabled;

    dataSource.client = hdb.createClient(settings);
    dataSource.client.on('error', function (err) {
        dataSource.emit('error', err);
        dataSource.connected = false;
        dataSource.connecting = false;
    });

    dataSource.connector = new SAPHANA(dataSource.client, settings);
    dataSource.connector.connect(function (err) {
        dataSource.connector.dataSource = dataSource;
        callback && callback(err);
    });
};

/**
 * The constructor of SAP HANA connector
 *
 * @param {Object} client SAPHANA node.js binding
 * @options {Object} settings An object for the data source settings.
 * @constructor
 */
function SAPHANA(client, settings) {
    this.constructor.super_.call(this, 'hdb', settings);
    this.client = client;
    this.settings = settings;
}
SAPHANA.newline = '\r\n';

// Inherit from loopback-datasource-juggler BaseSQL
util.inherits(SAPHANA, SqlConnector);

/**
 * Connect to SAP HANA
 *
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 */
SAPHANA.prototype.connect = function (callback) {
    var self = this;
    if (self.client.readyState === 'connected') {
        return process.nextTick(callback);
    }
    var connection = self.client.connect(function (err) {
        if (err) {
            debug('Connection error: ', err);
            return callback(err);
        }
        debug('Connection established: ', self.settings.server);
        callback(err);
    });
};

/**
 * Create a new model instance in SAP HANA
 *
 * @param {String} model The model name
 * @param {Object} data The model instance data
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 * @param (*} id The id of newly inserted model instance
 */
SAPHANA.prototype.create = function (model, data, callback) {
    var self = this;
    var fieldsAndData = this.buildInsertAndUpdate(model, data);
    var tblName = this.tableEscaped(model);
    var sql = 'INSERT INTO ' + tblName + ' (' + fieldsAndData.fields + ')' + SAPHANA.newline;
    sql += 'VALUES (' + fieldsAndData.paramPlaceholders + ')' + SAPHANA.newline;

    self.query(sql, fieldsAndData.params, function (err, results) {
        if (err) {
            return callback(err);
        }
        sql = 'SELECT ' + self.seqEscaped(model) + '.CURRVAL AS "insertId" ' + 'FROM DUMMY' + SAPHANA.newline;
        self.query(sql, function (err, results) {
            if (err) {
                return callback(err);
            }
            callback(null, results[0].insertId);
        });
    });
};

/**
 * Save a model instance to SAP HANA
 *
 * @param {String} model The model name
 * @param {Object} data The model instance data
 * @callback {Function} [callback] The callback function
 */
SAPHANA.prototype.save = function (model, data, callback) {
    this.updateOrCreate(model, data, callback);
};

/**
 * Check if a model instance exists by id
 *
 * @param {String} model The model name
 * @param {*} id The id value
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 * @param {Boolean} true if the id exists
 *
 */
SAPHANA.prototype.exists = function (model, id, callback) {
    var sql = 'SELECT 1 FROM ' + this.tableEscaped(model) + SAPHANA.newline;
    if (id) {
        sql += ' WHERE ' + this.idColumnEscaped(model) + ' = ' + id + ' LIMIT 1';
    } else {
        sql += ' WHERE ' + this.idColumnEscaped(model) + ' IS NULL LIMIT 1';
    }
    sql += SAPHANA.newline;

    this.query(sql, function (err, data) {
        if (err) {
            return callback(err);
        }
        callback(null, data.length === 1);
    });
};

/**
 * Find a model instance by id
 *
 * @param {String} model The model name
 * @param {*} id The id value
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 * @param {Object} The model instance
 */
SAPHANA.prototype.find = function find(model, id, callback) {
    var sql = 'SELECT * FROM ' + this.tableEscaped(model) + SAPHANA.newline;

    if (id) {
        var idVal = this.toDatabase(this._models[model].properties[this.idName(model)], id);
        sql += ' WHERE ' + this.idColumnEscaped(model) + ' = ' + idVal + ' LIMIT 1';
    }
    else {
        sql += ' WHERE ' + this.idColumnEscaped(model) + ' IS NULL LIMIT 1';
    }
    sql += SAPHANA.newline;

    this.query(sql, function (err, data) {
        if (data && data.length === 1) {
            // data[0][this.idColumn(model)] = id;
        } else {
            data = [null];
        }
        callback(err, this.fromDatabase(model, data[0]));
    }.bind(this));
};

/**
 * Find matching model instances by the filter
 *
 * @param {String} model The model name
 * @param {Object} filter The filter
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 * @param {Object[]} The matched model instances
 */
SAPHANA.prototype.all = function all(model, filter, callback) {
    // Order by id if no order is specified
    filter = filter || {};
    if (!filter.order) {
        var idNames = this.idNames(model);
        if (idNames && idNames.length) {
            filter.order = idNames;
        }
    }

    this.query('SELECT ' + this.getColumns(model, filter.fields) + '  FROM '
        + this.toFilter(model, filter), function (err, data) {
        if (err) {
            return callback(err, []);
        }
        if (data) {
            for (var i = 0; i < data.length; i++) {
                data[i] = this.fromDatabase(model, data[i]);
            }
        }
        if (filter && filter.include) {
            this._models[model].model.include(data, filter.include, callback);
        } else {
            callback(null, data);
        }
    }.bind(this));
};

/**
 * Count the number of instances for the given model
 *
 * @param {String} model The model name
 * @param {Function} [callback] The callback function
 * @param {Object} filter The filter for where
 *
 */
SAPHANA.prototype.count = function count(model, callback, filter) {
    this.query('SELECT count(*) as "cnt"  FROM '
        + ' ' + this.toFilter(model, filter && {where: filter}), function (err, data) {
        if (err) return callback(err);
        var c = data && data[0] && data[0].cnt;
        callback(err, Number(c));
    }.bind(this));
};

/**
 * Update if the model instance exists with the same id or create a new instance
 *
 * @param {String} model The model name
 * @param {Object} data The model instance data
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 * @param {Object} data The updated or created model instance
 */
SAPHANA.prototype.updateOrCreate = function (model, data, callback) {
    var self = this;
    var fieldsAndData = this.buildInsertAndUpdate(model, data);
    var props = this._models[model].properties;
    var tblName = this.tableEscaped(model);
    var modelPKID = this.idName(model);
    //get the correct id of the item using the pkid that they specified
    var id = data[modelPKID];

    var sql = '';
    self.exists(model, id, function (err, yn) {
        if (err) {
            return callback(err);
        }
        if (yn) {
            sql = 'UPDATE ' + tblName + SAPHANA.newline;
            sql += 'SET ' + fieldsAndData.combined + SAPHANA.newline;
            sql += 'WHERE "' + modelPKID + '" = ?' + SAPHANA.newline;
            fieldsAndData.updateParams.push(id);
            doQuery(sql, fieldsAndData.updateParams);
        } else {
            sql = 'INSERT INTO ' + tblName + ' (' + fieldsAndData.fields + ')' + SAPHANA.newline;
            sql += 'VALUES (' + fieldsAndData.paramPlaceholders + ')' + SAPHANA.newline;
            doQuery(sql, fieldsAndData.params);
        }
    });

    var doQuery = function (sql, fieldValues) {
        self.query(sql, fieldValues, function (err, results) {
            if (err) {
                return callback(err);
            }
            data[modelPKID] = id;
            //#jdb id compatibility#
            data.id = id; //set the id property also, to play nice
            // with the jugglingdb abstract class implementation.
            callback(err, data);
        });
    };
};


/**
 * Update model instances
 *
 * @param {String} model The model name
 * @param {String|String[]} where The where clause string or array
 * @param {Object} data The model instance data
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 * @param {Object[]} The matched model instances
 */
SAPHANA.prototype.update = function (model, where, data, callback) {
    var self = this;
    var fieldsAndData = this.buildInsertAndUpdate(model, data);
    var props = this._models[model].properties;
    var tblName = this.tableEscaped(model);
    var modelPKID = this.idName(model);
    //get the correct id of the item using the pkid that they specified
    var id = data[modelPKID];
    var whereClause = this.buildWhere(model, where);

    var sql = 'UPDATE ' + tblName + SAPHANA.newline;
    sql += 'SET ' + fieldsAndData.combined + SAPHANA.newline;
    sql += whereClause + SAPHANA.newline;

    self.query(sql, fieldsAndData.updateParams, function (err, data) {
        if (err) {
            return callback(err);
        }
        data[modelPKID] = id;
        //#jdb id compatibility#
        data.id = id; //set the id property also, to play nice
        // with the jugglingdb abstract class implementation.
        callback(err, data);
    });
};

SAPHANA.prototype.updateAll = SAPHANA.prototype.update;

/**
 * Delete a instance for the given model
 *
 * @param {String} model The model name
 * @param {*} id The id value
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 */
SAPHANA.prototype.destroy = function destroyAll(model, id, callback) {
    var sql = 'DELETE FROM ' + this.tableEscaped(model) + SAPHANA.newline;
    sql += 'WHERE "' + this.idName(model) + '" = ?' + SAPHANA.newline;
    this.query(sql, [id], function (err, data) {
        if (err) {
            return callback && callback(err);
        }
        callback && callback(null);
    });
};

/**
 * Delete instances for the given model
 *
 * @param {String} model The model name
 * @param {Object} [where] The filter for where
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 */
SAPHANA.prototype.destroyAll = function destroyAll(model, where, callback) {
    if (!callback && 'function' === typeof where) {
        callback = where;
        where = undefined;
    }
    var sql = 'DELETE FROM ' + this.toFilter(model, where && {where: where}) + SAPHANA.newline;
    this.query(sql, function (err, data) {
        if (err) {
            return callback(err);
        }
        callback && callback(err, data);
    });
};

/**
 * Execute a sql statement with the given parameters
 *
 * @param {String} sql The SQL statement
 * @param {[]|Function} optionsOrCallback An array of parameter values or callback
 * @callback {Function} callback or null
 * @param {String|Error} err The error string or object
 * @param {Object[]} data The array of object returned
 */
SAPHANA.prototype.query = function (sql, optionsOrCallback, callback) {
    //debugger;
    var hasOptions = true;
    var options = null;
    var cb = null;
    if (typeof optionsOrCallback === "function") {
        hasOptions = false;
        cb = optionsOrCallback;
    } else {
        options = optionsOrCallback;
        cb = callback;
    }
    if (hasOptions) {
        sql = format(sql, options);
    }
    debug('SQL: %s %j', sql, options);
    if (!this.dataSource.connected) {
        return this.dataSource.once('connected', function () {
            this.query(sql, cb);
        }.bind(this));
    }
    var time = Date.now();
    var log = this.log;
    if (typeof cb !== 'function') {
        throw new Error('callback should be a function');
    }

    this.client.exec(sql, cb);
};

/**
 * Build insert and update clause
 *
 * @param {String} model The model name
 * @param {Object} data The data
 * @returns {{fields: string, paramPlaceholders: string, params: Array, combined: string, updateParams: Array}}
 */
SAPHANA.prototype.buildInsertAndUpdate = function (model, data) {
    var self = this;
    var insertIntoFields = [];
    var paramPlaceholders = [];
    var params = [];
    var updateSetCombined = [];
    var updateParams = [];
    var props = this._models[model].properties;

    Object.keys(data).forEach(function (key) {
        if (props[key]) {
            insertIntoFields.push(self.columnEscaped(model, key));
            paramPlaceholders.push('?');
            if (key === self.idName(model)) {
                if (data[key]) {
                    params.push(self.toDatabase(props[key], data[key]));
                } else {
                    params.push(self.seqEscaped(model) + '.NEXTVAL');
                }

            } else {
                params.push(self.toDatabase(props[key], data[key]));
                updateSetCombined.push(self.columnEscaped(model, key) + ' = ?');
                updateParams.push(self.toDatabase(props[key], data[key]));
            }
        }
    }.bind(this));

    return { fields: insertIntoFields.join(),
        paramPlaceholders: paramPlaceholders.join(),
        params: params,
        combined: updateSetCombined.join(),
        updateParams: updateParams };
};

/**
 * This is a workaround to the limitation that SAP HANA driver doesn't support
 * parameterized SQL execution
 * @param {String} sql The SQL string with parameters as (?)
 * @param {*[]} params An array of parameter values
 * @returns {*} The fulfilled SQL string
 */
function format(sql, params) {
    if (Array.isArray(params)) {
        var count = 0;
        var index = -1;
        while (count < params.length) {
            index = sql.indexOf('?');
            if (index === -1) {
                return sql;
            }
            sql = sql.substring(0, index) + params[count] + sql.substring(index + 1);
            count++;
        }
    }
    return sql;
}

function dateToSAPHANA(val, dateOnly) {
    function fz(v) {
        return v < 10 ? '0' + v : v;
    }

    function ms(v) {
        if (v < 10) {
            return '00' + v;
        } else if (v < 100) {
            return '0' + v;
        } else {
            return '' + v;
        }
    }

    var dateStr = [
        val.getUTCFullYear(),
        fz(val.getUTCMonth() + 1),
        fz(val.getUTCDate())
    ].join('-') + ' ' + [
        fz(val.getUTCHours()),
        fz(val.getUTCMinutes()),
        fz(val.getUTCSeconds())
    ].join(':');

    if (!dateOnly) {
        dateStr += '.' + ms(val.getMilliseconds());
    }

    if (dateOnly) {
        return "to_seconddate('" + dateStr + "', 'yyyy-mm-dd hh24:mi:ss')";
    } else {
        return "to_timestamp('" + dateStr + "', 'yyyy-mm-dd hh24:mi:ss.ff3')";
    }

}

/**
 * Convert name/value to database value
 *
 * @param {String} prop The property name
 * @param {*} val The property value
 */
SAPHANA.prototype.toDatabase = function (prop, val) {
    if (val === null || val === undefined) {
        // SAPHANA complains with NULLs in not null columns
        // If we have an autoincrement value, return DEFAULT instead
        if (prop.autoIncrement) {
            return 'DEFAULT';
        }
        else {
            return 'NULL';
        }
    }
    if (val.constructor.name === 'Object') {
        if (prop.hdb && prop.hdb.dataType === 'json') {
            return JSON.stringify(val);
        }
        var operator = Object.keys(val)[0];
        val = val[operator];
        if (operator === 'between') {
            return this.toDatabase(prop, val[0]) + ' AND ' + this.toDatabase(prop, val[1]);
        }
        if (operator === 'inq' || operator === 'nin') {
            for (var i = 0; i < val.length; i++) {
                val[i] = escape(val[i]);
            }
            return val.join(',');
        }
        return this.toDatabase(prop, val);
    }
    if (prop.type.name === 'Number') {
        if (!val && val !== 0) {
            if (prop.autoIncrement) {
                return 'DEFAULT';
            }
            else {
                return 'NULL';
            }
        }
        return val;
    }

    if (prop.type.name === 'Date' || prop.type.name === 'Timestamp') {
        if (!val) {
            if (prop.autoIncrement) {
                return 'DEFAULT';
            }
            else {
                return 'NULL';
            }
        }
        if (!val) {
            if (prop.autoIncrement) {
                return 'DEFAULT';
            }
            else {
                return 'NULL';
            }
        }
        if (!val.toUTCString) {
            val = new Date(val);
        }
        return dateToSAPHANA(val, prop.type.name === 'Date');
    }

    // SAP HANA supports char(1) X/Space
    if (prop.type.name === 'Boolean') {
        if (val) {
            return '\'X\'';
        } else {
            return '\' \'';
        }
    }

    if (prop.type.name === 'GeoPoint') {
        if (val) {
            return '(' + val.lat + ',' + val.lng + ')';
        } else {
            return 'NULL';
        }
    }

    return "'" + escape(val.toString()) + "'";

};

/**
 * Convert the data from database to JSON
 *
 * @param {String} model The model name
 * @param {Object} data The data from DB
 */
SAPHANA.prototype.fromDatabase = function (model, data) {
    if (!data) {
        return null;
    }

    var props = this._models[model].properties;
    var reverseMap = this.buildReverseColumnMap(props);

    //look for date values in the data, convert them from the database to a javascript date object
    Object.keys(data).forEach(function (key) {
        var val = data[key];
        if (props[key]) {
            if (props[key].type.name === 'Boolean') {
                if (val !== null) {
                    val = true;
                } else {
                    val = false;
                }
            }
            if (props[key].type.name === 'Date' && val !== null) {
                if (!(val instanceof Date)) {
                    val = new Date(val.toString());
                }
            }
        }

        // Delete database value and map it to correct model property.
        delete data[key];
        data[reverseMap[key]] = val;
    });
    return data;
};

/**
 * Builds a reverse map that can be used to map database columns to JSON properties
 *
 * @param {Object} model properties
 */
SAPHANA.prototype.buildReverseColumnMap = function (modelProperties) {
    var map = {};

    for (var prop in modelProperties) {
        if (modelProperties[prop].hdb !== undefined && modelProperties[prop].hdb.columnName !== undefined) {
            map[modelProperties[prop].hdb.columnName] = prop;
        } else {
            map[prop] = prop;
        }
    }

    return map;
};

/**
 * Convert to the Database name
 *
 * @param {String} name The name
 * @returns {String} The converted name
 */
SAPHANA.prototype.dbName = function (name) {
    if (!name) {
        return name;
    }
    // SAP HANA default to lowercase names
    return name;
};

/**
 * Escape the name for SAP HANA
 *
 * @param {String} name The name
 * @returns {String} The escaped name
 */
SAPHANA.prototype.escapeName = function (name) {
    if (!name) {
        return name;
    }
    return '"' + name.replace(/\./g, '"."') + '"';
};

/**
 * Get the escaped schema name for SAP HANA
 *
 * @param {String} model The model name
 * @returns {String} The escaped schema name
 */
SAPHANA.prototype.schemaName = function (model) {
    // Check if there is a 'schema' property for hdb
    var dbMeta = this._models[model].settings && this._models[model].settings.hdb;
    var schemaName = (dbMeta && (dbMeta.schema || dbMeta.schemaName))
        || this.settings.schema || this.settings.user;
    return schemaName;
};

/**
 * Get the escaped table name for SAP HANA
 *
 * @param {String} model The model name
 * @returns {string} The escaped schema name
 */
SAPHANA.prototype.tableEscaped = function (model) {
    return this.escapeName(this.schemaName(model)) + '.' + this.escapeName(this.table(model));
};


/**
 * Get the escaped sequence name for SAP HANA
 *
 * @param {String} model The model name
 * @returns {string} The escaped sequence name
 */
SAPHANA.prototype.seqEscaped = function (model) {
    return this.escapeName(this.schemaName(model)) + '.' + this.escapeName(this.table(model) + 'Seq');
};

/*!
 * Get a list of columns based on the fields pattern
 *
 * @param {String} model The model name
 * @param {Object|String[]} props Fields pattern
 * @returns {String}
 */
SAPHANA.prototype.getColumns = function (model, props) {
    var cols = this._models[model].properties;
    var self = this;
    var keys = Object.keys(cols);
    if (Array.isArray(props) && props.length > 0) {
        // No empty array, including all the fields
        keys = props;
    } else if ('object' === typeof props && Object.keys(props).length > 0) {
        // { field1: boolean, field2: boolean ... }
        var included = [];
        var excluded = [];
        keys.forEach(function (k) {
            if (props[k]) {
                included.push(k);
            } else if ((k in props) && !props[k]) {
                excluded.push(k);
            }
        });
        if (included.length > 0) {
            keys = included;
        } else if (excluded.length > 0) {
            excluded.forEach(function (e) {
                var index = keys.indexOf(e);
                keys.splice(index, 1);
            });
        }
    }
    var names = keys.map(function (c) {
        return self.columnEscaped(model, c);
    });
    return names.join(', ');
};

function getPagination(filter) {
    var pagination = [];
    if (filter && (filter.limit || filter.offset || filter.skip)) {
        var offset = Number(filter.offset);
        if (!offset) {
            offset = Number(filter.skip);
        }
        var limit = Number(filter.limit);
        if (limit) {
            pagination.push('LIMIT ' + limit);
        }
        if (offset) {
            pagination.push('OFFSET ' + offset);
        } else {
            offset = 0;
        }
    }
    return pagination;
}

SAPHANA.prototype.buildWhere = function (model, conds) {
    var where = this._buildWhere(model, conds);
    if (where) {
        return ' WHERE ' + where;
    } else {
        return '';
    }
};

SAPHANA.prototype._buildWhere = function (model, conds) {
    if (!conds) {
        return '';
    }
    var self = this;
    var props = self._models[model].properties;
    var fields = [];
    if (typeof conds === 'string') {
        fields.push(conds);
    } else if (util.isArray(conds)) {
        var query = conds.shift().replace(/\?/g, function (s) {
            return escape(conds.shift());
        });
        fields.push(query);
    } else {
        var sqlCond = null;
        Object.keys(conds).forEach(function (key) {
            if (key === 'and' || key === 'or') {
                var clauses = conds[key];
                if (Array.isArray(clauses)) {
                    clauses = clauses.map(function (c) {
                        return self._buildWhere(model, c);
                    });
                    return fields.push('(' + clauses.join(' ' + key.toUpperCase() + ' ') + ')');
                }
                // The value is not an array, fall back to regular fields
            }
            if (conds[key] && conds[key].constructor.name === 'RegExp') {
                var regex = conds[key];
                sqlCond = self.columnEscaped(model, key);

                if (regex.ignoreCase) {
                    sqlCond += ' ~* ';
                } else {
                    sqlCond += ' ~ ';
                }

                sqlCond += "'" + regex.source + "'";

                fields.push(sqlCond);

                return;
            }
            if (props[key]) {
                var filterValue = self.toDatabase(props[key], conds[key]);
                if (filterValue === 'NULL') {
                    fields.push(self.columnEscaped(model, key) + ' IS ' + filterValue);
                } else if (conds[key].constructor.name === 'Object') {
                    var condType = Object.keys(conds[key])[0];
                    sqlCond = self.columnEscaped(model, key);
                    if ((condType === 'inq' || condType === 'nin') && filterValue.length === 0) {
                        fields.push(condType === 'inq' ? '1 = 2' : '1 = 1');
                        return true;
                    }
                    switch (condType) {
                        case 'gt':
                            sqlCond += ' > ';
                            break;
                        case 'gte':
                            sqlCond += ' >= ';
                            break;
                        case 'lt':
                            sqlCond += ' < ';
                            break;
                        case 'lte':
                            sqlCond += ' <= ';
                            break;
                        case 'between':
                            sqlCond += ' BETWEEN ';
                            break;
                        case 'inq':
                            sqlCond += ' IN ';
                            break;
                        case 'nin':
                            sqlCond += ' NOT IN ';
                            break;
                        case 'neq':
                            sqlCond += ' != ';
                            break;
                        case 'like':
                            sqlCond += ' LIKE ';
                            filterValue += "ESCAPE '\\'";
                            break;
                        case 'nlike':
                            sqlCond += ' NOT LIKE ';
                            filterValue += "ESCAPE '\\'";
                            break;
                        default:
                            sqlCond += ' ' + condType + ' ';
                            break;
                    }
                    sqlCond += (condType === 'inq' || condType === 'nin')
                        ? '(' + filterValue + ')' : filterValue;
                    fields.push(sqlCond);
                } else {
                    fields.push(self.columnEscaped(model, key) + ' = ' + filterValue);
                }
            }
        });
    }
    return fields.join(' AND ');
};

/**
 * Build the SQL clause
 * @param {String} model The model name
 * @param {Object} filter The filter
 * @returns {*}
 */
SAPHANA.prototype.toFilter = function (model, filter) {
    var self = this;
    if (filter && typeof filter.where === 'function') {
        return self.tableEscaped(model) + ' ' + filter.where();
    }
    if (!filter) {
        return self.tableEscaped(model);
    }
    var out = self.tableEscaped(model) + ' ';

    var where = self.buildWhere(model, filter.where);
    if (where) {
        out += where;
    }

    var pagination = getPagination(filter);

    if (filter.order) {
        var order = filter.order;
        if (typeof order === 'string') {
            order = [order];
        }
        var orderBy = '';
        filter.order = [];
        for (var i = 0, n = order.length; i < n; i++) {
            var t = order[i].split(/[\s]+/);
            var field = t[0], dir = t[1];
            filter.order.push(self.columnEscaped(model, field) + (dir ? ' ' + dir : ''));
        }
        orderBy = ' ORDER BY ' + filter.order.join(',');
        if (pagination.length) {
            out = out + ' ' + orderBy + ' ' + pagination.join(' ');
        } else {
            out = out + ' ' + orderBy;
        }
    } else {
        if (pagination.length) {
            out = out + ' '
                + pagination.join(' ');
        }
    }
    return out;
};

/*!
 * Discover the properties from a table
 * @param {String} model The model name
 * @param {Function} cb The callback function
 */
function getTableStatus(model, cb) {
    function decoratedCallback(err, data) {
        if (err) {
            console.error(err);
        }
        if (!err) {
            data.forEach(function (field) {
                field.type = mapSAPHANADatatypes(field.type);
            });
        }
        cb(err, data);
    }

    this.query('SELECT column_name AS "column", data_type_name AS "type", is_nullable AS "nullable"' // , data_default AS "Default"'
        + ' FROM "SYS"."TABLE_COLUMNS"'
        + ' WHERE table_name=\'' + this.table(model) + '\'', decoratedCallback);

}

/**
 * Perform autoupdate for the given models
 *
 * @param {String[]} [models] A model name or an array of model names. If not present, apply to all models
 * @callback {Function} [callback] The callback function
 * @param {String|Error} err The error string or object
 */
SAPHANA.prototype.autoupdate = function (models, cb) {
    var self = this;
    if ((!cb) && ('function' === typeof models)) {
        cb = models;
        models = undefined;
    }
    // First argument is a model name
    if ('string' === typeof models) {
        models = [models];
    }

    models = models || Object.keys(this._models);

    async.each(models, function (model, done) {
        if (!(model in self._models)) {
            return process.nextTick(function () {
                done(new Error('Model not found: ' + model));
            });
        }
        getTableStatus.call(self, model, function (err, fields) {
            if (!err && fields.length) {
                self.alterTable(model, fields, done);
            } else {
                self.createTable(model, done);
            }
        });
    }, cb);
};

/**
 * Check if the models exist
 *
 * @param {String[]} [models] A model name or an array of model names. If not present, apply to all models
 * @param {Function} [cb] The callback function
 */
SAPHANA.prototype.isActual = function (models, cb) {
    var self = this;

    if ((!cb) && ('function' === typeof models)) {
        cb = models;
        models = undefined;
    }
    // First argument is a model name
    if ('string' === typeof models) {
        models = [models];
    }

    models = models || Object.keys(this._models);

    var changes = [];
    async.each(models, function (model, done) {
        getTableStatus.call(self, model, function (err, fields) {
            changes = changes.concat(getAddColumns.call(self, model, fields));
            changes = changes.concat(getModifyColumns.call(self, model, fields));
            changes = changes.concat(getDropColumns.call(self, model, fields));
            done(err);
        });
    }, function done(err) {
        if (err) {
            return cb && cb(err);
        }
        var actual = (changes.length === 0);
        cb && cb(null, actual);
    });
};

/**
 * Alter the table for the given model
 *
 * @param {String} model The model name
 * @param {Object[]} actualFields Actual columns in the table
 * @param {Function} [cb] The callback function
 */
SAPHANA.prototype.alterTable = function (model, actualFields, cb) {
    var self = this;

    var addChanges = getAddColumns.call(self, model, actualFields);
    if (addChanges.length > 0) {
        applySqlChanges.call(self, model, addChanges, function (err, results) {
            var modifyChanges = getModifyColumns.call(self, model, actualFields);
            if (modifyChanges.length > 0) {
                applySqlChanges.call(self, model, modifyChanges, function (err, results) {
                    var dropColumns = getDropColumns.call(self, model, actualFields);
                    if (dropColumns.length > 0) {
                        applySqlChanges.call(self, model, dropColumns, cb);
                    } else {
                        cb && cb(err, results);
                    }
                });
            } else {
                cb && cb(err, results);
            }
        });
    } else {
        var modifyChanges = getModifyColumns.call(self, model, actualFields);
        if (modifyChanges.length > 0) {
            applySqlChanges.call(self, model, modifyChanges, function (err, results) {
                var dropColumns = getDropColumns.call(self, model, actualFields);
                if (dropColumns.length > 0) {
                    applySqlChanges.call(self, model, dropColumns, cb);
                } else {
                    cb && cb(err, results);
                }
            });
        }
        else {
            var dropColumns = getDropColumns.call(self, model, actualFields);
            if (dropColumns.length > 0) {
                applySqlChanges.call(self, model, dropColumns, cb);
            } else {
                cb && process.nextTick(cb.bind(null, null, []));
            }
        }
    }
};

function getAddColumns(model, actualFields) {
    var sql = [];
    var self = this;
    sql = sql.concat(getColumnsToAdd.call(self, model, actualFields));
    return sql;
}

function getModifyColumns(model, actualFields) {
    var sql = [];
    var self = this;
    var drops = getPropertiesToModify.call(self, model, actualFields);
    if (drops.length > 0) {
        if (sql.length > 0) {
            sql = sql.concat(', ');
        }
        sql = sql.concat(drops);
    }
    return sql;
}

function getDropColumns(model, actualFields) {
    var sql = [];
    var self = this;
    sql = sql.concat(getColumnsToDrop.call(self, model, actualFields));
    return sql;
}

function getColumnsToAdd(model, actualFields) {
    var self = this;
    var m = self._models[model];
    var propNames = Object.keys(m.properties);
    var sql = [];
    propNames.forEach(function (propName) {
        if (self.id(model, propName)) return;
        var found = searchForPropertyInActual.call(self, model, self.column(model, propName), actualFields);
        if (!found && propertyHasNotBeenDeleted.call(self, model, propName)) {
            sql.push(addPropertyToActual.call(self, model, propName));
        }
    });
    if (sql.length > 0) {
        sql = ['ADD (' + sql.join(', ') + ')'];
    }
    return sql;
}

function addPropertyToActual(model, propName) {
    var self = this;
    var sqlCommand = self.columnEscaped(model, propName)
        + ' ' + self.columnDataType(model, propName) + (propertyCanBeNull.call(self, model, propName) ? "" : " NOT NULL");
    return sqlCommand;
}

function searchForPropertyInActual(model, propName, actualFields) {
    var self = this;
    var found = false;
    actualFields.forEach(function (f) {
        if (f.column === self.column(model, propName)) {
            found = f;
            return;
        }
    });
    return found;
}

function getPropertiesToModify(model, actualFields) {
    var self = this;
    var sql = [];
    var m = self._models[model];
    var propNames = Object.keys(m.properties);
    var found;

    propNames.forEach(function (propName) {
        if (self.id(model, propName)) {
            return;
        }
        found = searchForPropertyInActual.call(self, model, propName, actualFields);
        if (found && propertyHasNotBeenDeleted.call(self, model, propName)) {
            if (datatypeChanged(propName, found)) {
                sql.push(modifyDatatypeInActual.call(self, model, propName));
            }
            if (nullabilityChanged(propName, found)) {
                sql.push(modifyNullabilityInActual.call(self, model, propName));
            }
        }
    });

    if (sql.length > 0) {

        sql = ['ALTER ( ' + sql.join(', ') + ' )'];
    }

    return sql;

    function datatypeChanged(propName, oldSettings) {
        var newSettings = m.properties[propName];
        if (!newSettings) {
            return false;
        }
        return oldSettings.type.toUpperCase() !== self.columnDataType(model, propName);
    }

    function nullabilityChanged(propName, oldSettings) {
        var newSettings = m.properties[propName];
        if (!newSettings) {
            return false;
        }
        var changed = false;
        if (oldSettings.nullable === 'Y' && (newSettings.allowNull === false || newSettings.null === false)) changed = true;
        if (oldSettings.nullable === 'N' && !(newSettings.allowNull === false || newSettings.null === false)) changed = true;
        return changed;
    }
}

function modifyDatatypeInActual(model, propName) {
    var self = this;
    var sqlCommand = self.columnEscaped(model, propName) + ' ' + self.columnDataType(model, propName);
    return sqlCommand;
}

function modifyNullabilityInActual(model, propName) {
    var self = this;
    var sqlCommand = self.columnEscaped(model, propName) + ' ';
    if (propertyCanBeNull.call(self, model, propName)) {
        sqlCommand = sqlCommand + "DROP ";
    } else {
        sqlCommand = sqlCommand + "SET ";
    }
    sqlCommand = sqlCommand + "NOT NULL";
    return sqlCommand;
}

function getColumnsToDrop(model, actualFields) {
    var self = this;
    var sql = [];
    actualFields.forEach(function (actualField) {
        if (self.idColumn(model) === actualField.column) {
            return;
        }
        if (actualFieldNotPresentInModel(actualField, model)) {
            sql.push(self.escapeName(actualField.column));
        }
    });
    if (sql.length > 0) {
        sql = ['DROP ( ' + sql.join(', ') + ' )'];
    }
    return sql;

    function actualFieldNotPresentInModel(actualField, model) {
        return !(self.propertyName(model, actualField.column));
    }
}

function applySqlChanges(model, pendingChanges, cb) {
    var self = this;
    if (pendingChanges.length) {
        var thisQuery = 'ALTER TABLE ' + self.tableEscaped(model);
        var ranOnce = false;
        pendingChanges.forEach(function (change) {
            if (ranOnce) {
                thisQuery = thisQuery + ' ';
            }
            thisQuery = thisQuery + ' ' + change;
            ranOnce = true;
        });
        // thisQuery = thisQuery + ';';
        self.query(thisQuery, cb);
    }
}

/**
 * Build a list of columns for the given model
 *
 * @param {String} model The model name
 * @returns {String}
 */
SAPHANA.prototype.propertiesSQL = function (model) {
    var self = this;
    var sql = [];
    var pks = this.idNames(model).map(function (i) {
        return self.columnEscaped(model, i);
    });
    Object.keys(this._models[model].properties).forEach(function (prop) {
        var colName = self.columnEscaped(model, prop);
        sql.push(colName + ' ' + self.propertySettingsSQL(model, prop));
    });
    if (pks.length > 0) {
        sql.push('PRIMARY KEY(' + pks.join(',') + ')');
    }
    return sql.join(',\n  ');

};

/**
 * Build settings for the model property
 *
 * @param {String} model The model name
 * @param {String} propName The property name
 * @returns {*|string}
 */
SAPHANA.prototype.propertySettingsSQL = function (model, propName) {
    var self = this;
    if (this.id(model, propName) && this._models[model].properties[propName].generated) {
        return 'INTEGER';
    }
    var result = self.columnDataType(model, propName);
    if (!propertyCanBeNull.call(self, model, propName)) result = result + ' NOT NULL';
    return result;
};

/**
 * Drop a table for the given model
 *
 * @param {String} model The model name
 * @param {Function} [cb] The callback function
 */
SAPHANA.prototype.dropTable = function (model, cb) {
    var self = this;
    var name = self.tableEscaped(model);
    var sql = 'DROP TABLE ' + name + ' CASCADE' + SAPHANA.newline;
    self.query(sql, function (err, data) {
        if (err) {
            return cb(err);
        }
        if (self._models[model].properties['id'].generated) {
            sql = 'DROP SEQUENCE ' + self.seqEscaped(model) + SAPHANA.newline;
            self.query(sql, function (err, data) {
                if (err) {
                    return cb(err);
                }
                cb(err, data);
            });
        } else {
            cb(err, data);
        }
    });
};

/**
 * Create a table for the given model
 *
 * @param {String} model The model name
 * @param {Function} [cb] The callback function
 */
SAPHANA.prototype.createTable = function (model, cb) {
    var self = this;
    var name = self.tableEscaped(model);
    var sql = 'CREATE COLUMN TABLE ' + name + ' (\n  ' + self.propertiesSQL(model) + '\n)' + SAPHANA.newline;
    self.query(sql, function (err, data) {
        if (err) {
            return cb(err);
        }
        if (self._models[model].properties['id'].generated) {
            sql = 'CREATE SEQUENCE ' + self.seqEscaped(model) + SAPHANA.newline;
            self.query(sql, function (err, data) {
                if (err) {
                    return cb(err);
                }
                cb(err, data);
            });
        } else {
            cb(err, data);
        }
    });
};

/**
 * Disconnect from SAP HANA
 * @param {Function} [cb] The callback function
 */
SAPHANA.prototype.disconnect = function disconnect(cb) {
    if (this.connection) {
        if (this.settings.debug) {
            this.debug('Disconnecting from ' + this.settings.hostname);
        }
        var conn = this.connection;
        this.connection = null;
        conn.end();  // This is sync
    }

    if (cb) {
        process.nextTick(function () {
            cb && cb();
        });
    }
};

/**
 * Ping to SAP HANA
 * @param {Function} [cb] The callback function
 */
SAPHANA.prototype.ping = function (cb) {
    this.query('SELECT 1 AS result FROM DUMMY', [], cb);
};

function propertyCanBeNull(model, propName) {
    var p = this._models[model].properties[propName];
    return !(p.allowNull === false || p['null'] === false);
}

function escape(val) {
    if (val === undefined || val === null) {
        return 'NULL';
    }

    switch (typeof val) {
        case 'boolean':
            return (val) ? "true" : "false";
        case 'number':
            return val + '';
    }

    if (typeof val === 'object') {
        val = (typeof val.toISOString === 'function')
            ? val.toISOString()
            : val.toString();
    }

    val = val.replace(/[\0\n\r\b\t\\\'\"\x1a]/g, function (s) {
        switch (s) {
            case "\0":
                return "\\0";
            case "\n":
                return "\\n";
            case "\r":
                return "\\r";
            case "\b":
                return "\\b";
            case "\t":
                return "\\t";
            case "\x1a":
                return "\\Z";
            case "\'":
                return "''"; // For hdb
            case "\"":
                return s; // For hdb
            default:
                return "\\" + s;
        }
    });
    // return "q'#"+val+"#'";
    return val;
}

/*!
 * Find the column type for a given model property
 *
 * @param {String} model The model name
 * @param {String} property The property name
 * @returns {String} The column type
 */
SAPHANA.prototype.columnDataType = function (model, property) {
    var columnMetadata = this.columnMetadata(model, property);
    var colType = columnMetadata && columnMetadata.dataType;
    if (colType) {
        colType = colType.toUpperCase();
    }
    var prop = this._models[model].properties[property];
    if (!prop) {
        return null;
    }
    var colLength = columnMetadata && columnMetadata.dataLength || prop.length;
    if (colType) {
        return colType + (colLength ? '(' + colLength + ')' : '');
    }

    switch (prop.type.name) {
        default:
        case 'String':
        case 'JSON':
            return 'VARCHAR' + (colLength ? '(' + colLength + ')' : '(1024)');
        case 'Text':
            return 'VARCHAR' + (colLength ? '(' + colLength + ')' : '(1024)');
        case 'Number':
            return 'INTEGER';
        case 'Date':
            return 'TIMESTAMP';
        case 'Timestamp':
            return 'TIMESTAMP';
        case 'Boolean':
            return 'VARCHAR(1)'; // SAPHANA doesn't have built-in boolean
    }
};

function mapSAPHANADatatypes(typeName) {
    return typeName;
}

function propertyHasNotBeenDeleted(model, propName) {
    return !!this._models[model].properties[propName];
}

require('./discovery')(SAPHANA);
