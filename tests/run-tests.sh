#!/usr/bin/sh

echo "diff-tests"
racket diff-tests.rkt
echo "euler-method-tests"
racket ode-tests/euler-method-tests.rkt
echo "newton-root-tests"
racket newton-root-tests.rkt
echo "newton-sqrt-tests"
racket newton-sqrt-tests.rkt
echo "simpson-tests"
racket integration-tests/simpson-tests.rkt
echo "util-tests"
racket util-tests.rkt
