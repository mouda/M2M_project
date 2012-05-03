// bitset::none
#include <iostream>
#include <bitset>
using namespace std;

int main ()
{
  bitset<16> mybits;

  cout << "enter a binary number: ";
  cin >> mybits;

  if (mybits.none())
    cout << "mybits has no bits set.\n";
  else
    cout << "mybits has " << (int)mybits.count() << " bits set.\n";

  return 0;
}


