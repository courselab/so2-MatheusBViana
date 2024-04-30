/*
 *    SPDX-FileCopyrightText: 2024 Monaco F. J. <monaco@usp.br>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */


#include "klib.h"

/* Video RAM as 2D matrix: short vram[row][col]. */

short (*vram)[COLUMNS] = (short (*)[COLUMNS])0xb8000;

char character_color = 0x70;	/* Default fore/background character color.*/

void writexy(unsigned char row, unsigned char col, const char* string)
{
  int i=col;
  int k=0;
  while (string[k])
    {
      if (col >= COLUMNS)
	{
	  row += 1;
	  col = 0;
	}

      row = row % ROWS;
      
      vram[row][i] = color_char(string[k]);
      i++;
      k++;
    }
}

/* Delay for 't' seconds. */

void __attribute__((fastcall)) delay(unsigned short t)
{
  __asm__
    (
      "pusha                   \n"
      "movb $0x86, %ah         \n" /* %ah = 0x86 (BIOS function for waiting).            */
      "int $0x15               \n" /* Call BIOS interrupt 0x15, function AH=0x86.       */
      "popa                    \n"
     );
}

void splash(void)
{
  int i,j;

  character_color = 0x70;
  
  writexy(ROWS*1/5, 5, "                                                                      ");
  
  for (j = (ROWS*1/5) + 1; j <= (ROWS*4/5) -1; j++)
    {
      writexy(j, 5, " ");
      writexy(j, COLUMNS-6, " ");
    }
  writexy(ROWS*4/5, 5, "                                                                      ");

  character_color = 0x02;
  writexy( ROWS/2-2, 10, "Loading...");
  character_color = 0x20;
  for (i=10; i<=COLUMNS-10; i++)
    {
      writexy(ROWS/2, i, " ");
      delay(1);
    }
  character_color = 0x02;
  writexy( ROWS/2-2, 20, "  100%");

  
}

void halt(void)
{
  __asm__
    (
     "khalt:        \n"
     "   hlt        \n"
     "   jmp khalt  \n"
     );
}
