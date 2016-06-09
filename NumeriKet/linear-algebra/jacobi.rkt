#lang racket/base

(require racket/list NumeriKet/linear-algebra/matrix-multiply
         NumeriKet/linear-algebra/scalar-multiply
         NumeriKet/linear-algebra/matrix-add)

; Provide implementation of Jacobi method for solving linear systems
(provide jacobi)

; function: (get-starting-vector n)
; Inputs:
; 		* n: the dimension of the vector to create
; Output: a list of n lists, where each list contains a single 1
(define (get-starting-vector n)     
  (build-list n (lambda (r) (build-list 1 (lambda (c) 1)))))

; function (set-list-to-zero-except-at-index L n)
; Inputs:
;       * L: a list o numbers
;       * n: the index at which L should not be 0
; Output: a list the length of L set to 0 except at n, the same as L's nth
(define (set-list-to-zero-except-at-index L n)
  (if (= n 0) (cons (/ 1 (first L)) (build-list (length (rest L)) 
                                                (lambda (x) 0)))
    (cons 0 (set-list-to-zero-except-at-index (rest L) (- n 1)))))

; function (get-diagonal A)
; Inputs:
;       * A: the square matrix whose diagonal elements will be found
; Output: a square matrix with A's diagonal inverse and zeros elsewhere
(define (get-diagonal-inverse A)
  (map (lambda (row n) (set-list-to-zero-except-at-index row n))
       A (range (length A))))

; function (set-list-to-zero-at-index L n)
; Inputs:
;       * L: a list of numbers
;       * n: the index at which L should be set to 0
; Output: a list identical to L except at index n, where it is 0
(define (set-list-to-zero-at-index L n)
  (if (= n 0) (cons 0 (rest L)) 
    (cons (first L) (set-list-to-zero-at-index (rest L) (- n 1)))))

; function (get-remainder A)
; Inputs:
;       * A: the square matrix whose remainder will be found
; Output: a square matrix with a zero diagonal and A's elements elsewhere
(define (get-remainder A)
  (map (lambda (row n) (set-list-to-zero-at-index row n)) 
       A (range (length A))))

; function: (jacobi-with-iterations A b x n)
; Inputs:
;       * A: a square matrix describing the system
;       * b: the value of Ax, where x is the unkown
;       * x: an approximation of the unknown vector
;       * n: an optional argument specifying the number of iterations to use
; Output: x, the unknown vector such that Ax = b
(define (jacobi-with-iterations A b x n)
  (if (= n 0) x
    (let* [(DInverse (get-diagonal-inverse A))
           (R (get-remainder A))
           (xNext (matrix-multiply DInverse 
                    (matrix-add b 
                      (scalar-multiply -1 
                        (matrix-multiply R x)))))]
      (jacobi-with-iterations A b xNext (- n 1))))) 

; function: (jacobi A b)
; Inputs:
;       * A: a square matrix describing the system
;       * b: the value of Ax, where x is the unkown
;       * n: an optional argument specifying the number of iterations to use
; Output: x, the unknown vector such that Ax = b
(define (jacobi A b #:n [n 1000]) 
  (map (lambda (x) (list (exact->inexact (first x)))) 
       (jacobi-with-iterations A b (get-starting-vector (length A)) n)))
