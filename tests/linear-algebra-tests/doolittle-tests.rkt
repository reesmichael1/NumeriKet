#lang racket/base

; Test implementation of Doolittle algorithm for LU matrix decomposition
(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/doolittle.rkt")

(define doolittle-tests
  (test-suite
    "dootlittle-tests"
    (check-equal? (doolittle '((4 3) (6 3))) 
                  '('((1 0) (1.5 1))
                    '((4 3) (0 -1.5)))
                  "Correct decomposition of 2x2 matrix")
    (check-equal? (doolittle '((1 2 1) (1 1 0) (-2 -1 -1)))
                  '('((1 0 0) (1 1 0) (-2 -3 1))
                    '((1 2 1) (0 -1 -1) (0 0 -2)))
                  "Correct decomposition of 3x3 matrix")
    (check-equal? (doolittle '((2 3 2 1) (4 8 7 3) (2 1 0 2) (-4 -4 1 2)))
                  '('((1 0 0 0) (2 1 0 0) (1 -1 1 0) (-2 1 2 1))
                    '((2 3 2 1) (0 2 3 1) (0 0 1 2) (0 0 0 -1)))
                  "Correct decomposition of 4x4 matrix")))

(run-tests doolittle-tests)
