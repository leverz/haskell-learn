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