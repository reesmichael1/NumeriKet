#lang racket/base

; Test implementation of the Jacobi method for solving linear systems

(require rackunit rackunit/text-ui "../../NumeriKet/util.rkt"
         "../../NumeriKet/linear-algebra/jacobi.rkt"
         "../../NumeriKet/linear-algebra/matrix-operations.rkt")

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
    (check-exn exn:fail? (lambda () (jacobi '((1) (2)) '((1))))
               "Fails on matrix and vector with different number of rows")))

(define verification-tests
  (test-suite
    "verification-tests"
    (check-true (verify-for-jacobi '((1 2) (1 2)) '((1) (2)))
                "Verifies valid matrix/vector pair")
    (check-false (verify-for-jacobi '((1 2) (1 2 3)) '((1) (2)))
                 "Rejects non-square matrix")
    (check-false (verify-for-jacobi '((1 2) (1 2)) '((1) (2) (3)))
                 "Rejects vector with different number of rows than matrix")
    ))

(run-tests jacobi-tests)
(run-tests verification-tests)
