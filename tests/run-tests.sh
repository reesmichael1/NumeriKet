#!/bin/sh

# The absolute, canonical ( no ".." ) path to this script
# See http://unix.stackexchange.com/a/76604
TEST_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")

echo "$TEST_DIR"

echo "dot-product-tests"
racket $TEST_DIR/linear-algebra-tests/dot-product-tests.rkt
echo "euler-method-tests"
racket $TEST_DIR/ode-tests/euler-method-tests.rkt
echo "ex-tests"
racket $TEST_DIR/ex-tests/ex-tests.rkt
echo "five-point-tests"
racket $TEST_DIR/diff-tests/five-point-tests.rkt
echo "ln-sqrt-tests"
racket $TEST_DIR/root-tests/ln-sqrt-tests.rkt
echo "ln-tests"
racket $TEST_DIR/ex-tests/ln-tests.rkt
echo "matrix-multiply-tests"
racket $TEST_DIR/linear-algebra-tests/matrix-multiply-tests.rkt
echo "newton-diff-tests"
racket $TEST_DIR/diff-tests/newton-diff-tests.rkt
echo "newton-root-tests"
racket $TEST_DIR/root-tests/newton-root-tests.rkt
echo "newton-sqrt-tests"
racket $TEST_DIR/root-tests/newton-sqrt-tests.rkt
echo "norm-tests"
racket $TEST_DIR/linear-algebra-tests/norm-tests.rkt
echo "power-iteration-tests"
racket $TEST_DIR/linear-algebra-tests/power-iteration-tests.rkt
echo "scalar-multiply-tests"
racket $TEST_DIR/linear-algebra-tests/scalar-multiply-tests.rkt
echo "simpson-tests"
racket $TEST_DIR/integration-tests/simpson-tests.rkt
echo "square-root-tests"
racket $TEST_DIR/root-tests/square-root-tests.rkt
echo "util-tests"
racket $TEST_DIR/util-tests.rkt
