
import Data.Monoid

type Food = String
type Price = Sum Int

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)


-- 无日志
isBigGang' :: Int -> Bool
isBigGang' x = x > 9

-- 日志
isBigGang :: Int -> (Bool, String)
isBigGang x = (x > 9, "Compared gang size to 9.")

-- f x 的值为二元组，可以匹配（解构赋值?）到 y 和 newLog 两个变量上，再用两个变量产生新值 
applyLog' :: (a, [c]) -> (a -> (b, [c])) -> (b, [c])
applyLog' (x, log) f = let (y, newLog) = f x in (y, log ++ newLog)

-- with Monoid
applyLog :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)
