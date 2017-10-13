import Text.CSV

-- 先定义数据的抽象
data Laptop = Laptop {
  brand :: Maybe String,
  model :: Maybe String,
  cost :: Maybe Float
} deriving Show

main :: IO ()
main = do
  let filename = "test.csv"
  input <- readFile filename
  let csv = parseCSV filename input
  let laptops = parseLaptops csv
  print laptops

parseLaptops (Left err) = []
parseLaptops (Right csv) =
  foldl (\a record -> if length record == 3
                      then (parseLaptop record):a
                      else a) [] csv

parseLaptop record = Laptop {
  brand = getBrand $ record !! 0,
  model = getModel $ record !! 1,
  cost = getCost $ record !! 2
}

getBrand :: String -> Maybe String
getBrand str = if null str then Nothing else Just str

getModel :: String -> Maybe String
getModel str = if null str then Nothing else Just str

getCost :: String -> Maybe Float
getCost str = case reads str::[(Float, String)] of
  [(cost, "")] -> Just cost
  _ -> Nothing