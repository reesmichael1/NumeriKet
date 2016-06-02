#lang racket/base

(require "newton-diff.rkt")

; Provide wrapper for methods of numerical differentiation
(provide diff)

(define diff 
  (lambda (#:method [method "newton-diff"] f x)
            (if (equal? method "newton-diff") (newton-diff f x)
              (error (string-append "diff: Method " method 
                                    " not implemented")))))

