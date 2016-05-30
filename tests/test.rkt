#lang racket/base

;; Utility file for testing

(provide approximate?)

(define (approximate? a b) (< (abs (- a b)) 0.00001))
