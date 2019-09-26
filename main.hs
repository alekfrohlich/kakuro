module Main where

import System.Environment
import Data.Array.IO
import Data.List

type KakuroBoard = IOArray 

main = do    
    args <- getArgs
    let width = (read (args !! 0) :: Int)
    let height = (read (args !! 1) :: Int)
    a <- newArray ()
    -- readFile f >>= readKakuroBoard a
    -- putStrLn "Original:"
    -- printSodokuBoard a
    -- putStrLn "Solutions:"
    -- solve a (1,1)

-- readKakuroBoard a xs = sequence_ $ do
--     (i,ys) <- zip [1..9] (lines xs)
--     (j,n)  <- zip [1..9] (words ys)
--     return $ writeBoard a (j,i) (read n)