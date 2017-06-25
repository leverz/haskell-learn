-- book p230
type Birds = Int
type Pole = (Birds, Birds)

x -: f = f x

landLeft :: Birds -> Pole -> Pole
landLeft n (left, right) = (left + n, right)

landRight :: Birds -> Pole -> Pole
landRight n (left, right) = (left, right + n)

-- This code will tell you if the number of birds is in balance。
landLeft' :: Birds -> Pole -> Maybe Pole
landLeft' n (left, right)
    | abs ((left + n) - right) < 4 = Just (left + n, right)
    | otherwise = Nothing

landRight' :: Birds -> Pole -> Maybe Pole
landRight' n (left, right)
    | abs (left - (right + n)) < 4 = Just (left, right + n)
    |otherwise = Nothing

-- meet the banana will out of balance
banana :: Pole -> Maybe Pole
banana _ = Nothing

(>>) :: (Monad m) => m a -> m b -> m b
m >> n = m >>= \_ -> n