import Data.HashMap.Lazy
import Data.Set(Set)
import qualified Data.Set as Set

emptyMap = empty :: HashMap Int (Set String)

insertWord m w = insertWith append key val m
  where append new old = Set.union new old
        key = length w
        val = Set.singleton w

wordsOfLength len m = Set.size(lookupDefault Set.empty len m)

constructMap text = foldl (\m w -> insertWord m w) emptyMap (words text)

main = do
  text <- readFile "../wordsScience/big.txt"
  let m = constructMap text
  print [wordsOfLength s m | s <- [1..30]]
