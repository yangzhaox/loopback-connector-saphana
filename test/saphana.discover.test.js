var should, db;

describe('SAP HANA discover models', function () {

    before(function (done) {
        should = require('./init.js');
        db = getDataSource();
        done();
    });

    describe('Discover models including views', function () {
        it('should return an array of tables and views', function (done) {

            db.discoverModelDefinitions({
                views: true,
                limit: 3
            }, function (err, models) {
                if (err) {
                    console.error(err);
                    done(err);
                } else {
                    var views = false;
                    models.forEach(function (m) {
                        // console.dir(m);
                        if (m.type === 'view') {
                            views = true;
                        }
                    });
                    views.should.be.true;
                    done(null, models);
                }
            });
        });
    });

    describe('Discover models excluding views', function () {
        it('should return an array of only tables', function (done) {

            db.discoverModelDefinitions({
                views: false,
                limit: 3
            }, function (err, models) {
                if (err) {
                    console.error(err);
                    done(err);
                } else {
                    var views = false;
                    models.forEach(function (m) {
                        // console.dir(m);
                        if (m.type === 'view') {
                            views = true;
                        }
                    });
                    models.should.have.length(3);
                    views.should.be.false;
                    done(null, models);
                }
            });
        });
    });
});

describe('Discover models including other users', function () {
    it('should return an array of all tables and views', function (done) {

        db.discoverModelDefinitions({
            all: true,
            limit: 3
        }, function (err, models) {
            if (err) {
                console.error(err);
                done(err);
            } else {
                var others = false;
                models.forEach(function (m) {
                    // console.dir(m);
                    if (m.owner !== 'strongloop') {
                        others = true;
                    }
                });
                others.should.be.true;
                done(err, models);
            }
        });
    });
});

describe('Discover model properties', function () {
    describe('Discover a named model', function () {
        it('should return an array of columns for product', function (done) {
            db.discoverModelProperties('product', function (err, models) {
                if (err) {
                    console.error(err);
                    done(err);
                } else {
                    models.forEach(function (m) {
                        m.tableName.should.be.equal('product');
                    });
                    done(null, models);
                }
            });
        });
    });

});

describe('Discover model primary keys', function () {
    it('should return an array of primary keys for product', function (done) {
        db.discoverPrimaryKeys('product', function (err, models) {
            if (err) {
                console.error(err);
                done(err);
            } else {
                models.forEach(function (m) {
                    m.should.be.eql({
                        owner: 'strongloop',
                        tableName: 'product',
                        columnName: 'id',
                        keySeq: 1,
                        pkName: 'product_pk' });
                });
                done(null, models);
            }
        });
    });

    it('should return an array of primary keys for strongloop.product', function (done) {
        db.discoverPrimaryKeys('product', {owner: 'strongloop'}, function (err, models) {
            if (err) {
                console.error(err);
                done(err);
            } else {
                models.forEach(function (m) {
                    m.tableName.should.be.equal('product');
                });
                done(null, models);
            }
        });
    });
});

describe('Discover model foreign keys', function () {
    it('should return an array of foreign keys for inventory', function (done) {
        db.discoverForeignKeys('inventory', function (err, models) {
            if (err) {
                console.error(err);
                done(err);
            } else {
                models.forEach(function (m) {
                    m.fkTableName.should.be.equal('inventory');
                });
                done(null, models);
            }
        });
    });
    it('should return an array of foreign keys for strongloop.inventory', function (done) {
        db.discoverForeignKeys('inventory', {owner: 'strongloop'}, function (err, models) {
            if (err) {
                console.error(err);
                done(err);
            } else {
                models[0].fkTableName.should.be.equal('product');
                models[1].fkTableName.should.be.equal('location');
                done(null, models);
            }
        });
    });
});


describe('Discover LDL schema from a table', function () {
    it('should return an LDL schema for inventory', function (done) {
        db.discoverSchema('inventory', {owner: 'strongloop'}, function (err, schema) {
            schema.name.should.be.equal('Inventory');
            schema.options.hdb.schema.should.be.equal('strongloop');
            schema.options.hdb.table.should.be.equal('inventory');
            schema.properties.productId.should.not.be.empty;
            schema.properties.productId.type.should.be.equal('String');
            schema.properties.productId.hdb.columnName.should.be.equal('product_id');
            schema.properties.locationId.should.not.be.empty;
            schema.properties.locationId.type.should.be.equal('String');
            schema.properties.locationId.hdb.columnName.should.be.equal('location_id');
            schema.properties.available.should.not.be.empty;
            schema.properties.available.type.should.be.equal('Number');
            schema.properties.total.should.not.be.empty;
            schema.properties.total.type.should.be.equal('Number');
            done(null, schema);
        });
    });
});
