#!/bin/sh
#/************************************************
#Woody Morrice - 11071060 - wam553
#CMPT214 - Assignment 5 - Fully-Implemented FORTH
#************************************************/

# Compile
g++ -pedantic -Wall -std=c++17 -c -o ./out/datum.o ./src/datum.cc
g++ -pedantic -Wall -std=c++17 -c -o ./out/forth.o ./src/forth.cc
g++ -pedantic -Wall -std=c++17 -c -o ./out/stack.o ./src/stack.cc
g++ -pedantic -Wall -std=c++17 -c -o ./out/dict.o ./src/dict.cc

# Link
g++ -pedantic -Wall -std=c++17 -lm -o ./bin/forth ./out/datum.o ./out/forth.o ./out/stack.o ./out/dict.o

# Run
./bin/forth -f "./lib/default.lib" -v