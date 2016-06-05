#lang racket/base

; Provide implementation of the five point method for the first derivative
(provide five-point)

(define five-point 
  (lambda (f x0 #:h [h 1e-8]) 
    (/ (- (* 8 (f (+ x0 h))) (f (+ x0 (* 2 h))) (* 8 (f (- x0 h))) 
          (* -1 (f (- x0 (* 2 h))))) (* 12 h))))
