#lang racket/base

; Test implementation of matrix multiplication and helper functions

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/matrix-multiply.rkt")

(define matrix-multiply-tests
  (test-suite
    "matrix-multiply-tests"
    (check-equal? (matrix-multiply '((1 0) (0 1)) '((1 0) (0 1)))
        '((1 0) (0 1)) "Identity matrix times itself is the identity")
    (check-equal? (matrix-multiply '((3 1 5) (4 1 8)) 
                  '((2 1) (6 1) (-3 7))) '((-3 39) (-10 61)))
    (check-equal? (matrix-multiply '((1 2 3 4) (5 6 7 8) 
                                     (-9 -10 -11 -12) (-13 -14 -15 -16))
                                   '((16 15 14 13) (12 11 10 9)
                                     (-8 -7 -6 -5) (-4 -3 -2 -1)))
                  '((0 4 8 12) (64 68 72 76) 
                    (-128 -132 -136 -140) (-192 -196 -200 -204)))))

(define get-row-tests
  (test-suite
    "get-row-tests"
    (check-equal? (get-row 0 '((1 2) (3 4) (5 6))) '(1 2))
    (check-equal? (get-row 2 '((1 2) (3 4) (5 6))) '(5 6))
    (check-equal? (get-row 3 
                           '((3 5 3) (-1 -1 -8) (-43 -8 2) (-38 17 2)))
            '(-38 17 2))))

(define get-column-tests
  (test-suite
    "get-column-tests"
    (check-equal? (get-column 1 '((1 0) (1 1))) '(0 1))
    (check-equal? (get-column 0 '((1) (2) (3) (4))) '(1 2 3 4))
    (check-equal? (get-column 2 '((1 2 3) (4 5 6))) '(3 6))))

(run-tests matrix-multiply-tests)
(run-tests get-row-tests)
(run-tests get-column-tests)
