{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}
import Database.MongoDB

-- Haskell with mongoDB: https://github.com/mongodb-haskell/mongodb/blob/master/doc/tutorial.md

main :: IO ()
main = do
  let db = "test"
  pipe <- connect $ readHostPort "127.0.0.1:27017"
  e <- access pipe master db run
  close pipe
  print e

run = getData
getData = rest =<< find (select [] "people") {sort=[]}
