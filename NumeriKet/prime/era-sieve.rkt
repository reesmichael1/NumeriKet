#lang racket/base

(require racket/list)

; Provide implementation of Sieve of Eratosthenes
(provide era-sieve)

; function: (get-limit L N)
; Inputs:
;       * L: the current guess at the upper limit
;       * N: the number of primes to generate
; Output: the range up to which the sieve should search
(define (get-limit L N)
  ; For some reason, ln is extremely slow here
  (if (> (/ L (log L)) N) L (get-limit (+ 1 L) N)))

; function: (remove-composites L)
; Inputs:
;       * L: the list whose composite elements should be removed
; Output: a list of all of the elements of L that are prime
(define (remove-elements L)
  (if (null? L) '()
  (cons (first L) 
        (remove-elements 
          (filter (lambda (n) (not (= (modulo n (first L)) 0))) L)))))

; function: (era-sieve N)
; Inputs:
;       * N: the number of prime numbers to generate
; Output: a list of the first N prime numbers
(define (era-sieve N)
  (let* [(L (get-limit 2 N))
         (initial-list (range 2 L))]
    (take (remove-elements initial-list) N)))
