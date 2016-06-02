#lang racket/base

; Test implemetation of Newton's iterative method 
; for finding square roots

(require rackunit rackunit/text-ui racket/math
         "../test.rkt" "../../NumeriKet/root/newton-sqrt.rkt")

(define newton-sqrt-tests
    (test-suite
        "Tests for newton-sqrt"
        (check-true (approximate? (newton-sqrt 2 1.4) (sqrt 2)) 
                        "Newton root, 2")
        (check-true (approximate? (newton-sqrt 1.7 1.3) (sqrt 1.7)) 
                        "Newton root, 1.7")
        (check-true (approximate? (newton-sqrt (exp 1) 1.6) (sqrt (exp 1)))
                        "Newton root, e")
        (check-false (approximate? (newton-sqrt 1 1) 10) "sqrt 1 != 10")))

(run-tests newton-sqrt-tests)
