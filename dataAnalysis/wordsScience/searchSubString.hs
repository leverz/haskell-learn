import Data.ByteString (breakSubstring)
import qualified Data.ByteString.Char8 as C

-- breakSubstring :: ByteString -> ByteString -> (ByteString, ByteString)
-- C.pack :: String -> C.ByteString
-- breakSubstring 递归匹配字符串
substringFound :: String -> String -> Bool
substringFound query str =
  (not . C.null . snd) $
  breakSubstring (C.pack query) (C.pack str)

main :: IO ()
main = do
  print $ substringFound "scraf" "swedish scraf mafia"
  print $ substringFound "flute" "swedish scraf mafia"
