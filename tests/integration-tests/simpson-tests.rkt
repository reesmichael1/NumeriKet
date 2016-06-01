#lang racket/base

; Test implementation of numerical integration with Simpson's rule

; redefine approximate? because simpson isn't terribly precise
(define (approximate? a b) (< (abs (- a b)) 0.05))

(require rackunit rackunit/text-ui racket/math 
         "../test.rkt" "../../NumeriKet/integration/simpson.rkt")

(define simpson-tests
    (test-suite
        "Tests for simpson"
        (check-equal? (simpson (lambda (x) (expt x 3)) '(0 10)) 2500.0
                      "Simpson's rule exact for third order polynomial")
        (check-equal? (simpson (lambda (x) (expt x 4)) '(0 10)) 20000.0
                      "Close for fourth order polynomial")
        (check-true (approximate? (simpson (lambda (x) (cos x)) 
                                            '(0 3.14159265)) 0.0)
                      "Close for well behaved function")
        (check-true (approximate? 
                      (simpson (lambda (x) (+ (* 3 (expt x 4)) 
                                              (* -.5 (expt x 3))
                                              (* 16.3 (expt x 2))
                                              (* 42 x) -17)) '(0 10))
                      66113.3) "Close for complicated polynomial")
        ))

(run-tests simpson-tests)
