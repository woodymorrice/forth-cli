/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
// dict.cc -- dictionary definitions for A5
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <cassert>
#include <cstddef>

#include "forth.h"
#include "dict.h"

dict *the_dictionary = NULL; // the dictionary for storing constants and variables

const char* RESTRICTED_NAMES[] = {"+", "-", "*", "/", "^", ".", "=", ">", "<", "!=", 
                                  ">=", "<=", "or", "and", "fix", "rot", "dup", "not",
                                  "drop", "swap", "substring", "space", "newline",
                                  "constant", "variable", "true", "false", "set"};
const int RESTR_SIZE = 28; // number of restricted names

// srch_dict -- searches the dictionary for a name and returns true if it finds it
bool srch_dict(char* s) {
    for (dict *wlk = the_dictionary; NULL!=wlk; wlk = wlk->next) {
        if (0 == strcmp(wlk->name,s)) return true;
    }
    return false;
}

//check_rstrct -- checks the list of restricted names
bool check_rstrct(char* s) {
    for (int i = 0; i < RESTR_SIZE; i++) {
        if (0 == strcmp(RESTRICTED_NAMES[i], s)) {
            if (verbose) { fprintf(stderr, "USER ERROR: name is restricted\n"); }
            return false;
        }
    }
    return true;
}

// push_dict -- pushes the specified entry from the dictionary to the top of the stack
//           -- always search before calling push_dict
int push_dict(char* s) {
    for (dict *wlk = the_dictionary; NULL!=wlk; wlk = wlk->next) {
        if (0 == strcmp(wlk->name,s)) { push(wlk->payload); return EXIT_SUCCESS; }
    }
    if (verbose) { printf("Critical Failure: entry not in dictionary\n"); }
	exit(EXIT_FAILURE);
}

// make_dict -- initializes a new dict
bool make_dict(dict_tag tag, datum d1, datum d2) {
    if (STRING != d2.tag) {
        if (verbose) { fprintf(stderr, "USER ERROR: name must be a string\n"); }
        assert(push(d2)); assert(push(d1));
        return false;
    }

    if (!check_rstrct(d2.s)) { assert(push(d2)); assert(push(d1)); }

    if (!srch_dict(d2.s)) { dict* new_entry = new dict;
                            new_entry->type = tag;
                            new_entry->payload = d1;
                            new_entry->name = strdup(d2.s);
                            new_entry->next = the_dictionary;
                            the_dictionary = new_entry;
                            return true;
    } else { if (verbose) { 
             fprintf(stderr, "USER ERROR: dictionary already contains an entry with that name\n"); }
	         assert(push(d2)); assert(push(d1)); 
    }
    return false; 
}

// set_dict -- changes the value of a variable dictionary entry (constants cannot be changed)
bool set_dict(datum d1, datum d2) {
    if (STRING != d2.tag) { if (verbose) { fprintf(stderr, "USER ERROR: name must be a string\n"); }
                            assert(push(d2));   assert(push(d1));
                            return false;
    }

    if (!check_rstrct(d2.s)) { assert(push(d2)); assert(push(d1)); }

    if (srch_dict(d2.s)) {
        for (dict *wlk = the_dictionary; NULL!=wlk; wlk = wlk->next) {
            if (0 == strcmp(wlk->name,d2.s)) {
                wlk->payload = d1;
                return true;
            }
        }
    } else { if (verbose) { 
                fprintf(stderr, "USER ERROR: there is no dictionary entry by that name\n"); }
	         assert(push(d2));
	         assert(push(d1)); 
    }
    return false;

}

// prnt_dict -- prints a dict
int prnt_dict(void) {
    for (dict *wlk = the_dictionary; NULL!=wlk; wlk = wlk->next) {
        printf("%s: ", wlk->name); 
        switch (wlk->payload.tag) {
            case   BOOL: printf("%d\n", wlk->payload.b); break;
            case  FLOAT: printf("%f\n", wlk->payload.f); break;
            case STRING: printf("%s\n", wlk->payload.s); break;
        }
    }
    return EXIT_SUCCESS;
}
