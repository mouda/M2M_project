#include <iostream>
#include <fstream>
#include <vector>
#include <stdio.h>
#include <string>
#include "huffmanCode.h"
#define BUFFERSIZE 100

using namespace std;

int main(int argc, char* argv []) {

  char *inFileName;
  char *outFileName;

  if (argc < 3) {
    cerr << "Missing options" << endl;
    return 1;
  }

  if (argc > 3) {
    cerr << "Too much parameters" <<endl;
    return 1;
  }

  inFileName = argv[1];
  outFileName = argv[2];
  fstream inFile(inFileName);
  ofstream outFile(outFileName);

  char oneChar; 
  int table[128];
  for (int i = 0; i < 128; i++) table[i] = 0;

  while ( inFile.good()) {
    inFile.get(oneChar);
    if ((int)oneChar == 10) continue; 
    if ((int)oneChar < 0 || (int)oneChar > 127) {
      cerr << "the input must be ANCII code!!" << endl;
      return 1;
    }
    table[(int)oneChar]++;
  }

  HuffmanCode huffmanCode(table);
//  huffmanCode.displaySource();
  huffmanCode.constructTable();
  huffmanCode.generateHuffmanCode();
//  huffmanCode.displayHuffmanTable();
  outFile << "# Huffman_encoding" << endl;
  outFile << huffmanCode.getHuffmanTable();
  outFile << "# end" << endl;

  char buffer[10];
  string result;
  inFile.close();
  inFile.open(inFileName, ifstream::in);
  while ( inFile.good()) {
    inFile.get(oneChar);
    if ((int)oneChar == 10) continue; 
    outFile <<  huffmanCode.HuffmanEncoder(oneChar);
  }


  outFile.close();
  inFile.close();
  return 0;



}
