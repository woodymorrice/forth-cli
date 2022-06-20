/************************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************************/
// forth.h -- external definitions shared with other modules

#ifndef _FORTH_H_
#define _FORTH_H_

extern bool verbose; // whether to be verbose or not

int process(FILE* f); // process -- read strings from stdin and process them

#endif
