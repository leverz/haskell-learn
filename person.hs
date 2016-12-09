-- 定义一个Person类型类，第一个字段是名字，第二个字段是姓，第三个字段是年龄

data Person = Person {
    firstName :: String,
    lastName :: String,
    age :: Int,
    height :: Float,
    phone :: String,
    flavor :: String
} deriving (Show)

data Person2 = Person2 String String Int Float String String deriving (Show)

firstName2 :: Person2 -> String
firstName2 (Person firstName _ _ _ _ _) = firstName

lastName2 :: Person -> String
lastName2 (Person _ lastName _ _ _ _) = lastName

age :: Person -> Int
age (Person _ _ age _ _ _) = age

height :: Person -> Int
height(Person _ _ _ height _ _) = height