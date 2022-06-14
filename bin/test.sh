#!/bin/sh
#/************************************************
#Woody Morrice - 11071060 - wam553
#CMPT214 - Assignment 5 - Fully-Implemented FORTH
#************************************************/


echo 'Building Project and Running Tests...'
echo '...'

# Compile
g++ -pedantic -Wall -std=c++17 -c -o ./out/datum.o ./src/datum.cc
g++ -pedantic -Wall -std=c++17 -c -o ./out/forth.o ./src/forth.cc
g++ -pedantic -Wall -std=c++17 -c -o ./out/stack.o ./src/stack.cc
g++ -pedantic -Wall -std=c++17 -c -o ./out/dict.o ./src/dict.cc

# Link
g++ -pedantic -Wall -std=c++17 -lm -o ./bin/forth ./out/datum.o ./out/forth.o ./out/stack.o ./out/dict.o

# Test

# Template
# Test : 
# Input: 
# Expected Output: 
# ./bin/forth < ./test/test.in \
# | diff - ./test/test.out     \
# | tee ./test/test.result     \


# Initial Tests

# NOTE: diff does not recognize stderr, will not be included in output, but noted in test cases

# Test 0: Testing files copied over from A3 - compile and run
# Input: none
# Expected Output: none - compiles and runs
./bin/forth < ./test/test0.in \
| diff - ./test/test0.out     \
| tee ./test/test0.result      \

# Test 1: Testing test script 
# Input: ."hello" space ."world" + + .
# Expected Output: hello world
./bin/forth < ./test/test1.in \
| diff - ./test/test1.out     \
| tee ./test/test1.result     \


# Debug Mode Tests

# Test 2: debug mode with an empty stack
# Input: .
# Expected Output: stack empty
#                  stack empty
./bin/forth -d < ./test/test2.in \
| diff - ./test/test2.out     \
| tee ./test/test2.result     \

# Test 3: One item in stack
# Input: ."hello"
# Expected Output: hello
./bin/forth -d < ./test/test3.in \
| diff - ./test/test3.out     \
| tee ./test/test3.result     \

# Test 4: Six items in the stack
# Input: ."hello" true 3.1415 ."greetings" false 23760
# Expected Output: hello
#                 true hello
#                 3.1415 true hello
#                 greetings 3.1415 true hello
#                 false greetings 3.1415 true hello
#                 23760 false greetings 3.1415 true hello
./bin/forth -d < ./test/test4.in \
| diff - ./test/test4.out     \
| tee ./test/test4.result     \

# Test 5: Seven items in the stack
# Input: ."hello" true 3.1415 ."greetings" false 23760 ."foobar"
# Expected Output: hello
                #  true hello
                #  3.1415 true hello
                #  greetings 3.1415 true hello
                #  false greetings 3.1415 true hello
                #  23760 false greetings 3.1415 true hello
                #  foobar 23760 false greetings 3.1415 true
./bin/forth -d < ./test/test5.in \
| diff - ./test/test5.out     \
| tee ./test/test5.result     \

# Test 6: After popping the only item in the stack
# Input: ."hello" .
# Expected Output: hello -- debug mode
                #  hello -- . output
                #  stack empty -- debug mode
./bin/forth -d < ./test/test6.in \
| diff - ./test/test6.out     \
| tee ./test/test6.result     \

# Test 7: After performing a ternary operation
# Input: ."hello" 2 2 substring .
# Expected Output: hello
                #  2 hello
                #  2 2 hello
                #  l
                #  l
                #  stack empty
./bin/forth -d < ./test/test7.in \
| diff - ./test/test7.out     \
| tee ./test/test7.result     \


# not -- Boolean Negation Operator Tests

# Test 8: true to false
# Input: true not .
# Expected Output: false
./bin/forth -v < ./test/test8.in \
| diff - ./test/test8.out     \
| tee ./test/test8.result     \

# Test 9: false to true
# Input: false not .
# Expected Output: true
./bin/forth -v < ./test/test9.in \
| diff - ./test/test9.out     \
| tee ./test/test9.result     \

# Test 10: empty stack
# Input: not
# Expected Output: stack empty
./bin/forth < ./test/test10.in \
| diff - ./test/test10.out     \
| tee ./test/test10.result     \

# Test 11: not a boolean
# Input: ."hello" not
# Expected Output: USER ERROR: not a bool to negate in verbose mode, otherwise no output
./bin/forth < ./test/test11.in \
| diff - ./test/test11.out     \
| tee ./test/test11.result     \


# and -- Binary Boolean Operator Tests

# Test 12: not 2 vals on stack
# Input: and
# Expected Output: binary ops require at least 2 values on the stack
./bin/forth < ./test/test12.in \
| diff - ./test/test12.out     \
| tee ./test/test12.result     \

# Test 13: not both bools
# Input: ."hello" true and
# Expected Output: none // USER ERROR: invalid operands to op 'not'
./bin/forth < ./test/test13.in \
| diff - ./test/test13.out     \
| tee ./test/test13.result     \

# Test 14: both true
# Input: true true and . .
# Expected Output: true
#                  stack empty
./bin/forth < ./test/test14.in \
| diff - ./test/test14.out     \
| tee ./test/test14.result     \

# Test 15: both false
# Input: false false and . .
# Expected Output: false
#                  stack empty
./bin/forth < ./test/test15.in \
| diff - ./test/test15.out     \
| tee ./test/test15.result     \

# Test 16: both different bools
# Input: true false and . .
# Expected Output: false
#                  stack empty
./bin/forth < ./test/test16.in \
| diff - ./test/test16.out     \
| tee ./test/test16.result     \


# or -- Binary Boolean Operator Tests


# Test 17: not 2 vals on stack
# Input: or
# Expected Output: binary ops require at least 2 values on the stack
./bin/forth < ./test/test17.in \
| diff - ./test/test17.out     \
| tee ./test/test17.result     \

# Test 18: not both bools
# Input: ."hello" true or
# Expected Output: none // USER ERROR: invalid operands to op 'or'
./bin/forth < ./test/test18.in \
| diff - ./test/test18.out     \
| tee ./test/test18.result     \

# Test 19: both true
# Input: true true or . .
# Expected Output: true
#                  stack empty
./bin/forth < ./test/test19.in \
| diff - ./test/test19.out     \
| tee ./test/test19.result     \

# Test 20: both false
# Input: false false or . .
# Expected Output: false
#                  stack empty
./bin/forth < ./test/test20.in \
| diff - ./test/test20.out     \
| tee ./test/test20.result     \

# Test 21: both different bools
# Input: true false or . .
# Expected Output: true
#                  stack empty
./bin/forth < ./test/test21.in \
| diff - ./test/test21.out     \
| tee ./test/test21.result     \


# BOOL -- Binary Comparison Operators

# NOTE: Will not be testing for not enough operands anymore 
# (empty stack, 1 too few, 2 too few) because that piece of 
# code has already been tested, and based on white box test 
# methodology, it is redundant.

# Test 22: = - are equal
# Input: true true = .
# Expected Output: true
./bin/forth < ./test/test22.in \
| diff - ./test/test22.out     \
| tee ./test/test22.result     \

# Test 23: = - are not equal
# Input: true false = .
# Expected Output: false
./bin/forth < ./test/test23.in \
| diff - ./test/test23.out     \
| tee ./test/test23.result     \

# Test 24: != - are equal
# Input: true true != .
# Expected Output: false
./bin/forth < ./test/test24.in \
| diff - ./test/test24.out     \
| tee ./test/test24.result     \

# Test 25: != - are not equal
# Input: false true != .
# Expected Output: true
./bin/forth < ./test/test25.in \
| diff - ./test/test25.out     \
| tee ./test/test25.result     \


# STRING -- Binary Comparison Operators

# Test 26: = - are equal
# Input: ."hello" ."hello" = .
# Expected Output: true
./bin/forth < ./test/test26.in \
| diff - ./test/test26.out     \
| tee ./test/test26.result     \

# Test 27: = - are not equal
# Input: ."hello" ."goodbye" = .
# Expected Output: false
./bin/forth < ./test/test27.in \
| diff - ./test/test27.out     \
| tee ./test/test27.result     \

# Test 28: != - are equal
# Input: ."hello" ."hello" != .
# Expected Output: false
./bin/forth < ./test/test28.in \
| diff - ./test/test28.out     \
| tee ./test/test28.result     \

# Test 29: != - are not equal
# Input: ."hello" ."goodbye" != .
# Expected Output: true
./bin/forth < ./test/test29.in \
| diff - ./test/test29.out     \
| tee ./test/test29.result     \

# Test 30: > - is greater than
# Input: ."bbbbbb" ."aaaaaa" > .
# Expected Output: true
./bin/forth < ./test/test30.in \
| diff - ./test/test30.out     \
| tee ./test/test30.result     \

# Test 31: > - is lesser than
# Input: ."aaaaaa" ."bbbbbb" > .
# Expected Output: false
./bin/forth < ./test/test31.in \
| diff - ./test/test31.out     \
| tee ./test/test31.result     \

# Test 32: < - is greater than
# Input: ."bbbbbb" ."aaaaaa" < .
# Expected Output: false
./bin/forth < ./test/test32.in \
| diff - ./test/test32.out     \
| tee ./test/test32.result     \

# Test 33: < - is lesser than
# Input: ."bbbbbb" ."aaaaaa" < .
# Expected Output: true
./bin/forth < ./test/test32.in \
| diff - ./test/test32.out     \
| tee ./test/test32.result     \

# Test 34: >= - is greater than
# Input: ."bbbbbb" ."aaaaaa" >= .
# Expected Output: true
./bin/forth < ./test/test34.in \
| diff - ./test/test34.out     \
| tee ./test/test34.result     \

# Test 35: >= - is lesser than
# Input: ."aaaaaa" ."bbbbbb" >= .
# Expected Output: false
./bin/forth < ./test/test35.in \
| diff - ./test/test35.out     \
| tee ./test/test35.result     \

# Test 36: >= - are equal
# Input: ."aaaaaa" ."aaaaaa" >= .
# Expected Output: true
./bin/forth < ./test/test36.in \
| diff - ./test/test36.out     \
| tee ./test/test36.result     \

# Test 37: <= - is greater than
# Input: ."bbbbbb" ."aaaaaa" <= .
# Expected Output: false
./bin/forth < ./test/test37.in \
| diff - ./test/test37.out     \
| tee ./test/test37.result     \

echo '...'

# Test 38: <= - is lesser than
# Input: ."bbbbbb" ."aaaaaa" <= .
# Expected Output: true
./bin/forth < ./test/test38.in \
| diff - ./test/test38.out     \
| tee ./test/test38.result     \

# Test 39: <= - are equal
# Input: ."bbbbbb" ."bbbbbb"  <= .
# Expected Output: true
./bin/forth < ./test/test39.in \
| diff - ./test/test39.out     \
| tee ./test/test39.result     \


# FLOAT -- Binary Comparison Operators

# Test 40: = - are equal
# Input: 15 15 = .
# Expected Output: true
./bin/forth < ./test/test40.in \
| diff - ./test/test40.out     \
| tee ./test/test40.result     \

# Test 41: = - are not equal
# Input: 15 28 = .
# Expected Output: false
./bin/forth < ./test/test41.in \
| diff - ./test/test41.out     \
| tee ./test/test41.result     \

# Test 42: != - are equal
# Input: 99 99 != .
# Expected Output: false
./bin/forth < ./test/test42.in \
| diff - ./test/test42.out     \
| tee ./test/test42.result     \

# Test 43: != - are not equal
# Input: 3.45 66.6 != .
# Expected Output: true
./bin/forth < ./test/test43.in \
| diff - ./test/test43.out     \
| tee ./test/test43.result     \

# Test 44: > - is greater than
# Input: 99 33 > .
# Expected Output: true
./bin/forth < ./test/test44.in \
| diff - ./test/test44.out     \
| tee ./test/test44.result     \

# Test 45: > - is lesser than
# Input: 33 99 > .
# Expected Output: false
./bin/forth < ./test/test45.in \
| diff - ./test/test45.out     \
| tee ./test/test45.result     \

# Test 46: < - is greater than
# Input: 99 33 < .
# Expected Output: false
./bin/forth < ./test/test46.in \
| diff - ./test/test46.out     \
| tee ./test/test46.result     \

# Test 47: < - is lesser than
# Input: 33 99 < .
# Expected Output: true
./bin/forth < ./test/test47.in \
| diff - ./test/test47.out     \
| tee ./test/test47.result     \

# Test 48: >= - is greater than
# Input: 99 33 >= .
# Expected Output: true
./bin/forth < ./test/test48.in \
| diff - ./test/test48.out     \
| tee ./test/test48.result     \

# Test 49: >= - is lesser than
# Input: 33 99 >= .
# Expected Output: false
./bin/forth < ./test/test49.in \
| diff - ./test/test49.out     \
| tee ./test/test49.result     \

# Test 50: >= - are equal
# Input: 99 99 >= .
# Expected Output: true
./bin/forth < ./test/test50.in \
| diff - ./test/test50.out     \
| tee ./test/test50.result     \

# Test 51: <= - is greater than
# Input: 99 33 <= .
# Expected Output: false
./bin/forth < ./test/test51.in \
| diff - ./test/test51.out     \
| tee ./test/test51.result     \

# Test 52: <= - is lesser than
# Input: 33 99 <= .
# Expected Output: true
./bin/forth < ./test/test52.in \
| diff - ./test/test52.out     \
| tee ./test/test52.result     \

# Test 53: <= - are equal
# Input: 99 99 <= .
# Expected Output: true
./bin/forth < ./test/test53.in \
| diff - ./test/test53.out     \
| tee ./test/test53.result     \

# White box tests for comparison operators

# Test 54: invalid operands -- only need to do this once, same code for every operator
# Input: ."hello" 12345 < .
# Expected Output: 12345 hello -- and stderr
./bin/forth < ./test/test54.in \
| diff - ./test/test54.out     \
| tee ./test/test54.result     \

# Test 55: invalid operator -- code written for this is just-in-case, should never actually be reached
# Input: 54321 12345 =\= .
# Expected Output: 12345 54321 -- and stderr
./bin/forth < ./test/test55.in \
| diff - ./test/test55.out     \
| tee ./test/test55.result     \

# Dictionary Tests

# Test 56: Adding an entry: name is not a string
# Input: true true constant . .
# Expected Output: true true -- user error: entry name is not a string
./bin/forth < ./test/test56.in \
| diff - ./test/test56.out     \
| tee ./test/test56.result     \

# Test 57: Adding an entry: no data to commit
# Input: ."helloworld" constant .
# Expected Output: helloworld -- error: not enough values in the stack
./bin/forth < ./test/test57.in \
| diff - ./test/test57.out     \
| tee ./test/test57.result     \

# Test 58: Adding an entry: already an entry with the same name
# Input: ."helloworld" ."hello" space ."world" + + constant
       # ."helloworld" ."hello" space ."world" + + constant . .
# Expected Output: hello world -- Dict error: already an entry with that name
              #    helloworld
              #    stack empty
./bin/forth < ./test/test58.in \
| diff - ./test/test58.out     \
| tee ./test/test58.result     \

# Test 59: Adding an entry: successful insertion of constant
# Input: ."pi" 3.1415 constant .
# Expected Output: stack empty
./bin/forth < ./test/test59.in \
| diff - ./test/test59.out     \
| tee ./test/test59.result     \

# Test 60: Adding an entry: successful insertion of variable
# Input: ."helloworld" ."hello" space ."world" + + variable . .
# Expected Output: stack empty
./bin/forth < ./test/test60.in \
| diff - ./test/test60.out     \
| tee ./test/test60.result     \

# Test 61: Adding an entry: already with the same name as an existing command
# Input: ."fix" ."fix" constant . .
# Expected Output: fix fix -- USER ERROR: entry cannot have the same name as an existing command
./bin/forth < ./test/test61.in \
| diff - ./test/test61.out     \
| tee ./test/test61.result     \

# Test 62: Calling an entry: calling a constant
# Input: ."PI" 3.1415 constant . . pi 0 + .
# Expected Output: stack empty
                 # stack empty
                 # 3.1415
./bin/forth < ./test/test62.in \
| diff - ./test/test62.out     \
| tee ./test/test62.result     \

# Test 63: Calling an entry: calling a variable
# Input: ."hello" ."hello" variable . . hello space ."world" + + .
# Expected Output: stack empty
              #    stack empty
              #    hello world
./bin/forth < ./test/test63.in \
| diff - ./test/test63.out     \
| tee ./test/test63.result     \

# Test 64: Calling an entry: entry does not exist
# Input: PI .
# Expected Output: stack empty -- USER ERROR: unrecognized op
./bin/forth < ./test/test64.in \
| diff - ./test/test64.out     \
| tee ./test/test64.result     \

# Test 65: Changing an entry: variable name is wrong or entry does not exist
# Input: ."pi" 3.14 variable pi . . ."pie" ."yum" set . . .
# Expected Output: 3.14 stack empty yum pie stack empty -- error on set
./bin/forth < ./test/test65.in \
| diff - ./test/test65.out     \
| tee ./test/test65.result     \

# Test 66: Changing an entry: trying to change a constant
# Input: ."pi" 3.14 constant pi . . ."pie" ."yum" set . . .
# Expected Output: 3.14 stack empty yum pie stack empty -- error on set
./bin/forth < ./test/test66.in \
| diff - ./test/test66.out     \
| tee ./test/test66.result     \

# Test 67: Changing an entry: name is not a string
# Input: ."pi" 3.14 constant pi . . 3.14 ."yum" set . . .
# Expected Output: 3.14 stack empty yum 3.14 stack empty -- error on set
./bin/forth < ./test/test67.in \
| diff - ./test/test67.out     \
| tee ./test/test67.result     \

# Test 68: Changing an entry: no datum to change it to
# Input: ."pi" 3.14 constant pi . . ."yum" set . . 
# Expected Output: 3.14 stack empty yum stack empty -- not enough values in stack
./bin/forth < ./test/test68.in \
| diff - ./test/test68.out     \
| tee ./test/test68.result     \

# Test 69: Changing an entry: successful change
# Input: ."pi" 3.14 variable pi . . ."pi" ."yum" set pi . .
# Expected Output: 3.14 stack empty yum stack empty -- error on set
./bin/forth < ./test/test69.in \
| diff - ./test/test69.out     \
| tee ./test/test69.result     \

# Test 70: Importing an initial dictionary: no dictionary specified
# Input: list_dict
# Expected Output: none -- empty dictionary
./bin/forth -f < ./test/test70.in \
| diff - ./test/test70.out     \
| tee ./test/test70.result     \

# # Test 71: Importing an initial dictionary: invalid dictionary specified
# # Input: list_dict
# # Expected Output: none -- empty dictionary
./bin/forth -f "" < ./test/test71.in \
| diff - ./test/test71.out     \
| tee ./test/test71.result     \

# Test 72: Importing an initial dictionary: empty dictionary specified
# Input: list_dict
# Expected Output: none -- empty dictionary
./bin/forth -f "./lib/empty.lib" < ./test/test72.in \
| diff - ./test/test72.out     \
| tee ./test/test72.result     \

# Test 73: Importing an initial dictionary: dictionary filled with garbage
# Input: list_dict
# Expected Output: none -- empty dictionary
./bin/forth -f "./lib/garbage.lib" < ./test/test73.in \
| diff - ./test/test73.out     \
| tee ./test/test73.result     \

# Test 74: Importing an initial dictionary: a valid dictionary
# Input: list_dict
# Expected Output:     class: CMPT270
                     # nsid: wam553
                     # last_name: Morrice
                     # first_name: Woody
                     # golden_ratio: 1.618034
                     # speed_of_light: 186.000000
                     # sqrt2: 1.414214
                     # e: 2.718282
                     # pi: 3.141593
./bin/forth -f "./lib/default.lib" < ./test/test74.in \
| diff - ./test/test74.out     \
| tee ./test/test74.result     \


echo "Tests complete"