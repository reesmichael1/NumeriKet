# NumeriKet

## Overview

This is a collection of modules to implement numerical methods in [Racket](https://racket-lang.org). It is primarily written as a learning project, but may be of some use.

Methods are implemented in the NumeriKet subdirectory. Tests are in the tests subdirectory.

## Installation

From a terminal prompt, run
```
git clone https://github.com/reesmichael1/NumeriKet/
cd NumeriKet
raco link NumeriKet
```

## Usage

```
#lang racket/base

(require NumeriKet)

(newton-sqrt 4 4)
(euler-method (lambda (t x) x) '(0 1) 4) 
```
Save as numeriket.rkt

```
> racket numeriket.rkt
2.0
54.5872
```
