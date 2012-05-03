#include <iostream>
#include <fstream> 
#include <bitset>
#include <climits>
#include <stdlib.h>
#include <stdio.h>
#include <vector>
#include "nodeMgr.h"
#include "huffmanCode.h"

#define FILELENGTH 100000
#define NODENUM 100
#define DATALENGTH 1000 

using namespace std;

bitset<9> double2binary( double input);


int main(int argc, char* argv []) {
  
  char *inFileName;
  char *outFileName;
  char *memblock;
  double x[FILELENGTH];
  string index;
  bitset<9> *totalData;

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
  fstream inFile;
  ofstream outFile(outFileName);
  inFile.open(inFileName,ios::in );

  int i = 0;
  while(inFile.good()) {
    inFile >> index >> x[i];
    i++;
  }
  /* allocate the data table */
  totalData = new bitset<9>[FILELENGTH];
  for (int i = 0; i < FILELENGTH; i++) 
    totalData[i] =  double2binary(x[i]);

#ifdef _DEBUG_ON_ 
  for (int i = 0; i < FILELENGTH; i++) {
    outFile << x[i] << ' ' << totalData[i] << endl;
  }
#endif

  NodeMgr nodeManager(NODENUM, DATALENGTH, totalData );
//  nodeManager.reportNode();

  outFile.close();
  inFile.close();
  return 0;
}

bitset<9> double2binary( double input) {
  bitset<9> binary;
  binary.reset();
  if ( input > 0 ) binary.set(1);
  else input*=-1;
  
  for (int i = 8; i > 0; i--) {
    if ( input > 1 ){
      binary.set(i);
      input = input - 1;
    }
    input*=2;
  }
  return binary;
} 
