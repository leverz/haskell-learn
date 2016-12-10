-- 定义一个Person类型类，第一个字段是名字，第二个字段是姓，第三个字段是年龄

data Person = Person {
    firstName :: String,
    lastName :: String,
    age :: Int,
    height :: Float,
    phone :: String,
    flavor :: String
} deriving (Show)

data IntMaybe = INothing | IJust Int
data StringMaybe = SNothing | SJust String
data ShapeMaybe = ShNothing | ShJust Shape