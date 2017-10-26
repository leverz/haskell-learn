import Text.CSV (parseCSV, Record)
import Data.Map (fromListWith)
import Control.Applicative ((<|>))

data Item = Item { name :: String 
                 , color :: String
                 , cost :: Maybe Float
                 } deriving Show
                 
main :: IO ()
main = do
  let fileName = "input.csv"
  input <- readFile fileName
  let csv = parseCSV fileName input
  either handleError doWork csv

handleError = print 

-- fromListWith :: Ord k => (a -> a -> a) -> [(k, a)] -> Map k a
-- eg: fromListWith (++) [(5,"a"), (5,"b"), (3,"b"), (3,"a"), (5,"a")] == fromList [(3, "ab"), (5, "aba")] 
--
doWork :: [Record] -> IO ()
doWork csv = print $
             fromListWith combine $
             map parseToTuple csv

combine :: Item -> Item -> Item
combine item1 item2 = 
    Item { name = name item1 
         , color = color item1 <|> color item2
         , cost = cost item1 <|> cost item2
         }

parseToTuple :: [String] -> (String, Item)
parseToTuple record = (name item, item)
    where item = parseItem record

parseItem :: Record -> Item
parseItem record = 
    Item { name = record !! 0
      , color = record !! 1
      -- reads 用来做类型转换 这里的 c 变量代表着 Float 类型的数据
      , cost = case reads(record !! 2)::[(Float, String)] of
        [(c, "")] -> Just c 
        _ -> Nothing }

