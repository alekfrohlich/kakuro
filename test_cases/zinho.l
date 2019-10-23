%option noyywrap
%x BLACK

%{
//  MIT License
//  
//  Copyright (c) 2019 Alek Frohlich, Nicolas Goeldner
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  
//  This program solves kakuro boards using backtracking.

#include <stdlib.h>
#include <stdio.h>

int line = 0;
int col  = 0;

int left;
int right;

FILE *out;

void outw();
void outb(int,int);
%}

white  [ \t]+
number [0-9]+

%%

{white}             { }

"0"                 { outw(); col++; }

{number}/"/"        { BEGIN BLACK; left = atoi(yytext); col++; }
<BLACK>"/"          { }
<BLACK>{number}     { right = atoi(yytext); outb(left, right); BEGIN INITIAL; col++; }

"\n"                { line++; col = 0; }
"."                 { }

%%

void header()
{
    fprintf(out, "(define board (vector ");
}

void footer()
{
    fprintf(out, "))\n");
}

void outw()
{
    fprintf(out, "(vector 1 0 0) ");
}

void outb(int left, int right)
{
    fprintf(out, "(vector 0 %d %d) ", left, right);
}

void outsize()
{
    fprintf(out, "(define height %d)\n", line);
    fprintf(out, "(define width %d)", col);
}

int main(int argc, char **argv)
{
    yyin = fopen(argv[1], "r");
    out  = fopen("test", "w");

    header();
    yylex();
    footer();

    outsize();
}