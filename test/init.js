module.exports = require('should');

var DataSource = require('loopback-datasource-juggler').DataSource;

var config = require('rc')('loopback', {test: {saphana: {}}}).test.saphana;

global.getConfig = function (options) {
    var dbConf = {
        host: config.host || 'gshana.pvgl.sap.corp',
        port: config.port || 30015,
        username: config.username || 'I016904',
        password: config.password || 'Yoyo1976',
        debug: true
    };

    if (options) {
        for (var el in options) {
            dbConf[el] = options[el];
        }
    }
    return dbConf;
};

global.getDataSource = global.getSchema = function (options) {
    var db = new DataSource(require('../'), getConfig(options));
    return db;
};