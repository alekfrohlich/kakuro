%option noyywrap
%S SECOND SCANNING
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
#include "language.h"
#include "zinho.h"
%}

white  [ \t]+
number [0-9]+
%%
    if (finished)
        BEGIN(SCANNING);

{white}                             { }

<INITIAL>"0"                        |
<INITIAL>{number}"/"{number}        { col++; }
<INITIAL>"\n"                       { line++; BEGIN(SECOND); }
<SECOND>"\n"                        { line++; }

<SCANNING>"0"                       {
                                        colno++; 
                                        if (colno == (col - 1))
                                            outw(1);
                                        else
                                            outw(0);
                                    }
<SCANNING>{number}/"/"              {
                                        left = atoi(yytext);
                                        input();
                                        BEGIN(BLACK);
                                    }
<BLACK>{number}                     {
                                        colno++;
                                        right = atoi(yytext);
                                        if (colno == (col - 1))
                                            outb(1);
                                        else
                                            outb(0);
                                        BEGIN(SCANNING);
                                    }

.                                   |
"\n"                                { }

%%

// pos board[line][col] = {{{1, 2, 3}, ...}}
// board = [[(1, 2, 3), []]]
// (define board (vector (vector 1 0 0) (vector 0 12 2)))
void outw(char last)
{
    fprintf(out, BEGIN_VEC);
    fprintf(out, "1%s0%s0", SEPARATOR, SEPARATOR);
    fprintf(out, END_VEC);

    #if DIMENSION > 2
    if(!last)
    #endif
        fprintf(out, SEPARATOR);
}

void outb(char last)
{
    fprintf(out, BEGIN_VEC);
    fprintf(out, "0%s%d%s%d", SEPARATOR, left, SEPARATOR, right);
    fprintf(out, END_VEC);

    #if DIMENSION > 2
    if(!last)
    #endif
        fprintf(out, SEPARATOR);
}

void declaration()
{
    #ifdef TYPED
        fprintf(out, BOARD_TYPE);
    #endif
    
    #ifdef PRESIZED
        fprintf(out, SIZE(line,col));
    #endif
    
    #if PRENAMED
        fprintf(out, NAME);
    #endif

    #ifdef ASSIGNED
        fprintf(out, ASSIGN);
    #endif
    
    #ifdef POSTSIZED
        fprintf(out, SIZE(line,col));
    #endif

    fprintf(out, BEGIN_BOARD);

    #ifdef POSTNAMED
        fprintf(out, NAME);
    #endif

    yylex();
    fprintf(out, END_BOARD);
}

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("Unknown paramets, usage: zinho <file>");
    }

    // setup streams.
    yyin = fopen(argv[1], "r");
    out  = fopen("test", "w");

    yylex();
    finished = 1;
    
    // restart file.
    fclose(yyin);
    yyin = fopen(argv[1], "r");

    declaration();
    yyrestart(yyin);
    printf("%d %d\n", line, col); 
}