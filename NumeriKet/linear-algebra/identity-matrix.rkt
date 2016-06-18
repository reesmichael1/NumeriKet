#lang racket/base

(require racket/list)

; Provide implementation of getting identity matrix
(provide identity-matrix)

; function: (identity-matrix n)
; Inputs:
;       * n: an integer, the requested dimension of the identity matrix
; Output: an identity matrix of dimension n
(define (identity-matrix n)
  (if (integer? n)
    (map (lambda (row) (map (lambda (column) (if (= column row) 1 0)) 
                            (range n))) (range n))
    (error "identity-matrix: given length is not an integer")))
