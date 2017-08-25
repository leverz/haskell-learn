import Control.Exception (catch, someException)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
    let filename  = case args of
      (a:_) -> a
          _ -> "input.txt"
  input <- catch (readFile filename)
    $ \err -> print (err::someException) >> return ""
  print $ countWords input

countWords :: String -> [Int]
countWords input = map (length.words) (lines input)