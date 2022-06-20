/************************************************
Woody Morrice - 11071060 - wam553
CMPT214 - Assignment 5 - Fully-Implemented FORTH
************************************************/
#include <cstdlib>
#include <cstdio>
#include <cassert>
#include <cstddef> // for NULL

#include <unistd.h>	// pow()
#include <cmath>	// getopt()
#include <cstring>	// strcmp()

#include "forth.h"
#include "dict.h"
#include "stack.h"
// #include "datum.h"


int process(FILE* f); // process -- read strings from stdin and process them
int process_cmd(const char*); // process_cmd -- process a command
// process_until -- reads commands from input until it sees the terminator
//					then conditionally executes them based on the boolean
int process_until(FILE* in, const char *term, bool exec);
// copy_until -- copies commands into a temporary file 
//				 from input until it sees the terminator
char* copy_until(char* file_name, const char* term, bool write, bool exec);
// do_loop -- opens a temporary file and copies all of the commands
// up to the loop terminator into that file, and closes it
int do_loop(char* file_name);

int copy(char* file_name, const char* term);

unsigned int fix = 4; // the number of decimals to print
bool verbose = false; // whether to be verbose or not
bool debug = false; // true enables debug mode
const char* EMPTY_MSG = "stack empty"; // Don't Repeat Yourself

// main -- process command-line arguments
int main(int argc, char* argv[]) {

	int opt;
	FILE *f = NULL;
	while (-1 != (opt = getopt(argc, argv, ":hvdf:"))) {
		switch (opt) {
			case 'h':	fprintf(stderr, "%s: *******FORTH*******************\n", argv[0]);
						fprintf(stderr, "Options :\n"
										"	-h to show help documentation\n"
										"	-v to enable verbose warnings\n"
										"	-d to enable debug mode\n"
										"For a list of commands, consult the README.\n"
										"*******************************************\n");
						return EXIT_SUCCESS;
						break;

			case 'v':	verbose = true;
						break;

			case 'd':	debug = true;
						break;

			case 'f':	if (NULL == optarg) {
							if (verbose) { fprintf(stderr, "USER ERROR: invalid or no file specified\n"); }
							break;
						} else { 
						f = fopen(optarg, "r+t");
						if (NULL == f) {
							if (verbose) { fprintf(stderr, "USER ERROR: invalid or no file specified\n"); }
							fclose(f); break;
						}
						process(f); fclose(f); break; 
						}

			case '?':
			default:	if (verbose) { fprintf(stderr, "%s: unknown option: %c\n", argv[0], opt); }
						return EXIT_FAILURE;
						break;
		}
	}
	int r = process(stdin);
	if (verbose) {
		if (!empty()) {
			fprintf(stderr, "WARNING: exiting without empty stack\n");
			while (!empty()) {
				print(pop(), fix, true);
			}
		}
		if (EXIT_SUCCESS != r) {
			fprintf(stderr, "WARNING: an error occurred, please review computations\n");
		}
	}
	return r;
}

// CMD_SIZE -- assumed size for an input string/command
const int CMD_SIZE = 80;

// process -- read commands from stdin and process them
//	returns EXIT_SUCCESS on success / EXIT_FAILURE on failure
int process(FILE* f) {

	int result = EXIT_SUCCESS;

	char cmd[CMD_SIZE + 1]; // ensure space for tombstone

	if (stdin != f) { // for importing libraries
		while (0 == feof(f)) {
			if (1 == fscanf(f, "%s", cmd)) {
				if (EXIT_FAILURE == process_cmd(cmd)) {
					result = EXIT_FAILURE;
				}
			}
		}
	}

	while (0 == feof(f)) { // standard user input
		if (1 == scanf("%s", cmd)) {
			if (EXIT_FAILURE == process_cmd(cmd)) {
				result = EXIT_FAILURE;
			}
			if (debug) { // debug mode
				if (empty()) { printf("%s\n", EMPTY_MSG); }
				else {	const int MAX_DBUG = 6; // max number of stack to show
						bool newl = false; // bool to print a space or newline after each val
					   	for (int i=0; (depth()-i)!=0 && MAX_DBUG!=i; i++) {
							if ((depth()-1)==i || MAX_DBUG-1==i) { newl = true; }	
							print(the_stack[(depth()-1)-i], fix, newl);
					   }
				}
			}
		}
	}

	return result;
}

// try_push -- wrap push in a verboseness checking operation
int try_push(datum d) {
	if (!push(d)) {
		if (verbose) {fprintf(stderr, "error: stack exhausted\n"); }
		return EXIT_FAILURE;
	}
	return EXIT_SUCCESS;
}

// try_push -- push a float
int try_push(float f) {
	datum d;
	d.tag = FLOAT;		d.f = f;
	return try_push(d);
}

// try_push -- push a boolean
int try_push(bool b) {
	datum d;
	d.tag = BOOL;		d.b = b;
	return try_push(d);
}

// try_push -- push a string
int try_push(char *s) {
	datum d;
	d.tag = STRING;		d.s = s;
	return try_push(d);
}

// OP -- a tag for FORTH operations					// # of operands
enum op { SPACE, NEWLINE, DICT, LIST,							// nonary
	  DOT, DROP, DUP, NOT, OFIX, IF, WHILE,	COLON,				// unary
	  SWAP, PLUS, MINUS, TIMES, DIVIDE, POWER, AND, OR, SET,	// binary
  	  EQL, NOTEQL, GRTR, LESS, GRTEQL, LSSEQL, CONST, VAR,
	  ROT, SUBS };												// ternary

// do_arith -- handles all arithmetic operations
int do_arith (char o, datum d1, datum d2) {
	if ((FLOAT == d1.tag) && (FLOAT == d2.tag)) {
		datum d; d.tag = FLOAT; // one line to declare the new datum and init the tag
		switch (o) {
		case '+': 	d.f = d2.f + d1.f;	break;
		case '-': 	d.f = d2.f - d1.f;	break;
		case '*': 	d.f = d2.f * d1.f;	break;
		case '/': 	d.f = d2.f / d1.f;	break; // div by 0 = infinity... maybe should handle
		case '^': 	d.f =pow(d2.f, d1.f);	break;
		default : 	if (verbose) { fprintf(stderr, "INTERNAL ERROR: invalid arithmetic op '%c'\n", o); }
					assert(push(d2));
					assert(push(d1));
					return EXIT_FAILURE;
					break;
		}
		assert(push(d));
		return EXIT_SUCCESS;
	}
	if ((STRING == d1.tag) && (STRING == d2.tag) && ('+' == o)) {
		datum d; d.tag = STRING; // one line to declare the new datum and init the tag
		// strnlen looks at the length of a string minus the tombstone and allows a max length (CMD_SIZE)
		d.s = new char[strnlen(d1.s, CMD_SIZE) + strnlen(d2.s, CMD_SIZE) + 1];
		d.s[0] = '\0'; // initializing the empty string
		strncat(d.s, d2.s, CMD_SIZE); // don't have to check the length using
		strncat(d.s, d1.s, CMD_SIZE); // strncat because we set the max length
		assert(push(d));
		return EXIT_SUCCESS;
	}
	if ((FLOAT == d1.tag) && (STRING == d2.tag) && ('*' == o)) {
		int m = (int) d1.f;
		if (m < 0) {
			if (verbose) { fprintf(stderr, "USER ERROR: negative string multiplier: %d\n", m); }
			assert (push(d2));
			assert (push(d1));
			return EXIT_FAILURE;
		}
		datum d; d.tag = STRING;
		d.s = new char[(m * strnlen(d1.s, CMD_SIZE)) + 1];
		d.s[0] = '\0';
		for (int i = 0; i < m ; i++) {
			strncat(d.s, d2.s, CMD_SIZE);
		}
		assert(push(d));
		return EXIT_SUCCESS;
	}
	if (verbose) { fprintf(stderr, "USER ERROR: invalid operands to op '%c'\n", o); }
	return EXIT_FAILURE;

}

// do_comp -- handles all comparison operations
int do_comp (char* o, datum d1, datum d2) {
	datum d; d.tag = BOOL;
	if	((BOOL == d1.tag) && (BOOL == d2.tag)) {
		if 		(0 == strcmp("=",  o)) { d.b = (d2.b == d1.b); }
		else if (0 == strcmp("!=", o)) { d.b = (d2.b != d1.b); }
		else {	if (verbose) { 
			fprintf(stderr, "INTERNAL ERROR: booleans can only be compared for equality\n"); }
			assert(push(d2));
			assert(push(d1));
			return EXIT_FAILURE; 
		}
		assert(push(d));
		return EXIT_SUCCESS;
	}
	if	((FLOAT == d1.tag) && (FLOAT == d2.tag)) {
		if 		(0 == strcmp("=",  o)) { d.b = d2.f == d1.f; }
		else if (0 == strcmp("!=", o)) { d.b = d2.f != d1.f; }
		else if (0 == strcmp(">",  o)) { d.b = d2.f >  d1.f; }
		else if (0 == strcmp("<",  o)) { d.b = d2.f <  d1.f; }
		else if (0 == strcmp(">=", o)) { d.b = d2.f >= d1.f; }
		else if (0 == strcmp("<=", o)) { d.b = d2.f <= d1.f; }
		else {	if (verbose) { fprintf(stderr, "INTERNAL ERROR: invalid comparison op '%s'\n", o); }
			assert(push(d2));
			assert(push(d1));
			return EXIT_FAILURE; 
		}
		assert(push(d));
		return EXIT_SUCCESS;
	}
	if	((STRING == d1.tag) && (STRING == d2.tag)) {
		int result = strcmp(d2.s, d1.s);
		if 		(0 == strcmp("=",  o)) { if (0 == result) d.b = true; else d.b = false; }
		else if (0 == strcmp("!=", o)) { if (0 != result) d.b = true; else d.b = false; }
		else if (0 == strcmp(">",  o)) { if (0 <  result) d.b = true; else d.b = false; }
		else if (0 == strcmp("<",  o)) { if (0 >  result) d.b = true; else d.b = false; }
		else if (0 == strcmp(">=", o)) { if (0 <= result) d.b = true; else d.b = false; }
		else if (0 == strcmp("<=", o)) { if (0 >= result) d.b = true; else d.b = false; }
		else {	if (verbose) { fprintf(stderr, "INTERNAL ERROR: invalid comparison op '%s'\n", o); }
			assert(push(d2));
			assert(push(d1));
			return EXIT_FAILURE; 
		}
		assert(push(d));
		return EXIT_SUCCESS;
	}

	if (verbose) { fprintf(stderr, "USER ERROR: invalid operands to op '%s'\n", o); }
	assert(push(d2));
	assert(push(d1));
	return EXIT_FAILURE;
}

// do_none(op) -- do an operation involving no stacked values
int do_0(op o, char* cmd) {
	switch (o) {
	case SPACE: 	return try_push(strdup(" ")); // strdup to get around str const to char*
					break;

	case NEWLINE: 	return try_push(strdup("\n"));
					break;

	case DICT:	    return push_dict(strdup(cmd));
					break;

	case LIST:	    return prnt_dict();

	default: if (verbose) { fprintf(stderr, "INTERNAL ERROR: unknown nonary operator %d\n", o); }
			 return EXIT_SUCCESS;
			 break;
	}
}

// do_1(op) -- do an operation involving only the value of the top of the stack
int do_1(op o) {
	if (empty()) {
		printf("%s\n", EMPTY_MSG);
		return EXIT_FAILURE;
	}
	datum d = pop();
	switch (o) {
	case DOT:	print(d, fix, true);
				break;

	case DUP:	assert(push(d));
				return try_push(d);
				break;

	case DROP:	break;

	case NOT: 	if (BOOL == d.tag) { return try_push(!d.b);
	 			} else { 
					if (verbose) { fprintf(stderr, "USER ERROR: not a bool to negate\n"); }
					assert(push(d));
					return EXIT_FAILURE;
				} break;

	case OFIX:	if (FLOAT == d.tag) {
					if (d.f < 0) {
						if (verbose) { fprintf(stderr, "USER ERROR: negative fix\n"); }
						assert(push(d));
						return EXIT_FAILURE;
					}
					fix = (unsigned int) d.f;
				} else {
					if (verbose) { fprintf(stderr, "USER ERROR: not a number to fix\n"); }
					assert(push(d));
					return EXIT_FAILURE;
				} break;

	case IF:	if (BOOL == d.tag) { 
					process_until(stdin, "else",  d.b);
					process_until(stdin, "then", !d.b); 
				} else {
					if (verbose) { fprintf(stderr, "USER ERROR: if statements must be preceded by a boolean\n"); }
					assert(push(d));
					return EXIT_FAILURE;
				} break;

	case WHILE:	{ char* file_name = strdup("./tmp/tmpXXXXXX\0");
				  if (-1 == mkstemp(file_name)) {
				  fprintf(stderr, "FILE ERROR: could not create temporary file\n");
				  }
				  copy(file_name, "loop");
				  //   char* loop_cmd = strdup(file_name);
				  //   do_loop(loop_cmd);
				  do_loop(file_name);
				  return EXIT_SUCCESS;
				} break;

	case COLON: { if (STRING != d.tag) {
				  if (verbose) { fprintf(stderr, "USER ERROR: popped value must be a string\n"); }
				  assert(push(d));
				  return EXIT_FAILURE;
				  }
		          char* file_name = strdup("./tmp/tmpXXXXXX\0");
				  if (-1 == mkstemp(file_name)) {
				  fprintf(stderr, "FILE ERROR: could not create temporary file\n");
				  }
				  copy(file_name, ";");
				//   copy_until(file_name, ";", true, false);
				//   datum d2; d2.tag = STRING; 
				//   strcpy(d2.s, file_name);
				//   d2.s = strdup(file_name);
				//   d2.s = file_name;
				  try_push(strdup(file_name));
				  datum d2 = pop();
				  make_dict(WORD, d2, d);
				  return EXIT_SUCCESS;
				} break;

	default: 	if (verbose) { fprintf(stderr, "INTERNAL ERROR: invalid unary op %d\n", o); }
				return EXIT_FAILURE;
				break;
	}
	return EXIT_SUCCESS;
}

// do_2(op) -- do an operation involving the top two values on the stack
int do_2(op o) {
	if (2 > depth()) {
		printf("binary ops require at least 2 values on the stack\n");
		return EXIT_FAILURE;
	}
	datum d1 = pop(); datum d2 = pop();
	switch (o) {
	case SWAP:  	assert(push(d1));
					assert(push(d2));
					break;

	case OR:		if (d1.tag == BOOL && d2.tag == BOOL) { try_push(d1.b || d2.b); 
					} else { if (verbose) {
								fprintf(stderr, "USER ERROR: invalid operands to op '%c'\n", o); }
					} break;

	case AND:		if (d1.tag == BOOL && d2.tag == BOOL) { try_push(d1.b && d2.b);
					} else { if (verbose) {
								fprintf(stderr, "USER ERROR: invalid operands to op '%c'\n", o); }
					} break;

	case PLUS:		return do_arith('+',  d1, d2); break;
	case MINUS:		return do_arith('-',  d1, d2); break;
	case TIMES:		return do_arith('*',  d1, d2); break;
	case DIVIDE:	return do_arith('/',  d1, d2); break;
	case POWER:		return do_arith('^',  d1, d2); break;

	case EQL:		return  do_comp(strdup("="),  d1, d2); break;
	case NOTEQL:	return  do_comp(strdup("!="), d1, d2); break;
	case GRTR:		return  do_comp(strdup(">"),  d1, d2); break;
	case LESS:		return  do_comp(strdup("<"),  d1, d2); break;
	case GRTEQL:	return  do_comp(strdup(">="), d1, d2); break;
	case LSSEQL:	return  do_comp(strdup("<="), d1, d2); break;

	case CONST:		return	make_dict(CONSTANT, d1, d2); break;
	case VAR:		return	make_dict(VARIABLE, d1, d2); break;
	case SET:		return 	 set_dict(d1, d2); break;

	default: 		if (verbose) {fprintf(stderr, "INTERNAL ERROR: invalid binary op %d\n", o); }
					return EXIT_FAILURE;
					break;
	}
	return EXIT_SUCCESS;
}

// do_3(op) -- do an operation involved the top three values on the stack
int do_3(op o) {
	if (3 > depth()) {
		printf("ternary ops require at least 3 values on the stack\n");
		return EXIT_FAILURE;
	}
	datum d1 = pop(); datum d2 = pop(); datum d3 = pop();
	switch (o) {
	case ROT: 	assert(push(d1));
				assert(push(d3));
				assert(push(d2));
				return EXIT_SUCCESS;
				break;

	case SUBS:	if ((STRING == d3.tag) && (FLOAT == d2.tag) && (FLOAT == d1.tag)) {
					const int d3l = strnlen(d3.s, CMD_SIZE);
					if (0 == d3l) {			// if length = 0 push empty str
						datum d; d.tag = STRING;
						d.s = strdup("");
						assert(push(d));
						return EXIT_SUCCESS;
					}

					int s = (int) d2.f;		// start
					if (s < 0) { s = 0; }		// if less than zero, set = 0
					int e = (int) d1.f;		// end
					if (e > d3l) { e = d3l; }	// if greater than length set = length
					if (s > e) { e = s; }		// if start > end, set end = start					
					const int dl = e - s + 1;	// length of slice

					datum d; d.tag = STRING;
					d.s = new char[dl+1];		// make room for tombstone
					strncpy(d.s, &d3.s[s], dl);	// copy d3 starting at start
					d.s[dl] = '\0';			// place tombstone at end
					assert(push(d));
					return EXIT_SUCCESS;
				} break;

	default: 	if (verbose) { fprintf(stderr, "INTERNAL ERROR: invalid ternary op %d\n", o); }
			return EXIT_FAILURE;
			break;
	}
  	if (verbose) { fprintf(stderr, "USER ERROR: invalid operands\n"); }
  	return EXIT_FAILURE;
}

// do_loop -- opens a temporary file and copies all of the commands
// up to the loop terminator into that file, and closes it
int do_loop(char* file_name) {
	while (!empty()) {
	FILE* file = fopen(file_name, "wrt");
		// printf("hello\n");
		// datum d; d = pop();
		// print(d, fix, true);
		process(file);
		datum d = pop();
		while (BOOL == d.tag && true == d.b) {
			do_loop(file_name);
			// process(file);
		}
		fclose(file);
	}
	return EXIT_SUCCESS;
}

int do_while() {
	if (empty()) {
		printf("%s\n", EMPTY_MSG);
		return EXIT_FAILURE;
	}
	char* file_name = strdup("./tmp/tmpXXXXXX\0");
	if (-1 == mkstemp(file_name)) {
	fprintf(stderr, "FILE ERROR: could not create temporary file\n");
	}
	copy(file_name, "loop");
	// while (!empty()) {
	datum d = pop();
		// if (BOOL == d.tag && true == d.b) {
			// while (BOOL == d.tag && true == d.b) {
				while (BOOL == d.tag && d.b) {
				FILE* file = fopen(file_name, "r");
				process(file);
				fflush(file);
				fclose(file);
				d = pop();
			}
		// }
	// }
	// file = fopen(file_name, "r");
	// process(file);
	// fflush(file);
	// d = pop();
	// fclose(file);
	// file = fopen(file_name, "r");
	// process(file);
	// fflush(file);
	// d = pop();
	// fclose(file);
	return EXIT_SUCCESS;
}

int copy(char* file_name, const char* term) {
	FILE* out = fopen(file_name, "w+t");
	char cmd[CMD_SIZE + 1];	
	while (0 == feof(stdin)) {
		if (1 == fscanf(stdin, "%s", cmd)) {
			if (0 == strcmp(term, cmd)) {
				fclose(out);
				return EXIT_SUCCESS;
			}	
			fprintf(out, cmd);
			fprintf(out, "\n");
			fflush(out);
		}
	}
	fclose(out);
	return EXIT_SUCCESS;
}

// process_until -- reads commands from input until it sees the terminator
// 					then conditionally executes them based on the boolean
int process_until(FILE* in, const char *term, bool exec) {
	char cmd[CMD_SIZE + 1];
	while (0 == feof(in)) {
		if (1 == fscanf(in, "%s", cmd)) {
			if (0 == strcmp(term, cmd)) {
				return EXIT_SUCCESS;
			}
			if (exec) {
				process_cmd(cmd);
			} else {
				if (0 == strcmp(cmd, "if")) {
					process_until(in, "then", false);
				}
			}
		}
	}
	return EXIT_FAILURE;
}

// process_cmd -- takes a command string and processes it
int process_cmd(const char* cmd) {
	float f = -9999999.99;
	if (1 == sscanf(cmd, "%g", &f)) {
		return try_push(f);

	} else if (0 == strcmp("true", cmd)) {
		return try_push(true);
	} else if (0 == strcmp("false", cmd)) {
		return try_push(false);

	} else if ((0 == strncmp(".\"", cmd, 2))
	&& (0 == strcmp("\"", &cmd[strnlen(cmd, CMD_SIZE)-1]))) {
		char *s = strdup(&cmd[2]);
		s[strnlen(s, CMD_SIZE)-1] = '\0';
		return try_push(s);

	  // arithmetic
	} else if (0 == strcmp("+",         cmd)) { return do_2(PLUS);
	} else if (0 == strcmp("-",         cmd)) { return do_2(MINUS);
	} else if (0 == strcmp("*",         cmd)) { return do_2(TIMES);
	} else if (0 == strcmp("/",         cmd)) { return do_2(DIVIDE);
	} else if (0 == strcmp("^",         cmd)) { return do_2(POWER);

	  // display
	} else if (0 == strcmp(".",         cmd)) { return do_1(DOT);
	} else if (0 == strcmp("fix",       cmd)) { return do_1(OFIX);

	  // stack
	} else if (0 == strcmp("rot",       cmd)) { return do_3(ROT);
	} else if (0 == strcmp("dup",       cmd)) { return do_1(DUP);
	} else if (0 == strcmp("drop",      cmd)) { return do_1(DROP);
	} else if (0 == strcmp("swap",      cmd)) { return do_2(SWAP);

	  // string
	} else if (0 == strcmp("substring", cmd)) { return do_3(SUBS);
	} else if (0 == strcmp("space",     cmd)) { return do_0(SPACE, strdup(cmd));
	} else if (0 == strcmp("newline",   cmd)) { return do_0(NEWLINE, strdup(cmd));

	  // logic
	} else if (0 == strcmp("not",       cmd)) { return do_1(NOT);
	} else if (0 == strcmp("and",       cmd)) { return do_2(AND);
	} else if (0 == strcmp("or",        cmd)) { return do_2(OR);

	  // comparison
	} else if (0 == strcmp("=",         cmd)) { return do_2(EQL);
	} else if (0 == strcmp("!=",        cmd)) { return do_2(NOTEQL);
	} else if (0 == strcmp(">",         cmd)) { return do_2(GRTR);
	} else if (0 == strcmp("<",         cmd)) { return do_2(LESS);
	} else if (0 == strcmp(">=",        cmd)) { return do_2(GRTEQL);
	} else if (0 == strcmp("<=",        cmd)) { return do_2(LSSEQL);

	  // dictionary ops
	} else if (0 == strcmp("constant",  cmd)) { return do_2(CONST);
	} else if (0 == strcmp("variable",  cmd)) { return do_2(VAR);
	} else if (0 == strcmp("set", 	    cmd)) { return do_2(SET);
	} else if (0 == strcmp("list_dict", cmd)) { return do_0(LIST, strdup(cmd));

	  // conditional ops
	} else if (0 == strcmp("if",        cmd)) { return do_1(IF);
	// } else if (0 == strcmp("while",     cmd)) { return do_1(WHILE);
	} else if (0 == strcmp("while",     cmd)) { return do_while();
	} else if (0 == strcmp(":",         cmd)) { return do_1(COLON);

	  // dictionary entry
	} else if (srch_dict(strdup(cmd))) 	      { return do_0(DICT, strdup(cmd));
	}
	
	  // unknown
	if (verbose) { fprintf(stderr, "USER ERROR: unrecognized op '%s'\n", cmd); }
	return EXIT_FAILURE;
}


// // copy_until -- reads commands from input until it sees the terminator
// // 					then copies them to a temporary file
// char* copy_until(char* file_name, const char* term, bool write, bool exec) {
// 	FILE* out = fopen(file_name, "w+t");
// 	char cmd[CMD_SIZE + 1];	
// 	while (0 == feof(stdin)) {
// 		if (1 == fscanf(stdin, "%s", cmd)) {
// 			if (0 == strcmp(term, cmd)) {

// 				return EXIT_SUCCESS;
// 			}
// 			if (write) {
// 				fprintf(out, cmd);
// 				fprintf(out, "\n");
// 				fflush(out);
// 				// if (exec) {
// 				// process_cmd(cmd);
// 				// }
// 			} else {
// 				if (0 == strcmp(cmd, "while")) {
// 					copy_until(file_name, "loop", false, false);
// 				}
// 			}
// 		}
// 	}
// 	fclose(out);
// 	return file_name;	
// }