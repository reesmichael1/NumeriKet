#lang racket/base

(require "newton-diff.rkt" "five-point.rkt")

; Provide wrapper for methods of numerical differentiation
(provide diff)

(define diff 
  (lambda (#:method [method "five-point"] f x)
            (if (equal? method "newton-diff") (newton-diff f x)
              (if (equal? method "five-point") (five-point f x)
              (error (string-append "diff: Method " method 
                                    " not implemented"))))))

