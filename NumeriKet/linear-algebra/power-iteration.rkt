#lang racket/base

; Provide power iteration method to find dominant eigenvalue
(provide power-iteration)

(require NumeriKet/linear-algebra/norm NumeriKet/linear-algebra/dot-product
         NumeriKet/linear-algebra/matrix-multiply
         NumeriKet/linear-algebra/scalar-multiply racket/list)

; function: (get-starting-vector n)
; Inputs:
; 		* n: the dimension of the vector to create
; Output: a list of n lists, where each list contains a single 1
(define (get-starting-vector n)     
  (build-list n (lambda (r) (build-list 1 (lambda (c) 1)))))

; function: (power-iteration-with-steps A b n)
; Inputs:
;       * A: the matrix whose dominant eigenvalue will be found
;       * b: a vector in the sequence used to find the eigenvalue
;       * n: the number of steps left in the iteration
; Output: the dominant eigenvalue of A
(define (power-iteration-with-steps A b n)
  (if (= n 0) (/ (dot-product (flatten b) 
                              (flatten (matrix-multiply A b))) 
                 (dot-product (flatten b) (flatten b)))
    (let* [(Ab (matrix-multiply A b))
           (normAb (norm Ab))
           (bNext (scalar-multiply (/ 1 normAb) Ab))]
      (power-iteration-with-steps A bNext (- n 1)))))

; function: (power-iteration A #:n)
; Inputs:
;       * A: the matrix whose dominant eigenvalue will be found
;       * n: an optional argument describing how many steps to use
; Output: the dominant eigenvalue of A
(define power-iteration (lambda (A #:n [n 1000])
  (power-iteration-with-steps A (get-starting-vector (length A)) n)))
