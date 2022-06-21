#!/bin/bash
#*************************************************
# Woody Morrice - 11071060 - wam553
# CMPT214 - Assignment 5 - Fully-Implemented FORTH
#*************************************************
# Test Script for A5

count=0
fails=0

if [ "x$1" == "x" ]
then    # if no command line argument, run all tests
    for T in test/test*.in
    do
    count=$((count + 1))
        bin/forth  <  test/`basename ${T} .in`.in   \
        | diff -      test/`basename ${T} .in`.out  \
        | tee      >  test/`basename ${T} .in`.result
        if [ -s test/`basename ${T} .in`.result ]
        then
            fails=$((fails + 1))
        fi
    done
else    # run all tests listed
    for i in $@
    do
    T=test/test${i}.in
    count=$((count + 1))
        bin/forth  <  test/`basename ${T} .in`.in   \
        | diff -      test/`basename ${T} .in`.out  \
        | tee      >  test/`basename ${T} .in`.result
        if [ -s test/`basename ${T} .in`.result ]
        then
            fails=$((fails + 1))
        fi
    done
fi

# if one, display results
if [ 1 == "$count" ]
then
    if [ -s test/test${i}.result ]
    then
        cat test/test${i}.result
    else
        echo test passed
    fi
# otherwise display passed tests
else 
    echo "$count tests run, $fails failed and $((count - fails)) passed."
fi
echo "NOTE: One test fails on purpose for demonstration purposes"



# bin/forth  <  test/test3.in   \
# | diff -      test/test3.out  \
# | tee         test/test3.result

# ########################################################
# # Test 1 - Testing Makefile
# # Test each target, if any errors are reported, test failed

# # make  out/forth.o > test/test1.act
# # make squeaky clean

# # make  out/stack.o >> test/test1.act
# # make squeaky clean

# # make  out/dict.o >> test/test1.act
# # make squeaky clean

# # make  out/datum.o >> test/test1.act
# # make squeaky clean

# # make  bin/forth >> test/test1.act
# # make squeaky clean

# # make  forth >> test/test1.act
# # make squeaky clean

# # make  all >> test/test1.act
# # make squeaky clean


# # diff test/test1.act test/test1.out | tee test/test1.result
# # rm -f test/test1.act

# ########################################################
# # Test 2 - Testing Makefile debug target and dependencies
# # Test each target, if any errors are reported, test failed

# # make  out/forth-g.o > test/test2.act
# # make squeaky clean

# # make  out/stack-g.o >> test/test2.act
# # make squeaky clean

# # make  out/dict-g.o >> test/test2.act
# # make squeaky clean

# # make  out/datum-g.o >> test/test2.act
# # make squeaky clean

# # make  bin/forth-debug >> test/test2.act
# # make squeaky clean

# # make  debug >> test/test2.act
# # make squeaky clean

# # make  all >> test/test2.act
# # make squeaky clean


# # diff test/test2.act test/test2.out | tee test/test2.result
# # rm -f test/test2.act


# ########################################################
# # Test 3 - Testing if/else/then
# # popped value is not a bool

# bin/forth  <  test/test3.in   \
# | diff -      test/test3.out  \
# | tee         test/test3.result


# ########################################################
# # Test 4 - Testing if/else/then
# # testing both conditions and nested statements

# bin/forth  <  test/test4.in   \
# | diff -      test/test4.out  \
# | tee         test/test4.result

# ########################################################
# # Test 5 - Testing if/else/then
# # testing true statement to make sure it works

# bin/forth  <  test/test5.in   \
# | diff -      test/test5.out  \
# | tee         test/test5.result

# ########################################################
# # Test 6 - Testing if/else/then
# # testing false statement to make sure it works

# bin/forth  <  test/test6.in   \
# | diff -      test/test6.out  \
# | tee         test/test6.result

# ########################################################
# # Test 7 - Testing if/else/then
# # testing nested loops - true -> true

# bin/forth  <  test/test7.in   \
# | diff -      test/test7.out  \
# | tee         test/test7.result

# ########################################################
# # Test 8 - Testing if/else/then
# # testing nested loops - true -> false

# bin/forth  <  test/test8.in   \
# | diff -      test/test8.out  \
# | tee         test/test8.result

# ########################################################
# # Test 9 - Testing if/else/then
# # testing nested loops - false -> false

# bin/forth  <  test/test9.in   \
# | diff -      test/test9.out  \
# | tee         test/test9.result

# ########################################################
# # Test 10 - Testing if/else/then
# # testing nested loops - false -> true

# bin/forth  <  test/test10.in   \
# | diff -      test/test10.out  \
# | tee         test/test10.result

# ########################################################
# # Test 11 - Testing while loop
# # testing simple while loop

# bin/forth  <  test/test11.in   \
# | diff -      test/test11.out  \
# | tee         test/test11.result

# ########################################################
# # Test 12 - Testing while loop
# # testing nested while loop

# bin/forth  <  test/test12.in   \
# | diff -      test/test12.out  \
# | tee         test/test12.result

# ########################################################
# # Test 13 - Testing while loop
# # testing popped val not a bool

# bin/forth  <  test/test13.in   \
# | diff -      test/test13.out  \
# | tee         test/test13.result

# ########################################################
# # Test 14 - Testing while loop
# # testing popped val is false

# bin/forth  <  test/test14.in   \
# | diff -      test/test14.out  \
# | tee         test/test14.result

# ########################################################
# # Test 15 - Testing user defined commands
# # testing simple command

# bin/forth  <  test/test15.in   \
# | diff -      test/test15.out  \
# | tee         test/test15.result

# ########################################################
# # Test 16 - Testing user defined commands
# # testing command calling another command

# bin/forth  <  test/test16.in   \
# | diff -      test/test16.out  \
# | tee         test/test16.result