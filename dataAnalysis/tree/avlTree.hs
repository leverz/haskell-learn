{-# LANGUAGE PackageImports #-}

import Data.Tree.Avl
import Data.COrdering
import qualified Data.Set as S

main = do
  -- asTree :: (e -> e -> COrdering e) -> [e] -> AVL
  -- fastCC :: Ord a => a -> a -> COrdering a
  let avl = asTree fstCC [4,2,1,5,3,6]
  let min = tryReadL avl
  let max = tryReadR avl
  print min
  print max

main' = do
  let s = S.fromList [4,2,1,5,3,6]
  let min = S.findMin s
  let max = S.findMax s
  print min
  print max
