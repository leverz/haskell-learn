import Data.List
import Control.Monad

solveRPN :: String -> Double
solveRPN = head . foldl foldingFunction [] . words

-- 普通版
foldingFunction :: [Double] -> String -> [Double]
foldingFunction (x:y:ys) "*" = (y * x):ys
foldingFunction (x:y:ys) "+" = (y + x):ys
foldingFunction (x:y:ys) "-" = (y - x):ys
foldingFunction xs numberString = read numberString:xs

readMaybe :: (Read a) => String -> Maybe a
readMaybe st = case reads st of [(x, "")] -> Just x
                                _ -> Nothing

-- 安全版
-- 这里用了 return 来包裹计算后的结果，其实也可以直接用 Just
foldingFunction' :: [Double] -> String -> Maybe [Double]
foldingFunction' (x:y:ys) "*" = return ((y * x):ys)
foldingFunction' (x:y:ys) "+" = return ((y + x):ys)
foldingFunction' (x:y:ys) "-" = return ((y - x):ys)
foldingFunction' xs numberString = liftM (:xs) (readMaybe numberString)

-- 使用了模式匹配，来匹配只有一个元素的列表，如果列表有多个元素，匹配失败返回 Nothing
solveRPN' :: String -> Maybe Double
solveRPN' st = do
  [result] <- foldM foldingFunction' [] (words st)
  return result
