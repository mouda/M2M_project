// -------------------------------------------------------------------------- //
// @Description: Define the class to manage all the machine node
// @Provides: mouda 
// -------------------------------------------------------------------------- //
#include <bitset>
#include <map>
#include <string>


// -------------------------------------------------------------------------- //
// @Description: Define the class to repesent each node 
// @Provides: mouda
// -------------------------------------------------------------------------- //

class Node{
  public:
    Node();
    ~Node();
    void initialize( unsigned length, std::bitset<9>* inputs);
    void resetNode();
    std::string reportData( unsigned index);
    double getAverageCodeLength(){return _avergthCodeLength;}

  private:
    std::bitset<9>* _data;
    std::map<std::string , unsigned> _mapTable;
    unsigned *_statisticTable;
    unsigned _dataLength;
    double _avergthCodeLength;      // As entropy if huffman encoder is used
};

// -------------------------------------------------------------------------- //
// @Description: Define the class to represent the node god and cluster head
// @Provides: mouda 
// -------------------------------------------------------------------------- //

class NodeMgr{
  public:
    NodeMgr( unsigned nodeNum, unsigned dataLength, std::bitset<9>* inputs);
    ~NodeMgr();
    double getAverageCodeLength(){return _avergthCodeLength;}
    void reportNode();
  private:
    Node *_allNodes;
    unsigned _nodeNumber;
    double _avergthCodeLength;      // As entropy if huffman encoder is used 
};
