#!/bin/sh
#*************************************************
# Woody Morrice - 11071060 - wam553
# CMPT214 - Assignment 5 - Fully-Implemented FORTH
#*************************************************
# Test Script for A5


########################################################
# Test 1 - Testing Makefile
# Test each target, if any errors are reported, test failed

make  out/forth.o > test/test1.act
make squeaky clean

make  out/stack.o >> test/test1.act
make squeaky clean

make  out/dict.o >> test/test1.act
make squeaky clean

make  out/datum.o >> test/test1.act
make squeaky clean

make  bin/forth >> test/test1.act
make squeaky clean

make  forth >> test/test1.act
make squeaky clean

make  all >> test/test1.act
make squeaky clean


diff test/test1.act test/test1.out | tee test/test1.result
rm -f test/test1.act

########################################################
# Test 2 - Testing Makefile debug target and dependencies
# Test each target, if any errors are reported, test failed

make  out/forth-g.o > test/test2.act
make squeaky clean

make  out/stack-g.o >> test/test2.act
make squeaky clean

make  out/dict-g.o >> test/test2.act
make squeaky clean

make  out/datum-g.o >> test/test2.act
make squeaky clean

make  bin/forth-debug >> test/test2.act
make squeaky clean

make  debug >> test/test2.act
make squeaky clean

make  all >> test/test2.act
make squeaky clean


diff test/test2.act test/test2.out | tee test/test2.result
rm -f test/test2.act


########################################################
# Test 3 - Testing if/else/then
# popped value is not a bool

bin/forth  <  test.test3.in   \
| diff -      test/test3.out  \
| tee         test/test3.result


########################################################
# Test 4 - Testing if/else/then
# testing both conditions and nested statements

bin/forth  <  test.test4.in   \
| diff -      test/test4.out  \
| tee         test/test4.result
