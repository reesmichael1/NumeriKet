#lang racket/base

(require rackunit rackunit/text-ui "../test.rkt" 
         "../../NumeriKet/root/square-root.rkt")

(define square-root-tests
    (test-suite
        "square-root-tests"
        (check-true (approximate? (square-root 4) 2.0)
                    "Calculates small perfect squares correctly")
        (check-true (approximate? (square-root 17.82801) (sqrt 17.82801))
                    "Calculates non-perfect squares well")
        (check-true (approximate? (square-root 1179829581.190181813)
                                  (sqrt 1179829581.190181813))
                    "Calculates large non-perfect squares well")
        (check-equal? (square-root 0) 0 "Calculates square root of 0")
        (check-exn exn:fail? (lambda () (square-root -1)) 
                   "Rejects negative input")
        ))

(run-tests square-root-tests)
