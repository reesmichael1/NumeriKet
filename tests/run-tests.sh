#!/usr/bin/sh

# The absolute, canonical ( no ".." ) path to this script
# See http://unix.stackexchange.com/a/76604
TEST_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")

echo "$TEST_DIR"

echo "euler-method-tests"
racket $TEST_DIR/ode-tests/euler-method-tests.rkt
echo "newton-diff-tests"
racket $TEST_DIR/diff-tests/newton-diff-tests.rkt
echo "newton-root-tests"
racket $TEST_DIR/newton-root-tests.rkt
echo "newton-sqrt-tests"
racket $TEST_DIR/newton-sqrt-tests.rkt
echo "simpson-tests"
racket $TEST_DIR/integration-tests/simpson-tests.rkt
echo "util-tests"
racket $TEST_DIR/util-tests.rkt
