#lang racket/base

(require rackunit rackunit/text-ui 
         "../../NumeriKet/linear-algebra/scalar-multiply.rkt")

(define scalar-multiply-tests
  (test-suite
    "scalar-multiply-tests"
    (check-equal? (scalar-multiply 2 '((1 0) (0 1))) '((2 0) (0 2))
                  "Scaling by a positive constant works")
    (check-equal? (scalar-multiply 0 '((1 3 5) (0 8 9))) '((0 0 0) (0 0 0))
                  "Scaling by 0 gives the zero matrix")
    (check-equal? (scalar-multiply -3.5 '((1) (2) (3) (4))) 
                  '((-3.5) (-7.0) (-10.5) (-14.0)) 
                  "Multiplying by a negative decimal works")))

(run-tests scalar-multiply-tests)
