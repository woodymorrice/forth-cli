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
rm -f out/forth.o

make  out/stack.o >> test/test1.act
rm -f out/stack.o

make  out/dict.o >> test/test1.act
rm -f out/dict.o

make  out/datum.o >> test/test1.act
rm -f out/datum.o

make  bin/forth >> test/test1.act
rm -f out/forth.o out/stack.o out/dict.o out/datum.o bin/forth

make  forth >> test/test1.act
rm -f out/forth.o out/stack.o out/dict.o out/datum.o bin/forth

make  all >> test/test1.act
rm -f out/forth.o out/stack.o out/dict.o out/datum.o bin/forth


diff test/test1.act test/test1.out | tee test/test1.result
rm -f test/test1.act

