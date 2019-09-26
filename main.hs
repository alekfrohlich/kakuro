module Main where

-- import System.Environment
-- import Data.Array.IO
-- import Data.List

-- type KakuroBoard = IOArray
-- main = do    
--     args <- getArgs
--     let file = (args !! 0)
--     let width = (read (args !! 0) :: Int)
--     let height = (read (args !! 1) :: Int)
    -- board <- newArray ()
    -- readFile file >>= readKakuroBoard a
    -- print ("Original:")
    -- printKakuroBoard a
    -- print ("Solutions:")
    -- solve board (0,0)
-- readKakuroBoard a xs = sequence_ $ do
--     (i,ys) <- zip [1..9] (lines xs)
--     (j,n)  <- zip [1..9] (words ys)
--     return $ writeBoard a (j,i) (read n)

main = do
    ...