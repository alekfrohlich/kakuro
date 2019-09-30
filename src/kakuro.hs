module Main where

    import Data.Array.MArray
    import Data.Array.IO
      
      
      -- kakuroBoard = [[(0,0,0), (0,14,0), (0,29,0), (0,10,0), (0,0,0), (0,0,0), (0,0,0), (0,24,0), (0,16,0), (0,22,0), (0,0,0), (0,0,0)]
      --                 ,[(0,0,23), (1,9,0), (1,0,0), (1,0,0), (0,3,0), (0,0,0), (0,12,24), (1,0,0), (1,0,0), (1,0,0), (0,24,0), (0,0,0)]
      --                 ,[(0,0,11), (1,3,0), (1,0,0), (1,0,0), (1,0,0), (0,6,34), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,17,0)]
      --                 ,[(0,0,13), (1,2,0), (1,0,0), (0,39,16), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,9,19), (1,0,0), (1,0,0), (1,0,0)]
      --                 ,[(0,0,0), (0,0,16), (1,0,0), (1,0,0), (0,4,3), (1,0,0), (1,0,0), (0,7,29), (1,0,0), (1,0,0), (1,0,0), (1,0,0)]
      --                 ,[(0,0,0), (0,4,0), (0,7,8), (1,0,0), (1,0,0), (1,0,0), (0,10,7), (1,0,0), (1,0,0), (1,0,0), (0,10,0), (0,0,0)]
      --                 ,[(0,0,10), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,6,4), (1,0,0), (1,0,0), (0,4,3), (1,0,0), (1,0,0), (0,15,0)]
      --                 ,[(0,0,11), (1,5,0), (1,4,0), (1,2,0), (0,4,11), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,4,11), (1,0,0), (1,0,0)]
      --                 ,[(0,0,0), (0,0,16), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,0,11), (1,0,0), (1,0,0), (1,0,0), (1,0,0)]
      --                 ,[(0,0,0), (0,0,0), (0,0,13), (1,0,0), (1,0,0), (1,0,0), (0,0,0), (0,0,0), (0,0,7), (1,0,0), (1,0,0), (1,0,0)]]
      
      -- -- 10x12 Puzzle (#2)
    kakuroBoard = [[(0,0,0), (0,14,0), (0,29,0), (0,10,0), (0,0,0), (0,0,0), (0,0,0), (0,24,0), (0,16,0), (0,22,0), (0,0,0), (0,0,0)]
                    ,[(0,0,23), (1,0,0), (1,0,0), (1,0,0), (0,3,0), (0,0,0), (0,12,24), (1,0,0), (1,0,0), (1,0,0), (0,24,0), (0,0,0)]
                    ,[(0,0,11), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,6,34), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,17,0)]
                    ,[(0,0,13), (1,0,0), (1,0,0), (0,39,16), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,9,19), (1,0,0), (1,0,0), (1,0,0)]
                    ,[(0,0,0), (0,0,16), (1,0,0), (1,0,0), (0,4,3), (1,0,0), (1,0,0), (0,7,29), (1,0,0), (1,0,0), (1,0,0), (1,0,0)]
                    ,[(0,0,0), (0,4,0), (0,7,8), (1,0,0), (1,0,0), (1,0,0), (0,10,7), (1,0,0), (1,0,0), (1,0,0), (0,10,0), (0,0,0)]
                    ,[(0,0,10), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,6,4), (1,0,0), (1,0,0), (0,4,3), (1,0,0), (1,0,0), (0,15,0)]
                    ,[(0,0,11), (1,0,0), (1,0,0), (1,0,0), (0,4,11), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,4,11), (1,0,0), (1,0,0)]
                    ,[(0,0,0), (0,0,16), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (0,0,11), (1,0,0), (1,0,0), (1,0,0), (1,0,0)]
                    ,[(0,0,0), (0,0,0), (0,0,13), (1,0,0), (1,0,0), (1,0,0), (0,0,0), (0,0,0), (0,0,7), (1,0,0), (1,0,0), (1,0,0)]]
    
    -- kakuroBoard = [[(0,0,0), (0,12,0), (0,21,0), (0,0,0), (0,16,0), (0,13,0)]
    --               ,[(0,0,17), (1,0,0), (1,0,0), (0,22,11), (1,0,0), (1,0,0)]
    --               ,[(0,0,15), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (1,0,0)]
    --               ,[(0,0,0), (0,4,13), (1,0,0), (1,0,0), (1,0,0), (0,10,0)]
    --               ,[(0,0,18), (1,0,0), (1,0,0), (1,0,0), (1,0,0), (1,0,0)]
    --               ,[(0,0,10), (1,0,0), (1,0,0), (0,0,14), (1,0,0), (1,0,0)]]
      
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
    
    height = 10        -- Board height.
    width  = 12         -- Board width.  
    
    last_i = height-1   -- Last available line index.
    last_j = width-1    -- Last available collumn index.        
    
    limit = 10          -- Last permited number.
    
    (!) = readArray
    
    {-- END OF DEFINES --}
    
    {-- START OF AUXILIARES --}
    
    -- Return next Position on board.
    nextPos :: Index -> Index
    nextPos (i,j)
            | (j == last_j) = ((i+1), (mod  (j+1) width))
            | otherwise = (i, (mod  (j+1) width))
    
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
    
    segundoIfCan (i,j) board = do
      checkL <- (checkLine (i,j) board 0)
      if (j==last_j) && (not checkL)
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
                  else do
                      return False
    
    terceiroIfCan (i,j) board = do
      checkC <- (checkCol (i,j) board 0)
      if (i == last_i) && (not checkC)
          then return True
          else do
              if(i /= last_i)
                  then do
                      (color,_,_) <- board ! ((i+1),j) 
                      if ((color == black) && (not checkC))
                          then
                              return True
                          else
                              return False
                  else do
                      return False
    
    -- Check if branch of computation can procede.
    canContinue (i,j) board w = do
        lReps <- (lineRepeats (i,(j-1)) board w)
        cReps <- (colRepeats ((i-1),j) board w)
        if (lReps || cReps)
            then return False
            else do 
                seg <- (segundoIfCan (i,j) board)
                ter <- (terceiroIfCan (i,j) board)
                if (seg || ter)
                    then return False
                    else return True
    
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
    
    hasFinished (i,j) board = do
        nextP <- (nextWhitePos (nextPos (i,j)) board)
        (color,_,_) <- board ! (last_i,last_j)
        if (isLastPos nextP) && (j == last_j || color == black)
            then return solved
            else do
              sol <- (solve nextP board) 
              if sol == solved
                then do
                    return solved
                else return continue
    
    -- Works out the tests to ...
    work (i,j) board w = do
        (writeArray board (i,j) (white, w, 0))
        can <- (canContinue (i,j) board w)
        if (can)
          then (hasFinished (i,j) board)
          else return continue
          
    -- Try one iteration of work.
    try (i,j) board w = do
        if (w == limit)
            then return unsolvable
            else do 
                wor <- (work (i,j) board w) 
                if (wor == solved)
                    then return solved
                    else (try (i,j) board (w+1))
    
    -- Solves Kakuro boards!
    solve (i,j) board = do
        (try (i,j) board 1)
    
    -- Here is where it all starts :-)
    main = do
      -- 1. Declare the matrix
      board <- newArray ((0,0), (height,width)) undefined
      let _ = board :: Board
    
      -- 2. Initialize the matrix.
      sequence_ $ do
          i <- [0..last_i]
          j <- [0..last_j]
          return $ writeArray board (i,j) ((kakuroBoard !! i) !! j)
      nex <- (nextWhitePos (0,0) board)
      sol <- (solve nex board)
      sequence_ $ do
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