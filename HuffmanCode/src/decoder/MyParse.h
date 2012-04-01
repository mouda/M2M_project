#include <iostream>
#include <vector>

#ifndef _MYPARSE_H_
#define _MYPARSE_H_

class MyParse {
   public:
	MyParse();
	void	myParse(string);
	string	decode();	// return the Huffman decode result in string type
	void	debug();
   private:
	bool	_isFinish;
	bool	_isOver;
	vector<char>	_charTable;	// store chararcter in this table
	vector<string>	_codeTable;	// stroe the binary code according to each charater in this table
	string	_huffmanCode;	// the source binary Huffman code

	void	_setCharCode(string);
	char	_search(string);
};

#endif
