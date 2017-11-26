import Data.Char (ord, digitToInt, isDigit)
import Numeric (readInt)

-- readInt :: Num a => a -> (Char -> Bool) -> (Char -> Int) -> ReadS a
str `base` b = readInt b isValidDigit letterToNum str

letterToNum :: Char -> Int
letterToNum d
  | isDigit d = digitToInt d
  | otherwise = ord d - ord 'a' + 10

isValidDigit :: Char -> Bool 
isValidDigit d = letterToNum d >= 0

main :: IO ()
main = do
  print $ "8" `base` 12
  print $ "a" `base` 12
  print $ "10" `base` 12
  print $ "3b" `base` 12
