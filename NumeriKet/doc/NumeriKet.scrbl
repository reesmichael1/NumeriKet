#lang scribble/manual

@(require (for-label racket) (for-label NumeriKet))

@title{NumeriKet}

A collection of Racket modules implementing numerical methods.

@section{Implemented Functions}
@subsection{Derivatives}
@defproc[(diff [f procedure?] [x0 number?] [#:method method string? 
    "newton-diff"]) number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0], using the method @racket[method]. 

    By default, @racket[five-point] is used.
}
@defproc[(five-point [f procedure?] [x0 number?]) number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0].

    This is implemented through the five point method with a step size of 1e-7.
}

@defproc[(newton-diff [f procedure?] [x0 number?]) number?]{
    Estimate the value of the derivative of @racket[f], a function of @racket[x], at the point @racket[x0].

    This is implemented through Newton's difference quotient with a step size of 1e-7.
}
@subsection{Exponential Function}
@defproc[(ex [x number?]) number?]{
    Approximate the value of raising the constant e to the power @racket[x].

    This is implemented through the algorithm described in this @hyperlink["http://math.stackexchange.com/a/55904" "Math Stack Exchange post"].
}
@subsection{Integrals}
@defproc[(integrate [f procedure?] [int list?] [#:method method string? 
    "simpson"]) number?]{
    Estimate the value of integrating @racket[f] over the interval @racket[int].

    By default, @racket[simpson] is used.
}
@defproc[(simpson [f procedure?] [int list?]) number?]{
    Estimate the value of integrating @racket[f] over the interval @racket[int]. 

    This is implemented through Simpson's rule. By default, @racket[int] is partitioned into intervals of length 0.001 up to a maximum of 50000 intervals. If the length of @racket[int] is greater than 50, then larger intervals are used to partition the interval into 50000 intervals.
}
@subsection{Root Finding}
@defproc[(square-root [x number?]) number?]{
    Approximate the square root of @racket[x].

    This is implemented through @racket[newton-root] by starting at the integer whose perfect square is the smallest perfect square less than or equal to @racket[x].
}
@defproc[(newton-root [f procedure?] [x0 number?]) number?]{
    Approximate the root of @racket[f] closest to @racket[x0]. 

    This is implemented through Newton's method for finding roots of real valued functions and uses ten iterations. Note that @racket[f] must have a continuous second derivative. 
}
@defproc[(newton-sqrt [s number?] [x0 number?]) number?]{
    Approximate the square root of @racket[s] by starting at @racket[x0]. 

    This is implemented through a specific case of @racket[newton-root] and uses one hundred iterations.
}
@subsection{Solving ODEs}
@defproc[(euler-method [f procedure?] [inits list?] [tf number?]) number?]{
    Given @racket[inits] of the form @racket['(t0 x0)], approximate the value of the solution of @racket[f] at @racket[tf], where @racket[(x t0)] is @racket[x0].

    This is implemented through Euler's method for solving first order differential equations, and uses a step size of 0.0001. Note that @racket[f], the flow of @racket[x] in time, is a function of @racket[t] and @racket[x] (in that order).
}
@subsection{Utility Functions}
@defproc[(round-to-precision [r number?] [p number?]) number?]{
    Round the value @racket[r] to @racket[p] decimal places.
}
