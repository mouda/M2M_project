// -------------------------------------------------------------------------- //
// @Description: implememtation
// @Provides: mouda 
// -------------------------------------------------------------------------- //
#include <bitset>
#include <iostream>
#include <string>
#include <cassert>
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
  _dataLength = length;
  _data = new std::bitset<9>[length];
  for (int i = 0; i < length; i++) 
    _data[i] = inputs[i];

  /* construct the statistic table */
  unsigned j = 0;
  for (int i = 0; i < length; i++) {
    if (_mapTable.find(_data[i].to_string()) == _mapTable.end()) {
      _mapTable.insert( std::pair<std::string, unsigned >(_data[i].to_string(), j) );
      j++;
    }
  }
#ifdef _DEBUG_ON_
  std::map< std::string, unsigned >::iterator it;
  for ( it = _mapTable.begin(); it != _mapTable.end(); it++) 
    std::cout << (*it).first << " => " << (*it).second << std::endl;
#endif
  _statisticTable = new unsigned[_mapTable.size()];
  for (int i = 0; i < _mapTable.size(); i++) 
    _statisticTable[i] = 0; 
  for (int i = 0; i < length; i++) 
    _statisticTable[_mapTable.find(_data[i].to_string())->second]++;



  /* huffman encoding */

}

// -------------------------------------------------------------------------- //
// @Description: reset the status of node
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void Node::resetNode()
{
  delete [] _statisticTable;

}

// -------------------------------------------------------------------------- //
// @Description: report data
// @Provides: mouda 
// -------------------------------------------------------------------------- //

std::string Node::reportData( unsigned index)
{
  assert( index < _dataLength && index >= 0);
  return  _data[index].to_string();
}

// -------------------------------------------------------------------------- //
// @Description: NodeMgr constructer and destructer implementation, note that 
//  each node get the same length of data.
// @Provides: mouda 
// -------------------------------------------------------------------------- //

NodeMgr::NodeMgr( unsigned nodeNum, unsigned dataLength, std::bitset<9>* inputs)
{
  _nodeNumber = nodeNum;
  _allNodes = new Node[nodeNum]; 
  for (int i = 0; i < nodeNum; i++)  
    _allNodes[i].initialize(dataLength, &inputs[i*dataLength]); // memory offset

}

NodeMgr::~NodeMgr()
{
  delete [] _allNodes;
  _allNodes = 0;

}

void NodeMgr::reportNode()
{
  for (int i = 0; i < _nodeNumber; i++) {
    std::cout << "**************** [" << i << "] ***************" << std::endl;
    std::cout <<  _allNodes[i].reportData(0) << std::endl;
  }
}
