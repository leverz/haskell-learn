import Text.XML.HXT.Core
-- TODO: read HXT document

-- how to use hxt: https://wiki.haskell.org/HXT

-- hasName :: String -> a XmlTree XmlTree
-- getText :: a XmlTree String
-- runX :: IOSArrow XmlTree String -> IO()
main :: IO()
main = do
  input <- readFile "input.xml"
  dates <- runX $ readString [withValidate no] input
      //> hasName "date"
      //> getText
  print dates