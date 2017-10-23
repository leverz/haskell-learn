import Text.Regex.Posix ((=~))

-- match strings which look like names with regexp
looksLikeName :: String -> Bool
looksLikeName str = str =~ "^[A-Z][a-z]{1,30}$" :: Bool
-- looksLikeName = (=~) "^[A-Z][a-z]{1, 30}$" :: Bool

-- ignore specific characters
punctuations = ['!', '"', '#', '$', '%', '(', ')', '.', ',', '?' ]

removePunctuations = filter (`notElem` punctuations)

specialSymbols = ['/', '-']
replaceSpecial = map $ 
                  (\c -> if c `elem` specialSymbols
                         then ' ' else c)

createTuples (x:y:xs) = (x ++ " " ++ y) : createTuples (y:xs)
createTuples _ = []

-- Retrieve the input and find posible names.
main :: IO()
main = do
  input <- readFile "input.txt"
  let cleanInput = (removePunctuations . replaceSpecial) input

  let wordPairs = createTuples $ words cleanInput

  let possibleNames = filter (all looksLikeName . words) wordPairs

  print possibleNames

