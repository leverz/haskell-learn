import Control.Exception (catch, someException)
import System.Environment (getArgs)
import System.Directory (doesFileExist)

main :: IO ()
main = do
  args <- getArgs
    let filename  = case args of
      (a:_) -> a
          _ -> "input.txt"
  input <- catch (readFile filename)
    $ \err -> print (err::someException) >> return ""
  print $ countWords input

-- use doesFileExist
main' :: IO ()
main' = do
  args <- getArgs
    let filename = case args of
      (a:_) -> a
          _ -> "input.txt"
  exists <- doesFileExist filename
  input <- if exists then readFile filename else return ""

countWords :: String -> [Int]
countWords input = map (length.words) (lines input)