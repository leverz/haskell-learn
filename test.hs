import Data.List
import Data.Char
import qualified Data.Map as Map
import Geometry
import qualified Geometry.Sphere as Sphere
doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100
    then x
    else doubleMe x
doubleSmallNumber' x = doubleSmallNumber x + 1
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG" | x <- xs, even x]
length' xs = sum [1 | _ <- xs]
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
factorial :: Integer -> Integer
factorial n = product [1..n]
circumference :: Float -> Float
circumference r = 2 * pi * r
circumference' :: Double -> Double
circumference' r = 2 * pi * r
lucky :: Int -> String
lucky 7 = "Lucky number seven!"
lucky x = "Sorry, you're out of luck, pal!"
factorial' :: Int -> Int
factorial' 0 = 1
factorial' n = n * factorial'(n - 1)
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
first :: (a, b, c) -> a
first (x, _, _) = x
second :: (a, b, c) -> b
second (_, y, _) = y
third :: (a, b, c) -> c
third (_, _, z) = z
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x
firstletter :: String -> String
firstletter "" = "Empty string, whoops!"
firstletter all@(x:xs) = "The First Letter Of " ++ all ++ " Is " ++ [x]
getBMI :: Double -> Double -> Double
getBMI weight height = weight / height ^ 2
bmiTell :: Double -> String
bmiTell bmi 
    | bmi <= skinny = "You're underweight." 
    | bmi <= normal = "You're supposedly normal." 
    | bmi <= fat = "You're fat!" 
    | otherwise = "You're a whale, congratulations!"
    where skinny = 18.5
          normal = 25.0
          fat = 30.0
getBMIInfo :: Double -> Double -> String
getBMIInfo weight height = bmiTell bmi where bmi = getBMI weight height
getBMIInfo' :: Double -> Double -> String
getBMIInfo' weight height = let bmi = getBMI weight height in bmiTell bmi

max' :: (Ord a) => a -> a -> a
max' a b
    | a <= b = b
    | otherwise = a

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a == b = EQ
    | a > b = GT
    | otherwise = LT

-- 递归的使用，递归找出一个数组中的最大值
{-
	注释的使用
-}
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

-- 生成具有指定个数的重复某个元素的列表

replicate' :: Int -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x:replicate' (n - 1) x

-- 从一个列表中取出一定数量的元素
take' :: Int -> [a] -> [a]
take' n _
    | n <= 0 = []
take' _ [] = []
take' n (x : xs) = x : take' (n - 1) xs

-- 反转列表
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x : xs) = reverse' xs ++ [x]

-- reverse 函数 foldl 实现
reverse'' :: [a] -> [a]
reverse'' = foldl (\acc x -> x : acc) []

-- reverse 函数 foldl 简化
reverse''' :: [a] -> [a]
reverse''' = foldl (flip (:)) []

-- 重复生成一个仅包含一个元素的无限长度的列表
repeat' :: a -> [a]
repeat' x = x : repeat' x

-- zip 将两个列表捆绑在一起
zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

-- elem 取一个元素与一个列表作为参数，并检测该元素在此列表中是否存在
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x = True
    | otherwise = a `elem'` xs

-- elem 的 foldr 实现
elem'' :: (Eq a) => a -> [a] -> Bool
elem'' x xs = foldr (\y acc -> if y == x then True else acc) False xs

{-
    quicksort 快速排序，选取一个元素作为基准，将列表分为小于
    基准的部分和大于基准的部分，然后再分别进行快速排序
    列表推到式版
-}
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallOrEqual = [a | a <- xs, a <= x]
        larger = [a | a <- xs, a > x]
        in quicksort smallOrEqual ++ [x] ++ quicksort larger

{-
    filter版的quicksort
-}
quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
    let smallOrEqual = filter (<=x) xs
        larger = filter (>x) xs
        in quicksort' smallOrEqual ++ [x] ++ quicksort' larger

-- 连续调用两次
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

{-
    zipWith接受三个参数,第一个参数为函数，第二个是数组，第三个页数数组
    通过类型声明可以很清楚的看到，第一个参数中的函数会把后两个列表中的相关元素作为参数，并返回一个处理结果，最后将这些结果放到新的列表中
    从函数名就可以看出，这其实是一种压缩算法的实现，将多个二进制位合并成一个数，解压时再逆向过来执行函数就可以
-}
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
{-
    函数柯里化的好例子：
    flip函数的作用是将某个函数传入的两个参数的位置颠倒过来
    对flip函数来说，如果不传x和y参数，那么根据函数柯里化，得到的结果是一个参数颠倒的f函数，正是我们想要的东西
    加深一次对函数柯里化的理解：柯里函数不会一次性取完所有的参数，而是每次只取一个参数，并返回一个一元函数来取下一个参数
-}
flip' :: (a -> b -> c) -> b -> a -> c
flip' f y x = f x y

{-
    map函数的实现
-}
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- map函数使用foldr的实现
map'' :: (a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> f x : acc) [] xs

{-
   filter函数实现
-}
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x = x : filter' f xs
    | otherwise = filter' f xs

-- filter 函数 foldr版
filter'' :: (a -> Bool) -> [a] -> [a]
filter'' f = foldr (\x acc -> if f x then x : acc else acc) []


{-
    寻找100000以下3829的最大倍数
-}
largestDivisible :: Integer
largestDivisible = head (filter p [100000, 99999..]) where p x = x `mod` 3829 == 0
largestDivisible' :: Integer
largestDivisible' = head [x | x <- [100000, 99999..], x `mod` 3829 == 0]

{-
    产生一个克拉兹序列
-}
collatzChain :: Integer -> [Integer]
collatzChain 1 = [1]
collatzChain x
    | even x = x : collatzChain (x `div` 2)
    | otherwise = x : collatzChain (x * 3 + 1)

-- 1-100之间的所有书作为起始数，有多少克拉兹链的长度大于15？
getChainLengthGreaterThan15 :: Int
getChainLengthGreaterThan15 = length [x | x <- [1..100], length (collatzChain x) > 15]

-- sum函数
sum' :: (Num a) => [a] -> a
sum' xs = foldl (+) 0 xs

-- product函数
product' :: (Num a) => [a] -> a
product' = foldl (*) 1

-- last 函数
last' :: [a] -> a
last' = foldl1 (\_ x -> x)

-- and 函数
and' :: [Bool] -> Bool
and' = foldr (&&) True

-- 将自然数的平方根相加，将在何处超过1000
findSquareSumBiggerThan1000 :: Int
findSquareSumBiggerThan1000 = length (takeWhile (< 1000) (scanl1 (\acc x -> acc + sqrt x ) [1..])) + 1

-- 统计字符串中出现了多少单词,每个单词出现多少次
wordNums :: String -> [(String, Int)]
wordNums = map (\(x:xs) -> (x, length xs + 1)) . group . sort . words
-- 字符串中是否有某个子串
isIn :: (Eq a) => [a] -> [a] -> Bool
needle `isIn` haystack = any (needle `isPrefixOf`) (tails haystack)

-- 凯撒密码加密
encode :: Int -> String -> String
encode offset = map (chr . (+ offset) . ord)

-- 凯撒密码解密
decode :: Int -> String -> String
decode shift = encode (negate shift)

-- 将一个数字的各位相加得出结果
digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

getSmallThan40 :: [Int] -> Int
getSmallThan40 = length . takeWhile (< 40) . map digitSum
getSmallThan40' :: [Int] -> Maybe Int
getSmallThan40' = find (\x -> digitSum x == 40)

firstTo :: Int -> Maybe Int
firstTo y = find (\x -> digitSum x == y) [1..]

findKey :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey key [] = Nothing
findKey key ((k, v) : xs)
    | key == k = Just v
    | otherwise = findKey key xs

findKey' :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey' key xs = foldr (\(k, v) acc -> if key == k then Just v else acc) Nothing xs

phoneBook :: Map.Map String String
phoneBook = Map.fromList $
    [("betty", "555-2938"),("bonnie", "452-2928"),("Pettew", "111-2123"),("Jen", "342-4883"),("Rich", "329-2329"), ("Jen", "877-3222")]

stringToDigit :: String -> [Int]
stringToDigit = map digitToInt . filter isDigit

intBook :: Map.Map String String -> Map.Map String [Int]
intBook = Map.map stringToDigit

phoneBookToMap :: (Ord k) => [(k, String)] -> Map.Map k String
phoneBookToMap xs = Map.fromListWith add xs
    where add number1 number2 = number1 ++ ", " ++ number2

phoneBookToMap' :: (Ord k) => [(k, String)] -> Map.Map k [String]
phoneBookToMap' xs = Map.fromListWith (++) $ map (\(k, v) -> (k, [v])) xs











