#lang racket/base

; Provide implementation of adding two matrices
(provide matrix-add)

; function: (matrix-add A B)
; Inputs:
;       * A: the first matrix addend
;       * B: the second matrix addend
(define (matrix-add A B) 
  (let* [(rows (length A))]
    (map (lambda (rowA rowB) (map (lambda (x y) (+ x y)) rowA rowB)) A B)))
