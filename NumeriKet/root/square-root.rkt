#lang racket/base

; Provide implementation of square root calculationg
(provide square-root closest-integer-sqrt)

(require NumeriKet/root/newton-sqrt)

; function: closest-integer-sqrt
; Inputs:
;       * x: the number (>= 0) whose closest perfect square is sought
;       * nMin: the integer forming a lower bound on the interval to check
;       * nMax: the integer forming an upper bound on the interval to check
; Output: an integer y such that y^2 <= x, but (y + 1)^2 > x
(define (closest-integer-sqrt x nMin nMax)
  (if (< (- nMax nMin) 2)
    (if (> (expt nMax 2) x) nMin nMax)
    (let* [(nMid (floor (/ (+ nMin nMax) 2)))]
       (if (> (expt nMid 2) x) 
         (closest-integer-sqrt x nMin nMid) 
         (closest-integer-sqrt x nMid nMax) ))))

; function: square-root
; Inputs:
;       * x: the number whose square root will be calculated
; Output: the square root of x
(define (square-root x)
  (if (> 0 x) (error "sqrt: input must be non-negative")
    (if (= 0 x) 0
      (newton-sqrt x (closest-integer-sqrt x 0 x)))))
