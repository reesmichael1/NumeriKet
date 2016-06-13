#lang racket/base

; for range
(require racket/list NumeriKet/linear-algebra/dot-product)

; Provide common matrix operations
(provide matrix-add matrix-multiply scalar-multiply)

; function: (matrix-add A B)
; Inputs:
;       * A: the first matrix addend
;       * B: the second matrix addend
(define (matrix-add A B) 
  (let* [(rows (length A))]
    (map (lambda (rowA rowB) (map (lambda (x y) (+ x y)) rowA rowB)) A B)))

; Provide implementation of matrix multiplication
(provide matrix-multiply get-row get-column)

; function get-row
; Inputs:
;       * i: the index of the row to return (starting from 0)
;       * matrix: the matrix whose row will be returned
; Output: the row at index i in matrix
(define get-row (lambda (i matrix) (list-ref matrix i)))

; function get-column
; Inputs:
;       * i: the index of the column to return (starting from 0)
;       * matrix: the matrix whose column will be returned
; Output: the column at index i in matrix
(define get-column 
  (lambda (i matrix) 
    (map (lambda (x) (list-ref x i)) matrix) ))

; function: matrix-multiply
; Inputs:
;       A: the matrix on the left hand side of the product
;       B: the matrix on the right hand side of the product
; Output: the matrix product AB
(define (matrix-multiply A B)
  (let* [(rows (length A))
         (columns (length (car B)))]
    (map (lambda (row) 
      (map (lambda (column) 
        (dot-product (get-row row A) 
          (get-column column B))) 
          (range columns))) (range rows))))

; function: (scalar-multiply a A)
; Inputs:
;       * a: the scalar to multiply the matrix by
;       * A: the matrix to be scaled
; Output: the matrix A with all of its elements scaled by a
(define (scalar-multiply a A)
    (map (lambda (row) (map (lambda (x) (* a x)) row)) A))
