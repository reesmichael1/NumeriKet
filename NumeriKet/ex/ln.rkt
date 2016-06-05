#lang racket/base

(require NumeriKet/root/newton-root NumeriKet/ex/ex "./e-const.rkt")

; Provide implementation of natural log function
(provide ln get-start-guess)

; function: get-start-guess
; Inputs:
;       * b: a number to be divided by e
;       * n: the number of times b has been divided so far
; Output: the ceiling of the natural log of b
(define (get-start-guess b n)
  (if (< b 1 n) n (get-start-guess (/ b e-const) (+ n 1))))

; function: ln
; Inputs:
;       * x: the number whose natural logarithm will be found
; Output: the natural logarithm of x
(define (ln x) 
  (if (<= x 0) (error "ln: input must be positive")
    (newton-root (lambda (y) (- (ex y) x)) (get-start-guess x 0))))
