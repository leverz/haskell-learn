import Data.BloomFilter (fromList, elem, empty, insert)
import Data.BloomFilter.Hash (cheapHashes)
import Data.Map (Map, empty, insertWith)
import qualified Data.Map as Map

removeUniques strands = foldl bloomMapCheck (emptyBloom, emptyMap) strands
  where emptyBloom = Data.BloomFilter.empty (cheapHashes 3) 1024
        emptyMap = Map.empty :: Map String Int
        bloomMapCheck (b, m) x
          | Data.BloomFilter.elem x b = (b, insertWith (+) x 1 m)
          | otherwise = (insert x b, m)

main = do
  let strands = ["GAT", "GATC", "CGT", "GAT", "GAT", "CGT", "GAT", "CGT"]
  print $ snd $ removeUniques strands
