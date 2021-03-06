// -------------------------------------------------------------------------- //
// @Description: Define the class to manage the Huffman encoder 
// @Provides: mouda
// -------------------------------------------------------------------------- //
#include <string>
#include <map>

using std::string;

class HuffmanCode {

public:
  HuffmanCode( int *table, int numberOfElements);
  ~HuffmanCode();

  void displaySource();
  void constructTable();
  bool findTwoSmallestAddTogether( int column);
  void generateHuffmanCode();
  double getAverageCodeLength() { return averageCodeLength;}
  string HuffmanEncoder(char input);


  void displayTable(); 
  void displayTemp();
  void displayHuffmanTable();
  string getHuffmanTable();

private:
  int count;                //total ASCII chars
  int totalExistingTimes;   //total words of the article
  int **x;                  //store the statistic result
  int **temp;               //store the dp trace
  int **dp;                 //DP table
  double averageCodeLength;    //entropy
  string *HuffmanCodeTable; //the Huffman code table

};
