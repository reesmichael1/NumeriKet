#lang racket/base

(require "simpson.rkt")

; Provide wrapper for numerical integration methods
(provide integrate)

(define integrate
    (lambda (#:method [method "simpson"] f int)
        (if (equal? method "simpson") (simpson f int) 
            (error (string-append "integrate: Method " method 
                                  " not implemented")))))
