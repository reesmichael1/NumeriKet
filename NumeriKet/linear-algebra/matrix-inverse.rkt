#lang racket/base

; Provide implementation of calculating a matrix inverse
(provide matrix-inverse)

(require racket/list NumeriKet/linear-algebra/matrix-operations 
         NumeriKet/linear-algebra/identity-matrix)

; function: (get-transpose A)
; Inputs:
;       * A: a matrix, assumed to be square, to be transposed
; Output: the transpose of A
(define (get-transpose A)
  (map (lambda (column-index) 
         (map (lambda (row) (list-ref row column-index)) A)) 
       (range (length A))))

; function: (row-norm A)
; Inputs:
;       * A: the matrix whose norm will be calculated
; Output: the greatest absolute sum of a row of A
(define (row-norm A)
  (apply max (map (lambda (row) 
              (foldl (lambda (x y) (+ (abs x) (abs y))) 0 row)) A)))

; function: (inverse-algorithm-with-iterations A Vn n)
; Inputs:
;       * A: the matrix to use in the iteration
;       * Vn: the current guess at the inverse
;       * n: the number of iterations left
(define (inverse-algorithm-with-iterations A Vn n)
  (if (= n 0) (map (lambda (row) (map (lambda (el) (exact->inexact el)) row)) Vn)
    (let* [(N (length A))
           (inner1 (matrix-add (scalar-multiply -15 (identity-matrix N))
                               (matrix-multiply A Vn)))
           (inner2 (matrix-add (scalar-multiply 93 (identity-matrix N))
                               (matrix-multiply A 
                                            (matrix-multiply Vn inner1))))
           (inner3 (matrix-add (scalar-multiply -315 (identity-matrix N))
                               (matrix-multiply A
                                            (matrix-multiply Vn inner2))))
           (inner4 (matrix-add (scalar-multiply 651 (identity-matrix N))
                               (matrix-multiply A
                                            (matrix-multiply Vn inner3))))
           (inner5 (matrix-add (scalar-multiply -861 (identity-matrix N))
                               (matrix-multiply A
                                            (matrix-multiply Vn inner4))))
           (inner6 (matrix-add (scalar-multiply 735 (identity-matrix N))
                               (matrix-multiply A
                                            (matrix-multiply Vn inner5))))
           (inner7 (matrix-add (scalar-multiply -393 (identity-matrix N))
                               (matrix-multiply A
                                            (matrix-multiply Vn inner6))))
           (inner8 (matrix-add (scalar-multiply 120 (identity-matrix N))
                               (matrix-multiply A
                                            (matrix-multiply Vn inner7))))
           (VNext (scalar-multiply (/ 1 16) (matrix-multiply Vn inner8)))]
      (inverse-algorithm-with-iterations A VNext (- n 1)))))

(define (get-initial-guess A)
  (scalar-multiply (/ 1 (* (row-norm A) (row-norm (get-transpose A)))) (get-transpose A)))

; function: (matrix-inverse A)
; Inputs:
;       * A: the square matrix to invert
; Output: the matrix inverse of A
(define (matrix-inverse A #:n [n 5])
  (inverse-algorithm-with-iterations A (get-initial-guess A) n))
