import Data.Graph
import Data.Map (Map, (!), fromList)
import Data.List (nub)

graph :: Ord k => [k] -> Graph
graph ls = buildG bounds edges
  where bounds = (1, (length.nub) ls)
        edges = tuples $ map (mappingStrToNum !) ls
        mappingStrToNum = fromList $ zip (nub ls) [1..]
        tuples (a:b:cs) = (a, b) : tuples cs
        tuples _ = []

showTopoSort :: [String] -> Graph -> String
showTopoSort ls g =
  unlines $ map (mappingNumToStr !)(topSort g)
  where mappingNumToStr = fromList $ zip [1..] (nub ls)

main = do
  ls <- fmap lines getContents
  let g = graph ls
  putStrLn $ showTopoSort ls g
