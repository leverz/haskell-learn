import Data.Char (intToDigit, chr, ord)
import Numeric (showIntAtBase)
-- haskell 数字进制转换并转换为字符串
inBase n b = showIntAtBase b intToDigit n ""

main :: IO ()
main = do
  putStrLn $ 8 `inBase` 12
  putStrLn $ 10 `inBase` 12
  putStrLn $ 12 `inBase` 12
  putStrLn $ 47 `inBase` 12
