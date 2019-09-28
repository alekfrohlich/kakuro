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
#ifndef __KAKURO__
#define __KAKURO__
    #include "kakuro.hpp"
#endif  // namespace kakuro.
#include "test.hpp"

// declarations.
inline static bool check_line(int,int);
inline static bool check_col(int,int);
inline static bool line_repeats(int,int,int);
inline static bool col_repeats(int,int,int);


//---------------------------------------------------

struct idx {
    int x;
    int y;
};

static bool can_continue(int i, int j, int value)
{
    if (line_repeats(i, j, value) || col_repeats(i, j, value))
        return false;

    if ((((j == LAST_J) || ((j != LAST_J) && board[i][j+1].c == BLACK)) && !check_line(i, j)))
        return false;
    
    if ((((i == LAST_I) || ((i != LAST_I) && board[i+1][j].c == BLACK)) && !check_col(i, j)))
        return false;
    
    return true;
}

static inline bool has_finished(int i, int j)
{
    return (i == LAST_I) && (j == LAST_J);
}

static idx next_pos(int i, int j)
{
    if (i > LAST_I)
        return {LAST_I, LAST_J};
                
    if (board[i][j].c == WHITE)
        return {i, j};
        
    else
        return next_pos(((j == LAST_J)? i+1: i), (j+1) % WIDTH);
}

int solve2(int i, int j)
{
    for (int w = 1; w < 10; w++)
    {
        board[i][j].first = w;
        if (can_continue(i, j, w))
        {
            idx p = next_pos(((j == LAST_J)? i+1: i), (j+1) % WIDTH);
            
            if (has_finished(p.x, p.y))
                return SOLVED;

            if (solve2(p.x, p.y) == SOLVED)
                return SOLVED;
        }        
    }

    return UNSOLVABLE;
}

//---------------------------------------------------

/*
 * Solves a given kakuro board. 
 */
int solve(char i, char j, char value, bool forward)
{   
    /*
     * Skip black positions (forward).
     */
    if (board[i][j].c == BLACK && forward)
    {
        /*
         * Last position is black. 
         */
        if (i == LAST_I && j == LAST_J)
            return SOLVED;

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
        if (j == 0 && i == 0)
            return UNSOLVABLE;

        /*
         * Backtrack (up).
         */
        else if (j == 0)
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
     * Right is black or last element of row.
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
     * Down is black or last element of collumn.
     */
    if ((i == LAST_I) || ((i != LAST_I) && board[i+1][j].c == BLACK))
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
    if (line_repeats(i, j, value) || col_repeats(i, j, value))
        /*
         * White middle-man repeats
         * some value, try again
         * with next possible value. 
         */
        return solve(i, j, value+1, FORWARD);
    else
        /*
         * Move forward. 
         */
        return solve(((j == LAST_J)? i+1: i), (j+1) % WIDTH, 1, FORWARD);
}

/*
 * Check if line sums-up to hint. 
 */
static bool inline check_line(int line, int j)
{
    int sum = 0;
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
    int sum = 0;
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
    while (true)
    {   
        --j;

        /*
         * Stop after hitting
         * a black position. 
         */
        if(board[line][j].c == BLACK)
            return false;
        if (board[line][j].first == value)
            return true;
    }
}

/*
 * Check if element repeats in collumn. 
 */
static bool inline col_repeats(int i, int col, int value)
{
    while (true)
    {
        --i;

        /*
         * Stop after hitting
         * a black position. 
         */
        if(board[i][col].c == BLACK)
            return false;
        if (board[i][col].first == value)
            return true;
    }
}

/*
 * Print solution if there is one.
 */
static void print_solution()
{
    using namespace std;

    for (int i = 0; i < HEIGHT; i++)
    {
        for (int j = 0; j < WIDTH; j++)
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
    idx init_p = next_pos(0,0);
    if (solve2(init_p.x, init_p.y) == SOLVED)
        print_solution();
    else
        cout << "Unsolvable board!" << endl;    
}