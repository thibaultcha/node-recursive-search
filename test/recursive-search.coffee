require 'should'
fs = require 'fs'
search = require '../lib/recursive-search'

testfiles = "#{__dirname}/fixtures"

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

    it 'should return all files if filename is *', ->
      results = search.recursiveSearchSync '*', testfiles
      results.should.be.an.instanceOf(Array)
      results.length.should.equal 5

    it 'should search a file from a RegExp', ->
      results = search.recursiveSearchSync /.txt/, testfiles
      results.should.be.an.instanceOf(Array)
      results.length.should.equal 5

    it 'should return absolute path to existing files', ->
      results = search.recursiveSearchSync 'foo.txt', testfiles
      for result in results
        (fs.existsSync result).should.be.ok

    it 'should return hidden files if options.all is true', ->
      options =
        all: true
      results = search.recursiveSearchSync '*', testfiles, options
      results.should.be.an.instanceOf(Array)
      results.length.should.equal 6

  describe 'recursiveSearch()', ->

    it 'should return an empty array if file not found', (done) ->
      results = []
      search.recursiveSearch 'foobar.txt', testfiles, (err, result) ->
        done err if err
        results.push result
      , ->
        results.length.should.be.equal 0
        done()

    it 'should return an array with results in complete callback', (done) ->
      results = []
      search.recursiveSearch 'foo.txt', testfiles, (err, result) ->
        done err if err
        results.push result
      , (completeResults) ->
        results.length.should.be.equal 2
        completeResults.should.eql results
        done()

    it 'should search a file from a RegExp', (done) ->
      results = []
      search.recursiveSearch /.txt/, testfiles, (err, result) ->
        done err if err
        results.push result
      , (completeResults) ->
        results.length.should.be.equal 5
        completeResults.should.eql results
        done()

    it 'should return absolute path to existing files', (done) ->
      search.recursiveSearch 'bar.txt', testfiles, (err, result) ->
        done err if err
      , (completeResults) ->
        for result in completeResults
          (fs.existsSync result).should.be.ok
        done()

    it 'should return hidden files if options.all is true', (done) ->
      options =
        all: true
      results = []
      search.recursiveSearch '*', testfiles, options, (err, result) ->
        done err if err
        results.push result
      , (completeResults) ->
        results.length.should.be.equal 6
        completeResults.should.eql results
        done()
