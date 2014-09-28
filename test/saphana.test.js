require('loopback-datasource-juggler/test/common.batch.js');
require('loopback-datasource-juggler/test/include.test.js');


var should = require('should');

var Post, db;

describe('SAP HANA connector', function () {

    before(function () {
        db = getDataSource();

        Post = db.define('PostWithBoolean', {
            title: { type: String, length: 255, index: true },
            content: { type: String },
            approved: Boolean
        });
    });

    it('should run migration', function (done) {
        db.automigrate('PostWithBoolean', function () {
            done();
        });
    });

    it('should support boolean types with true value', function (done) {
        Post.create({title: 'T1', content: 'C1', approved: true}, function (err, p) {
            should.not.exists(err);
            Post.findById(p.id, function (err, p) {
                should.not.exists(err);
                p.should.have.property('approved', true);
                done();
            });
        });
    });

    it('should support boolean types with false value', function (done) {
        Post.create({title: 'T1', content: 'C1', approved: false}, function (err, p) {
            should.not.exists(err);
            Post.findById(p.id, function (err, p) {
                should.not.exists(err);
                p.should.have.property('approved', false);
                done();
            });
        });
    });

});