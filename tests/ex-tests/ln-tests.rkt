#lang racket/base

; Test implementation of natural logarithm function

(require rackunit rackunit/text-ui math/base  "../../NumeriKet/ex/ln.rkt" 
         "../test.rkt")

(define ln-tests
  (test-suite
    "ln-tests"
    (check-true (approximate? (ln euler.0) 1) "Natural log of e is 1")
    (check-true (approximate? (ln 100) (log 100)) "Natural log of 100")
    (check-true (approximate? (ln 3283) (log 3283)) "Natural log of 3283")
    (check-true (approximate? (ln 184832.2847) (log 184832.2847))
                "Natural log of 184832.2847")))

(define get-start-guess-tests
  (test-suite
    "get-start-guess-tests"
    (check-equal? (get-start-guess 4 0) 2)
    (check-equal? (get-start-guess (+ (exp 17) 1) 0) 18)
    (check-equal? (get-start-guess 1000000000 0) 21)))

(run-tests ln-tests)
(run-tests get-start-guess-tests)
