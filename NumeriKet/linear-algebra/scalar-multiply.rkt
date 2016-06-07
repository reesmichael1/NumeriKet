#lang racket/base

; Provide implementation of multiplying a matrix by a scalar
(provide scalar-multiply)

; function: (scalar-multiply a A)
; Inputs:
;       * a: the scalar to multiply the matrix by
;       * A: the matrix to be scaled
; Output: the matrix A with all of its elements scaled by a
(define (scalar-multiply a A)
    (map (lambda (row) (map (lambda (x) (* a x)) row)) A))
