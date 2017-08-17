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