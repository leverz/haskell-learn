data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

freeTree :: Tree Char
freeTree = 
  Node 'p'
    (Node 'O'
      (Node 'L'
        (Node 'N' Empty Empty)
        (Node 'T' Empty Empty)
      )
      (Node 'Y'
        (Node 'S' Empty Empty)
        (Node 'A' Empty Empty)
      )
    )
    (Node 'L'
      (Node 'W'
        (Node 'C' Empty Empty)
        (Node 'R' Empty Empty)
      )
      (Node 'A'
        (Node 'A' Empty Empty)
        (Node 'C' Empty Empty)
      )
    )

-- 匹配并修改 W 为 P
changeTop :: Tree Char -> Tree Char
changeTop (Node x l (Node y (Node _ m n) r)) = Node x l (Node y (Node 'P' m n) r)

-- 递归式修改 W 为 P, 其实是把模式匹配中的方向抽离出来作为输入
-- 将问题的解决办法拆分成多步，然后递归消费他们
data Direction = L | R deriving (Show)
type Directions = [Direction]

changeTop' :: Directions -> Tree Char -> Tree Char
changeTop' (L:ds) (Node x l r) = Node x (changeTop' ds l) r
changeTop' (R:ds) (Node x l r) = Node x l (changeTop' ds r)
changeTop' [] (Node _ l r) = Node 'P' l r

-- 输入方向列表，输出目标元素
elemAt :: Directions -> Tree a -> a
elemAt (L:ds) (Node _ l _) = elemAt ds l
elemAt (R:ds) (Node _ _ r) = elemAt ds r
elemAt [] (Node x _ _) = x