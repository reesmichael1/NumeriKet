#lang racket/base

; for rest
(require racket/list)

; Provide implementation of the dot product
(provide dot-product)

; Provide verification function for unit testing
(provide verify-for-dot-product)

; function: (verify-for-dot-product v1 v2)
; Inputs:
;       * v1: the first vector
;       * v2: a vector that is checked against v1
; Output: #t if v1 and b2 are row/column vectors of the same length
;         #f otherwise
(define (verify-for-dot-product v1 v2)
  (if (= (length v1) (length v2) 0) #t
    (if (or (= (length v1) 0) (= (length v2) 0)) #f
      (verify-for-dot-product (rest (flatten v1)) (rest (flatten v2))))))

; function: dot-product
; Inputs:
;       * v1: the first vector
;       * v2: the second vector
; Output: the dot product v1 * v2
(define (dot-product v1 v2)
  (if (verify-for-dot-product v1 v2)
    (foldl (lambda (a b c) (+ (* a b) c)) 0 v1 v2)
    (error "dot-product: given vectors are not valid for dot product")))
