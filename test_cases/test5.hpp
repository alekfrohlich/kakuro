// test case 2 (10x12).

#include <cstdlib>

#ifndef __KAKURO__
#define __KAKURO__
    #include "kakuro.hpp"
#endif  // namespace kakuro.

// declarations
const int HEIGHT = 10;            // Board height.
const int WIDTH  = 12;            // Board width.

const int LAST_I = 9;            // Last available line index.
const int LAST_J = 11;            // Last available collumn index.

pos board[HEIGHT][WIDTH];

// extern declarations.
extern const int BLACK;
extern const int WHITE;

/*
 * Initialize board.
 */
void init_board(void)
{
    board[0][0].c = BLACK; board[0][0].first = 0; board[0][0].second = 0;
    board[0][1].c = BLACK; board[0][1].first = 14; board[0][1].second = 0;
    board[0][2].c = BLACK; board[0][2].first = 29; board[0][2].second = 0;
    board[0][3].c = BLACK; board[0][3].first = 10; board[0][3].second = 0;
    board[0][4].c = BLACK; board[0][4].first = 0; board[0][4].second = 0;
    board[0][5].c = BLACK; board[0][5].first = 0; board[0][5].second = 0;
    board[0][6].c = BLACK; board[0][6].first = 0; board[0][6].second = 0;
    board[0][7].c = BLACK; board[0][7].first = 24; board[0][7].second = 0;
    board[0][8].c = BLACK; board[0][8].first = 16; board[0][8].second = 0;
    board[0][9].c = BLACK; board[0][9].first = 22; board[0][9].second = 0;
    board[0][10].c = BLACK; board[0][10].first = 0; board[0][10].second = 0;
    board[0][11].c = BLACK; board[0][11].first = 0; board[0][11].second = 0;
    board[1][0].c = BLACK; board[1][0].first = 0; board[1][0].second = 23;
    board[1][1].c = WHITE; board[1][1].first = 0; board[1][1].second = 0;
    board[1][2].c = WHITE; board[1][2].first = 0; board[1][2].second = 0;
    board[1][3].c = WHITE; board[1][3].first = 0; board[1][3].second = 0;
    board[1][4].c = BLACK; board[1][4].first = 3; board[1][4].second = 0;
    board[1][5].c = BLACK; board[1][5].first = 0; board[1][5].second = 0;
    board[1][6].c = BLACK; board[1][6].first = 12; board[1][6].second = 24;
    board[1][7].c = WHITE; board[1][7].first = 0; board[1][7].second = 0;
    board[1][8].c = WHITE; board[1][8].first = 0; board[1][8].second = 0;
    board[1][9].c = WHITE; board[1][9].first = 0; board[1][9].second = 0;
    board[1][10].c = BLACK; board[1][10].first = 24; board[1][10].second = 0;
    board[1][11].c = BLACK; board[1][11].first = 0; board[1][11].second = 0;
    board[2][0].c = BLACK; board[2][0].first = 0; board[2][0].second = 11;
    board[2][1].c = WHITE; board[2][1].first = 0; board[2][1].second = 0;
    board[2][2].c = WHITE; board[2][2].first = 0; board[2][2].second = 0;
    board[2][3].c = WHITE; board[2][3].first = 0; board[2][3].second = 0;
    board[2][4].c = WHITE; board[2][4].first = 0; board[2][4].second = 0;
    board[2][5].c = BLACK; board[2][5].first = 6; board[2][5].second = 34;
    board[2][6].c = WHITE; board[2][6].first = 0; board[2][6].second = 0;
    board[2][7].c = WHITE; board[2][7].first = 0; board[2][7].second = 0;
    board[2][8].c = WHITE; board[2][8].first = 0; board[2][8].second = 0;
    board[2][9].c = WHITE; board[2][9].first = 0; board[2][9].second = 0;
    board[2][10].c = WHITE; board[2][10].first = 0; board[2][10].second = 0;
    board[2][11].c = BLACK; board[2][11].first = 17; board[2][11].second = 0;
    board[3][0].c = BLACK; board[3][0].first = 0; board[3][0].second = 13;
    board[3][1].c = WHITE; board[3][1].first = 0; board[3][1].second = 0;
    board[3][2].c = WHITE; board[3][2].first = 0; board[3][2].second = 0;
    board[3][3].c = BLACK; board[3][3].first = 39; board[3][3].second = 16;
    board[3][4].c = WHITE; board[3][4].first = 0; board[3][4].second = 0;
    board[3][5].c = WHITE; board[3][5].first = 0; board[3][5].second = 0;
    board[3][6].c = WHITE; board[3][6].first = 0; board[3][6].second = 0;
    board[3][7].c = WHITE; board[3][7].first = 0; board[3][7].second = 0;
    board[3][8].c = BLACK; board[3][8].first = 9; board[3][8].second = 19;
    board[3][9].c = WHITE; board[3][9].first = 0; board[3][9].second = 0;
    board[3][10].c = WHITE; board[3][10].first = 0; board[3][10].second = 0;
    board[3][11].c = WHITE; board[3][11].first = 0; board[3][11].second = 0;
    board[4][0].c = BLACK; board[4][0].first = 0; board[4][0].second = 0;
    board[4][1].c = BLACK; board[4][1].first = 0; board[4][1].second = 16;
    board[4][2].c = WHITE; board[4][2].first = 0; board[4][2].second = 0;
    board[4][3].c = WHITE; board[4][3].first = 0; board[4][3].second = 0;
    board[4][4].c = BLACK; board[4][4].first = 4; board[4][4].second = 3;
    board[4][5].c = WHITE; board[4][5].first = 0; board[4][5].second = 0;
    board[4][6].c = WHITE; board[4][6].first = 0; board[4][6].second = 0;
    board[4][7].c = BLACK; board[4][7].first = 7; board[4][7].second = 29;
    board[4][8].c = WHITE; board[4][8].first = 0; board[4][8].second = 0;
    board[4][9].c = WHITE; board[4][9].first = 0; board[4][9].second = 0;
    board[4][10].c = WHITE; board[4][10].first = 0; board[4][10].second = 0;
    board[4][11].c = WHITE; board[4][11].first = 0; board[4][11].second = 0;
    board[5][0].c = BLACK; board[5][0].first = 0; board[5][0].second = 0;
    board[5][1].c = BLACK; board[5][1].first = 4; board[5][1].second = 0;
    board[5][2].c =  BLACK; board[5][2].first = 7; board[5][2].second = 8;
    board[5][3].c =  WHITE; board[5][3].first = 0; board[5][3].second = 0;
    board[5][4].c =  WHITE; board[5][4].first = 0; board[5][4].second = 0;
    board[5][5].c =  WHITE; board[5][5].first = 0; board[5][5].second = 0;
    board[5][6].c =  BLACK; board[5][6].first = 10; board[5][6].second = 7;
    board[5][7].c =  WHITE; board[5][7].first = 0; board[5][7].second = 0;
    board[5][8].c =  WHITE; board[5][8].first = 0; board[5][8].second = 0;
    board[5][9].c =  WHITE; board[5][9].first = 0; board[5][9].second = 0;
    board[5][10].c = BLACK; board[5][10].first = 10; board[5][10].second = 0;
    board[5][11].c = BLACK; board[5][11].first = 0; board[5][11].second = 0;
    board[6][0].c =  BLACK; board[6][0].first = 0; board[6][0].second = 10;
    board[6][1].c =  WHITE; board[6][1].first = 0; board[6][1].second = 0;
    board[6][2].c =  WHITE; board[6][2].first = 0; board[6][2].second = 0;
    board[6][3].c =  WHITE; board[6][3].first = 0; board[6][3].second = 0;
    board[6][4].c =  WHITE; board[6][4].first = 0; board[6][4].second = 0;
    board[6][5].c =  BLACK; board[6][5].first = 6; board[6][5].second = 4;
    board[6][6].c =  WHITE; board[6][6].first = 0; board[6][6].second = 0;
    board[6][7].c =  WHITE; board[6][7].first = 0; board[6][7].second = 0;
    board[6][8].c =  BLACK; board[6][8].first = 4; board[6][8].second = 3;
    board[6][9].c =  WHITE; board[6][9].first = 0; board[6][9].second = 0;
    board[6][10].c = WHITE; board[6][10].first = 0; board[6][10].second = 0;
    board[6][11].c = BLACK; board[6][11].first = 15; board[6][11].second = 0;
    board[7][0].c =  BLACK; board[7][0].first = 0; board[7][0].second = 11;
    board[7][1].c =  WHITE; board[7][1].first = 0; board[7][1].second = 0;
    board[7][2].c =  WHITE; board[7][2].first = 0; board[7][2].second = 0;
    board[7][3].c =  WHITE; board[7][3].first = 0; board[7][3].second = 0;
    board[7][4].c =  BLACK; board[7][4].first = 4; board[7][4].second = 11;
    board[7][5].c =  WHITE; board[7][5].first = 0; board[7][5].second = 0;
    board[7][6].c =  WHITE; board[7][6].first = 0; board[7][6].second = 0;
    board[7][7].c =  WHITE; board[7][7].first = 0; board[7][7].second = 0;
    board[7][8].c =  WHITE; board[7][8].first = 0; board[7][8].second = 0;
    board[7][9].c =  BLACK; board[7][9].first = 4; board[7][9].second = 11;
    board[7][10].c = WHITE; board[7][10].first = 0; board[7][10].second = 0;
    board[7][11].c = WHITE; board[7][11].first = 0; board[7][11].second = 0;
    board[8][0].c =  BLACK; board[8][0].first = 0; board[8][0].second = 0;
    board[8][1].c =  BLACK; board[8][1].first = 0; board[8][1].second = 16;
    board[8][2].c =  WHITE; board[8][2].first = 0; board[8][2].second = 0;
    board[8][3].c =  WHITE; board[8][3].first = 0; board[8][3].second = 0;
    board[8][4].c =  WHITE; board[8][4].first = 0; board[8][4].second = 0;
    board[8][5].c =  WHITE; board[8][5].first = 0; board[8][5].second = 0;
    board[8][6].c =  WHITE; board[8][6].first = 0; board[8][6].second = 0;
    board[8][7].c =  BLACK; board[8][7].first = 0; board[8][7].second = 11;
    board[8][8].c =  WHITE; board[8][8].first = 0; board[8][8].second = 0;
    board[8][9].c =  WHITE; board[8][9].first = 0; board[8][9].second = 0;
    board[8][10].c = WHITE; board[8][10].first = 0; board[8][10].second = 0;
    board[8][11].c = WHITE; board[8][11].first = 0; board[8][11].second = 0;
    board[9][0].c =  BLACK; board[9][0].first = 0; board[9][0].second = 0;
    board[9][1].c =  BLACK; board[9][1].first = 0; board[9][1].second = 0;
    board[9][2].c =  BLACK; board[9][2].first = 0; board[9][2].second = 13;
    board[9][3].c =  WHITE; board[9][3].first = 0; board[9][3].second = 0;
    board[9][4].c =  WHITE; board[9][4].first = 0; board[9][4].second = 0;
    board[9][5].c =  WHITE; board[9][5].first = 0; board[9][5].second = 0;
    board[9][6].c =  BLACK; board[9][6].first = 0; board[9][6].second = 0;
    board[9][7].c =  BLACK; board[9][7].first = 0; board[9][7].second = 0;
    board[9][8].c =  BLACK; board[9][8].first = 0; board[9][8].second = 7;
    board[9][9].c =  WHITE; board[9][9].first = 0; board[9][9].second = 0;
    board[9][10].c = WHITE; board[9][10].first = 0; board[9][10].second = 0;
    board[9][11].c = WHITE; board[9][11].first = 0; board[9][11].second = 0;
}