module.exports = require('should');

var DataSource = require('loopback-datasource-juggler').DataSource;

var config = require('rc')('loopback', {test: {saphana: {}}}).test.saphana;

global.getConfig = function (options) {
    var dbConf = {
        host: config.host,
        port: config.port,
        username: config.username,
        password: config.password,
        debug: config.debug
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