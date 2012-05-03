#include "huffmanCode.h"
#include "int2bin.h"
#include <string>
#include <iostream>
#include <stdio.h>

using std::cout;
using std::endl;
using std::string;

// -------------------------------------------------------------------------- //
// @Description: the constructor 
// @Provides: mouda 
// -------------------------------------------------------------------------- //

HuffmanCode::HuffmanCode( int *table, int numberOfElements)
{
  count = 0;
  totalExistingTimes = 0;
  for (int i = 0; i < numberOfElements; i++) { 
    if (table[i] != 0 ) count++;
    totalExistingTimes+=table[i];
  }

  /* construct the x table */
  x = new int *[count];
  for (int i = 0; i < count; i++) x[i] = new int[2];
  for (int i = 0, j = 0; i < numberOfElements; i++) 
    if (table[i] != 0 ) { x[j][0] =i; x[j][1] = table[i]; j++;}  


  /* construct the TEMP table */
  temp = new int *[count];
  for (int i = 0; i < count; i++) temp[i] = new int[2]; 

  /* construct the dp table */
  dp = new int *[count];
  for (int i = 0; i < count; i++) dp[i] = new int[count]; 
  for (int i = 0; i < count; i++) {
    for (int j = 0; i < count; i++) {
      dp[i][j] = 0;
    }
  }
  /* construct the code word table */
  HuffmanCodeTable = new string [count];
  

}


// -------------------------------------------------------------------------- //
// @Description: the destructor
// @Provides: mouda 
// -------------------------------------------------------------------------- //

HuffmanCode::~HuffmanCode()
{
  for (int i = 0; i < count  ; i++) {
    delete[] x[i];
    delete[] temp[i];
    delete[] dp[i];
  }
  delete[] x;
  delete[] temp;
  delete[] dp;
  delete[] HuffmanCodeTable;

}

// -------------------------------------------------------------------------- //
// @Description: construct the dynamic programming table
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void HuffmanCode::constructTable()
{
  for (int i = 0; i < count; i++) dp[i][0] = x[i][1];
  int i = 0;
  while ( findTwoSmallestAddTogether(i)) i++; 

#ifdef _DEBUG_ON_
//  displayTable();
//  displayTemp();
//  cout << totalExistingTimes <<endl;
#endif 

}

// -------------------------------------------------------------------------- //
// @Description: find the two smallest number of existence and add them 
//  together, store to the result to the smaller index entry (at the next
//  column) and set the larger index entry as the total number+1. Also, saving 
//  the index of two smaller number to the temp table. 
// @Provides: mouda 
// -------------------------------------------------------------------------- //

bool HuffmanCode::findTwoSmallestAddTogether( int column)
{
  if (column+1 >= count) return false; 

  /* the first entry stores  character number and the second entry stores 
   * existing times*/
  int smaller[2], smallest[2];
  smallest[0] = 0, smallest[1] = totalExistingTimes+1;
  smaller[0] = 1, smaller[1] = totalExistingTimes+1;

  /* find the 1st and 2nd smallest */
  for (int i = 0; i < count; i++) 
    if (dp[i][column] <= smallest[1]) {
      smallest[0] = i;
      smallest[1] = dp[i][column];
    }
  for (int i = 0; i < count; i++) {
    if ( smallest[0] == i) continue; 
    if (dp[i][column] >= smallest[1] && dp[i][column] <= smaller[1]) {
      smaller[0] = i;
      smaller[1] = dp[i][column];
    }
  }

#ifdef _DEBUG_ON_
//  printf("smaller %d: %d, smallest %d: %d\n", smaller[0], smaller[1], 
//      smallest[0], smallest[1]);
#endif

  /* copy to the next column */
  for (int i = 0; i < count; i++) dp[i][column+1] = dp[i][column];

  /* add the result to the smaller index, the larger one set to 
   * totalExistingTimes, also save the index to the TEMP table*/
  if (smallest[0] < smaller[0]) {
    dp[smallest[0]][column+1] = smallest[1] + smaller[1];
    dp[smaller[0]][column+1] = totalExistingTimes+1;
    temp[column][0] = smallest[0];
    temp[column][1] = smaller[0];
  }
  else {
    dp[smaller[0]][column+1] = smallest[1] + smaller[1];
    dp[smallest[0]][column+1] = totalExistingTimes+1;
    temp[column][0] = smaller[0];
    temp[column][1] = smallest[0];
  }
  return true;
}



// -------------------------------------------------------------------------- //
// @Description: generate the Huffman Code word 
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void HuffmanCode::generateHuffmanCode()
{
//  displayTemp();
  for (int i = count-2 ; i >= 0; i--) {
    HuffmanCodeTable[temp[i][1]] = HuffmanCodeTable[temp[i][0]] + '1';
    HuffmanCodeTable[temp[i][0]] = HuffmanCodeTable[temp[i][0]] + '0';
  }
//  displayHuffmanTable();

}

// -------------------------------------------------------------------------- //
// @Description: Huffman encoder, to translate the source code into the Huffman
//  code
// @Provides: mouda 
// -------------------------------------------------------------------------- //

string HuffmanCode::HuffmanEncoder( char input)
{
  int i = 0;
  for (; i < count; i++)
    if ( (int)input == x[i][0] ){
      HuffmanCodeTable[i];  
      break;
    } 
  return HuffmanCodeTable[i];


}


// -------------------------------------------------------------------------- //
// @Description: display the input statistic result
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void HuffmanCode::displaySource()
{
  for (int i = 0; i < count; i++) printf("%c: %d \n", x[i][0], x[i][1]);
}

// -------------------------------------------------------------------------- //
// @Description: display the DP table
// @Provides: mouda
// -------------------------------------------------------------------------- //

void HuffmanCode::displayTable()
{
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      cout << dp[i][j] << ' ';
    }
    cout << endl;
  }
}

// -------------------------------------------------------------------------- //
// @Description: display the Temp table
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void HuffmanCode::displayTemp()
{
  for (int i = 0; i < count; i++) {
    cout << temp[i][0] << ' ' << temp[i][1] << endl;
  }
}

// -------------------------------------------------------------------------- //
// @Description: display the Huffman Code Table 
// @Provides: mouda 
// -------------------------------------------------------------------------- //

void HuffmanCode::displayHuffmanTable()
{
  for (int i = 0; i < count; i++) {
    cout <<(char)x[i][0] << ": " << HuffmanCodeTable[i] << endl;
  }
}

// -------------------------------------------------------------------------- //
// @Description: return the string storing Huffman Code Table
// @Provides: mouda 
// -------------------------------------------------------------------------- //

string HuffmanCode::getHuffmanTable()
{
  string Table;
  for (int i = 0; i < count; i++) {
    Table.push_back((char)x[i][0]);
    Table+=": ";
    Table+=HuffmanCodeTable[i];
    Table.push_back('\n');
  }
  return Table;
}



