import Data.Char
import Data.List

-- instance Functor IO where
--     fmap f action = do
--         result <- action
--         return (f result)

-- 提示用户输入一行，翻转后打印出来
main' = do line <- getLine
           let line' = reverse line
           putStrLn $ "You said " ++ line' ++ " backwards!"
           putStrLn $ "Yes, you said " ++ line' ++ " backwards!"

-- fmap改写
main'' = do line <- fmap reverse getLine
            putStrLn $ "You said " ++ line ++ " backwards!"
            putStrLn $ "Yes, you really said" ++ line ++ " backwards!"

-- fmap + composition
main = do line <- fmap (intersperse '-' . reverse . map toUpper) getLine
          putStrLn line


