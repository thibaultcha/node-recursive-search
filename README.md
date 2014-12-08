# node-recursive-search

[![Build Status](https://api.travis-ci.org/thibaultCha/node-recursive-search.png)](https://travis-ci.org/thibaultCha/node-recursive-search) [![NPM version](https://badge.fury.io/js/recursive-search.png)](http://badge.fury.io/js/recursive-search)

Recursively search a file in given directory from name or RegExp. Can return dot files or ignore them.

### Install

```
$ npm install recursive-search
```

### Methods

```javascript
recursiveSearchSync(searchTerm, directory, [options])
recursiveSearch(searchTerm, directory, [options], callback, complete)
```

Where `searchTerm` can be a `String` or a `RegExp`.

#### Options

- `all`: includes hidden files (starting with `.`)
    - `default`: `false`

### Example

```javascript
  var search = require('recursive-search')

  // search one file
  var results = search.recursiveSearchSync('foo.txt', __dirname + '/dir')
  if (results.length > 0) {
    // no file
  } else {
    // results
  }

  // search all files
  search.recursiveSearch('*', __dirname + '/dir', function (err, result) {
    if (err) throw err
    // result
  }, function(results){
    // complete
  })

  // search with RegExp
  results = search.recursiveSearchSync(/.txt$/, __dirname + '/dir')

  // include hidden files
  results = search.recursiveSearchSync(/.txt$/, __dirname + '/dir', { all: true }) // return hidden files
```

## License

Copyright (C) 2013 by Thibault Charbonnier.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
