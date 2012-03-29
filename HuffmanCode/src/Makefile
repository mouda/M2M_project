
CXX=g++

all: encoder

encoder: main.o
	${CXX} main.o -o ../bin/encoder

main.o: main.cpp
	${CXX} -c  main.cpp -o main.o

clean:
		rm -rf *.o ../bin/encoder

