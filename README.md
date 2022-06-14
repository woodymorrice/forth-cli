/** Woody Morrice - 11071060 - wam553 - CMPT214 - Assignment 4 - FORTH **/

## FORTH

FORTH is a procedural, stack-oriented programming language and command line environment. It combines a compiler with an integrated multitasking command shell. The user performs computations using subroutines and variables called 'words' that can be defined and changed by the user, as well as imported when running the program. Parameters are pushed to and popped from a stack, so expressions are formed using postfix notation.


## What is Postfix Notation?

Postfix (or Reverse Polish Notation) is a mathematical notation where the operator appears after the operands, i.e., the operator between operands is taken out and placed after the operands. For example:

3 + 4

would be written in postfix notation as:

3 4 +

Simple!


## Installation

If you haven't got a compiler (or don't even know what that is), you're in luck! Simply navigate to the bin folder found in the same folder as this README and run the 'forth' program!

Compiling the source code:
Note: Requires any C++ compiler that supports C++17, or specifically the GNU C++ compiler (g++) if you are using the shell script.
Simply run the build.sh script located in bin/ from your favorite Unix command line to build the calculator, and run it using bin/forth or by typing bin/forth from the command line while in the top level directory of this project.


## Requirements

A computer, that runs, preferably.


## Usage

Help:

    The command line argument '-h' will print out a short help documentation. But if you're reading this, you probably won't need it.

Verbose Mode:

    Use the command line argument -v to enable Verbose Mode. It will provide you with many helpful messages about if something goes wrong,
    or if you're not using the program correctly.

Debug Mode:

    Use the command line argument -d to enable Debug Mode. It will print up to the top six values on the stack to the console after each command is executed.

Importing Dictionaries:

    To import a dictionary of constants and/or variables (stored as a set of commands in a text file) use the command line argument -f followed by the file location.


Adding Values to the Stack:

    Numbers:
    To add a number to the stack, type it in and press enter.

    3.345345
    enter

    Strings:
    To add a string to the stack, type it in preceded by a . and enclosed in double quotes and press enter.

    ."hello world"
    enter

    Booleans:
    To add booleans, type true or false, and press enter.

    true
    enter

Adding or Editing Entries in the Dictionary:

    The dictionary is a repository of custom commands and variables that the user can define and change at will. Each entry must have a unique name, but the values stored in variables and commands can be changed. There are two types of values that can currently be added to the dictionary:

    Variables: The user can assign a name to a value and place it in the dictionary, and if they wish to be able to change it later, they may define it as a variable. To store a variable:
        name: value: command:
        ."pi" 3.1415 variable
    To change a variable:
        ."pi" ."pie" set

    Constants: Constants behave the same way as variables, except they cannot be changed.
    To store a constant
        ."pi" 3.1415 constant

    Commands will be added in the next patch.


Commands:

    . -- The most important command, pops the top value off the stack. The '=' button in the context of a calculator. Must be at least one value in the stack.

    rot -- Rotates the top three arguments on the stack: the second-from-top becomes the top, the third-from-top becomes the second-from-top, and the top of the stack gets moved down to third-from top. Must be at least three values on the stack.

    dup -- Takes the top element on the stack and duplicates it. Must be at least one value in the stack.

    drop -- Pops the top element from the stack and discards it. Must be at least one value in the stack.

    swap -- Swaps the top two elements of the stack. Must be at least two values on the stack.

    space -- Pushes a string onto the stack containing only a space. Useful for creating strings that are sentences.

    newline -- Pushes a newline character onto the stack. Useful if you are writing a novel.

    substring -- Returns a substring of the string in the third position on the stack, using the number second from the top of the stack as the starting index, and the number at the top of the stack as the ending index. Must be at least three values on the stack.
        input:
        ."hello" space "world" + + . 0 4 substring .
        output:
        hello world
        hello

Boolean Operations:

    There are a multitude of ways to manipulate and produce booleans.

    not -- If the top element is a boolean, replaces it with the opposite boolean. Must be at least one value in the stack.

    or -- Analyzes two booleans, if both are false it pushes a false onto the stack, otherwise it pushes a true. Must be at least two values on the stack.

    not -- Analyzes two booleans, if both are true it pushes a true to the stack, otherwise it pushes a false. Must be at least two values on the stack.

    = -- Checks two values of the same type and returns true if they are equal, and false otherwise. Must be at least two values on the stack.

    != -- Checks two values of the same type and returns true if they are not equal, false otherwise. Must be at least two values on the stack.

    > -- Compares numbers and strings. If the first value is greater than the second, returns true. Must be at least two values on the stack.

    < -- Compares numbers and strings. If the first value is less than the second, returns true. Must be at least two values on the stack.

    >= -- Compares numbers and strings. If the first value is greater than or equal to the second, returns true. Must be at least two values on the stack.

    <= -- Compares numbers and strings. If the first value is less than or equal to than the second, returns true. Must be at least two values on the stack.


The Mathematical Operations and How to Use Them:

    After any operation, press '.' to display the result (It works the same as the '=' did on any calculator you have used before).

    Addition: To add two numbers together, type each number separated by a space, followed by the '+' sign. E.g.:
                            3 4 +
                            .
                            7
    Subtraction: To subtract the second number from the first (the order matters!), type each number separated by a space, followed by the '-' sign. E.g.:
                            3 4 -
                            .
                            -1
    Multiplication: To multiply two numbers together, type each number separated by a space, followed by the "*" sign. E.g.:
                            3 4 *
                            .
                            12
    Division: To divide the first number by the second number (the order matters!), type each number separated by a space, followed by the '/' sign. E.g.:
                            3 4 /
                            .
                            0.75
    Exponentiation: To get the first number to the power of the second number (the order matters!), type each number separated by a space, followed by the '^' sign. E.g.:
                            3 4 ^
                            .
                            81
    Decimal Truncation (Fix): Must be at least one value in the stack. The first number is the number you want to truncate, the second number is the number of decimals you want to display. E.g.:
                            3.1415 2 fix
                            .
                            3.14

    Longer Operations Work Too!

    As long as there is a number stored to do an operation with, you can do successive calculations. As soon as you press '.' it will display the result of your most recent calculation and you will not be able to use that number in any further calculation (unless you type it in again).


## Support

Contact wam553@usask.ca if you need any more help, or would like to express any questions, comments, or concerns.


## Roadmap

Stack Functionality

    Stack functionality was implemented on May 21st and updated on May 28th.

RPN Calculator

    RPN Calculator functionality, including +,-,*,/,^ and fix operations implemented the week of May 22nd.

Support for Multiple Data Types

    Implemented support for multiple data types on Monday, May 30th.

Stack Manipulation

    rot(), dup(), drop() and swap() for the user to manipulate the stack on Tuesday, May 31st.

String Arithmetic

    Added for the user the ability to concatenate and multiply strings on Wednesday, June 1st.

Other String Tools

    Added commands to push spaces and newlines to the stack, and a substring command to extract strings from other strings on Wednesday, June 1st.

Debug Mode

    Added -d command line argument that displays up to the top 6 values on the stack after each command is executed on Saturday, June 4th.

Boolean Operations and Comparison Operations

    Added boolean 'and' and 'or' operations as well as =, !=, >, <, >=, <= for all applicable data types on June 5th.
    
The Dictionary

    Users can define and store variables and constants in the dictionary (a repository of custom commands). Variables can also be edited by the user. Implemented on June 6th.

Importing Dictionaries

    Users can use a the command line argument -f and provide the location of a text file of commands defining some default variables and constants. Implemented on June 6th.

MORE CHANGES COMING... Words, if statements, and while loops...


## Authors and acknowledgment

Special thanks to Professor Chris Dutchyn for providing the resources and motivation for this project.
I'd also like to thank my mom. Thanks mom!


## License

This is the property of the University of Saskatchewan, licensed in perpetuity, until the heat death of the universe.

## Testing

All tests performed documented here. Expected behavior achieved (possibly after a bug fix) unless otherwise documented.
NOTE: verbose mode causes test script to print concerning messages when tests are passing so it won't be used unless necessary, will just test with pop() instead. Also debug mode will only be used when necessary to keep input and output from being unnecessarily complex.
NOTE: diff only analyzes stdout and does not recognize stderr, so stderr will not be included in .out files, but it will be noted in test cases.


Initial Tests

Test 0: Testing files copied over from A3 - compile and run
Input: none
Expected Output: none - compiles and runs
Actual Output: test passed

Test 1: Testing test script 
Input: ."hello" space ."world" + + .
Expected Output: hello world - test.result should be empty
Actual Output: test passed

Debug Mode Tests
./bin/forth -d

Test 2: debug mode with an empty stack
Input: .
Expected Output: stack empty
                 stack empty
Actual Output: test passed

Test 3: One item in stack
Input ."hello"
Expected Output: hello
Actual Output: test passed

Test 4: Six items in the stack
Input: ."hello" true 3.1415 ."greetings" false 23760
Expected Output: hello
                 true hello
                 3.1415 true hello
                 greetings 3.1415 true hello
                 false greetings 3.1415 true hello
                 23760 false greetings 3.1415 true hello
Actual Output: test passed

Test 5: Seven items in the stack
Input: ."hello" true 3.1415 ."greetings" false 23760 ."foobar"
Expected Output: hello
                 true hello
                 3.1415 true hello
                 greetings 3.1415 true hello
                 false greetings 3.1415 true hello
                 23760 false greetings 3.1415 true hello
                 foobar 23760 false greetings 3.1415 true
Actual Output: test passed

Test 6: After popping the only item in the stack
Input: ."hello" .
Expected Output: hello -- debug mode
                 hello -- . output
                 stack empty -- debug mode
Actual Output: test passed

Test 7: After performing a ternary operation
Input: ."hello" 2 2 substring .
Expected Output: hello
                 2 hello
                 2 2 hello
                 l
                 l
                 stack empty
Actual Output: test passed


not -- Boolean Negation Operator Tests

Test 8: true to false
Input: true not .
Expected Output: false
Actual Output: test passed

Test 9: false to true
Input: false not .
Expected Output: true
Actual Output: test passed

Test 10: empty stack
Input: not
Expected Output: stack empty
Actual Output: test passed

Test 11: not a boolean
Input: ."hello" not .
Expected Output: USER ERROR: not a bool to negate
Actual Output: test passed
NOTE: diff does not recognize stderr, will not be included in output, but noted in test cases


and -- Binary Boolean Operator Tests

Test 12: not 2 vals on stack
Input: and
Expected Output: binary ops require at least 2 values on the stack
Actual Output: test passed

Test 13: not both bools
Input: ."hello" true and
Expected Output: none // USER ERROR: invalid operands to op 'not'
Actual Output: test passed

Test 14: both true
Input: true true and . .
Expected Output: true
                 stack empty
Actual Output: test passed

Test 15: both false
Input: false false and . .
Expected Output: false
                 stack empty
Actual Output: test passed

Test 16: both different bools
Input: true false and . .
Expected Output: false
                 stack empty
Actual Output: test passed


or -- Binary Boolean Operator Tests


Test 17: not 2 vals on stack
Input: or
Expected Output: binary ops require at least 2 values on the stack
Actual Output: test passed

Test 18: not both bools
Input: ."hello" true or
Expected Output: none // USER ERROR: invalid operands to op 'or'
Actual Output: test passed

Test 19: both true
Input: true true or . .
Expected Output: true
                 stack empty
Actual Output: test passed

Test 20: both false
Input: false false or . .
Expected Output: false
                 stack empty
Actual Output: test passed

Test 21: both different bools
Input: true false or . .
Expected Output: true
                 stack empty
Actual Output: test passed


BOOL -- Binary Comparison Operators

NOTE: Will not be testing for not enough operands anymore (empty stack, 1 too few, 2 too few) because that piece of code has already been tested, and based on white box test methodology, it is redundant.


Test 22: = - are equal
Input: true true = .
Expected Output: true
Actual Output: test passed

Test 23: = - are not equal
Input: true false = .
Expected Output: false
Actual Output: bug with boolean in/equality, fixing...

Test 24: != - are equal
Input: true true != .
Expected Output: false
Actual Output: test passed

Test 25: != - are not equal
Input: false true != .
Expected Output: true
Actual Output: bug with boolean in/equality, fixing...


STRING -- Binary Comparison Operators

Test 26: = - are equal
Input: ."hello" ."hello" = .
Expected Output: true
Actual Output: test passed

Test 27: = - are not equal
Input: ."hello" ."goodbye" = .
Expected Output: false
Actual Output: test passed

Test 28: != - are equal
Input: ."hello" ."hello" != .
Expected Output: false
Actual Output: test passed

Test 29: != - are not equal
Input: ."hello" ."goodbye" != .
Expected Output: true
Actual Output: test passed

Test 30: > - is greater than
Input: ."bbbbbb" ."aaaaaa" > .
Expected Output: true
Actual Output: test passed

Test 31: > - is lesser than
Input: ."aaaaaa" ."bbbbbb" > .
Expected Output: false
Actual Output: test passed

Test 32: < - is greater than
Input: ."bbbbbb" ."aaaaaa" < .
Expected Output: false
Actual Output: test passed

Test 33: < - is lesser than
Input: ."bbbbbb" ."aaaaaa" < .
Expected Output: true
Actual Output: test passed

Test 34: >= - is greater than
Input: ."bbbbbb" ."aaaaaa" >= .
Expected Output: true
Actual Output: test passed

Test 35: >= - is lesser than
Input: ."aaaaaa" ."bbbbbb" >= .
Expected Output: false
Actual Output: test passed

Test 36: >= - are equal
Input: ."aaaaaa" ."aaaaaa" >= .
Expected Output: true
Actual Output: test passed

Test 37: <= - is greater than
Input: ."bbbbbb" ."aaaaaa" <= .
Expected Output: false
Actual Output: test passed

Test 38: <= - is lesser than
Input: ."aaaaaa" ."bbbbbb" <= .
Expected Output: true
Actual Output: mistyped input, false positive, fixed. test passed.

Test 39: <= - are equal
Input: ."bbbbbb" ."bbbbbb"  <= .
Expected Output: true
Actual Output: test passed


FLOAT -- Binary Comparison Operators

Test 40: = - are equal
Input: 15 15 = .
Expected Output: true
Actual Output: test passed

Test 41: = - are not equal
Input: 15 28 = .
Expected Output: false
Actual Output: test passed

Test 42: != - are equal
Input: 99 99 != .
Expected Output: false
Actual Output: test passed

Test 43: != - are not equal
Input: 3.45 66.6 != .
Expected Output: true
Actual Output: test passed

Test 44: > - is greater than
Input: 99 33 > .
Expected Output: true
Actual Output: test passed

Test 45: > - is lesser than
Input: 33 99 > .
Expected Output: false
Actual Output: test passed

Test 46: < - is greater than
Input: 99 33 < .
Expected Output: false
Actual Output: test passed

Test 47: < - is lesser than
Input: 33 99 < .
Expected Output: true
Actual Output: test passed

Test 48: >= - is greater than
Input: 99 33 >= .
Expected Output: true
Actual Output: test passed

Test 49: >= - is lesser than
Input: 33 99 >= .
Expected Output: false
Actual Output: test passed

Test 50: >= - are equal
Input: 99 99 >= .
Expected Output: true
Actual Output: test passed

Test 51: <= - is greater than
Input: 99 33 <= .
Expected Output: false
Actual Output: test passed

Test 52: <= - is lesser than
Input: 33 99 <= .
Expected Output: true
Actual Output: test passed

Test 53: <= - are equal
Input: 99 99 <= .
Expected Output: true
Actual Output: test passed


White box tests for comparison operators

Test 54: invalid operands -- white box test, only need to do this once, same code for every operator
Input: ."hello" 12345 < .
Expected Output: 12345 hello -- and stderr
Actual Output:  test passed

Test 55: invalid operator -- code written for this is just-in-case, should never actually be reached
Input: 54321 12345 =\=
Expected Output: 12345 54321 -- and stderr
Actual Output: test passed


Dictionary Tests

Test 56: Adding an entry: name is not a string
Input: true true constant . .
Expected Output: true true -- user error: entry name is not a string
Actual Output: test passed

Test 57: Adding an entry: no data to commit
Input: ."helloworld" constant .
Expected Output: helloworld -- error: not enough values in the stack
Actual Output: test passed

Test 58: Adding an entry: already an entry with the same name
Input: ."helloworld" ."hello" space ."world" + + constant
       ."helloworld" ."hello" space ."world" + + constant . .
Expected Output: hello world helloworld -- Dict error: already an entry with that name
Actual Output: test passed

Test 59: Adding an entry: successful insertion of constant
Input: ."pi" 3.1415 constant . .
Expected Output: stack empty stack empty
Actual Output: test passed

Test 60: Adding an entry: successful insertion of variable
Input: ."helloworld" ."hello" space ."world" + + variable . .
Expected Output: stack empty stack empty
Actual Output: test passed

Test 61: Adding an entry: already with the same name as an existing command
Input: ."fix" ."fix" constant . .
Expected Output: fix fix - USER ERROR: entry cannot have the same name as an existing command
Actual Output: test passed

Test 62: Calling an entry: calling a constant
Input: ."PI" 3.1415 constant . . pi 0 + .
Expected Output: stack empty
               # stack empty
               # 3.1415
Actual Output: test passed

Test 63: Calling an entry: calling a variable
Input: ."hello" ."hello" variable . . hello space ."world" + + .
Expected Output: stack empty
              #  stack empty
              #  hello world
Actual Output: test passed

Test 64: Calling an entry: entry does not exist
Input: PI .
Expected Output: stack empty -- USER ERROR: unrecognized op
Actual Output: test passed

Test 65: Changing an entry: variable name is wrong or entry does not exist
Input: ."pi" 3.14 variable pi . . ."pie" ."yum" set . . .
Expected Output: 3.14 stack empty yum pie stack empty -- error on set
Actual Output: test passed

Test 66: Changing an entry: trying to change a constant
Input: ."pi" 3.14 constant pi . . ."pi" ."yum" set . . .
Expected Output: 3.14 stack empty yum pie stack empty -- error on set
Actual Output: test passed

Test 67: Changing an entry: name is not a string
Input: ."pi" 3.14 constant pi . . 3.14 ."yum" set . . .
Expected Output: 3.14 stack empty yum 3.14 stack empty -- error on set
Actual Output: test passed

Test 68: Changing an entry: no datum to change it to
Input: ."pi" 3.14 constant pi . . ."yum" set . . 
Expected Output: 3.14 stack empty yum stack empty -- not enough values in stack
Actual Output: test passed 

Test 69: Changing an entry: successful change
Input: ."pi" 3.14 variable pi . . ."pi" ."yum" set pi . .
Expected Output: 3.14 stack empty yum stack empty -- error on set
Actual Output: test passed

Test 70: Importing an initial dictionary: no dictionary specified
Input: list_dict -- -f
Expected Output: none -- empty dictionary
Actual Output: test passed

Test 71: Importing an initial dictionary: invalid dictionary specified
Input: list_dict -- -f ""
Expected Output: none -- empty dictionary
Actual Output: test passed

Test 72: Importing an initial dictionary: empty dictionary specified
Input: list_dict -- -f "../lib/empty.lib"
Expected Output: none -- empty dictionary
Actual Output: test passed

Test 73: Importing an initial dictionary: dictionary filled with garbage
Input: list_dict -- -f "../lib/garbage.lib"
Expected Output: none -- empty dictionary
Actual Output: test passed

Test 74: Importing an initial dictionary: a valid dictionary
Input: list_dict -- -f "../lib/default.lib"
Expected Output:    class: CMPT270
                    nsid: wam553
                    last_name: Morrice
                    first_name: Woody
                    golden_ratio: 1.618034
                    speed_of_light: 186.000000
                    sqrt2: 1.414214
                    e: 2.718282
                    pi: 3.141593
Actual Output: test passed
