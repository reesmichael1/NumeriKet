#lang racket/base

; Test implementation of five point method for differentiation

(require rackunit rackunit/text-ui racket/math 
         "../test.rkt" "../../NumeriKet/diff/five-point.rkt")

(define five-point-tests
    (test-suite
        "Tests for five-point"
        (check-true (approximate? (five-point (lambda (x) x) 1) 1)
                    "Derivative of line is constant")
        (check-true (approximate? (five-point (lambda (x) 1) 1) 0)
                    "Derivative of constant is zero")
        (check-true (approximate? (five-point (lambda (x) (expt x 2)) 1) 2)
                        "f(x) = x^2, f'(1) = 2")
        (check-false (approximate? (five-point
                                        (lambda (x) (* 3 (expt x 2))) 2) 17)
                        "f(x) = 3x^2, f'(2) != 17")
        (check-true (approximate? (five-point (lambda (x) (sin (* 3 x))) 
                                               .5) (* 3 (cos 1.5))) 
                        "f(x) = sin(3x), f'(.5) = -3 cos(1.5)")
        (check-true (approximate? (five-point (lambda (x) (exp x)) pi)
                                  (exp pi)) "f(x) = e^x, f'(pi) = e^pi")))

(run-tests five-point-tests)
