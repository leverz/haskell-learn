import Data.Tree (rootLabel, subForest, Tree(..))
import Data.List (tails)

breadthFirst :: Tree a -> [a]
breadthFirst t = bf [t]
  where bf forest | null forest = []
                  | otherwise = map rootLabel forest ++
                         bf (concat (map subForest forest))

add :: Tree Int -> Int
add t = sum $ breadthFirst t

someTree :: Tree Int
someTree = root
  where root = Node { rootLabel = 0, subForest = [n1, n4] }
        n1 = Node { rootLabel = 1, subForest = [n2, n3] }
        n2 = Node { rootLabel = 2, subForest = [] }
        n3 = Node { rootLabel = 3, subForest = [] }
        n4 = Node { rootLabel = 4, subForest = [] }

main = do
  print $ breadthFirst someTree
  print $ add someTree
