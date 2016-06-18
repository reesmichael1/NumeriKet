#lang racket/base

; Test implementation of getting identity matrix

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/identity-matrix.rkt")

(define identity-tests
  (test-suite
    "identity-tests"
    (check-equal? (identity-matrix 1) '((1))
                  "One dimensional identity works")
    (check-equal? (identity-matrix 2) '((1 0) (0 1))
                  "Two dimensional identity works")
    (check-equal? (identity-matrix 3) '((1 0 0) (0 1 0) (0 0 1))
                  "Three dimensional identity works")))

(run-tests identity-tests)
