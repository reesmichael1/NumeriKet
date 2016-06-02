#lang racket/base

; Provide implementation of Newton's difference quotient for differentiation
(provide newton-diff)

; function: (derivative-at-point f x h)
; Inputs: 
;      * f: the function that will be differentiated
;      * x: the point at which the derivative will be evaluated
;      * h: the step size used in calculating the derivative
; Output: the approximate value of f'(x)
(define (derivative-at-point f x h)
      (/ (- (f (+ x h)) (f x)) h))

; function: (diff f x)
; Inputs:
;       * f: the function that will be differentiated
;       * x: the point at which the derivative will be evaluated
; Output: the approximate value of f'(x)
(define (newton-diff f x) (derivative-at-point f x 0.0000001))
