#lang racket/base

(require "./e-const.rkt")

; Provide implementation of exponential function
; Implemented through algorithm from http://math.stackexchange.com/a/55904
(provide ex)

; function: ex-frac
; Inputs: 
;       * b: a real number in [0, 1)
; Output: the value of e^b, accurate to 8 decimal places
(define (ex-frac b)
    (ex-frac-with-iterations b 100 1)
)

; function: ex-frac-with-iterations
; Inputs:
;       * b: a real number in [0, 1)
;       * n: the number of iterations, total
;       * m: the number of the current iteration
; Output: the value of e^b, using n iterations
(define (ex-frac-with-iterations b n m)
    (if (> m n) 1 (+ 1 (* (/ b m) (ex-frac-with-iterations b n (+ 1 m))))))

; function: ex
; Inputs:
;       * x: the power to which e is raised
; Output: the value of e^x
(define (ex x) 
    (let* [(a (floor x))
           (b (- x (floor x)))
           (e-intpower (expt e-const a))] 
      (* e-intpower (ex-frac b)))
)
