#lang racket/base

; Test implementation of calculating derivative of a function at a point

(require rackunit rackunit/text-ui racket/math 
         "test.rkt" "../NumeriKet/diff.rkt")

(define diff-tests
    (test-suite
        "Tests for diff"
        (check-true (approximate? (diff (lambda (x) (expt x 2)) 1) 2)
                        "f(x) = x^2, f'(1) = 2")
        (check-false (approximate? (diff
                                        (lambda (x) (* 3 (expt x 2))) 2) 17)
                        "f(x) = 3x^2, f'(2) != 17")
        (check-true (approximate? (diff (lambda (x) (sin (* 3 x))) .5)
                            (* 3 (cos 1.5))) 
                        "f(x) = sin(3x), f'(.5) = -3 cos(1.5)")
        (check-true (approximate? (diff (lambda (x) (exp x)) pi) (exp pi))
                        "f(x) = e^x, f'(pi) = e^pi")))

(run-tests diff-tests)
