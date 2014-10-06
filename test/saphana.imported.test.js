var should;

describe('SAP HANA imported features', function () {

    before(function (done) {
        should = require('./init.js');
        done();
    });

    require('loopback-datasource-juggler/test/common.batch.js');
    require('loopback-datasource-juggler/test/include.test.js');

});