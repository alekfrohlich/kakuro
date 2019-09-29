module Main where

-- Defines
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

last_i = 5          -- Last available line index.
last_j = 5          -- Last available collumn index.

height = 6          -- Board height.
width  = 6          -- Board width.          

limit = 10          -- Last permited number.

{-- START OF BOARD INTERFACE --}

-- IOArray Wrapper Interface
(!) = readArray
(!*) = writeArray

-- Print Solved Board.
printBoard board (i,j) = sequence_ $ do
    i <- [1..height]
    j <- [1..width]
    return $ do
      (color, first, second) <- readBoard board (i,j)

      putStr $ if color == 0
                then '*'
                else (show first)
      if j == width
        then putChar '\n'
        else return () 

{-- END OF BOARD INTERFACE --}

{-- START OF AUXILIARES --}

-- Return next Position on board.
nextPos :: Index -> Index
nextPos (i,j)
        | (j == last_j) = ((i+1), (mod  (j+1) width))
        | otherwise = (i, (mod  (j+1) width)
        
checkColAux :: Index -> Int -> Board -> Int
checkColAux (i,j) w sum
        | (readAndTestIsWhite (i,j)) = (checkColAux ((i-1), j) w (sum + ((readBoard(i,j)) !! 1)))
        | otherwise = (sum == ((readBoard(i,j)) !! 1))

checkLineAux :: Index -> Int -> Board -> Int
checkLineAux (i,j) w sum
        | (readAndTestIsWhite (i,j)) = (checkLineAux (i, (j-1)) w (sum + ((readBoard(i,j)) !! 1)))
        | otherwise = (sum == ((readBoard(i,j)) !! 1))

readAndTestIsWhite :: Index -> Bool
readAndTestIsWhite (i,j) = isWhite (readBoard (i,j))

{-- END OF AUXILIARES --}

{-- START OF KAKURO --}

checkCol :: Index -> Int -> Board -> Bool
checkCol (i,j) w = (checkColAux (i,j) w 0)

checkLine :: Index -> Int -> Board -> Bool
checkLine (i,j) w = (checkLineAux (i,j) w 0)

lineRepeats :: Index -> Int -> Board -> Bool
lineRepeats (i,j) w
        | (not (readAndTestIsWhite (i,j))) = False
        | ((readBoard (i,j)) !! 1) == w = True
        | otherwise = (lineRepeats (i, (j-1)))

colRepeats :: Index -> Int -> Board -> Bool
colRepeats (i,j) w
        | (not (readAndTestIsWhite (i,j))) = False
        | ((readBoard (i,j)) !! 1) == w = True
        | otherwise = (colRepeats ((i-1), j))

-- 
canContinue :: Int -> Int -> Int -> Bool
canContinue i j value
        | (lineRepeats i j value) = False
        | (colRepeats i j value)  = False
        | (j == last_j && (not check)) = False
        | ((board ! (i,(j+1))) !! 0 ) == Black && (not check) 
        | 
        | otherwise = True
        where check = ()

-- Checks if index is last of board.
isLastPos :: Index -> Bool
isLastPos (i, j) = (i == last_i) && (j == last_j)

--
hasFinished :: Index -> Int -> Board -> Int
hasFinished (i,j) w
        | (isLastPos nextP) && (j == last_j || lastIsBlack)) = solved
        | (solve nextP) == solved = solved
        | otherwise = continue
        where nextP = (nextWhitePos (nextPos (i,j))

-- Works out the tests to ...
work :: Index -> Int -> Board -> Int
work (i,j) w = do
        board !* (i,j) w
        if (canContinue (i,j) w ) then 
                (hasFinished (i,j) w)
        else 
                continue
                
-- Try one iteration of work.
try :: Index -> Int -> Board -> Int
try (i,j) w board
        | (w == limit) = unsolvable
        | ((work (i,j) w board) == solved) = solved
        | otherwise = try (i,j) (w+1) board
                        
-- Solves Kakuro boards!
solve :: Index -> Board -> Int
solve (i,j) board = (try (i,j) 1 board)

-- Here is where it all starts :-)
main = do
    -- 1. Declare the array
    arr <- newArray ((1,1), (height, width)) undefined   
    let _ = arr :: IOArray (Int,Int) Integer

-- QUEBRADO
nextWhitePos :: Index -> Board -> Index
nextWhitePos (i,j)
        | (i > last_i) = (last_i, last_j)
        | (readAndTestIsWhite (i,j)) = (i,j)
        | otherwise = (nextPos (i,j)))