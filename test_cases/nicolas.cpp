#include <stdio.h>
#include<string.h>
// #ifndef __KAKURO__
// #define __KAKURO__
//     #include "kakuro.hpp"
// #endif  // namespace kakuro.


// declarations
int WIDTH ;            // Board width.
int HEIGHT;            // Board const int 

int LAST_J;            // Last available collumn index.
int LAST_I;            // Last available line index.


// extern declarations.
extern const int BLACK;
extern const int WHITE;
int var=0;
int main(){
    printf("problem(Rows) :-\nRows = (");
    scanf("%d %d", &WIDTH, &HEIGHT);
    LAST_J = WIDTH-1; LAST_I = HEIGHT-1;
    // pos board[HEIGHT][WIDTH];
    char value[5];
    printf("[");
    for(int i=0;i<HEIGHT;i++){
        printf("[" );
        for(int j=0;j<WIDTH;j++){
            scanf("%s ", value);
            if(strlen(value)==1){
                if(value[0]=='0'){
                    // board[i][j].c = WHITE;
                    // board[i][j].first = 0;
                    // board[i][j].second = 0;
                    // printf("board[%d][%d].c = WHITE; board[%d][%d].first = 0; board[%d][%d].second = 0;\n",i,j,i,j,i,j);
                    // printf("sequence_ $ do\ni <- [1..height]\nj <- [1..width]\nreturn $ writeArray arr (%d, %d) (1,0,0)", i,j);
                                        // printf("(1,0,0)");
                                        var++;
                                        printf("[1,_,0]");
                                        if(j!=WIDTH-1)
                                            printf(", ");

                    // printf("\n");
                }else{
                    printf("ERRO %d %d\n", i, j);
                }
            }else if(strlen(value)>=3){
                int h=0;
                int aux=0;
                while(value[h]!='/'){
                    aux*=10;
                    aux+=value[h]-'0';
                    h++;
                }
                h++;
                // board[i][j].c = BLACK;
                // board[i][j].first = aux;
                // printf("board[%d][%d].c = BLACK; board[%d][%d].first = %d; ",i,j,i,j,aux);
                int aux2 = 0;
                for(h;h<strlen(value);h++){
                    aux2*=10;
                    aux2+=value[h]-'0';
                }
                // board[i][j].second = aux2;
                // printf("board[%d][%d].second = %d;\n",i,j,aux);
                // printf("sequence_ $ do\ni <- [1..height]\nj <- [1..width]\nreturn $ writeArray arr (%d, %d) (0,%d,%d)\n", i,j,aux,aux2);
                // printf("(0,%d,%d)",aux,aux2);
                printf("[0,%d,%d]",aux,aux2);
                                        if(j!=WIDTH-1)
                                            printf(", ");

            }else{
                printf("ERRO %d %d\n", i, j);
            }
        }
        printf("]");
        if(i!=HEIGHT-1)
            printf("\n,");
        else
            printf("]).\n");
    }
    while(scanf("%s ", value)!=EOF){
        printf("ERRO");
    }
    return 0;
} 