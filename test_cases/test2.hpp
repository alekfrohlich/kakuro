// test case 96 (9x9).

#include <cstdlib>

#ifndef __KAKURO__
#define __KAKURO__
    #include "kakuro.hpp"
#endif  // namespace kakuro.

// declarations
const int WIDTH  = 9;            // Board width.
const int HEIGHT = 9;            // Board const int 

const int LAST_I = 8;            // Last available line index.
const int LAST_J = 8;            // Last available collumn index.

pos** board;

// extern declarations.
extern const int BLACK;
extern const int WHITE;

/*
 * Initialize board.
 */
void init_board(void)
{
    board = (pos**) std::malloc(sizeof(pos) * HEIGHT);

    for(int i=0;i<HEIGHT;i++)
        board[i] = (pos*) std::malloc(sizeof(pos) * WIDTH);

    board[0][0] = {BLACK, 0, 0};
    board[0][1] = {BLACK, 4, 0};    
    board[0][2] = {BLACK, 18, 0};
    board[0][3] = {BLACK, 0, 0};
    board[0][4] = {BLACK, 10, 0};
    board[0][5] = {BLACK, 16, 0};
    board[0][6] = {BLACK, 0, 0};
    board[0][7] = {BLACK, 17, 0};
    board[0][8] = {BLACK, 5, 0};
    board[1][0] = {BLACK, 0, 8};
    board[1][1] = {WHITE, 0, 0};    
    board[1][2] = {WHITE, 0, 0};
    board[1][3] = {BLACK, 11, 5};
    board[1][4] = {WHITE, 0, 0};
    board[1][5] = {WHITE, 0, 0};
    board[1][6] = {BLACK, 14, 12};
    board[1][7] = {WHITE, 0, 0};
    board[1][8] = {WHITE, 0, 0};
    board[2][0] = {BLACK, 0, 37};
    board[2][1] = {WHITE, 0, 0};    
    board[2][2] = {WHITE, 0, 0};
    board[2][3] = {WHITE, 0, 0};
    board[2][4] = {WHITE, 0, 0};
    board[2][5] = {WHITE, 0, 0};
    board[2][6] = {WHITE, 0, 0};
    board[2][7] = {WHITE, 0, 0};
    board[2][8] = {WHITE, 0, 0};
    board[3][0] = {BLACK, 0, 0};
    board[3][1] = {BLACK, 12, 6};    
    board[3][2] = {WHITE, 0, 0};
    board[3][3] = {WHITE, 0, 0};
    board[3][4] = {BLACK, 27, 8};
    board[3][5] = {WHITE, 0, 0};
    board[3][6] = {WHITE, 0, 0};
    board[3][7] = {BLACK, 34, 0};
    board[3][8] = {BLACK, 8, 0};
    board[4][0] = {BLACK, 0, 7};
    board[4][1] = {WHITE, 0, 0};    
    board[4][2] = {WHITE, 0, 0};
    board[4][3] = {BLACK, 23, 15};
    board[4][4] = {WHITE, 0, 0};
    board[4][5] = {WHITE, 0, 0};
    board[4][6] = {WHITE, 0, 0};
    board[4][7] = {WHITE, 0, 0};
    board[4][8] = {WHITE, 0, 0};
    board[5][0] = {BLACK, 0, 35};
    board[5][1] = {WHITE, 0, 0};    
    board[5][2] = {WHITE, 0, 0};
    board[5][3] = {WHITE, 0, 0};
    board[5][4] = {WHITE, 0, 0};
    board[5][5] = {WHITE, 0, 0};
    board[5][6] = {BLACK, 8, 13};
    board[5][7] = {WHITE, 0, 0};
    board[5][8] = {WHITE, 0, 0};
    board[6][0] = {BLACK, 0, 0};
    board[6][1] = {BLACK, 16, 0};    
    board[6][2] = {BLACK, 7, 10};
    board[6][3] = {WHITE, 0, 0};
    board[6][4] = {WHITE, 0, 0};
    board[6][5] = {BLACK, 3, 14};
    board[6][6] = {WHITE, 0, 0};
    board[6][7] = {WHITE, 0, 0};
    board[6][8] = {BLACK, 9, 0};
    board[7][0] = {BLACK, 0, 43};
    board[7][1] = {WHITE, 0, 0};    
    board[7][2] = {WHITE, 0, 0};
    board[7][3] = {WHITE, 0, 0};
    board[7][4] = {WHITE, 0, 0};
    board[7][5] = {WHITE, 0, 0};
    board[7][6] = {WHITE, 0, 0};
    board[7][7] = {WHITE, 0, 0};
    board[7][8] = {WHITE, 0, 0};
    board[8][0] = {BLACK, 0, 12};
    board[8][1] = {WHITE, 0, 0};    
    board[8][2] = {WHITE, 0, 0};
    board[8][3] = {BLACK, 0, 6};
    board[8][4] = {WHITE, 0, 0};
    board[8][5] = {WHITE, 0, 0};
    board[8][6] = {BLACK, 0, 11};
    board[8][7] = {WHITE, 0, 0};
    board[8][8] = {WHITE, 0, 0};
}