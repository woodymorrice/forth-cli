/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
// datum.cc -- operations on a datum
#include <cstdio>
#include <cassert>
#include <cstring>

#include "datum.h"

// print -- prints a datum with given fix, bool for newline or not
void print(datum d, int fix, bool newl) {
	char* ln = strdup("\n"); if (!newl) { ln = strdup(" "); }
  	switch (d.tag) {
  	case BOOL:   	printf("%s%s", d.b ? "true" : "false", ln);
               		break;
  	case FLOAT:  	printf("%.*f%s", fix, d.f, ln);
               		break;
  	case STRING:    printf("%s%s", d.s, ln);
               		break;
  	default: 		assert(false);
           			break;
  	}
}
