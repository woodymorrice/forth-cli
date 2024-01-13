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

## Testing and Progress Report for A5

Q1: Copied over my project files from A4, made a few formatting changes and added #define and #ifdef/#ifndef commands for the pre-processor in the header files.

Q2: Ensured the application works properly and satisfies all the functional requirements for A4 - All requirements were achieved, included all tests from A4 and all tests passed.'

Q3: Added Makefile with all and required dependencies. Test1 calls Makefile with each target. any error means the test failed. 

Q4: Added clean and squeaky targets to Makefile. Test1 calls squeaky clean after each target. if any target fails because the file already exists, the test fails.

Q5: Added debug target to Makefile. Added all new targets for dependencies to avoid bugs. Test2 calls debug and all dependencies. All targets must build to pass.

Q6: Added two tests for if/else/then - Test3 tests the case where the value popped from the stack is not a boolean. Should return an error message. Test4 Tests if the bool is true and false, and nested if statements. Should result in expected behavior. Added another two tests to check the if and the else conditions. Added more tests for different situations. Tests passed after several different implementations. Simpler turned out to be better.

Q7: Adding two tests for while loop- simple loop and a nested loop. Added two more tests to check the conditions where the loop doesnt execute. Achieved expected behaviour with a copy() function then a do_while() function to loop it until a false was popped.

Q8: Three tests added for user defined commands. A simple command, a command calling another command, and a recursive command. Recursive test was taking from the assignment outline, and actually resulted in infinite recursion... so we know the recursion works, but the test case was removed.

Q9: Added dynamic test script, allows for single tests to check results, or runs all tests and reports how many pass and fail. One test runs all tests, one is a single pass, one is a single fail, one has multiple tests with one pass, and one has multiple tests with one fail.
