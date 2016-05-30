#lang racket/base

; Utility functions for NumeriKet

(provide round-to-precision)

; function: (found-to-precision r p)
; Inputs:
;       * r: the number that will be rounded
;       * p: the number of decimal places that will be left in r
; Output: r rounded to p decimal places
(define (round-to-precision r p)
    (/ (round (* (expt 10 p) r)) (expt 10 p)))
