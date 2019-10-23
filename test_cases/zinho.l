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

int lastj = 0;

int line = 1;
int col  = 0;

int left;
int right;

FILE *out;

void outw();
void outb(int,int);
void outline();

enum languages {
    CPP = 1,
    HASKELL,
    SCHEME,
};

enum languages target;
%}

white  [ \t]+
number [0-9]+

%%

{white}             { }

"@"                 { lastj = 1; }

"0"                 { outw(); col++; }

{number}/"/"        { BEGIN BLACK; left = atoi(yytext); }
<BLACK>"/"          { }
<BLACK>{number}     { right = atoi(yytext); outb(left, right); BEGIN INITIAL; col++; }

"$"                 { yyterminate(); }
"\n"                { line++; col = 0; outline(); lastj = 0; }
"."                 { }

%%

void header()
{
    switch(target)
    {
        case CPP:
            break;

        case HASKELL:
            fprintf(out, "module TestCases (height, width, kakuroBoard) where\n");
            fprintf(out, "kakuroBoard :: [[(Int, Int, Int)]]\n");
            fprintf(out, "kakuroBoard = [[");
            break;

        case SCHEME:
           fprintf(out, "(define board (vector ");
            break;
        
        default:
            printf("Language %u not supported!", target);
    }    
}

void footer()
{
    switch(target)
    {
        case HASKELL:
            fprintf(out, "]]\n");
            break;

        case SCHEME:
            fprintf(out, "))\n");
            break;
        
        default:
            printf("Language %u not supported!", target);
    }      
}

void outw()
{
    switch(target)
    {
        case HASKELL:
            if (lastj)
                fprintf(out, "(1,0,0)");
            else
                fprintf(out, "(1,0,0),");
            break;

        case SCHEME:
            fprintf(out, "(vector 1 0 0) ");
            break;
        
        default:
            printf("Language %u not supported!", target);
    }   
}

void outb(int left, int right)
{
    switch(target)
    {
        case HASKELL:
            if (lastj)
                fprintf(out, "(0,%d,%d)", left, right);
            else
                fprintf(out, "(0,%d,%d),", left, right);
            break;

        case SCHEME:
            fprintf(out, "(vector 0 %d %d) ", left, right);
            break;
        
        default:
            printf("Language %u not supported!", target);
    }
}

void outsize()
{
    switch(target)
    {
        case HASKELL:
            fprintf(out, "height :: Int\n");
            fprintf(out, "height = %d\n", line);
            fprintf(out, "width :: Int\n");
            fprintf(out, "width = %d\n", col);
            break;

        case SCHEME:
            fprintf(out, "(define height %d)\n", line);
            fprintf(out, "(define width %d)", col);
            break;
        
        default:
            printf("Language %u not supported!", target);
    }
}

void outline()
{
    switch(target)
    {
        case HASKELL:
            fprintf(out, "],[");
    }
}

int main(int argc, char **argv)
{
    if (argc != 4)
    {
        printf("Unknown paramets, usage: zinho <language> <file>");
    }

    // setup language choice.
    target = atoi(argv[1]);

    // setup streams.
    yyin = fopen(argv[2], "r");
    out  = fopen(argv[3], "w");

    header();
    yylex();
    footer();

    outsize();
}