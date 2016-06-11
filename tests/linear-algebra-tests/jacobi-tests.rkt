#lang racket/base

; Test implementation of the Jacobi method for solving linear systems

(require rackunit rackunit/text-ui "../../NumeriKet/util.rkt"
         "../../NumeriKet/linear-algebra/jacobi.rkt"
         "../../NumeriKet/linear-algebra/matrix-multiply.rkt")

(define jacobi-tests
  (test-suite
    "jacobi-tests"
    (check-equal? (jacobi '((1 0) (0 1)) '((2) (2))) '((2.0) (2.0))
                  "Correct for simple system")
    (check-equal? (jacobi '((1 0) (1 1)) '((1) (1)) #:warn-converge #f)
                  '((1.0) (0.0)) 
                  "Correct for simple system with false positive")
    (check-equal? (jacobi '((4 -1 -1) (-2 6 1) (-1 1 7)) '((3) (9) (-6)))
                  '((1.0) (2.0) (-1.0)) 
                  "Correct for three dimensional system")
    (check-equal? (map (lambda (x) (list (round-to-precision (car x) 1)))
                       (matrix-multiply 
                         '((7 -2 1 2) (2 8 3 1) (-1 0 5 2) (0 2 -1 4))
                     (jacobi '((7 -2 1 2) (2 8 3 1) (-1 0 5 2) (0 2 -1 4))
                          '((3) (-2) (5) (4)))))
                  '((3.0) (-2.0) (5.0) (4.0)) 
                  "Correct for four dimensional system")
    (check-exn exn:fail? (lambda () (jacobi '((1 3) (10 10)) '((1) (2))))
               "Gives warning on matrix that will not converge")
    ))

(run-tests jacobi-tests)
