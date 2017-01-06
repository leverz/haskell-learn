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