#include <iostream>
#include <fstream>

using namespace std;

#include "MyParse.h"

int main(int argc, char *argv[])
{
   string line;
   fstream myfile(argv[1]);
   MyParse parse;

   if (myfile.is_open()) {
      while(myfile.good()) {
	 getline(myfile, line);
	 parse.myParse(line);
      }
      myfile.close();
   }
   else cout << "Unable to open file" << endl;

   parse.debug();
   cout << parse.decode() << endl;
   return 0;
}
