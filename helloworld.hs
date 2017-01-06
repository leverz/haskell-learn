-- main = putStrLn "Hello, World!"
import Data.Char

module Main where

main = do
    putStrLn "Hello, what's your name?"
    name <- getLine
    putStrLn ("Hey " ++ name ++ ", you rock!")

main2 = do
    putStrLn "what's your first name?"
    firstName <- getLine
    putStrLn "what's your last name?"
    lastName <- getLine
    let bigFirstName = map toUpper firstName
        bigLastName = map toUpper lastName
    putStrLn $ "hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"
