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

-- 获取少于十个字符的行内容
main_shortLinesOnly = do
    contents <- getContents
    putStr (shortLinesOnly contents)

-- 未省略参数版shortLinesOnly
shortLinesOnly :: String -> String
shortLinesOnly input = 
    let allLines = lines input
        shortLines = filter (\line -> length line < 10) allLines
        result = unlines shortLines
    in result

-- interact版 获取少于十个字符的行内容
main = interact shortLinesOnly'

-- 省略参数版shortLinesOnly
shortLinesOnly' :: String -> String
shortLinesOnly' = unlines . filter (\line -> length line < 10) .lines

-- less code版
main_less_code = interact $ unlines . filter ((<10) . length) . lines

