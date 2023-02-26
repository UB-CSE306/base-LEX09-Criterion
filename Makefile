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

program.o: program.c program.h
	$(CC) -c $(FLAGS) program.c

runner.o: runner.c program.h
	$(CC) -c $(CFLAGS) runner.c

tests.o: tests.c program.h
	$(CC) -c $(DEBUG) $(CFLAGS) -I $(INCLUDE_PATH) tests.c

runner: program.o runner.o
	$(CC) $(CFLAGS) -o runner program.o runner.o

tests:  program.o tests.o
	$(CC) $(DEBUG) $(CFLAGS) -L $(LIB_PATH) -I $(INCLUDE_PATH) -o tests program.o tests.o -lcriterion

.PHONY: clean
clean:
	rm -rf *~ *.o tests runner *.dSYM
