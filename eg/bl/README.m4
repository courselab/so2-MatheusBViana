dnl    SPDX-FileCopyrightText: 2024 Monaco F. J. <monaco@usp.br>
dnl   
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

include(docm4.m4)

 Bl: simple bootloader
 ==============================
 
 This is a very simple example of a bootloader. The first stage, which fits
 within the boot sector, loads the remaining sectors from the boot media using
 the BIOS disk service.

 Bl is a very simple example of an OS bootloader. The zeroth-stage boot setp is
 performed by the BIOS' legacy boot mechanism, which loads the first disk sector
 into RAM. This 512-byte block implements the bootloader, which then performs
 the first-stage boot step by loading the kernel from disk into RAM. The kernel
 may span several sectors and is loaded by the bootloader using the BIOS disk
 service.
 
 The "kernel", implemented by this example, is actually a simple program that
 runs in x86 real-mode that does nothing but writing in the video memory. It
 can be an useful example, though, of bare-metal C programming and inline assembly.

 Directions
 ------------------------------

1) Build and execute the program:

   make
   make boot.bin/run

2) Take some time to understand the program source.

   The file 'stage1.c' implements the bootloader in plain C.
   
   Observe that the 'main' function calls some auxiliary functions implemented
   using BIOS services. Those functions are conveniently written in assembly in
   the source file 'bios1.S; . Since the bootloader must fit the 512-byte limit
   (actually 448 bytes), 'bios1.S' contains only the functions needed by the
   first-stage boot.

   Still in 'stage1',the function 'load_kernel()', if successfull, loads kernel
   into RAM. Then, the function 'kernel_init()', that is implemented by the
   kernel, is called. Here, 'main()' will never return.
   
   The file 'kernel.c' implements the kernel. It's only function,
   'kernel_init()', prints a message in the screen which signalizes the user
   that the first-stage boot has been successful.

   To illustrate how it's easier to program without the 512-byte limitation,
   the file 'klib.c' implements the function 'slpash()', which draws some
   graphics on the screen. File 'klib.c' is written mostly in plain C, with
   a few inline assembly parts that illustrate this technique.

   The program is linked using the linker script 'boot.ld', that takes care of
   the static relocation to match the load address, ensemble the relevant
   object sections into a flat binary, and adds the boot signature.

   It's interesting to take a closer look at how the linker script works. First
   it sets the program origin to 0x7c00, and then creates a section '.stage1'
   that contains all objects that compose the bootloader. This section needs to
   fit the boot sector of the disk. Then, after the boot signature, the linker
   creates another section '.kernel' which contains only the objects composing
   the kernel.

   The example introduces a very useful feature of the linker script, that is
   the possibility of defining new symbols in addition to those already
   existing in the form of variables and function names. The symbol
   '_KERNEL_ADDR' in the linker script is defined as the address of the kernel
   in the binary file: since it comes after the boot signature, we know the
   kernel starts at the 513rd byte. Then, '_KERNEL_SIZE' will automatically be
   assigned the kernel size. The kernel size is required by the function
   'load_kernel()', that needs to know how many sectors to read.

   Observe that '_KERNEL_SIZE' is not a variable, nor a function. It is just an
   entry in the object's symbol table. You can see it by running

      $ readelf -s bios1.o
      $ readlef -r bios1.o

   It is symbol that must be resolved in bios1.o by the linker, as any other
   undefined symbol. In this case, we make it easier for the linker because we
   manually defined it in the linker script itself. The symbol '_END_STACK',
   used by 'rt0.o' is defined through the same scheme.

   The linker scripts also prepends the program with 'rt0.o' (created from
   rt0.S), which performs the basic C runtime initialization, including the
   proper  canonicalization of registers and ensuring that 'main' is the entry
   function.

   For simplicity, all functions are assumed to implement the fastcall calling
   convention, which means that function arguments, if any, are passed through
   registers %cx and %dx, and that return values are passed back to caller
   using register %ax.

   Go through the 'Makefile' script to see how each component is built from its
   source. Consult GCC manual if needed to recall the command-line compiler
   options (we use flag '-Os' with 'utils.o' to optimize for size).
   

 DOCM4_BINTOOLS_DOC

