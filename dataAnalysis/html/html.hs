import Text.XML.HXT.Core
import Data.List.Split (chunksOf)

-- HXT使用指南： https://shimo.im/docs/cbcs2AnuMFU8ZqTJ?r=YQ8JQO

main :: IO()
main = do
  input <- readFile "input.html"
  texts <- runX $ readString
           [withParseHTML yes, withWarnings no] input
    //> hasName "td"
    //> getText
  print texts
  let rows = chunksOf 3 texts
  print $ findBiggest rows

findBiggest :: [[String]] -> [String]
findBiggest [] = []
findBiggest items = foldl1
                    (\a x -> if capacity x > capacity a then x else a) items

capacity [a, b, c] = toInt c
capacity _ = -1

toInt :: String -> Int
toInt = read
