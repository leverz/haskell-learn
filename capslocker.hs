import Control.Monad
import Data.Char

-- getLine版本
main_getLine = forever $ do
    i <- getLine
    putStrLn $ map toUpper i

-- getContents版本
main_getContents = do
    contents <- getContents
    putStrLn (map toUpper contents)

main = do
    contents <- getContents
    putStr (shortLinesOnly contents)

shortLinesOnly :: String -> String
shortLinesOnly input = 
    let allLines = lines input
        shortLines = filter (\line -> length line < 10) allLines
        result = unlines shortLines
    in result