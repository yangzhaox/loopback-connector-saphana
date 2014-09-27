/*!
 * Module dependencies
 */
var saphana = require('hdb');

var SqlConnector = require('loopback-connector').SqlConnector;

var async = require('async');
var debug = require('debug')('loopback:connector:saphana');


exports.initialize = function initializeDataSource(dataSource, callback) {
    if (!saphana) {
        return;
    }

};