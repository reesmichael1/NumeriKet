#lang racket/base

; Test implementation of matrix-add

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/matrix-add.rkt")

(define matrix-add-tests
  (test-suite
    "matrix-add-tests"
    (check-equal? (matrix-add '((1 0) (0 1)) '((0 0) (0 0))) '((1 0) (0 1))
                  "Adding zero matrix doesn't change other matrix")
    (check-equal? (matrix-add '((1 0) (0 1)) '((0 1) (1 0))) '((1 1) (1 1))
                  "Simple addition works")
    (check-equal? (matrix-add '((1 -1 3) (1 7.5 0)) '((0 0 0) (-1 -1 -1)))
                  '((1 -1 3) (0 6.5 -1)) 
                  "Adding with negatives and zeros works")
    (check-equal? (matrix-add '((1 2 3) (3 2 1)) '((4 5 6) (6 5 4)))
                  (matrix-add '((4 5 6) (6 5 4)) '((1 2 3) (3 2 1)))
                  "Matrix addition is commutative")))

(run-tests matrix-add-tests)
