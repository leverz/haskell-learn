import Control.Monad
import Data.Char

main = forever $ do
    i <- getLine
    putStrLn $ map toUpper i