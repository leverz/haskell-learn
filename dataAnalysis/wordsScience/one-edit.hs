import Data.Char (toLower)
import Data.List (group, sort)

edits1 :: String -> [String]
edits1 word = unique $ deletes ++ transposes ++ replaces ++ inserts
  -- splits 从 0 开始 take 和 drop 构造 "hi" -> [("", "hi"), ("h", "i"), ("hi", "")]
  -- "hello" -> [("", "hello"), ("h", "ello"), ("he", "llo"), ("hel", "lo"), ("hell", "o"), ("hello", "")]
  where splits = [ (take i word', drop i word') | i <- [0..length word'] ]
        -- 删掉其中一个字母
        deletes = [ a ++ (tail b) | (a, b) <- splits, (not.null) b ]
        -- 前后互换顺序 只更新 b 中前两个字母的顺序，然后拼接即可
        transposes = [ a ++ [b!!1] ++ [head b] ++ (drop 2 b) | (a,b) <- splits, length b > 1 ]
        -- 替换一个字母 只从 b 中替换，然后拼接即可
        replaces = [ a ++ [c] ++ (drop 1 b) | (a, b) <- splits, c <- alphabet, (not.null) b ]
        -- 插入一个字母
        inserts = [ a ++ [c] ++ b | (a, b) <- splits, c <- alphabet ]
        alphabet = ['a'..'z']
        word' = map toLower word

unique :: [String] -> [String]
-- (map head).group.sort $ []
unique = map head.group.sort

main = print $ edits1 "hi"

edits1' :: [String] -> [String]
edits1' ls = unique $ concat $ map edits1 ls

editsN :: String -> Int -> [String]
editsN word n = iterate edits1' (edits1 word) !! n
