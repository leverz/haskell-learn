import qualified Data.Map as Map

data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

-- 定义了一种叫LockerMap的格式（k, (s, c)） k表示箱子的索引，s表示锁定状态，c表示密码

type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map = case Map.lookup lockerNumber map of
    Nothing -> Left $ "Locker" ++ show lockerNumber ++ " doesn't exist!"
    Just (state, code) -> if state /= Taken
        then Right code
        else Left $ "Locker" ++ show lockerNumber ++ " is already taken!"


lockers :: LockerMap
lockers = Map.fromList
    [
        (100, (Taken, "ZD39I")),
        (101, (Free, "JAH3I")),
        (103, (Free, "OQSA9")),
        (105, (Free, "IQTSA")),
        (109, (Taken, "893JJ")),
        (110, (Taken, "99292"))
    ]