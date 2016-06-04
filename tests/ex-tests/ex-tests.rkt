#lang racket/base

(require rackunit rackunit/text-ui "../../NumeriKet/ex/ex.rkt" 
         "../test.rkt")

; Test implementation of exponential function 
(define ex-tests
    (test-suite
        "Test ex"
        (check-equal? (ex 0) 1 "0 power results in 1")
        (check-true (approximate? (ex .5) 1.64872)
                    "e^0.5 correct (fraction less than 1)")
        (check-true (approximate? (ex 2.5) 12.1825)
                    "e^2.5 correct (fraction greater than 1)")
        (check-true (approximate? (ex 10) 22026.46579)
                    "e^10 correct (large power)")
        (check-true (approximate? (/ (ex 100.86) (expt 10 43)) 6.35245)
                    "e^100 correct (huge fractional power)")
        ))


(run-tests ex-tests)
