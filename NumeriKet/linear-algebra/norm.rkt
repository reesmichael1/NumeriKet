#lang racket/base

(require racket/list NumeriKet/linear-algebra/dot-product)

; Provide implementation of calculating Euclidean norm
(provide norm)

; function: (norm v)
; Inputs:
;       * v: the vector whose norm will be calculated
; Output: the Euclidean norm of v
(define (norm v) (sqrt (dot-product (flatten v) (flatten v))))
