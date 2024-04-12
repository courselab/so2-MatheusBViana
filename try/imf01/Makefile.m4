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

bin = decode

# bin = cypherbin 
# main_obj = main.o
# main_lib = libfoobar
# main_ldflags = -L. -Wl,-Bstatic
# cypherbin_obj = cypherbin.o

decode_obj = decode.o cypher.o

# lib = libfoobar
# libfoobar_obj = foo.o

CPP_FLAGS= -Wall 
C_FLAGS= -m32 -fcf-protection=none -O0
LD_FLAGS= -m32

LOCAL_CLEAN = *~

DOCM4_RELEVANT_RULES

# DOCM4_MAKEGYVER

DOCM4_UPDATE

DOCM4_BINTOOLS


# cypher.o : cypher.s
# 	$(CC)  $(MKG_CPPFLAGS) $(MKG_CFLAGS) -fno-pic $($*_cppflags) $($*_cflags) -c $< -o $@

# cypher.s : cypher.c
# 	$(CC)  $(MKG_CPPFLAGS) $(MKG_CFLAGS) -fno-pic $($*_cppflags) $($*_cflags) -S $< -o $@


