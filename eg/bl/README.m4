dnl    SPDX-FileCopyrightText: 2024 Monaco F. J. <monaco@usp.br>
dnl   
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

include(docm4.m4)

 2SBoot: a two-stage boot
 ==============================
 
 2SBoot is a very simple two-stage bootloader. The first stage, which fits
 within the boot sector, loads the remaining sectors from the boot media using
 the BIOS disk service.

 The second stage prints a greeting message and halts.

 Challenge
 ------------------------------

1) Build and execute BootCmd:

   make
   make bcmd.bin/run

2) Take some time to understand the program source.

   The file 'main.c' contains the the main program, in plain C.

   Observe that the 'main' function calls some auxiliary functions implemented
   using BIOS services. Those functions are conveniently written in assembly in
   the source file 'bios.S'
   
   The 'strcmp' function, on the other hand, can be written in plain C, and is
   implemented in the file 'utils.c'.
   
   The program is linked using the linker script 'bcmd.ld', that takes care of
   the static relocation to match the load address, ensemble the relevant
   object sections into a flat binary, and adds the boot signature.

   The linker scripts also prepends the program with 'rt0.o' (created from
   rt0.S), which performs the basic C runtime initialization, including the
   proper  initialization of registers and ensuring that 'main' is the entry
   function.

   For simplicity, all functions are assumed to implement the fastcall calling
   convention, which means that function arguments, if any, are passed through
   registers %cx and %dx, and that return values are passed back to caller
   using register %ax.

   Go through the 'Makefile' script to see how each component is built from its
   source. Consult GCC manual if needed to recall the command-line compiler
   options (we use flag '-Os' with 'utils.o' to optimize for size).
   

3) Implement a new built-in command.

   Think of a new command, such as to return the current date, print the
   available RAM memory, draw some cool graphics using video memory...
   or anything else you feel like.

   You may write your function in either assembly or C, whatever seems easier
   depending on the functionality you chose to implement.

   If you start running out of memory (remember the 512-byte limitation), you
   may save some space replacing the 'strcmp' function in 'utils.c' with the
   handcrafted memory-optimized assembly counterpart found in 'opt.S' (edit
   the Makefile accordingly).

   To save even more space, you may get rid of the 'help' command, shorten
   strings, explore compact assembly idioms (e.g. 'xor %ax, %ax' rather than
   'mov $0, %ax') and doing manual bit twiddling.


 DOCM4_EXERCISE_DIRECTIONS

 DOCM4_BINTOOLS_DOC

