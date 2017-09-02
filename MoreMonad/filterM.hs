import Data.Monoid
import Control.Monad.Writer

keepSmall :: Int -> Writer [String] Bool
keepSmall x
  | x < 4 = do
    tell ["keeping " ++ show x]
    return True
  | otherwise = do
    tell [show x ++ " is too large, throwing it away"]
    return False

-- 还是没太想明白 filterM 这种用法的原理，不过可以去看源码
-- http://hackage.haskell.org/package/base-4.10.0.0/docs/src/Control.Monad.html#
powerset :: [a] -> [[a]]
powerset xs = filterM (\x -> [True, False]) xs
