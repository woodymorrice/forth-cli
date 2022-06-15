/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
// stack.h -- stack declarations for A5

#ifndef _STACK_H_
#define _STACK_H_

#include "forth.h"
#include "datum.h" // include datum.h for operations

// STACK_SIZE -- A constant representing the maximum size of the stack
extern const int STACK_SIZE;

extern datum the_stack[]; // the_stack -- the array of data

//  push -- takes a float and pushes it on top of the stack
//  returns a boolean that indicates whether the operation was successful
//  (or not, in the case of the stack being full)
bool push(datum dat);

// pop -- removes and returns the float at the top of the stack
// if the stack is empty, abort the program, because all calls
// to pop need to be guarded with a call to empty to ensure it works
datum pop(void);

// empty -- takes no arguments and returns a boolean that indicates
// whether the stack is empty or not. True means the stack is empty.
bool empty(void);

// peek -- returns but does not remove the float at the top of the stack
// any calls to peek() on an empty stack are not allowed
datum peek(void);

// depth -- returns the depth of the stack (the number of items in the stack)
int depth(void);

#endif
