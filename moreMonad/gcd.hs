import Control.Monad.Writer

-- 欧几里得算法 计算最大公约数
gcd' :: Int -> Int -> Int
gcd' a b
  | b == 0 = a
  | otherwise = gcd' b (a `mod` b)

-- gcd with Monad
gcd'' :: Int -> Int -> Writer [String] Int
gcd'' a b
  | b == 0 = do
      tell ["Finished with " ++ show a]
      return a
  | otherwise = do
      tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
      gcd'' b (a `mod` b)