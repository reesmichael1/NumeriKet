#lang racket/base

; Test the implementation of Euler's method 
; for solving systems of ordinary differential equations

(require rackunit rackunit/text-ui racket/math
         "../../NumeriKet/ode/euler-method.rkt")

; Redefine approximate? because euler-method isn't as precise
; as other functions that are tested
(define (approximate? a b) (< (abs (- a b)) 0.001))

(define euler-method-tests
    (test-suite
        "Tests for euler-method"
        (check-true (approximate? 
                        (euler-method (lambda (t x) x) '(0 1) 2) (exp 2))
                    "Given f'(x) = x, f(0) = 1 -> f'(2) = e^2")
        (check-equal? (euler-method (lambda (t x) (expt x 2)) '(0 1) 2) 
                 +inf.0 "f'(x) = x^2, f(0) = 1 -> f'(2) = 1/(2 - 2)")
        (check-true (approximate?
                        (euler-method (lambda (t x) 
                                        (* t (cos x))) '(0 0) 2) 1.30176) 
                    "f'(t, x) = t cos(x), f(0) = 0 -> f(2) = 1.30176")))

(run-tests euler-method-tests)
