#ifndef __ZINHO__
#define __ZINHO__

#include <stdio.h>

FILE * out;

int line = 0;
int col = 0;
char finished = 0;

int colno = 0;

int left, right;

void outw(char);
void outb(char);

#endif