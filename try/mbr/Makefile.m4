dnl    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
dnl   
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
dnl
dnl    >> Usage hint:
dnl
dnl       If you're looking for a file such as README or Makefile, then this one 
dnl       you are reading now is probably not the file you are interested in. This
dnl       and other files named with suffix '.m4' are source files used by SYSeg
dnl       to create the actual documentation files, scripts and other items they
dnl       refer to. If you can't find a corresponding file without the '.m4' name
dnl       extension in this same directory, then chances are that you have missed
dnl       the build instructions in the README file at the top of SYSeg's source
dnl       tree (yep, it's called README for a reason).

include(docm4.m4)dnl

#
# Main examples and auxiliary examples
#

bin = mbr.bin

objs = main.o mbr.o

AUXDIR =../../tools#

all : $(bin) 

DOCM4_UPDATE

## C source code.
## We build the program using gcc, as and ld.

mbr.bin : $(objs) mbr.ld rt0.o
	ld -melf_i386 --orphan-handling=discard  -T mbr.ld $(objs) -o $@

main.o mbr.o rt0.o :%.o: %.s 
	as --32 $< -o $@

main.s mbr.s rt0.s :%.s: %.c
	gcc -m16 -O0 -I. -Wall -Wextra -fno-pic -fcf-protection=none  --freestanding -S $< -o $@

main.s mbr.s : mbr.h

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*



## ----------------------------------------------------------------------
##
## Programming exercise
##

EXPORT_FILES_C = main.c mbr.c rt0.c mbr.h mbr.ld
EXPORT_FILES_MAKE = Makefile
EXPORT_FILES_TEXT = README $(AUXDIR)/COPYING 
EXPORT_FILES_SH =

DOCM4_EXPORT([mbr],[0.1.1])


dnl Include Make Bintools

DOCM4_BINTOOLS

