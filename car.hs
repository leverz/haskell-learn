data Car = Car {
    company :: String,
    model   :: String,
    year    :: Int
} deriving (Show)

data Car2 a b c = Car2 {
    company :: a,
    model   :: b,
    year    :: c
} deriving (Show)

tellCar :: Car -> String
tellCar (Car {company = c, model = m, year = y}) = 
    "This " ++ c ++ " " ++ m ++ " was made in " ++ show y

tellCar' :: (Show a) => Car2 String String a -> String
tellCar' (Car2 {company = c, model = m, year = y}) = 
    "This " ++ c ++ " " ++ m ++ " was made in" ++ show y