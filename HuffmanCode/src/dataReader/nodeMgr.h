// -------------------------------------------------------------------------- //
// @Description: Define the class to manage all the machine node
// @Provides: mouda 
// -------------------------------------------------------------------------- //
#include <bitset>


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
    double getAverageCodeLength(){return _avergthCodeLength;}

  private:
    std::bitset<9>* _data;
    unsigned **_statisticTable;
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
  private:
    Node *_allNodes;
    double _avergthCodeLength;      // As entropy if huffman encoder is used 
};
