should = require 'should'
fs     = require 'fs'
search = require '../lib/recursive-search'

testfiles = "#{__dirname}/test-files"

describe 'node-recursive-search', ->

    describe 'recursiveSearchSync()', ->

        it 'should return an empty array if file not found', ->
            results = search.recursiveSearchSync 'foobar.txt', testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 0

        it 'should return an array with results', ->
            results = search.recursiveSearchSync 'foo.txt', testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 2

            results = search.recursiveSearchSync 'bar.txt', testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 3

        it 'should search a file from a RegExp', ->
            results = search.recursiveSearchSync /.txt/, testfiles
            results.should.be.an.instanceOf(Array)
            results.length.should.equal 5

        it 'should return absolute path to existing files', ->
            results = search.recursiveSearchSync 'foo.txt', testfiles
            for result in results
                (fs.existsSync result).should.be.ok

    describe 'recursivesearch()', ->

        it 'should return an empty array if file not found', (done) ->
            results = []
            search.recursiveSearch 'foobar.txt', testfiles, (err, result) ->
                results.push result
            , ->
                results.length.should.be.equal 0
                done()

        it 'should return an array with results in complete callback', (done) ->
            results = []
            search.recursiveSearch 'foo.txt', testfiles, (err, result) ->
                results.push result
            , (completeResults) ->
                results.length.should.be.equal 2
                completeResults.should.eql results
                done()

        it 'should search a file from a RegExp', (done) ->
            results = []
            search.recursiveSearch /.txt/, testfiles, (err, result) ->
                results.push result
            , (completeResults) ->
                results.length.should.be.equal 5
                completeResults.should.eql results
                done()

        it 'should return absolute path to existing files',(done) ->
            results = []
            search.recursiveSearch 'bar.txt', testfiles, (err, result) ->
                results.push result
            , ->
                for result in results
                    (fs.existsSync result).should.be.ok
                done()

