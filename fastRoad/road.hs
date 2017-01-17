data Node = Node Road (Maybe Road)
data Road = Road Int Node

data Section = Section {getA :: Int, getB :: Int, getC :: Int} deriving (Show)
type RoadSystem = [Section]