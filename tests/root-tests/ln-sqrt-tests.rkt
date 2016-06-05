#lang racket/base

; Test ln-sqrt

(require rackunit rackunit/text-ui "../test.rkt" 
         "../../NumeriKet/root/ln-sqrt.rkt")

(define ln-sqrt-tests
  (test-suite
    "ln-sqrt-tests"
    (check-true (approximate? (ln-sqrt 4) 2) 
                "Close for small perfect square")
    (check-true (approximate? (ln-sqrt 103927.29) (sqrt 103927.29))
                "Close for decimals around 1e5")
    (check-exn exn:fail? (lambda () (ln-sqrt -1)) 
               "Rejects negative input")))

(run-tests ln-sqrt-tests)
