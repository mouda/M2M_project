#include <iostream>

using namespace std;

#include "MyParse.h"

MyParse::MyParse()
{
   _isFinish = false;
   _isOver = false;
   _huffmanCode = "";
}

void MyParse::myParse(string line)
{
   if (!_isOver) {
      if (_isFinish) {
	 _huffmanCode = line;
	 _isOver = true;
      }
      else {
	 if (line == "# Huffman_encoding") {
	    
	 }
	 else if (line == "# end") {
	    _isFinish = true;
	 }
	 else {
	    _setCharCode(line);
	 }
      }
   }
}

void MyParse::_setCharCode(string line)
{
   int cut = line.find(": ");
   _charTable.push_back(line.substr(0, cut).c_str()[0]);
   _codeTable.push_back(line.substr(cut + 2));
}

string MyParse::decode()
{
   string result = "";
   string tmpKey;
   int cut;
   while(_huffmanCode.length() != 0) {
      cut = 0;
      while(true) {
	 tmpKey = _huffmanCode.substr(0, cut);
	 if (_search(tmpKey) == '\0') {
	    cut ++;
	 }
	 else {
	    result += _search(tmpKey);
	    break;
	 }
      }
      _huffmanCode = _huffmanCode.substr(cut);
   }
   return result;
}

char MyParse::_search(string key)
{
   char result = '\0';
   for (int i = 0; i < _codeTable.size(); i ++) {
      if (_codeTable[i] == key) {
	 result = _charTable[i];
	 break;
      }
   }
   return result;
}

void MyParse::debug()
{
   for (int i = 0; i < _charTable.size(); i ++) {
      cout << _charTable.at(i) << "\t";
      cout << _codeTable.at(i) << endl;
   }
   cout << _huffmanCode << endl;
}
