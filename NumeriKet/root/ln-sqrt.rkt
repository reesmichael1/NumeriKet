#lang racket/base

; Provide an implementation of the square root function using ln
(provide ln-sqrt)

(require NumeriKet/ex/ln)
(require NumeriKet/ex/ex)

(define (ln-sqrt x)
  (if (> 0 x) (error "ln-sqrt: input must be non-negative")
    (if (= 0 x) 0
      (ex (* 0.5 (ln x))))))
