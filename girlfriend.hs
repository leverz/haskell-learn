import System.IO
import Control.Exception
import Data.Char

-- 不适用withFile版本
main_openFile = do
    handle <- openFile "girlfriend.txt" ReadMode
    contents <- hGetContents handle
    putStr contents
    hClose handle

main_withFile = do
    withFile'' "girlfriend.txt" ReadMode (\handle -> do
        contents <- hGetContents handle
        putStr contents)

withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
withFile' path mode f = do
    handle <- openFile path mode
    result <- f handle
    hClose handle
    return result

withFile'' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
withFile'' path mode f = bracket (openFile path mode) hClose f

main_readFile = do
    contents <- readFile "girlfriend.txt"
    putStr contents

-- Turn girlfriend.txt into a CAPSLOCKED version and write it to girlfriendcaps.txt:
main = do
    contents <- readFile "girlfriend.txt"
    writeFile "girlfriendcaps.txt" (map toUpper contents)

main = do
    withFile "something.txt" ReadMode (\handle -> do
        hSetBuffering handle $ BlockBuffering (Just 2048)
        putStr contents)