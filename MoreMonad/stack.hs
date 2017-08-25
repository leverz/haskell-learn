import Control.Monad.State

type Stack = [Int]

pop :: Stack -> (Int, Stack)
pop (x:xs) = (x, xs)

push :: Int -> Stack -> ((), Stack)
push a xs = ((), a:xs)

-- test
stackManip :: Stack -> (Int, Stack)
stackManip stack = let
  ((), newStack1) = push 3 stack
  (a, newStack2) = pop newStack1
  in pop newStack2

-- 有点不明白
stackManip' :: Stack -> (Int, Stack)
stackManip' = do
  push 3
  a <- pop
  pop

pop' :: State Stack Int
pop' = state $ \ (x:xs) -> (x, xs)

push' :: Int -> State Stack ()
push' a = state $ \xs -> ((), a:xs)

stackyStack :: State Stack ()
stackyStack = do
  stackNow <- get
  if stackNow == [1, 2, 3]
    then put [8, 3, 1]
    else put [9, 2, 1]

pop'' :: State Stack Int
pop'' = do
  (x:xs) <- get
  put xs
  return x

push'' :: Int -> State Stack ()
push x = do
  xs <- get
  put (x:xs)