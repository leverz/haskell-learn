import Data.MultiSet (fromList, toOccurList)

data Color = Red | Green | Blue deriving (Show, Ord, Eq)

main :: IO ()
main = do
  let items = [Red, Green, Green, Blue, Red, Green, Green]
  -- fromList :: Ord a => [a] -> Data.MultiSet.MultiSet a
  -- toOccurList :: MultiSet a -> [(a, Int)]
  let freq = toOccurList . fromList $ items
  print freq
