{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
import Control.Applicative
import qualified Data.ByteString.Lazy as B

-- how to use Data.Aeson: https://hackage.haskell.org/package/aeson-1.2.2.0/docs/Data-Aeson.html

data Mathematician = Mathematician
                     { name :: String
                     , nationality :: String
                     , born :: Int
                     , died :: Maybe Int
                     }

{--
 -- 取出 json 中必有的 key
 -- (.:) :: FromJSON a => Object -> Text -> Parser a
 -- 取出 json 中可能有的 key, 如果 key 的值为 null 也会被解析成 Nothing
 -- (.:?) :: FromJSON a => Object -> Text -> Parser (Maybe a)
 -- 取出 json 中可能有的 key, 这个函数会试图解析 key 的值为 null 的情况
 -- (.:!) :: FromJSON a => Object -> Text -> Parser (Maybe a)
 -- 设置默认值, 可以配合 .:? 来使用
 -- (.!=) :: Parser (Maybe a) -> a -> Parser a
 --
 -- Value 表示一个 JSON value, Parser 表示 JSON parser
 -- parseJSON :: Value -> Parser Value
 --}
instance FromJSON Mathematician where
  parseJSON (Object v) = Mathematician
                         <$> (v .: "name")
                         <*> (v .: "nationality")
                         <*> (v .: "born")
                         <*> (v .:? "died")

main :: IO()
main = do
  input <- B.readFile "input.json"
  
  -- decode :: FromJSON a => ByteString -> Maybe a
  let mm = decode input :: Maybe Mathematician

  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn.greet) m

greet m = (show.name) m ++
          " was born in the year " ++
          (show.born) m