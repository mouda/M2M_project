// -------------------------------------------------------------------------- //
// @Description: implememtation
// @Provides: mouda 
// -------------------------------------------------------------------------- //
#include <bitset>
#include "nodeMgr.h"
#include "huffmanCode.h"

// -------------------------------------------------------------------------- //
// @Description: Node constructer and destructer implementation 
// @Provides: mouda 
// -------------------------------------------------------------------------- //

Node::Node( )
{
}

Node::~Node()
{

}

// -------------------------------------------------------------------------- //
// @Description: initialize the node
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void Node::initialize( unsigned length, std::bitset<9>* inputs)
{
  /* set the data length and assign the data */
  _data = new std::bitset<9>[length];
  for (int i = 0; i < length; i++) {
    _data[i] = inputs[i];
  }
  /* huffman encoding */
  //TODO

}

// -------------------------------------------------------------------------- //
// @Description: reset the status of node
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void Node::resetNode()
{

}

// -------------------------------------------------------------------------- //
// @Description: NodeMgr constructer and destructer implementation, note that 
//  each node get the same length of data.
// @Provides: mouda 
// -------------------------------------------------------------------------- //

NodeMgr::NodeMgr( unsigned nodeNum, unsigned dataLength, std::bitset<9>* inputs)
{
  _allNodes = new Node[nodeNum]; 
  for (int i = 0; i < nodeNum; i++)  
    _allNodes[i].initialize(dataLength, &inputs[i*dataLength]); // memory offset

}

NodeMgr::~NodeMgr()
{
  delete _allNodes;
  _allNodes = 0;

}

