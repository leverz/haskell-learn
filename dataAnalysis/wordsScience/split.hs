import Data.List.Split (splitOn)

main = do
  input <- readFile "input.txt"
  -- split by line
  let ls = lines input
  print $ ls
  -- split by space
  let ws = words $ ls !! 2
  print ws
  -- split by ,
  let cs = splitOn "," $ ls !! 3
  print cs
  -- split by an
  let ds = splitOn "an" $ ls !! 4
  print ds
