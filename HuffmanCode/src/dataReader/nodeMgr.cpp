// -------------------------------------------------------------------------- //
// @Description: implememtation
// @Provides: mouda 
// -------------------------------------------------------------------------- //
#include <bitset>
#include <iostream>
#include <string>
#include <cassert>
#include "nodeMgr.h"

using std::pair;
using std::cout;
using std::endl;
using std::bitset;
using std::string;
using std::iterator;
using std::map;
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

void Node::initialize( unsigned length, bitset<9>* inputs)
{
  /* set the data length and assign the data */
  _dataLength = length;
  _data = new bitset<9>[length];
  for (int i = 0; i < length; i++) 
    _data[i] = inputs[i];

  /* construct the statistic table */
  unsigned j = 0;
  for (int i = 0; i < length; i++) {
    if (_mapTable.find(_data[i].to_string()) == _mapTable.end()) {
      _mapTable.insert( pair<string, unsigned >(_data[i].to_string(), j) );
      j++;
    }
  }
#ifdef _DEBUG_ON_
//  map< string, unsigned >::iterator it;
//  for ( it = _mapTable.begin(); it != _mapTable.end(); it++) 
//    cout << (*it).first << " => " << (*it).second << endl;
#endif
  _statisticTable = new int[_mapTable.size()];
  for (int i = 0; i < _mapTable.size(); i++){
    _statisticTable[i] = 0; 
  } 
  for (int i = 0; i < length; i++){ 
    _statisticTable[_mapTable.find(_data[i].to_string())->second]++;
  }

#ifdef _DEBUG_ON_
//  for (int i = 0; i < _mapTable.size(); i++) {
//    cout << i << ' ' << _statisticTable[i] << endl;
//  }
#endif

 /* huffman encoding */
  _huffmanCode = new HuffmanCode(_statisticTable, _mapTable.size());
  _huffmanCode->constructTable();
  _huffmanCode->generateHuffmanCode();
  _avergthCodeLength = _huffmanCode->getAverageCodeLength();
}

// -------------------------------------------------------------------------- //
// @Description: reset the status of node
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void Node::resetNode()
{
  delete [] _statisticTable;
  delete _huffmanCode;
  _statisticTable = 0;
  _huffmanCode = 0;

}

// -------------------------------------------------------------------------- //
// @Description: report data
// @Provides: mouda 
// -------------------------------------------------------------------------- //

string Node::reportData( unsigned index)
{
  assert( index < _dataLength && index >= 0);
  return  _data[index].to_string();
}

// -------------------------------------------------------------------------- //
// @Description: get the huffman code table
// @Provides: mouda
// -------------------------------------------------------------------------- //

string Node::getCodeTable()
{
  return _huffmanCode->getHuffmanTable();
}

// -------------------------------------------------------------------------- //
// @Description: NodeMgr constructer and destructer implementation, note that 
//  each node get the same length of data.
// @Provides: mouda 
// -------------------------------------------------------------------------- //

NodeMgr::NodeMgr( unsigned nodeNum, unsigned dataLength, bitset<9>* inputs)
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
    cout << "**************** [" << i << "] ***************" << endl;
    cout <<  _allNodes[i].reportData(0) << endl;
    //cout << _allNodes[i].getCodeTable() << endl;
    cout << _allNodes[i].getAverageCodeLength() << endl;

  }
}
