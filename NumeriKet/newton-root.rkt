#lang racket/base

; Provide an implementation of Newton's iterative method 
; for finding roots of polynomials
(provide newton-root)

(require NumeriKet/diff)

; function: (newton-root-with-num-steps p x0 n)
; Input:
;       * p: the function of x whose root will be found 
;       * x0: the point at which the iteration will start
;       * n: the number of iterations remaining
; Output: the root of p closest to x0
(define (newton-root-with-num-steps p x0 n) 
    (if (= n 1) x0 
      (let* [(x1 (- x0 (/ (p x0) (diff p x0))))]
        (newton-root-with-num-steps p x1 (- n 1)))))

(define (newton-root p x0) (newton-root-with-num-steps p x0 10))
