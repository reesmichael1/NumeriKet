#lang racket/base

(require NumeriKet/util)

; Provide implementation of Euler's method 
; for solving ordinary differential equations
(provide euler-method)

(define step-size 0.0001)

; function: (euler-method-with-step-size f inits tf h)
; Inputs:
;       * f: flow of x in time (that is, x'(t) = f(t, x(t)))
;       * inits: a list of the form '(t0 x0), where x(t0) = x0
;       * tf: the time to which the iteration should be processed
;       * h: the step size to be used in the iteration
; Output: the approximate value of x(tf)
(define (euler-method-with-step-size f inits tf h)
    (let* [(t0 (car inits))
           (x0 (cadr inits))
           (t1 (+ t0 h))
           (x1 (+ x0 (* h (f t0 x0))))]
        (if (< (abs (- t0 tf)) (* 0.99 step-size)) x0 
          (euler-method-with-step-size f (list t1 x1) tf h))))

; function: (euler-method-without-rounding f inits tf)
; Inputs:
;       * f: flow of x in time (that is, x'(t) = f(t, x(t)))
;       * inits: a list of the form '(t0 x0), where x(t0) = x0
;       * tf: the time to which the iteration should be processed
; Output: the approximate value of x(tf) in full "precision"
(define (euler-method-without-rounding f inits tf) 
    (euler-method-with-step-size f inits tf step-size))

; function (euler-method f inits tf)
; Inputs:
;       * f: flow of x in time (that is, x'(t) = f(t, x(t)))
;       * inits: a list of the form '(t0 x0), where x(t0) = x0
;       * tf: the time to which the iteration should be processed
; Output: the approximate value of x(tf), rounded to four decimal places
(define (euler-method f inits tf)
    (round-to-precision (euler-method-without-rounding f inits tf) 4))
