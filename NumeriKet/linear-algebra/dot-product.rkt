#lang racket/base

; Provide implementation of the dot product
(provide dot-product)

; function: dot-product
; Inputs:
;       * v1: the first vector
;       * v2: the second vector
; Output: the dot product v1 * v2
(define (dot-product v1 v2) (foldl (lambda (a b c) (+ (* a b) c)) 0 v1 v2))
