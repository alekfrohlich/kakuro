#include <cstdlib>

#ifndef __KAKURO__
#define __KAKURO__
    #include "kakuro.hpp"
#endif  // namespace kakuro.

// declarations
const int WIDTH  = 6;            // Board width.
const int HEIGHT = 6;            // Board const int 

const int LAST_I = 5;            // Last available line index.
const int LAST_J = 5;            // Last available collumn index.

pos board[HEIGHT][WIDTH];

// extern declarations.
extern const int BLACK;
extern const int WHITE;

/*
 * Initialize board.
 */
void init_board(void)
{
    board[0][0] = {BLACK, 0, 0};
    board[0][1] = {BLACK, 12, 0};    
    board[0][2] = {BLACK, 21, 0};
    board[0][3] = {BLACK, 0, 0};
    board[0][4] = {BLACK, 16, 0};
    board[0][5] = {BLACK, 13, 0};
    board[1][0] = {BLACK, 0, 17};
    board[1][1] = {WHITE, 0, 0};    
    board[1][2] = {WHITE, 0, 0};
    board[1][3] = {BLACK, 22, 11};
    board[1][4] = {WHITE, 0, 0};
    board[1][5] = {WHITE, 0, 0};
    board[2][0] = {BLACK, 0, 15};
    board[2][1] = {WHITE, 0, 0};    
    board[2][2] = {WHITE, 0, 0};
    board[2][3] = {WHITE, 0, 0};
    board[2][4] = {WHITE, 0, 0};
    board[2][5] = {WHITE, 0, 0};
    board[3][0] = {BLACK, 0, 0};
    board[3][1] = {BLACK, 4, 13};    
    board[3][2] = {WHITE, 0, 0};
    board[3][3] = {WHITE, 0, 0};
    board[3][4] = {WHITE, 0, 0};
    board[3][5] = {BLACK, 10, 0};
    board[4][0] = {BLACK, 0, 18};
    board[4][1] = {WHITE, 0, 0};    
    board[4][2] = {WHITE, 0, 0};
    board[4][3] = {WHITE, 0, 0};
    board[4][4] = {WHITE, 0, 0};
    board[4][5] = {WHITE, 0, 0};
    board[5][0] = {BLACK, 0, 10};
    board[5][1] = {WHITE, 0, 0};    
    board[5][2] = {WHITE, 0, 0};
    board[5][3] = {BLACK, 0, 14};
    board[5][4] = {WHITE, 0, 0};
    board[5][5] = {WHITE, 0, 0};
}