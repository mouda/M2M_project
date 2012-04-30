#include <iostream>
#include <fstream> 

using namespace std;

int main(int argc, char* argv []) {
  
  char *inFileName;
  char *outFileName;
  char *memblock;
  double x[100000];

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
  for (int i = 0; i < 100000; i++) {
    inFile >> x[i];
  }
  for (int i = 0; i < 100000; i++) cout<< x[i] <<endl; 



  outFile.close();
  inFile.close();
  return 0;
}
