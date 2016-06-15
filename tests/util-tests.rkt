#lang racket/base

; Test utility functions for NumeriKet

(require rackunit rackunit/text-ui "../NumeriKet/util.rkt")

(define round-to-precision-tests
    (test-suite
        "Test round-to-precision"
        (check-equal? (round-to-precision 10 3) 10 "Rounds integers")
        (check-equal? (round-to-precision 0.17832 2) 0.18 "Rounds decimals")
        (check-equal? (round-to-precision 13.878 0) 14.0
                      "Rounds to 0 decimals")
        (check-equal? (round-to-precision -inf.f 10) -inf.f 
                      "Rounds infinite cases")
        (check-equal? (round-to-precision -234.871034 50) -234.871034 
                      "Rounds more decimals than are in input")))

(run-tests round-to-precision-tests)
