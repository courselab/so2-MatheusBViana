/*
 *    SPDX-FileCopyrightText: 2024 Monaco F. J. <monaco@usp.br>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */

#ifndef KLIB_H
#define KLIB_H

#define COLUMNS 80		/* VGA-compatible text mode: 80 columns. */
#define ROWS    25		/* VGA-compatible text mode: 25 rows.    */
#define UPPER    0		/* First row (upper of the screen).      */
#define BOTTOM  (ROWS-1)	/* Last row (bottom of the screen).      */
#define LEFT    0		/* First column (left of the screen).    */
#define RIGHT   (COLUMNS -1)	/* Last column (right of the screen).    */

extern char character_color;    /* Default fore/background char color.   */

void splash(void);		/* Draw the splash screen.               */

/* Two-byte value to be written into video RAM: color+ascii.             */

#define color_char(ascii) ((character_color<<8) + ascii)

void halt(void);		/* Halt the system.                       */

#endif  /* KLIB_H  */
