#lang racket/base

; Provide implementation of square root calculationg
(provide square-root)

(require NumeriKet/root/newton-sqrt)

; function: closest-integer-sqrt
; Inputs:
;       * x: the number (>= 0) whose closest perfect square is sought
;       * n: the integer that is checked to be a perfect square of x
; Output: an integer y such that y^2 <= x, but (y + 1)^2 > x
(define (closest-integer-sqrt x n)
    (if (< x (expt (+ n 1) 2)) n (closest-integer-sqrt x (+ n 1))))

; function: square-root
; Inputs:
;       * x: the number whose square root will be calculated
; Output: the square root of x
(define (square-root x)
    (if (> 0 x) (error "sqrt: input must be non-negative")
        (if (= 0 x) 0
          (newton-sqrt x (closest-integer-sqrt x 0)))))
