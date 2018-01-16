{-# LANGUAGE OverloadedStrings #-}
import Data.ByteString.Search.KarpRabin (indicesOfAny)
import qualified Data.ByteString as BS

main = do
  let needles = [ "abc", "fwi", "lqa", "pwf", "ooo"
               , "mos", "fez", "cwd", "qfo", "mic"
               , "zoe", "qdk", "bbc", "wwi", "qad"
               , "fwf", "sos", "zez", "dwd", "ofo"
               , "cic", "zde", "kdq", "bna", "uin"]
  haystack <- BS.readFile "big.txt"
  print $ indicesOfAny needles haystack
