/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
// dict.h -- dictionary definitions for A5

#ifndef _DICT_H_
#define _DICT_H_

// #include "stack.h"
#include "datum.h"
#include "forth.h"

// entry_type -- tags to identify dict entry types
enum dict_tag { CONSTANT, VARIABLE, WORD };

// dict -- structure to hold dictionary entries
struct dict {   dict_tag        type;
                char*           name;
                datum           payload;
                dict           *next;   };

extern dict *the_dictionary; // the dictionary for storing constants and variables
extern int dict_size;           // the size of the dictionary (number of entries)

// srch_dict -- searches the dictionary for a name and returns true if it finds it
bool srch_dict(char* s);

// push_dict -- pushes the specified entry from the dictionary to the top of the stack
//           -- always search before calling push_dict
int push_dict(char* s);

// make_dict -- initializes a new dict
bool make_dict(dict_tag, datum d1, datum d2);

// set_dict -- changes the value of a variable dictionary entry (constants cannot be changed)
bool set_dict(datum d1, datum d2);

// prnt_dict -- prints a dict
int prnt_dict(void);

// free_dict -- empties the dictionary from memory when exiting the program
int free_dict(void);

#endif
