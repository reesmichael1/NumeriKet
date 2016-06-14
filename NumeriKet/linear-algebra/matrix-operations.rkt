#lang racket/base

; for range
(require racket/list NumeriKet/linear-algebra/dot-product)

; Provide common matrix operations
(provide matrix-add matrix-subtract matrix-multiply scalar-multiply
         get-row get-column)

; Provide verification functions for unit testing
(provide verify-for-adding verify-for-multiplication)

; function (verify-for-adding A B)
; Inputs:
;       * A: the first matrix to check
;       * B: the matrix that will be compared to A
;       * n1: the number of columns expected in A, starts at -1
;       * n2: the number of columns expected in B, starts at -1
; Output: a boolean, #t if A and B have identical dimensions, #f otherwise
(define (verify-for-adding A B #:n1 [n1 -1] #:n2 [n2 -1])
  (let* [(ARows (length A))
         (BRows (length B))]
    (if (and (= ARows 0) (= BRows 0)) #t
      (if (or (= ARows 0) (= BRows 0)) #f
        (let*[(AColumns (length (first A)))
              (BColumns (length (first B)))]
          (if (and (= n1 -1) (= n2 -1))
            (verify-for-adding A B #:n1 AColumns #:n2 BColumns)
            (if (not (and (= AColumns n1) (= BColumns n2))) #f
              (if (not (= ARows BRows)) #f
                (if (not (= AColumns BColumns))
                  #f (verify-for-adding (rest A) (rest B) #:n1 n1 #:n2 n2)
                  )))))))))

; function (remove-column M)
; Inputs:
;       * M: a (non-empty) matrix whose first column will be removed
; M with its first column removed. If M has one column, '(()) is returned.
(define (remove-column M)
  (if (= (length M) 0) null 
    (if (= (length (first M)) 1) (remove-column (rest M))
      (cons (rest (first M)) (remove-column (rest M))))))

; function (verify-for-multiplication A B)
; Inputs: 
;       * A: the first matrix to check
;       * B: the matrix that will be compared to A
; Output: #t if A and B have the same number of rows/columns, #f otherwise
(define (verify-for-multiplication A B)
  (let* [(ARows (length A))
         (BRows (length B))]
    (if (and (= ARows 0) (= BRows 0)) #t
      (if (not (and (verify-for-adding A A) (verify-for-adding B B))) #f
        (let* [(BColumns (length (first B)))]
          (if (not (= ARows BColumns)) #f
            (verify-for-multiplication (rest A) (remove-column B))))))))

; function: (matrix-add A B)
; Inputs:
;       * A: the first matrix addend
;       * B: the second matrix addend
(define (matrix-add A B) 
  (if (verify-for-adding A B)
    (map (lambda (rowA rowB) (map (lambda (x y) (+ x y)) rowA rowB)) A B)
    (error "matrix-add: given matrices not valid for adding")))

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

; function (matrix-subtract A B)
; Inputs:
;       * A: the first matrix
;       * B: the matrix subtracted from A
; Output: the difference of A and B
(define (matrix-subtract A B) 
  (if (verify-for-adding A B)
    (matrix-add A (scalar-multiply -1 B))
    (error "matrix-subtract: given matrices not valid for subtraction")))
