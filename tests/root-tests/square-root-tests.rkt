#lang racket/base

(require rackunit rackunit/text-ui racket/math "../test.rkt" 
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
                   "Rejects negative input")))

(define closest-integer-sqrt-tests
    (test-suite
        "closest-integer-sqrt-tests"
        (check-equal? (closest-integer-sqrt 4 0 4) 2 
                      "Correct for perfect squares")
        (check-equal? (closest-integer-sqrt 23 0 23) 4
                      "Correct for imperfect square integers")
        (check-equal? (closest-integer-sqrt 97.4 0 97.4) 9.0
                      "Correct for imperfect square rational numbers")
        (check-equal? (closest-integer-sqrt pi 0 pi) 1.0
                      "Correct for irrational numbers")
        (check-equal? (closest-integer-sqrt 51298301000395829582.1835 0
                                            51298301000395829582.1835) 
                      7162283225.0 "Correct for very large numbers")
    ))

(run-tests square-root-tests) 
(run-tests closest-integer-sqrt-tests)
