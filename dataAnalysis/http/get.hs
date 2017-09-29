import Text.XML.HXT.Core
import Text.HandsomeSoup

main :: IO ()
main = do
  -- 居然没办法处理 https, 太尴尬了
  let doc = fromUrl "http://lever.wang/2016/05/04/20160504/"
  links <- runX $ doc >>> css "body a" ! "href"
  print links
