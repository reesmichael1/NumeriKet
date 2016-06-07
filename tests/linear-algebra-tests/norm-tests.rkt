#lang racket/base

; Test implementation of finding the norm of a vector

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/norm.rkt")

(define norm-tests
  (test-suite
    "norm-tests"
    (check-equal? (norm '(1)) 1 "Norm of row-less vector is correct")
    (check-equal? (norm '((1))) 1 "Norm of vector with row is correct")
    (check-equal? (norm '(1 2 3 4)) (sqrt 30) 
                  "Norm of longer vector is correct")
    (check-equal? (norm '(1 2 3)) (norm '((1) (2) (3)))
                  "Norm is same for equivalent row and column vectors")
    (check-equal? (norm '(-1 -2 -3)) (sqrt 14) 
                  "Norm of vector with negative elements is correct")))

(run-tests norm-tests)
