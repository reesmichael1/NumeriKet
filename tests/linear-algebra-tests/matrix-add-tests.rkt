#lang racket/base

; Test implementation of matrix-add

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/matrix-operations.rkt")

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
                  "Matrix addition is commutative")
    (check-exn exn:fail? (lambda () (matrix-add '((1) (2)) '((1 2))))
               "Gives error for matrices of different number of rows")
    (check-exn exn:fail? (lambda () (matrix-add '((1 2)) '((1))))
               "Gives error for matrices of different number of columns")
    ))

(define verification-tests
  (test-suite
    "verification-tests"
    (check-true (verify-for-adding '((1 2 3) (1 2 3)) '((0 3 5) (-1 -2 -3)))
                "Valid matrices for adding are verified")
    (check-false (verify-for-adding '((1) (2)) '((1 2) (3 4)))
                 "Adding matrices with different number of columns fails")
    (check-false (verify-for-adding '((1) (2)) '((1)))
                 "Adding matrices with different number of rows fails")
    (check-false (verify-for-adding '((1) (1 2)) '((1) (1)))
                 "Malformed matrix is caught")
    (check-false (verify-for-adding '((1) (1 2)) '((1) (1 2)))
                 "Two malformed matrices are caught")
    (check-true (verify-for-multiplication '((1 2) (1 2) (1 2)) 
                                           '((1 2 3) (1 2 3))) 
                "Valid matrices for multiplication are verified")
    (check-false (verify-for-multiplication '((1 2)) '((1 2)))
                 "Two 1x2 matrices cannot be multiplied")
    (check-false (verify-for-multiplication '((1) (2)) '((1 2 3)))
                 "A*B should fail when B has more columns than A has rows")
    (check-false (verify-for-multiplication '((1) (1 2)) '(1 2))
                 "Malformed first matrix is caught")
    (check-false (verify-for-multiplication '((1 2) (1 2)) '((1 2) (1)))
                 "Malformed second matrix is caught")
    ))

(run-tests matrix-add-tests)
(run-tests verification-tests)
