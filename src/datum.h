/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
// datum.h -- header for the datum datatype

#ifndef _DATUM_H_
#define _DATUM_H_

// datum_type -- tags to identify datum types
enum datum_type { BOOL, FLOAT, STRING };

// datum -- structure to hold a datum
struct datum {  datum_type tag;
                bool       b;
                float      f;
                char      *s;   };

// print -- prints a datum with given fix, bool for newline or not
void print(datum, int, bool);

#endif
