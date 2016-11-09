-- 定义一个Person类型类，第一个字段是名字，第二个字段是姓，第三个字段是年龄
data Person = Person String String Int Float String String deriving (Show)

firstName :: Person -> String
firstName (Person firstName _ _ _ _ _) = firstName

lastName :: Person -> String
lastName (Person _ _ _ _ _ lastName) = lastName

age :: Person -> Int
age (Person _ _ age _ _ _) = age

height :: Person -> Float
height (Person _ _ _ height _ _) = height

phoneNumber :: Person -> String
phoneNumber (Person _ _ _ _ number _) = number

flavor :: Person -> String
flavor (Person _ _ _ _ _ flavor) = flavor