-- data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

-- 感觉这是一种元编程能力
infixr 5 :-:
data Underscore a = Empty | a :-: (Underscore a) deriving (Show, Read, Eq, Ord)

-- infixr 5 ++
-- (++) :: [a] -> [a] -> [a]
-- -- 递归
-- [] ++ ys = ys
-- (x:xs) ++ ys = x : (xs ++ ys)

infixr 5 ^++
(^++) :: Underscore a -> Underscore a -> Underscore a
Empty ^++ ys = ys
(x :-: xs) ^++ ys = x :-: (xs ^++ ys)