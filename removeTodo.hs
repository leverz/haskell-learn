import System.IO
import System.Directory
import Data.List
import Control.Exception

main = do
    handle <- openFile "todo.txt" ReadMode
    contents <- hGetContents handle
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStrLn "These are your TO-Do items:"
    -- 可以用以下代码替代
    -- mapM putStrLn numberedTasks
    putStr $ unlines numberedTasks
    putStrLn "Which one do you want to delete?"
    numberString <- getLine
    let number = read numberString
        newTodoItems = delete (todoTasks !! number) todoTasks
    -- 使用openTempFile 而不是新建一个文件，减少开销
    -- (tempName, tempHandle) <- openTempFile "." "temp"
    bracketOnError (openTempFile "." "temp")
        (\(tempName, tempHandle) -> do
            hClose tempHandle
            removeFile tempName)
        (\(tempName, tempHandle) -> do
            hPutStr tempHandle newTodoItems
            hClose tempHandle
            removeFile "todo.txt"
            renameFile tempName "todo.txt")