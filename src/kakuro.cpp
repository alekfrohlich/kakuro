/* MIT License
 * 
 * Copyright (c) 2019 Alek Frohlich, Nicolas Goeldner
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * 
 * This program solves kakuro boards using backtracking.
 */


#include <iostream>

#define BLACK 0             // Black position.
#define WHITE 1             // White position.

#define LIM 10              // Last permited number.

#define WIDTH 6             // Board width.
#define HEIGHT 6            // Board Height.

#define LAST_I 5            // Last available line index.
#define LAST_J 5            // Last available collumn index.

#define FORWARD true        // Going forward in board.
#define BACKWARD false      // Going backward in board.

#define SOLVED 0            // Solvable board.
#define UNSOLVABLE 1        // Unsolvable board.

// declarations
inline static bool check_line(int,int);
inline static bool check_col(int,int);
inline static bool line_repeats(int,int,int);
inline static bool col_repeats(int,int,int);

/*
 * Black/White position. 
 */
struct pos {
    int c;
    int first;
    int second;
};

/*
 * Kakuro board.
 */
static pos board[HEIGHT][WIDTH];

/*
 * Initialize board.
 */
static void init_board()
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

/*
 * Solves a given kakuro board. 
 */
int solve(int i, int j, int value, bool forward)
{   
    /*
     * Skip black positions (forward).
     */
    if (board[i][j].c == BLACK && forward)
    {
        /*
         * Move forward.
         */
        return solve(((j == LAST_J)? i+1: i), (j+1) % WIDTH, 1, FORWARD);

    } 
    
    /*
     * Skip black position (backward). 
     */
    else if (board[i][j].c == BLACK && !forward)
     {
        /*
         * All possible combinations failed.
         */
        if (j==0 && i==0)
            return UNSOLVABLE;

        /*
         * Backtrack (up).
         */
        else if (j==0)
            return solve(i-1, LAST_J, board[i-1][LAST_J].first+1, BACKWARD);

        /*
         * Backtrack (left).
         */
        else
            return solve(i, j-1, board[i][j-1].first+1, BACKWARD);
    }

    /*
     * Try new value for position.
     */
    board[i][j].first = value;

    /*
     * Right is black.
     */
    if ((j == LAST_J) || ((j != LAST_J) && board[i][j+1].c == BLACK))
    {
        /*
         * Tried all possible numbers for this
         * position, backtrack (left).
         */
        if (value == LIM)
            return solve(i, j-1, board[i][j-1].first+1, BACKWARD);

        /*
         * Try next possible value. 
         */
        else if (!check_line(i, j) || line_repeats(i, j, value))
            return solve(i, j, value+1, FORWARD);
    }

    /*
     * Down is black.
     */
    if ((i == LAST_I) || ((i != LAST_I) && board[i+1][j].c == BLACK))
    {    
        /*
         * Tried all possible
         * numbers for this position.
         */
        if (value == LIM)
        {
            /*
             * Backtrack (up). 
             */
            if (j == 0)
                return solve(i-1, LAST_J, board[i-1][LAST_J].first+1, BACKWARD);

            /*
             * Backtrack (left). 
             */
            else
                return solve(i, j-1, board[i][j-1].first+1, BACKWARD);   
        }

        /*
         * Try next possible value. 
         */            
        if (!check_col(i, j) || col_repeats(i, j, value))
            return solve(i, j, value+1, FORWARD);
    }
    
    /*
     * Backtrack after trying all possible numbers.
     */
    if (value == LIM)
        return solve(i, j-1, board[i][j-1].first+1, BACKWARD);

    /*
     * Last position?
     */
    if (i == LAST_I && j == LAST_J)
        return SOLVED;
    
    /*
     * Right and down are white.
     */
    return solve(((j == LAST_J)? i+1: i), (j+1) % WIDTH, 1, FORWARD);
}

/*
 * Check if line sums-up to hint. 
 */
static bool inline check_line(int line, int j)
{
    static int sum = 0;
    while (board[line][j].c == WHITE)
    {
        sum += board[line][j].first;
        j--;
    }
    return (sum == board[line][j].second);
}

/*
 * Check if collum sums-up to hint. 
 */
static bool inline check_col(int i, int col)
{
    static int sum = 0;
    while (board[i][col].c == WHITE)
    {
        sum += board[i][col].first;
        i--;
    }
    return (sum == board[i][col].first);
}

/*
 * Check if element repeats in line. 
 */
static bool inline line_repeats(int line, int j, int value)
{
    while (board[line][j].c == WHITE)
    {
        if (board[line][--j].first == value)
            return true;
    }
    return false;
}

/*
 * Check if element repeats in collumn. 
 */
static bool inline col_repeats(int i, int col, int value)
{
    while (board[i][col].c == WHITE)
    {
        if (board[--i][col].first == value)
            return true;
    }
    return false;
}

/*
 * Print solution if there is one.
 */
static void print_solution()
{
    using namespace std;

    for (int i = 0; i < 6; i++)
    {
        for (int j = 0; j < 6; j++)
        {
            if (board[i][j].c == WHITE)
                cout << board[i][j].first;
            else
                cout << "*";
        }
        cout << endl;
    }
}

/*
 * Solves kakuro boards.
 */
int main()
{
    using namespace std;

    init_board();
    if (solve(0, 0, 0, FORWARD) == SOLVED)
        print_solution();
    else
        cout << "Unsolvable board!" << endl;    
}