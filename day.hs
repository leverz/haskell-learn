data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving (Eq, Ord, Show, Read, Bounded, Enum)

data Either a b = Left a | Right b deriving(Eq, Ord, Read, Show)