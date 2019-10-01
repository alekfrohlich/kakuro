{- 
 MIT License
 
 Copyright (c) 2019 Alek Frohlich, Nicolas Goeldner
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 This program solves kakuro boards using backtracking.
-}


module Main where

import Data.Array.MArray
import Data.Array.IO

import TestCases (height, width, kakuroBoard)

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

last_i = height-1   -- Last available line index.
last_j = width-1    -- Last available collumn index.        

limit = 10          -- Last permited number.

{-
 External defines:
    * height.       -- Board height.
    * width.        -- Board width.
    * kakuroBoard.  -- Kakuro board.
 -}

{-- END OF DEFINES --}

{-- START OF AUXILIARES --}

-- Alias for acessing kakuroBoard.
(!) = readArray

-- Return next Position on board.
nextPos :: Index -> Index
nextPos (i,j)
        | (j == last_j) = ((i+1), (mod  (j+1) width))
        | otherwise = (i, (mod  (j+1) width))

-- Compare monadic values.
cmpM m1 m2 = do
    a <- m1
    b <- m2
    if a == b then (return True) else (return False)

-- Monadic if.
ifM act t e = do
    b <- act
    if b then t else e

-- Monadic or.
(||^) a b = ifM a (return True) b

-- Monadic and.
(&&^) a b = ifM a b (return False)

-- Monadic compare.
(==^) m1 m2 = cmpM m1 m2

-- Alias for return (used in boolean expressions to avoid cluttering).
l m = return m

{-- END OF AUXILIARES --}

{-- START OF KAKURO --}

-- Check if line sums up to hint.
checkLine (i,j) board sum = do
    (color, value, final) <- board ! (i,j)
    if color == white
        then (checkLine (i, (j-1)) board (sum + value))
        else return (sum == final)

-- Check if collumn sums up to hint.
checkCol (i,j) board sum = do
    (color, value, _) <- board ! (i,j)
    if color == white
        then (checkCol ((i-1), j) board (sum + value))
        else return (sum == value)

-- Check if element repeats on given line.
lineRepeats (i,j) board w = do
    (color, value, _) <- board ! (i,j)
    if color == black
        then return False
        else if value == w
            then return True
            else (lineRepeats (i, (j-1)) board w)

-- Check if element repeats on given collumn.
colRepeats (i,j) board w = do   
    (color, value, _) <- board ! (i,j)
    if color == black
        then return False
        else if value == w
            then return True
            else (colRepeats ((i-1), j) board w)

-- Test second if. 
horizContTest (i,j) board = do
    checkL <- (checkLine (i,j) board 0)
    if (j == last_j) && (not checkL)
        then return True
        else do
            if (j /= last_j)
                then do
                    (color,_,_) <- board ! (nextPos (i,j)) 
                    if ((color == black) && (not checkL))
                        then
                            return True
                        else
                            return False
                    else
                        return False

-- Test third if.
vertContTest (i,j) board = do
    checkC <- (checkCol (i,j) board 0)
    if (i == last_i) && (not checkC)
        then return True
        else do
            if (i /= last_i)
                then do
                    (color,_,_) <- board ! ((i+1),j) 
                    if ((color == black) && (not checkC))
                        then
                            return True
                        else
                            return False
                    else
                        return False

-- Check if branch of computation can procede.
canContinue (i,j) board w = do
    ifM ((lineRepeats (i,(j-1)) board w) ||^ (colRepeats ((i-1),j) board w))
        (return False)
        (do 
            ifM ((horizContTest (i,j) board) ||^ (vertContTest (i,j) board))
                (return False)
                (return True))

{-
 Returns next white position on board,
 if there isn't none, returns last position
 instead.
 -}
nextWhitePos (i,j) board = do
    if (i > last_i)
        then do
            return (last_i,last_j)
        else do
            (color, _, _) <- board ! (i,j)
            if (color == white)
                then return (i,j)
                else (nextWhitePos (nextPos (i,j)) board)

-- Checks if index is last of board.
isLastPos :: Index -> Bool
isLastPos (i, j) = (i == last_i) && (j == last_j)

-- Test finish conditions. Calls next position to try.
hasFinished (i,j) board = do
    nextP <- (nextWhitePos (nextPos (i,j)) board)
    (color,_,_) <- board ! (last_i,last_j)
    if (isLastPos nextP) && (j == last_j || color == black)
        then return solved
        else do
            ifM ((solve nextP board) ==^ (l solved))
                (return solved)
                (return continue)

-- Skip impossible board states, also propagate finished state.
work (i,j) board w = do
    (writeArray board (i,j) (white, w, 0))
    ifM (canContinue (i,j) board w)
        (hasFinished (i,j) board)
        (return continue)

-- Try one iteration of work.
try (i,j) board w = do
    if (w == limit)
        then return unsolvable
        else do
            ifM ((work (i,j) board w) ==^ (l solved))
                (return solved)
                ((try (i,j) board (w+1)))

-- Solves Kakuro boards!
solve (i,j) board = do
    (try (i,j) board 1)

-- Here is where it all starts :-)
main = do
    -- 1. Declare the board
    board <- newArray ((0,0), (height,width)) undefined
    let _ = board :: Board

    -- 2. Initialize the board.
    sequence_ $ do
            i <- [0..last_i]
            j <- [0..last_j]
            return $ writeArray board (i,j) ((kakuroBoard !! i) !! j)

    -- 3. Solve the puzzle.
    nex <- (nextWhitePos (0,0) board)
    sol <- (solve nex board)

    -- 4. Print solution.
    if (sol == solved)
        then sequence_ $ do
                i <- [0..last_i]
                j <- [0..last_j]
                return $ do
                (color, first, second) <- board ! (i,j)
                putStr $ if color == black
                        then "*"
                        else (show first)
                if j == last_j
                        then putChar '\n'
                        else return ()
        else
            print ("Unsolvable!")