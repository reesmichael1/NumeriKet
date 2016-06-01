#lang racket/base (require racket/list)

; Provide implementation of Simpson's rule for numerical integration
(provide simpson)

(define max-n 50000)
(define int-width (/ 1 1000))

; function: (simpson-over-n-intervals f int n)
; Inputs:
;       * f: the function that will be integrated
;       * int: a list of the form '(a b) that represents the interval 
;              over which f will be integrated
;       * n: the (even) number of subintervals that should be used
; Output: the approximate value of the integral of f over (a, b)
(define (simpson-over-n-intervals f int n)
    (let* [(a (first int))
           (b (second int))
           (h (/ (- b a) n))
           (xn (map f (range (+ a h) b h)))]
      (* (/ h 3) (+ (f a) (f b) (sum-subints xn)))))

; function: (sum-subints xn)
; Inputs:
;       * xn: a list of subintervals used in evaluating Simpson's rule
;       * n: the number of iterations left to complete
; Output: the result of summing every first and third term and 
;         four times every second term
(define (sum-subints xn)
    (if (= (length xn) 1) (* 4 (first xn))
        (+ (* 4 (first xn)) (* 2 (second xn)) 
           (sum-subints (rest (rest xn)))) ))

; function: (simpson f int)
; Inputs:
;       * f: the function that will be integrated
;       * int: a list of the form '(a b) that represents the interval 
;              over which f will be integrated
; Output: the approximate value of the integral of f over (a, b)
(define (simpson f int) 
  (let* [(potential-n (* (/ 1 int-width) (- (second int) (first int))))]
    (if (< potential-n max-n) (exact->inexact
    (simpson-over-n-intervals f int potential-n))
      (exact->inexact (simpson-over-n-intervals f int max-n))) ))
