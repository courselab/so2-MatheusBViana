/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */

#include "bios.h"
#include "utils.h"

#define PROMPT "$ "
char buffer[10];

int __attribute__((fastcall)) strcmp(const char*, const char*);

int main()
{
  clear();
  
  println  ("Boot Command 1.0");

  while (1)
    {
      print(PROMPT);
      readln(buffer);

      println(buffer);
      
      if (buffer[0])
	{
	  if (!strcmp(buffer,"help"))
	    println("A Beattles's song.");
	  else 
	    println("Unkown command.");
	}
    }
  
  return 0;

}

