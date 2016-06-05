#lang racket/base 

; Provide an implementation of Newton's iterative method 
; for computing square roots
(provide newton-sqrt)

; function: (newton-sqrt-with-num-steps s x0 n)
; Inputs:
;       * s: the square whose root will be calculated
;       * x0: the initial value to use in the iteration
;       * n: the number of iterations left to compute
; Output: the approximate square root of s
(define (newton-sqrt-with-num-steps s x0 n) (if (= n 1) x0 
    (let* [(x1 (* 0.5 (+ x0 (/ s x0))))]
       (newton-sqrt-with-num-steps s x1 (- n 1)))))

; function: (newton-sqrt s x0)
; Inputs:
;       * s: the square whose root will be calculated
;       * x0: the initial value to use in the iteration
;       * n: an optional argument specifying the numer of iterations
; Output: the approximate square root of s
(define newton-sqrt (lambda (s x0 #:n [n 100]) 
     (newton-sqrt-with-num-steps s x0 n)))
