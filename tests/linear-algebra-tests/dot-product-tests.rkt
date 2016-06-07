#lang racket/base

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/dot-product.rkt")

(define dot-product-tests
  (test-suite
    "dot-product-tests"
    (check-equal? (dot-product '(1) '(1)) 1)
    (check-equal? (dot-product '(1 2 3) '(1 2 3)) 14)
    (check-equal? (dot-product '(1 2 3) '(4 5 6)) 32)
    (check-equal? (dot-product '(-1 4 6 4) '(3 3 3 3)) 39)
    (check-equal? (dot-product '(3 5 1) '(5 3 5)) 35)
    (check-equal? (dot-product '(8 -3 1 0) '(14 -1 -8 7)) 107)))

(run-tests dot-product-tests)  
