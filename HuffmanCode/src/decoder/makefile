# CC and CFLAGS are varibales
CC = g++
CFLAGS = -c
# -c option ask g++ to compile the sorce files, but do not link.
# -O2 option is for optimized version
OPTFLAGS = -O2

# optimized version
huffman_decoding: main.o MyParse.o
	$(CC) $(OPTFLAGS) main.o MyParse.o -o ../../bin/huffman_decoding

main.o: main.cpp
	$(CC) $(CFLAGS) $(OPTFLAGS) main.cpp -o main.o

MyParse.o: MyParse.cpp
	$(CC) $(CFLAGS) $(OPTFLAGS) MyParse.cpp -o MyParse.o

# clean all the .o and executable files
clean:
	rm -rf *.o ../../bin/huffman_decoding
