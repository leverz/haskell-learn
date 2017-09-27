{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
import Control.Applicative
import qualified Data.ByteStrings.Lazy as B

-- how to use Data.Aeson: https://hackage.haskell.org/package/aeson-1.2.2.0/docs/Data-Aeson.html

data Mathematician = Mathematician
                     { name :: String
                     , nationality :: String
                     , born :: Int
                     , died :: Maybe Int
                     }

instance FromJSON Mathematician where
  parseJSON (Object v) = Mathematician
                         <$> (v .: "name")
                         <*> (v .: "nationality")
                         <*> (v .: "born")
                         <*> (v .:? "died")

main :: IO()
main = do
  input <- B.readFile "input.json"

  let mm = decode input :: Maybe Mathematician

  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn.greet) m

greet m = (show.name) m ++
          " was born in the year " ++
          (show.born) m