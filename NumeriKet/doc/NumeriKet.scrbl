#lang scribble/manual

@(require (for-label racket) (for-label NumeriKet))

@title{NumeriKet}

A collection of Racket modules implementing numerical methods.

@section{Overview}

Basic numerical methods, such as 
@itemlist[@item{Newton's method for square roots}
          @item{Newton's method for roots of polynomials}
          @item{Euler's method for solving ordinary differential equations}]
are included. 

@codeblock|{
#lang racket/base
(require NumeriKet)

(newton-sqrt 4 4)
(newton-root (lambda (x) (- (sin x) (cos x) -1)) -1) 
}|

@verbatim|{
> racket test.rkt
2.0
-1.5707963267948966
}|

@section{Implemented Functions}
@subsection{Root Finding}
@defproc[(newton-root [f procedure?] [x0 number?]) number?]{
    Approximate the root of @racket[f] closest to @racket[x0]. 

    This is implemented through Newton's method for finding roots of real valued functions and uses ten iterations. Note that @racket[f] must have a continuous second derivative. 
}
@defproc[(newton-sqrt [s number?] [x0 number?]) number?]{
    Approximate the square root of @racket[s] by starting at @racket[x0]. 

    This is implemented through a specific case of @racket[newton-root] and uses ten iterations.
}

@subsection{Derivatives}
@defproc[(diff [f procedure?] [x0 number?]) number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0].

    This is implemented through Newton's difference quotient with a step size of 1e-7.
}

@subsection{Integrals}
@defproc[(simpson [f procedure?] [int list?]) number?]{
    Estimate the value of integrating @racket[f] over the interval @racket[int]. 

    This is implemented through Simpson's rule. By default, @racket[int] is partitioned into intervals of length 0.001 up to a maximum of 50000 intervals. If the length of @racket[int] (that is, @racket|{(- (second int) (first int)}|) is greater than 50, then larger intervals are used to partition the interval into 50000 intervals.
}

@subsection{Solving ODEs}
@defproc[(euler-method [f procedure?] [inits list?] [tf number?]) number?]{
    Given @racket[(define t0 (first inits))] and @racket[(define x0 (second inits))], approximate the value of the solution of @racket[f] at @racket[tf], where @racket[(x t0)] is @racket[x0].

    This is implemented through Euler's method for solving first order differential equations, and uses a step size of 0.0001. Note that @racket[f], the flow of @racket[x] in time, is a function of @racket[t] and @racket[x] (in that order).
}

@subsection{Utility Functions}
@defproc[(round-to-precision [r number?] [p number?]) number?]{
    Round the value @racket[r] to @racket[p] decimal places.
}
