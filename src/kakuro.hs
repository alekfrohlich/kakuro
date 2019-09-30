module Main where

import Data.Array.MArray
import Data.Array.IO

-- 10x12 Puzzle (#2)
kakuroBoard = [[(0,0,0),   (0,14,0),  (0,29,0),  (0,10,0),  (0,0,0),   (0,0,0),   (0,0,0),   (0,24,0),  (0,16,0),  (0,22,0),  (0,0,0),   (0,0,0)  ]
              ,[(0,0,23),  (1,0,0),   (1,0,0),   (1,0,0),   (0,3,0),   (0,0,0),   (0,12,24), (1,0,0),   (1,0,0),   (1,0,0),   (0,24,0),  (0,0,0)  ]
              ,[(0,0,11),  (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (0,6,34),  (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (0,17,0) ]
              ,[(0,0,13),  (1,0,0),   (1,0,0),   (0,39,16), (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (0,9,19),  (1,0,0),   (1,0,0),   (1,0,0)  ]
              ,[(0,0,0),   (0,0,16),  (1,0,0),   (1,0,0),   (0,4,3),   (1,0,0),   (1,0,0),   (0,7,29),  (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0)  ]
              ,[(0,0,0),   (0,4,0),   (0,7,8),   (1,0,0),   (1,0,0),   (1,0,0),   (0,10,7),  (1,0,0),   (1,0,0),   (1,0,0),   (0,10,0),  (0,0,0)  ]
              ,[(0,0,10),  (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (0,6,4),   (1,0,0),   (1,0,0),   (0,4,3),   (1,0,0),   (1,0,0),   (0,15,0) ]
              ,[(0,0,11),  (1,0,0),   (1,0,0),   (1,0,0),   (0,4,11) , (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (0,4,11),  (1,0,0),   (1,0,0)  ]
              ,[(0,0,0),   (0,0,16),  (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0),   (0,0,11),  (1,0,0),   (1,0,0),   (1,0,0),   (1,0,0)  ]
              ,[(0,0,0),   (0,0,0),   (0,0,13),  (1,0,0),   (1,0,0),   (1,0,0),   (0,0,0),   (0,0,0),   (0,0,7),   (1,0,0),   (1,0,0),   (1,0,0)  ]]

{-- START OF DEFINES --}

--           (Color, First, Second).
type Pos   = (Int, Int, Int)
--           (Row, Collumn).
type Index = (Int, Int)
type Board = IOArray (Int, Int) Pos

solved = 0          -- Solved board.
unsolvable = -1     -- Unsovable board.
continue = 2        -- Continue for

black = 0           -- Black position.
white = 1           -- White position.

height = 10         -- Board height.
width  = 12         -- Board width.  

last_i = height-1   -- Last available line index.
last_j = width-1    -- Last available collumn index.        

limit = 10          -- Last permited number.

{-- END OF DEFINES --}

{-- START OF BOARD INTERFACE --}

-- IOArray Wrapper Interface
(!) = readArray

{-- END OF BOARD INTERFACE --}

{-- START OF AUXILIARES --}

-- Return next Position on board.
nextPos :: Index -> Index
nextPos (i,j)
        | (j == last_j) = ((i+1), (mod  (j+1) width))
        | otherwise = (i, (mod  (j+1) width))

{-- END OF AUXILIARES --}

{-- START OF KAKURO --}

checkCol (i,j) board sum = do
    (color, value, _) <- board ! (i,j)
    if color == white
        then (checkCol ((i-1), j) board (sum + value))
        else return (sum == value)

checkLine (i,j) board sum = do
    (color, value, _) <- board ! (i,j)
    if color == white
        then (checkLine (i, (j-1)) board (sum + value))
        else return (sum == value)

lineRepeats (i,j) board w = do
    (color, value, _) <- board ! (i,j)
    if color == black
        then return False
        else if value == w
            then return True
            else (lineRepeats (i, (j-1)) board w)

colRepeats (i,j) board w = do
    (color, value, _) <- board ! (i,j)
    if color == black
        then return False
        else if value == w
            then return True
            else (colRepeats ((i-1), j) board w)

canContinue (i,j) board w = do
    lReps <- (lineRepeats (i,j) board w)
    cReps <- (colRepeats (i,j) board w)
    if (lReps || cReps)
        then return False
        else do 
            checkL <- (checkLine (i,j) board 0)
            checkC <- (checkCol (i,j) board 0)
            if ((j == last_j) && (not checkL)) || ((i == last_i) && (not checkC))
                then return False
                else do
                    (colorRight, _, _) <- (board ! (i, (j+1)))
                    (colorDown, _, _) <- (board ! (i+1, j))
                    if ((colorRight == black) && (not checkL)) || ((colorDown == black) && (not checkC))
                        then return False
                        else return True

-- --
-- hasFinished :: Index -> Int -> Board -> Int
-- hasFinished (i,j) w board
--         | (isLastPos nextP) && (j == last_j || ((getColor (last_i,last_j)!!0)==black)) = solved
--         | (solve nextP) == solved = solved
--         | otherwise = continue
--         where nextP = (nextWhitePos (nextPos (i,j)))

-- -- Works out the tests to ...
-- work :: Index -> Int -> Board -> Int
-- work (i,j) w board = do
--     writeArray board (i,j) w
--     return (if (canContinue (i,j) w board) then 
--         (hasFinished (i,j) w board)
--     else continue)
                
-- -- Try one iteration of work.
-- try :: Index -> Int -> Board -> Int
-- try (i,j) w board
--         | (w == limit) = unsolvable
--         | ((work (i,j) w board) == solved) = solved
--         | otherwise = (try (i,j) (w+1) board)
                        
-- -- Solves Kakuro boards!
-- solve :: Index -> Board -> Int
-- solve (i,j) board = (try (i,j) 1 board)

-- Here is where it all starts :-)
main = do
    -- 1. Declare the matrix
    board <- newArray ((0,0), (height,width)) undefined
    let _ = board :: Board

    -- 2. Initialize the matrix.
    sequence_ $ do
        i <- [0..last_i]
        j <- [0..last_j]
        return $ writeArray board (nextPos(i, (j-1))) ((kakuroBoard !! i) !! j)
    sequence_ $ do
            i <- [0..last_i]
            j <- [0..last_j]
            return $ do
            (color, first, second) <- board ! (i,j)
            putStr $ if color == 0
                    then "*"
                    else (show first)
            if j == last_j
                    then putChar '\n'
                    else return ()             