main :: IO ()
main = do
  let quote = "Deep Blue plays very good chees-so what?\
    \Does that tell you something about how we play chess?\
    \No. Does it tell you about how Kasparov envisions,\ 
    \understands a chessboard? (Douglas Hofstadter)"
  putStrLn $ (removePunctuation.replaceSpecialSymbols) quote

punctuations = ['!', '"', '#', '$', '%', '(', ')', '.', ',', '?']

removePunctuation = filter (`notElem` punctuations)

specialSymbols = ['/', '-']

replaceSpecialSymbols = map (\c -> if c `elem` specialSymbols then ' ' else c)
