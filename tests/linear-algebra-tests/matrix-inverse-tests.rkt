#lang racket/base

; Test implementation of matrix-inverse
(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/matrix-inverse.rkt")

(define matrix-inverse-tests
  (test-suite
    "matrix-inverse-tests"
    (check-equal? (matrix-inverse '((1 0) (0 1))) '((1 0) (0 1))
                  "Inverse of identity is identity")
    (check-equal? (matrix-inverse '((4 3) (3 2))) '((-2 3) (3 -4))
                  "Inverse of 2x2 matrix is correct")
    (check-equal? (matrix-inverse '((1 2 3) (0 1 4) (5 6 0)))
                  '((-24 18 5) (20 -15 -4) (-5 4 1))
                  "Inverse of 3x3 matrix is correct")))

(run-tests matrix-inverse-tests)
