CXX=g++
DBFLAGS=-g -D_DEBUG_ON_

all: encoder

encoder: encoder.o huffmanCode.o int2bin.o
	$(CXX) $(DBFLAGS)  encoder.o  huffmanCode.o int2bin.o -o ../../bin/encoder

encoder.o: encoder.cpp
	$(CXX) $(DBFLAGS) -c  encoder.cpp -o encoder.o

huffmanCode.o:  huffmanCode.cpp
	$(CXX) $(DBFLAGS) -c  huffmanCode.cpp 

int2bin.o:  int2bin.cpp
	$(CXX) $(DBFLAGS) -c  int2bin.cpp

clean:
		rm -rf *.o *.gch ../../bin/encoder

