#lang racket/base
 
; Test implementation of Sieve of Erastothenes

(require rackunit rackunit/text-ui racket/list
         "../../NumeriKet/prime/era-sieve.rkt")

(define era-sieve-tests
  (test-suite
    "era-sieve-tests"
    (check-equal? (era-sieve 10) '(2 3 5 7 11 13 17 19 23 29)
        "First ten primes are correctly computed")
    (check-equal? (take-right (era-sieve 950) 3) '(7487 7489 7499))))

(run-tests era-sieve-tests)
