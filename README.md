# NumeriKet

## Overview

This is a collection of modules to implement numerical methods in [Racket](https://racket-lang.org). It is primarily written as a learning project, but may be of some use.

Methods are implemented in the NumeriKet subdirectory. Tests are in the tests subdirectory.

[Full API documentation](http://reesmichael1.com/math/NumeriKet.html) is also available.

## Installation

From a terminal prompt, run
```
git clone https://github.com/reesmichael1/NumeriKet/
cd NumeriKet
raco link NumeriKet
```

## Usage

```
$ racket
Welcome to Racket v6.5
> (require NumeriKet)
> (ex (ln 3872.295))
3872.2950000000033
```
Consult the [API documentation](http://reesmichael1.com/math/NumeriKet.html) for a full list of implemented methods.
