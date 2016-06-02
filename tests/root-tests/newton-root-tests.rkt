#lang racket/base

; Test implementation of Newton's iterative method 
; for finding roots of functions

(require rackunit rackunit/text-ui racket/math
         "../test.rkt" "../../NumeriKet/root/newton-root.rkt")

(define newton-root-tests
    (test-suite
        "Tests for newton-root"
        (check-true (approximate? 
                      (newton-root (lambda (x) (- (expt x 2) 4)) -1) -2)
                    "The zero of x^2 - 4 closest to -1 is -2")
        (check-false (approximate? 
                      (newton-root (lambda (x) (- (expt x 2) 4)) 1) -2)
                    "A zero of x^2 - 4 is -2, but 2 is closer to 1")
        (check-true (approximate? 
                      (newton-root (lambda (x) (- (expt x 2) 4)) 1) 2)
                    "The zero of x^2 - 4 closes to 1 is 2")
        (check-true (approximate?
                      (newton-root (lambda (x) (- (sin x) (cos x) -1)) -1)
                          (/ pi -2))
                    "The zero of sin(x)-cos(x)+1 closest to -1 is -pi/2")))

(run-tests newton-root-tests)
