import System.Random
import Control.Monad(when)

threeCoins :: StdGen -> (Bool, Bool, Bool)
threeCoins gen = 
    let (firstCoin, newGen) = random gen
        (secondCoin, newGen') = random newGen
        (thirdCoin, newGen'') = random newGen'
    in (firstCoin, secondCoin, thirdCoin)

randoms' :: (RandomGen g, Random a) => g -> [a]
randoms' gen = let (value, newGen) = random gen in value : randoms' newGen

main0 = do
    gen <- getStdGen
    putStr $ take 20 (randomRs ('a', 'z') gen)

main2 = do
    gen <- getStdGen
    let randomChars = randomRs ('a', 'z') gen
        (first20, rest) = splitAt 20 randomChars
        (second20, _) = splitAt 20 rest
    putStrLn first20
    putStr second20

main3 = do
    gen <- getStdGen
    putStrLn $ take 20 (randomRs ('a', 'z') gen)
    gen' <- newStdGen
    putStr $ take 20 (randomRs ('a', 'z') gen)

main4 = do
    gen <- getStdGen
    askForNumber gen

askForNumber :: StdGen -> IO ()
askForNumber gen = do
    let (randNumber, newGen) = randomR (1, 10) gen :: (Int, StdGen)
    putStr "Which number in the range from 1 to 10 am I thinking of?"
    numberString <- getLine
    when (not $ null numberString) $ do
        let number = read numberString
        if randNumber == number
            then putStrLn "You are correct!"
            else putStrLn $ "Sorry, it was " ++ show randNumber
        askForNumber newGen

main5 = do
    gen <- getStdGen
    let (randNumber, _) = randomR (1, 10) gen :: (Int, StdGen)
    putStr "Which number in the range from 1 to 10 am I thinking of?"
    numberString <- getLine
    when (not $ null numberString) $ do
        let number = read numberString
        if randNumber == number
            then putStrLn "You are correct!"
            else putStrLn $ "Sorry, it was " ++ show randNumber
        newStdGen
        main5
