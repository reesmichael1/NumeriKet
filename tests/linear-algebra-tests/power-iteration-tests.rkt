#lang racket/base

; Test power iteration method for finding dominant eigenvalues of a matrix

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/power-iteration.rkt")

(define power-iteration-tests
  (test-suite
    "power-iteration-tests"
    (check-equal? (power-iteration '((1 0) (0 1))) 1.0
                 "Dominant eigenvalue of identity matrix is 1")
    (check-equal? (power-iteration '((2 3) (4 1))) 5.0
                  "Dominant eigenvalue of 2x2 matrix is correct")
    (check-equal? (power-iteration '((2 3 2) (4 1 6) (1 1 1)))
                  6.394628822190897
                  "Dominant eigenvalue of 3x3 matrix is correct")
    (check-equal? (power-iteration '((1 0) (0 -1))) 0.0
                  "Matrix with no dominant eigenvalue is correct")))

(define verification-tests
  (test-suite
    "verification-tests"
    (check-true (verify-for-power-iteration '((1 2) (2 1)))
                "Accepts square matrix")
    (check-false (verify-for-power-iteration '((1 2 3) (1 2 3)))
                 "Rejects matrix with more columns than rows")
    (check-false (verify-for-power-iteration '((1 2) (1 2) (1 2)))
                 "Rejects matrix with more rows than columns")
    (check-false (verify-for-power-iteration '((1 2) (1)))
                 "Rejects malformed matrix")))

(run-tests power-iteration-tests)
(run-tests verification-tests)
