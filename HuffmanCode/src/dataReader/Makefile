CXX=g++
DBFLAGS=-g -D_DEBUG_ON_

all: dataReader

dataReader: main.o huffmanCode.o nodeMgr.o 
	$(CXX) $(DBFLAGS)  main.o  huffmanCode.o nodeMgr.o -o ../../bin/dataReader

main.o: main.cpp
	$(CXX) $(DBFLAGS) -c  main.cpp -o main.o

huffmanCode.o:  ../encoder/huffmanCode.cpp
	$(CXX) $(DBFLAGS) -c  ../encoder/huffmanCode.cpp 

nodeMgr:  nodeMgr.cpp
	$(CXX) $(DBFLAGS) -c  nodeMgr.cpp 

clean:
		rm -rf *.o *.gch ../../bin/dataReader

