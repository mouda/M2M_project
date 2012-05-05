// -------------------------------------------------------------------------- //
// @Description: Define the class to manage all the machine node
// @Provides: mouda 
// -------------------------------------------------------------------------- //
#include <bitset>
#include <map>
#include <string>
#include "huffmanCode.h"


using std::string;
using std::bitset;
using std::map;

// -------------------------------------------------------------------------- //
// @Description: Define the class to repesent each node 
// @Provides: mouda
// -------------------------------------------------------------------------- //

class Node{
  public:
    Node();
    ~Node();
    void      initialize( unsigned length, bitset<9>* inputs);
    void      resetNode();
    double    getAverageCodeLength(){return _avergthCodeLength;}
    string    reportData( unsigned index);
    string    getCodeTable();

  private:
    bitset<9>*                _data;
    map< string , unsigned>   _mapTable;
    int*                      _statisticTable;
    unsigned                  _dataLength;
    double                    _avergthCodeLength;
    // As entropy if huffman encoder is used
    HuffmanCode               *_huffmanCode; 
};

// -------------------------------------------------------------------------- //
// @Description: Define the class to represent the node god and cluster head
// @Provides: mouda 
// -------------------------------------------------------------------------- //

class NodeMgr{
  public:
    NodeMgr( unsigned nodeNum, unsigned dataLength, std::bitset<9>* inputs);
    ~NodeMgr();
    double  getAverageCodeLength(){return _avergthCodeLength;}
    void    reportNode();
  private:
    Node      *_allNodes;
    unsigned  _nodeNumber;
    double    _avergthCodeLength;      // As entropy if huffman encoder is used 
};
