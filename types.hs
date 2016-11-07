-- Point类型，表示平面中的点
data Point = Point Float Float deriving (Show)
-- Shape 是类型，它的值为Circle和Rectangle
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

area :: Shape -> Float
area (Circle _ r) = pi * r ^ 2
area (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)