#lang scribble/manual

@(require scribble/eval (for-label racket NumeriKet))

@title{NumeriKet}

A collection of Racket modules implementing numerical methods.

@section{Implemented Functions}
@subsection{Derivatives}

@(define diff-eval (make-base-eval))
@(define newton-diff-eval (make-base-eval))
@(define five-point-eval (make-base-eval))
     

@defproc[(diff [f procedure?] [x0 number?] [#:method method string? 
    "five-point"]) number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0], using the method @racket[method]. 

    By default, @racket[five-point] is used.
 
    @interaction-eval[#:eval diff-eval (require NumeriKet/diff/diff)]
    @examples[ 
        #:eval diff-eval
        (diff (lambda (x) x) 1)
        (diff (lambda (x) (+ (expt x 2) (* -2 x) 3)) 3.4)
        (diff (lambda (x) (exp x)) 1)
    ]
}

@defproc[(five-point [f procedure?] [x0 number?] [#:h h number? 1e-8]) 
    number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0].

    This is implemented through the @hyperlink["https://en.wikipedia.org/wiki/Five-point_stencil" "five point method"] with a step size of @racket[h].

    @interaction-eval[#:eval five-point-eval 
        (require NumeriKet/diff/five-point racket/math)]
    @examples[
        #:eval five-point-eval
        (five-point (lambda (x) x) 1)
        (five-point (lambda (x) 1) 1)
        (five-point (lambda (x) (sin x)) (/ pi 2))]
}

@defproc[(newton-diff [f procedure?] [x0 number?] [#:h h number? 1e-8])
    number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0].

    This is implemented through @hyperlink["https://en.wikipedia.org/wiki/Difference_quotient" "Newton's difference quotient"] with a step size of @racket[h].

    @interaction-eval[#:eval newton-diff-eval 
        (require NumeriKet/diff/newton-diff racket/math)]
    @examples[
        #:eval newton-diff-eval
        (newton-diff (lambda (x) x) 1)
        (newton-diff (lambda (x) 1) 1)
        (newton-diff (lambda (x) (sin x)) (/ pi 2))]
}

@subsection{Exponential Function and Natural Logarithm}

@(define ex-eval (make-base-eval))
@(define ln-eval (make-base-eval))

@defproc[(ex [x number?]) number?]{
    Approximate the value of raising the constant e to the power @racket[x].

    This is implemented through the algorithm described in this @hyperlink["http://math.stackexchange.com/a/55904" "Math Stack Exchange post"].

    @interaction-eval[#:eval ex-eval (require NumeriKet/ex/ex racket/math)]
    @examples[
        #:eval ex-eval
        (ex 0)
        (ex 1)
        (ex pi)
        (ex 103.17)]
}

@defproc[(ln [x number?]) number?]{
    Approximate the natural logarithm of @racket[x].

    This is implemented through solving the equation e^y - x = 0 for y with @racket[newton-root]. The initial guess is the number of times that @racket[e] needs to be divided into @racket[x] to produce a number smaller than 1.

    @interaction-eval[#:eval ln-eval (require NumeriKet/ex/ln 
        NumeriKet/ex/ex math/base)]
    @examples[
        #:eval ln-eval
        (ln 1)
        (ln euler.0)
        (ln 1038.87913)
        (ex (ln 1038.87913))]
}

@(define integrate-eval (make-base-eval))
@(define simpson-eval (make-base-eval))

@subsection{Integrals}
@defproc[(integrate [f procedure?] [int list?] [#:method method string? 
    "simpson"]) number?]{
    Estimate the value of integrating @racket[f] over the interval @racket[int].

    By default, @racket[simpson] is used.

    @interaction-eval[#:eval integrate-eval 
        (require NumeriKet/integration/integrate)]
    @examples[ 
        #:eval integrate-eval 
        (integrate (lambda (x) 1) '(0 1))
        (integrate (lambda (x) (cos x)) '(-3.141592653589 3.141592653589))
        (integrate (lambda (x) (exp x)) '(0 1))]
}

@defproc[(simpson [f procedure?] [int list?]) number?]{
    Estimate the value of integrating @racket[f] over the interval @racket[int]. 

    This is implemented through @hyperlink["https://en.wikipedia.org/wiki/Simpson%27s_rule#Composite_Simpson.27s_rule" "Simpson's rule"]. By default, @racket[int] is partitioned into intervals of length 0.001 up to a maximum of 50000 intervals. If the length of @racket[int] is greater than 50, then larger intervals are used to partition the interval into 50000 intervals.

    @interaction-eval[#:eval simpson-eval
        (require NumeriKet/integration/simpson)]
    @examples[
        #:eval simpson-eval
        (simpson (lambda (x) (expt x 2)) '(0 4))
        (simpson (lambda (x) (sin x)) '(0 3.141592653589))
        (simpson (lambda (x) (+ 1 (* 2 x) (* 3 (expt x 2)) 
                                    (* 4 (expt x 3)))) '(0 10))]
}

@(define dot-product-eval (make-base-eval))
@(define identity-eval (make-base-eval))
@(define matrix-inverse-eval (make-base-eval))
@(define norm-eval (make-base-eval))

@subsection{Linear Algebra}

@defproc[(dot-product [v1 list?] [v2 list?]) list?]{
    Calculate the @hyperlink["https://en.wikipedia.org/wiki/Dot_product" "dot product"] of the vectors @racket[v1] and @racket[v2].

    @racket[v1] and @racket[v2] should themselves be lists.

    @interaction-eval[#:eval dot-product-eval 
        (require NumeriKet/linear-algebra/dot-product)]
    @examples[
        #:eval dot-product-eval
        (dot-product '(1) '(2))
        (dot-product '(1 2 3) '(4 5 6))
        (dot-product '(1 -1) '(1 1))]
}

@defproc[(identity-matrix [n integer?]) list?]{
    Create an @racket[n]x@racket[n] identity matrix.

    @interaction-eval[#:eval identity-eval
        (require NumeriKet/linear-algebra/identity-matrix)]
    @examples[
        #:eval identity-eval
        (identity-matrix 2)
        (identity-matrix 4)]
}

@defproc[(matrix-inverse [A list?] [#:n n number? 5]) list?]{
    Calculate the inverse of the matrix @racket[A].

    This is implemented through the algorithm described by @hyperlink["http://www.hindawi.com/journals/ijmms/2012/134653/" "Soleymani in 2012"]. Note that this implementation is very slow, and is infeasible for large matrices. A faster algorithm will be implemented soon.
    
    @interaction-eval[#:eval matrix-inverse-eval
        (require NumeriKet/linear-algebra/matrix-inverse)]
    @examples[
        #:eval matrix-inverse-eval
        (matrix-inverse '((1 0) (0 1)))
        (matrix-inverse '((2 0 0) (0 3 2) (0 0 -1)))]
}

@defproc[(norm [v list?]) number?]{
    Calculate the @hyperlink["https://en.wikipedia.org/wiki/Euclidean_distance" "Euclidean norm"] of a given vector @racket[v] in R^n.
    
    @racket[v] can either be a list of single element lists (a column vector) or a list of numbers (a row vector).
    
    @interaction-eval[#:eval norm-eval 
        (require NumeriKet/linear-algebra/norm)]
    @examples[
        #:eval norm-eval
        (norm '(1 2 3))
        (norm '((1) (2) (3)))
        (norm '(-1 2 -3 4 -5))]
}

@(define power-iteration-eval (make-base-eval))

@subsubsection{Eigenvalues and Eigenvectors}

@defproc[(power-iteration [A list?] [#:n n integer? 1000]) number?]{
    Approximate the dominant eigenvalue of a matrix @racket[A]. @racket[A] should be given as a list of lists, where each sub-list corresponds to a row of the matrix. If there are no dominant eigenvalues, @racket[0] is returned.

    This is implemented through the @hyperlink["https://en.wikipedia.org/wiki/Power_iteration" "power iteration"] method with @racket[n] iterations.

    @interaction-eval[#:eval power-iteration-eval 
        (require NumeriKet/linear-algebra/power-iteration)]
    @examples[
        #:eval power-iteration-eval
        (power-iteration '((1 0) (0 1)))
        (power-iteration '((1 2 3) (4 5 6) (7 8 9)))
        (power-iteration '((1 0) (0 -1)))]
}

@(define matrix-add-eval (make-base-eval))
@(define matrix-multiply-eval (make-base-eval))
@(define matrix-subtract-eval (make-base-eval))
@(define scalar-multiply-eval (make-base-eval))

@subsubsection{Matrix Operations}

@defproc[(matrix-add [A list?] [B list?]) list?]{
    Add two matrices @racket[A] and @racket[B].

    @racket[A] and @racket[B] should be lists of lists, where each sub-list corresponds to a matrix row.

    @interaction-eval[#:eval matrix-add-eval 
        (require NumeriKet/linear-algebra/matrix-operations)]
    @examples[
        #:eval matrix-add-eval
        (matrix-add '((1 0) (0 1)) '((1 0) (0 1)))
        (matrix-add '((1 2 3) (3 2 1)) '((0 0 0) (0 0 0)))
        (matrix-add '((1 2 3) (3 2 1)) '((-1 -2 -3) (-3 -2 -1)))]
}

@defproc[(matrix-multiply [A list?] [B list?]) list?]{
    Multiply two matrices @racket[A] and @racket[B].

    @racket[A] and @racket[B] should be lists of lists, where each sub-list corresponds to a matrix row.

    @interaction-eval[#:eval matrix-multiply-eval
        (require NumeriKet/linear-algebra/matrix-operations)]
    @examples[
        #:eval matrix-multiply-eval
        (matrix-multiply '((1 0) (0 1)) '((2 3) (5 -1)))
        (matrix-multiply '((1 2 3 4) (5 6 7 8) 
                           (-9 -10 -11 -12) (-13 -14 -15 -16))
                         '((16 15 14 13) (12 11 10 9)
                           (-8 -7 -6 -5) (-4 -3 -2 -1)))]
}

@defproc[(matrix-subtract [A list?] [B list?]) list?]{
    Subtract a matrix @racket[B] from a matrix @racket[A].

    @racket[A] and @racket[B] should each be lists of lists, where each element corresponds to a matrix row.

    @interaction-eval[#:eval matrix-subtract-eval
        (require NumeriKet/linear-algebra/matrix-operations)]
    @examples[
        #:eval matrix-subtract-eval
        (matrix-subtract '((1 0) (0 1)) '((1 0) (0 1)))
        (matrix-subtract '((1) (2) (3)) '((4) (5) (6)))]
}

@defproc[(scalar-multiply [a number?] [A list?]) list?]{
    Multiply a matrix @racket[A] by a scalar @racket[a]. 

    @racket[A] should be a list of lists, where each sub-list corresponds to a matrix row.

    @interaction-eval[#:eval scalar-multiply-eval
        (require NumeriKet/linear-algebra/matrix-operations)]
    @examples[
        #:eval scalar-multiply-eval
        (scalar-multiply 2 '((1 0) (0 1)))
        (scalar-multiply -13 '((3.8 1 -29) (1 2 3) (-3 -2 1)))]
}

@(define jacobi-eval (make-base-eval))

@subsubsection{Solving Linear Systems}

@defproc[(jacobi [A list?] [b list?] [#:n n number? 1000] 
        [#:warn-converge warn-converge boolean? #t]) list?]{
    Solve the linear system @racket[A]@racket[x] = @racket[b] for some unknown vector @racket[x]. 

    @racket[A] should be a list of lists, where each sub-list corresponds to a matrix row, and @racket[b] should be a list of single element lists, where each sub-list contains an element of the vector.

    This is implemented through the @hyperlink["https://en.wikipedia.org/wiki/Jacobi_method" "Jacobi method"] with @racket[n] iterations. Note that, for the vector @racket[x] to necessarily converge, @racket[A] must be either strictly diagonally dominant or diagonally dominant and irreducible. If @racket[A] does not meet these conditions and @racket[warn-converge] is @racket[#t], an error will be returned.

    @(italic "Note: technically, the current check for convergence may return some false positives. Once a better method for finding the dominant eigenvalue has been implemented, this should be improved.")

    @interaction-eval[#:eval jacobi-eval 
        (require NumeriKet/linear-algebra/jacobi)]
    @examples[
        #:eval jacobi-eval
        (jacobi '((1 0) (0 1)) '((2) (0.5)))
        (jacobi '((7 -2 1 2) (2 8 3 1) (-1 0 5 2) (0 2 -1 4)) 
          '((3) (-2) (5) (4)))
        (jacobi '((1 3) (10 10)) '((1) (1)))]
}

@(define square-root-eval (make-base-eval))
@(define ln-sqrt-eval (make-base-eval))
@(define newton-root-eval (make-base-eval))
@(define newton-sqrt-eval (make-base-eval))

@subsection{Root Finding}
@defproc[(square-root [x number?] [#:method method string? "newton-sqrt"])
    number?]{
    Approximate the square root of @racket[x].

    By default, for @racket[x] less than @racket[1e28], this is implemented through @racket[newton-sqrt] by starting at the integer whose perfect square is the smallest perfect square less than or equal to @racket[x]. For @racket[x] greater than or equal to @racket[1e28], this is implemented through @racket[ln-sqrt] (due to performance).

    @interaction-eval[#:eval square-root-eval 
        (require NumeriKet/root/square-root racket/math)]
    @examples[
        #:eval square-root-eval
        (square-root 100)
        (square-root pi)
        (square-root 3827164936632198.1837642)]
}

@defproc[(ln-sqrt [x number?]) number?]{
    Approximate the square root of @racket[x] by evaluating the expession e^(0.5 ln(x)).
}

@defproc[(newton-root [f procedure?] [x0 number?] [#:n n number? 100])
    number?]{
    Approximate the root of @racket[f] closest to @racket[x0]. 

    This is implemented through @hyperlink["https://en.wikipedia.org/wiki/Newton's_method" "Newton's method"] for finding roots of real valued functions and uses @racket[n] iterations. Note that @racket[f] must have a continuous second derivative. 

    @interaction-eval[#:eval newton-root-eval 
        (require NumeriKet/root/newton-root)]
    @examples[
        #:eval newton-root-eval
        (newton-root (lambda (x) x) 1)
        (newton-root (lambda (x) (- (cos x) x)) 0)
        (newton-root (lambda (x) (- (exp x) 2)) 1)]
}

@defproc[(newton-sqrt [s number?] [x0 number?] [#:n n number? 100])
    number?]{
    Approximate the square root of @racket[s] by starting at @racket[x0]. 

    This is implemented through a specific case of @racket[newton-root] and uses @racket[n] iterations.

    @interaction-eval[#:eval newton-sqrt-eval
        (require NumeriKet/root/newton-sqrt racket/math)]
    @examples[
        #:eval newton-sqrt-eval
        (newton-sqrt 4 1)
        (newton-sqrt pi 1)
        (newton-sqrt 148 12)]
}

@(define euler-method-eval (make-base-eval))

@subsection{Solving ODEs}
@defproc[(euler-method [f procedure?] [inits list?] [tf number?] 
    [#:h h number? 1e-4]) number?]{
    Given @racket[inits] of the form @racket['(t0 x0)], approximate the value of the solution of @racket[f] at @racket[tf], where @racket[(x t0)] is @racket[x0].

    This is implemented through @hyperlink["https://en.wikipedia.org/wiki/Euler_method" "Euler's method"] for solving first order differential equations, and uses a step size of @racket[h]. Note that @racket[f], the flow of @racket[x] in time, is a function of @racket[t] and @racket[x] (in that order).

    @interaction-eval[#:eval euler-method-eval 
        (require NumeriKet/ode/euler-method)]
    @examples[
        #:eval euler-method-eval
        (euler-method (lambda (t x) 1) '(0 1) 3)
        (euler-method (lambda (t x) (* t (cos x))) '(0 1) 2)]
}

@(define round-to-precision-eval (make-base-eval))

@subsection{Utility Functions}
@defproc[(round-to-precision [r number?] [p number?]) number?]{
    Round the value @racket[r] to @racket[p] decimal places.

    @interaction-eval[#:eval round-to-precision-eval 
        (require NumeriKet/util)]
    @examples[
        #:eval round-to-precision-eval
        (round-to-precision 4 3)
        (round-to-precision 4.3 0)
        (round-to-precision 17.876324 5)
        (round-to-precision -4.873 1)]
}
