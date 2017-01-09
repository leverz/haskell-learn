import Control.Monad
import Data.Char

module Main where

main = do
    line <- getLine
    if null line
        then return "Haha"
        else do
            putStrLn $ reverseWords line
            main

-- "."可以右结合
reverseWords :: String -> String
reverseWords = unwords . map reverse . words

main2 = do
    return ()
    return "HAHHA"
    line <- getLine
    return "Blah blah blah"
    return 4
    putStrLn line


-- 用putChar 实现 putStr
-- putStr :: String -> IO ()
-- putStr [] = return ()
-- putStr (x:xs) = do
--     putChar x
--     putStr xs

main3 = do
    c <- getChar
    if c /= ' '
        then do
            putChar c
            main3
        else return ()

main4 = do
    c <- getChar
    when (c /= ' ') $ do
        putChar c
        main4

main5 = forever $ do
    putStr "Give me some input: "
    l <- getLine
    putStrLn $ map toUpper l

main6 = do
    colors <- forM [1,2,3,4] (\a -> do
        putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
        color <- getLine
        return color)
    putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "
    mapM putStrLn colors