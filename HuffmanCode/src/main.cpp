#include <iostream>
#include <fstream>
#include <vector>
#include <stdio.h>
#include "huffmanCode.h"
#define BUFFERSIZE 100

using namespace std;

int main(int argc, char* argv []) {

  char *inFileName;
  char *outFileName;

  if (argc < 3) {
    cout << "Missing options" << endl;
    return 1;
  }

  if (argc > 3) {
    cout << "Too much parameters" <<endl;
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
    table[(int)oneChar]++;
//    printf("%d\n", oneChar);
  }

  HuffmanCode huffmanCode(table);
//  huffmanCode.displaySource();
  huffmanCode.constructTable();
  huffmanCode.generateHuffmanCode();
  huffmanCode.displayHuffmanTable();


  outFile.close();
  inFile.close();
  return 0;



}
