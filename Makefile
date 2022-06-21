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
RM = rm
TAR = tar

# Other Commands
BASENAME = basename
DIRNAME = dirname
GREP = grep

# Default Target
all: forth debug


# For Convenience
forth: bin/forth

debug: bin/forth-debug

# $@ == Target
# @< == Dependencies


### Production Build ###
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


### Debug Build ###
# Linking
bin/forth-debug: out/forth-g.o out/datum-g.o out/dict-g.o out/stack-g.o
	$(CC) $(CFLAGS) $(LIBS) -g -o $@ $^

# Compiling
out/datum-g.o: src/datum.cc src/datum.h
	$(CC) $(CFLAGS) -c -g -o $@ $<

out/dict-g.o: src/dict.cc src/dict.h src/forth.h
	$(CC) $(CFLAGS) -c -g -o $@ $<

out/stack-g.o: src/stack.cc src/stack.h src/datum.h src/forth.h
	$(CC) $(CFLAGS) -c -g -o $@ $<

out/forth-g.o: src/forth.cc src/forth.h src/stack.h src/dict.h
	$(CC) $(CFLAGS) -c -g -o $@ $<


# Phony Targets
.PHONY:	forth clean squeaky archive tests

# Clean -- no dependencies
clean:
	-$(RM) out/*.o
	-$(RM) src/*~ ./*~
	-$(RM) test/*.result test/*.err

# Squeaky -- depends on clean, removes executable and archive
squeaky: clean
	-$(RM) bin/forth
	-$(RM) bin/forth-debug
	-$(RM) $(ARCHIVE)
