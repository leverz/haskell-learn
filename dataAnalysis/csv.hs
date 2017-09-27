import Text.CSV

{--
 -- code of Text.CSV: https://hackage.haskell.org/package/csv-0.1.2/docs/src/Text-CSV.html#CSV
 -- type CSV = [Record]
 -- type Record = [Field]
 -- type Field = String
 --}

main :: IO()
main = do
  let filename = "input.csv"
  input <- readFile filename
  let csv = parseCSV filename input
  either handleError doWork csv

handleError csv = putStrLn "error parsing"

doWork csv = (print.findOldest.tail) (filter (\x -> length x == 2) csv)

findOldest :: CSV -> Record
findOldest [] = []
findOldest xs = foldl1
           (\a x -> if age x > age a then x else a) xs

age :: Record -> Int
age [a, b] = toInt b

toInt :: Field -> Int
toInt = read
