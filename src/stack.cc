/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
// stack.cc -- stack definitions for A5
#include <cstdlib>
#include <cstdio>
#include <cassert>

#include "stack.h"

// STACK_SIZE -- A constant representing the maximum size of the stack
const int STACK_SIZE = 15;

datum the_stack[STACK_SIZE]; // the_stack -- the array of data
unsigned int next = 0;		 //next -- the index of the next value in the stack


// push -- takes a float and pushes it on top of the stack
// returns a boolean that indicates whether the operation was successful
bool push(datum dat) {
	assert(STACK_SIZE >= next);
	if (STACK_SIZE == next) {
		if (verbose) {
			fprintf(stderr, "STACK ERROR: Cannot push, the stack is full\n");
		}
		return false;
	} else {
		the_stack[next++] = dat;
		return true;
	}
}

// pop -- removes and returns the value at the top of the stack
// if empty, abort program -- pop calls must be guarded by empty()
datum pop(void) {
	if (empty()) {
		if (verbose) {
			fprintf(stderr, "CRITICAL FAILURE: Cannot pop() from an empty stack\n");
		}
		exit(EXIT_FAILURE); // use exit() instead of returning EXIT_FAILURE
	}
	return the_stack[--next];
}

// empty -- returns a boolean that indicates if the stack is empty
bool empty(void) {
	return (0 == next);
}

// peek -- returns but does not remove the value at the top of the stack
datum peek(void) {
	if (empty()) {
		if (verbose) {
			fprintf(stderr, "CRITICAL FAILURE: Cannot peek() an empty stack\n");
		}
		exit(EXIT_FAILURE);
	}
	return the_stack[next-1];
}

//depth -- returns the depth of the stack (the number of items in the stack)
int depth(void) {
	return (next);
}