import Data.Char (isSpace)

-- dropWhile ::  (a -> Bool) -> [a] -> [a]
-- isSpace :: Char -> Bool

trim :: String -> String
trim = f . f
  where f = reverse . dropWhile isSpace

main :: IO ()
main = putStrLn $ trim " hello world!    "