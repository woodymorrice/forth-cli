#!/bin/sh
#*************************************************
# Woody Morrice - 11071060 - wam553
# CMPT214 - Assignment 5 - Fully-Implemented FORTH
#*************************************************
# Test Script for A5


########################################################
# Test 1 - Testing Makefile
# Test each target, if any errors are reported, test failed

# make  out/forth.o > test/test1.act
# make squeaky clean

# make  out/stack.o >> test/test1.act
# make squeaky clean

# make  out/dict.o >> test/test1.act
# make squeaky clean

# make  out/datum.o >> test/test1.act
# make squeaky clean

# make  bin/forth >> test/test1.act
# make squeaky clean

# make  forth >> test/test1.act
# make squeaky clean

# make  all >> test/test1.act
# make squeaky clean


# diff test/test1.act test/test1.out | tee test/test1.result
# rm -f test/test1.act

########################################################
# Test 2 - Testing Makefile debug target and dependencies
# Test each target, if any errors are reported, test failed

# make  out/forth-g.o > test/test2.act
# make squeaky clean

# make  out/stack-g.o >> test/test2.act
# make squeaky clean

# make  out/dict-g.o >> test/test2.act
# make squeaky clean

# make  out/datum-g.o >> test/test2.act
# make squeaky clean

# make  bin/forth-debug >> test/test2.act
# make squeaky clean

# make  debug >> test/test2.act
# make squeaky clean

# make  all >> test/test2.act
# make squeaky clean


# diff test/test2.act test/test2.out | tee test/test2.result
# rm -f test/test2.act


########################################################
# Test 3 - Testing if/else/then
# popped value is not a bool

bin/forth  <  test/test3.in   \
| diff -      test/test3.out  \
| tee         test/test3.result


########################################################
# Test 4 - Testing if/else/then
# testing both conditions and nested statements

bin/forth  <  test/test4.in   \
| diff -      test/test4.out  \
| tee         test/test4.result

########################################################
# Test 5 - Testing if/else/then
# testing true statement to make sure it works

bin/forth  <  test/test5.in   \
| diff -      test/test5.out  \
| tee         test/test5.result

########################################################
# Test 6 - Testing if/else/then
# testing false statement to make sure it works

bin/forth  <  test/test6.in   \
| diff -      test/test6.out  \
| tee         test/test6.result

########################################################
# Test 7 - Testing if/else/then
# testing nested loops - true -> true

bin/forth  <  test/test7.in   \
| diff -      test/test7.out  \
| tee         test/test7.result

########################################################
# Test 8 - Testing if/else/then
# testing nested loops - true -> false

bin/forth  <  test/test8.in   \
| diff -      test/test8.out  \
| tee         test/test8.result

########################################################
# Test 9 - Testing if/else/then
# testing nested loops - false -> false

bin/forth  <  test/test9.in   \
| diff -      test/test9.out  \
| tee         test/test9.result

########################################################
# Test 10 - Testing if/else/then
# testing nested loops - false -> true

bin/forth  <  test/test10.in   \
| diff -      test/test10.out  \
| tee         test/test10.result

########################################################
# Test 11 - Testing while loop
# testing simple while loop

bin/forth  <  test/test11.in   \
| diff -      test/test11.out  \
| tee         test/test11.result

########################################################
# Test 12 - Testing while loop
# testing nested while loop

bin/forth  <  test/test12.in   \
| diff -      test/test12.out  \
| tee         test/test12.result