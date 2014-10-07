var should, db;

describe('SAP HANA auto update', function () {

    before(function (done) {
        should = require('./init.js');
        db = getDataSource();
        done();
    });

    it('should auto migrate/update tables', function (done) {

        var schema_v1 =
        {
            "name": "CustomerTest",
            "options": {
                "idInjection": false,
                "hdb": {
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
                "hdb": {
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
                    "hdb": {
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

            db.discoverModelProperties('customer_test', null, function (err, props) {
                props.should.have.length(4);
                var names = props.map(function (p) {
                    return p.columnName;
                });
                names[0].should.be.equal('id');
                names[1].should.be.equal('name');
                names[2].should.be.equal('email');
                names[3].should.be.equal('age');

                db.createModel(schema_v2.name, schema_v2.properties, schema_v2.options);

                db.autoupdate(function (err, result) {
                    db.discoverModelProperties('customer_test', null, function (err, props) {
                        props.should.have.length(4);
                        var names = props.map(function (p) {
                            return p.columnName;
                        });
                        names[0].should.be.equal('id');
                        names[1].should.be.equal('email');
                        names[2].should.be.equal('firstName');
                        names[3].should.be.equal('lastName');
                        done(err, result);
                    });
                });
            });
        });
    });

    it('should report errors for automigrate', function () {
        db.automigrate('XYZ', function (err) {
            should.exist(err);
        });
    });

    it('should report errors for autoupdate', function () {
        db.autoupdate('XYZ', function (err) {
            should.exist(err);
        });
    });

});
