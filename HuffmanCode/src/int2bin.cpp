#include <limits.h>
#include "int2bin.h"
char *itob(int x)
{
  static char buff[sizeof(int) * CHAR_BIT + 1];
  int i;
  int j = sizeof(int) * CHAR_BIT - 1;

  buff[j] = 0;
  for(i=0;i<sizeof(int) * CHAR_BIT; i++)
  {
    if(x & (1 << i))
      buff[j] = '1';
    else
      buff[j] = '0';
    j--;
  }
  return buff;
}


