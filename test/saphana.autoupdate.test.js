var should, assert, db;

describe('SAP HANA auto update', function () {

    before(function (done) {
        should = require('./init.js');
        assert = require('assert');
        db = getDataSource();
        done();
    });

    it('should auto migrate/update tables', function (done) {

        var schema_v1 =
        {
            "name": "CustomerTest",
            "options": {
                "idInjection": false,
                "saphana": {
                    "schema": "",
                    "table": "customer_test"
                }
            },
            "properties": {
                "id": {
                    "type": "String",
                    "length": 20,
                    "id": 1
                },
                "name": {
                    "type": "String",
                    "required": false,
                    "length": 40
                },
                "email": {
                    "type": "String",
                    "required": false,
                    "length": 40
                },
                "age": {
                    "type": "Number",
                    "required": false
                }
            }
        };

        var schema_v2 =
        {
            "name": "CustomerTest",
            "options": {
                "idInjection": false,
                "saphana": {
                    "schema": "",
                    "table": "customer_test"
                }
            },
            "properties": {
                "id": {
                    "type": "String",
                    "length": 20,
                    "id": 1
                },
                "email": {
                    "type": "String",
                    "required": false,
                    "length": 60,
                    "saphana": {
                        "columnName": "email",
                        "dataType": "varchar",
                        "dataLength": 60,
                        "nullable": "Y"
                    }
                },
                "firstName": {
                    "type": "String",
                    "required": false,
                    "length": 40
                },
                "lastName": {
                    "type": "String",
                    "required": false,
                    "length": 40
                }
            }
        };

        db.createModel(schema_v1.name, schema_v1.properties, schema_v1.options);

        db.automigrate(function () {

            db.discoverModelProperties('customer_test', function (err, props) {
                assert.equal(props.length, 4);
                var names = props.map(function (p) {
                    return p.columnName;
                });
                assert.equal(names[0], 'id');
                assert.equal(names[1], 'name');
                assert.equal(names[2], 'email');
                assert.equal(names[3], 'age');

                db.createModel(schema_v2.name, schema_v2.properties, schema_v2.options);

                db.autoupdate(function (err, result) {
                    db.discoverModelProperties('customer_test', function (err, props) {
                        assert.equal(props.length, 4);
                        var names = props.map(function (p) {
                            return p.columnName;
                        });
                        assert.equal(names[0], 'id');
                        assert.equal(names[1], 'email');
                        assert.equal(names[2], 'firstname');
                        assert.equal(names[3], 'lastname');
                        // console.log(err, result);
                        done(err, result);
                    });
                });
            });
        });
    });

    it('should report errors for automigrate', function () {
        db.automigrate('XYZ', function (err) {
            assert(err);
        });
    });

    it('should report errors for autoupdate', function () {
        db.autoupdate('XYZ', function (err) {
            assert(err);
        });
    });

});
