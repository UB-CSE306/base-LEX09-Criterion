# OS identification from: https://stackoverflow.com/questions/714100/os-detecting-makefile
OS := $(shell uname -s)

ifeq ($(OS), Darwin) 
  INCLUDE_PATH := /opt/homebrew/Cellar/criterion/2.4.1_1/include
  LIB_PATH := /opt/homebrew/Cellar/criterion/2.4.1_1/lib
endif
ifeq ($(OS), Linux) 
  INCLUDE_PATH := /util/criterion/include
  LIB_PATH := /util/criterion/lib/x86_64-linux-gnu
endif

CC = gcc
CFLAGS = -Wall -std=c11 -ggdb

program.o: program.c
	$(CC) -c $(FLAGS) program.c

program: program.o
	$(CC) $(FLAGS) -o program program.o

runner: runner.c program.o
	$(CC) $(FLAGS) -o runner program.o runner.c

tests.o: tests.c code.c
	$(CC) -c $(DEBUG) $(CFLAGS) -I $(INCLUDE_PATH) tests.c

tests:  program.o tests.o
	$(CC) $(DEBUG) $(CFLAGS) -L $(LIB_PATH) -I $(INCLUDE_PATH) -o tests program.o tests.o -lcriterion

.PHONY: clean
clean:
	rm -rf *~ *.o program tests runner *.dSYM
