import Data.Char (isAlpha, isSpace, toLower)
import Data.List (group, sort, maximumBy)
import Data.Ord (comparing)
import Data.Map (fromListWith, Map, member, (!))

autofix :: Map String Int -> String -> String
autofix m sentence = unwords $ map (correct m) (words sentence)

getWords :: String -> [String]
getWords str = words $ filter (\x -> isAlpha x || isSpace x) lower
               where lower = map toLower str

train :: [String] -> Map String Int
train = fromListWith (+) . ('zip' repeat 1)

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

knownEdits2 :: String -> Map String a -> [String]
knownEdits2 word m = unique $ [ e2
                              | e1 <- edits1 word
                              , e2 <- edits1 e1
                              , e2 'member' m ]

known :: [String] -> Map String a -> [String]
known ws m = filter ('member' m) ws

correct :: Map String Int -> String -> String
correct m word = maximumBy (comparing (m!)) candidates
                 where candidates = head $ filter (not.null)
                                    [ known [word] m
                                    , known (edits1 word) m
                                    , knownEdits2 word m
                                    , [word] ]

main :: IO ()
main = do
  rawText <- readFile "big.txt"
  let m = train $ getWords rawText
  let sentence = "such codez many hsakell very spel so korrect"
  print $ autofix m sentence
