CXX=g++
DBFLAGS=-g -D_DEBUG_ON_

all: encoder

encoder: main.o huffmanCode.o int2bin.o
	$(CXX) $(DBFLAGS)  main.o  huffmanCode.o int2bin.o -o ../../bin/encoder

main.o: main.cpp
	$(CXX) $(DBFLAGS) -c  main.cpp -o main.o

huffmanCode.o:  huffmanCode.cpp
	$(CXX) $(DBFLAGS) -c  huffmanCode.cpp 

int2bin.o:  int2bin.cpp
	$(CXX) $(DBFLAGS) -c  int2bin.cpp

clean:
		rm -rf *.o *.gch ../../bin/main

