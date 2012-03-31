// -------------------------------------------------------------------------- //
// @Description: Define the class to manage the Huffman encoder 
// @Provides: mouda
// -------------------------------------------------------------------------- //
#include <string>

using std::string;

class HuffmanCode {

public:
  HuffmanCode( int *table);
  ~HuffmanCode();

  void displaySource();
  void constructTable();
  bool findTwoSmallestAddTogether( int column);
  void generateHuffmanCode();
  char* HuffmanEncoder(char* input);


  void displayTable(); 
  void displayTemp();
  void displayHuffmanTable();

private:
  int count;
  int totalExistingTimes;
  int **x;
  int **temp;
  int **dp;
  string *HuffmanCodeTable;

};
