#lang racket/base

; Test implementation of subtracting matrices

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/matrix-operations.rkt")

(define matrix-subtract-tests
  (test-suite
    "matrix-subtract-tests"
    (check-equal? (matrix-subtract '((1 0) (0 1)) '((1 0) (0 1))) 
                  '((0 0) (0 0)) "Identity minus identity is zero matrix")
    (check-equal? (matrix-subtract '((4 5 6) (4 5 6)) '((1 2 3) (1 2 3)))
                  '((3 3 3) (3 3 3)) "Works for simple 2x3 matrix")
    (check-equal? (matrix-subtract '((1) (2) (3) (4) (5)) 
                                   '((8) (-1) (0) (-3.8) (100)))
                  '((-7) (3) (3) (7.8) (-95)) 
                  "Works for matrix with more columns than rows")))

(run-tests matrix-subtract-tests)
