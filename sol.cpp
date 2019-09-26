#include <iostream>

#define BLACK 0         // Black position.
#define WHITE 1         // White position.

#define LIM 10          // Last permited number.

#define WIDTH 6         // Board width.
#define HEIGHT 6        // Board Height.

#define LAST_I 5        // Last available line index.
#define LAST_J 5        // Last available collumn index.

#define FORWARD true    // Going forward in board.
#define BACKWARD false  // Going backward in board.

#define SOLVABLE 0      // Solvable board.
#define UNSOLVABLE 1    // Unsolvable board.


inline static bool check_line(int,int);
inline static bool check_col(int,int);
inline static bool line_repeats(int,int,int);
inline static bool col_repeats(int,int,int);

using namespace std;


struct pos {
    int c;
    int first;
    int second;
};

pos board[HEIGHT][WIDTH];

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

int solve(int i, int j, int value, bool forward)
{   
    /*
     * Pular posicoes pretas.
     */
    if (board[i][j].c == BLACK && forward) {
        return solve(((j==LAST_J)? i+1: i), (j+1)%WIDTH, 1, FORWARD);
    } else if(board[i][j].c == BLACK && !forward) {
        if (j==0 && i==0)
            return UNSOLVABLE;
        if (j==0)
            return solve(i-1, LAST_J, board[i-1][LAST_J].first+1, BACKWARD);
        else
            return solve(i, j-1, board[i][j-1].first+1, BACKWARD);
    }

    board[i][j].first = value;

    /*
     * Direita preto.
     */
    if ((j==LAST_J) || ((j!=LAST_J) && board[i][j+1].c == BLACK)) {
        if (value == LIM)
            return solve(i, j-1, board[i][j-1].first+1, BACKWARD);
        if (!check_line(i,j) || line_repeats(i,j,value))
            return solve(i, j, value+1, FORWARD);
    }

    /*
     * Baixo preto.
     */
    if ((i==LAST_I) || ((i!=LAST_I) && board[i+1][j].c == BLACK)) {
        if (value == LIM){
            if(j==0)
                return solve(i-1, LAST_J, board[i-1][LAST_J].first+1, BACKWARD);
            else
                return solve(i, j-1, board[i][j-1].first+1, BACKWARD);   
        }
            
        if (!check_col(i,j) || col_repeats(i,j,value))
            return solve(i, j, value+1, FORWARD);
    }
    
    /*
     * Direita branco, baixo branco.
     */
    if (value == LIM)
        return solve(i, j-1, board[i][j-1].first+1,BACKWARD);

    /*
     * Ultima posicao.
     */
    if (i==LAST_I && j==LAST_J)
        return SOLVABLE;
    
    /*
     * Direita branco, baixo branco.
     */
    return solve(((j==LAST_J)? i+1: i), (j+1)%WIDTH, 1, FORWARD);
}

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

static bool inline line_repeats(int line, int j, int value)
{
    while (board[line][j].c == WHITE)
    {
        if (board[line][--j].first == value)
            return true;
    }
    return false;
}

static bool inline col_repeats(int i, int col, int value)
{
    while (board[i][col].c == WHITE)
    {
        if (board[--i][col].first == value)
            return true;
    }
    return false;
}

void print_solution() {
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

int main()
{
    init_board();
    solve(0, 0, 0, FORWARD);
    print_solution();
    return 0;
}