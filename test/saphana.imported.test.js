var should;

describe('SAP HANA imported features', function () {

    before(function () {
        should = require('./init.js');
    });

    require('loopback-datasource-juggler/test/common.batch.js');
    require('loopback-datasource-juggler/test/include.test.js');

});