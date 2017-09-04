import Data.List

type KnightPos = (Int, Int)

class Monad m => MonadPlus m where
  mzero :: m a
  mplus :: m a -> m a -> m a

instance MonadPlus [] where
  mzero = []
  mplus = (++)

guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()
guard False = mzero

-- 列表 Monad
moveKnight :: KnightPos -> [KnightPos]
moveKnight (c, r) = do
  (c', r') <- [
    (c + 2, r - 1), 
    (c + 2, r + 1), 
    (c - 2, r - 1), 
    (c - 2, r + 1), 
    (c + 1, r - 2), 
    (c + 1, r + 2), 
    (c - 1, r - 2), 
    (c - 1, r + 2)
    ]
  guard (c' `elem` [1..8] && r' `elem` [1..8])
  return (c', r')

-- with filter
moveKnight' :: KnightPos -> [KnightPos]
moveKnight' (c, r) = filter onBoard
  [
    (c + 2, r - 1), 
    (c + 2, r + 1), 
    (c - 2, r - 1), 
    (c - 2, r + 1), 
    (c + 1, r - 2), 
    (c + 1, r + 2), 
    (c - 1, r - 2), 
    (c - 1, r + 2)
  ] where onBoard (c', r') = c' `elem` [1..8] && r' `elem` [1..8]

-- 列表
moveKnight'' :: KnightPos -> [KnightPos]
moveKnight'' (c, r) = [(c', r') | (c', r') <- [
    (c + 2, r - 1), 
    (c + 2, r + 1), 
    (c - 2, r - 1), 
    (c - 2, r + 1), 
    (c + 1, r - 2), 
    (c + 1, r + 2), 
    (c - 1, r - 2), 
    (c - 1, r + 2)
  ], c' `elem` [1..8], r' `elem` [1..8]]

-- use do
in3 :: KnightPos -> [KnightPos]
in3 start = do
  first <- moveKnight start
  second <- moveKnight first
  moveKnight second

-- without do
in3' :: KnightPos -> [KnightPos]
in3' start = return start >>= moveKnight >>= moveKnight >>= moveKnight

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start

-- 自定义步数，使用 replicate 产生一个 moveKnight 列表
inMany :: Int -> KnightPos -> [KnightPos]
inMany x start = return start >>= foldr (<=<) return (replicate x moveKnight)

canReachIn :: Int -> KnightPos -> KnightPos -> Bool
canReachIn x start end = end `elem` inMany x start