#*************************************************
# Woody Morrice - 11071060 - wam553
# CMPT214 - Assignment 5 - Fully-Implemented FORTH
#*************************************************
# FORTH Makefile

CC = g++
CFLAGS = -Wall -pedantic -std=c++17

# Libraries
LIBS = -lm

# Utilities
RM = rm -i
TAR = tar

# Other Commands
BASENAME = basename
DIRNAME = dirname
GREP = grep

# Default Target
all: forth


# For Convenience
forth: ./bin/forth

# $@ == Target
# @< == Dependencies

# Linking
bin/forth:	out/forth.o out/datum.o out/dict.o out/stack.o
	$(CC) $(CFLAGS) $(LIBS) -o $@ $^

# Compiling
out/datum.o: src/datum.cc src/datum.h
	$(CC) $(CFLAGS) -c -o $@ $<

out/dict.o: src/dict.cc src/dict.h src/forth.h
	$(CC) $(CFLAGS) -c -o $@ $<

out/stack.o: src/stack.cc src/stack.h src/datum.h src/forth.h
	$(CC) $(CFLAGS) -c -o $@ $<

out/forth.o: src/forth.cc src/forth.h src/stack.h src/dict.h
	$(CC) $(CFLAGS) -c -o $@ $<
