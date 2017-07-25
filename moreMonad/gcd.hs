-- 欧几里得算法 计算最大公约数
gcd' :: Int -> Int -> Int
gcd' a b
  | b == 0 = a
  | otherwise = gcd' b (a `mod` b)