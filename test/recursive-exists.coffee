should = require 'should'
fs     = require 'fs'
exists = require '../lib/recursive-exists'
testfiles = "#{__dirname}/test-files"

describe 'node-recursive-exists.js', ->

    describe 'recursiveExistsSync()', ->

        it 'should return an empty array if file not found', ->
            results = exists.recursiveExistsSync 'foobar.txt', testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 0

        it 'should return an array with results', ->
            results = exists.recursiveExistsSync 'foo.txt', testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 2

            results = exists.recursiveExistsSync 'bar.txt', testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 3

        it 'should return absolute path to existing files', ->
            results = exists.recursiveExistsSync 'foo.txt', testfiles
            for result in results
                (fs.existsSync result).should.be.ok
