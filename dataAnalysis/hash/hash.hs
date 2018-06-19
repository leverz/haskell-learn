import Data.Hashable

main = do
  print $ hash "foo"
  print $ hashWithSalt 1 "foo"
  print $ hashWithSalt 2 "foo"
  print $ hash [ (1 :: Int, "hello", True)
               , (0 :: Int, "goodbye", False) ]
