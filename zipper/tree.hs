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

type Breadcrumbs = [Direction]

goLeft :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)
goLeft (Node _ l _, bs) = (l, L:bs)

goRight :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)
goRight (Node _ _ r, bs) = (r, R:bs)

-- 先向右走，再向左走
x -: f = f x
-- (freeTree, []) -: goRight -: goLeft

-- 定义一个新类型以存储遍历过的树，方便之后对树进行重建
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)
type Breadcrumbs' a = [Crumb a]

-- LeftCrumb 表示向左走，另外两个字段分别表示所离开的节点和未被选中的右子树
goLeft' :: (Tree a, Breadcrumbs' a) -> (Tree a, Breadcrumbs' a)
goLeft' (Node x l r, bs) = (l, LeftCrumb x r:bs)

goRight' :: (Tree a, Breadcrumbs' a) -> (Tree a, Breadcrumbs' a)
goRight' (Node x l r, bs) = (r, RightCrumb x l:bs)

-- 有了父节点的信息，可以进行向上走操作
goUp :: (Tree a, Breadcrumbs' a) -> (Tree a, Breadcrumbs' a)
goUp (t, LeftCrumb x r:bs) = (Node x t r, bs)
goUp (t, RightCrumb x l:bs) = (Node x l t, bs)

type Zipper a = (Tree a, Breadcrumbs' a)

modify :: (a -> a) -> Zipper a -> Zipper a
modify f (Node x l r, bs) = (Node (f x) l r, bs)
modify f (Empty, bs) = (Empty, bs)

-- 替换树上的某棵子树
attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

-- 一路向上
topMost :: Zipper a -> Zipper a
topMost (t, []) = (t, [])
topMost z = topMost (goUp z)

-- 列表中的 zipper
type ListZipper a = ([a], [a])
goForward :: ListZipper a -> ListZipper a
goForward (x:xs, bs) = (xs, x:bs)

goBack :: ListZipper a -> ListZipper a
goBack (xs, b:bs) = (b:xs, bs)

-- with maybe monad
goLeft'' :: Zipper a -> Maybe (Zipper a)
goLeft'' (Node x l r, bs) = Just (l, LeftCrumb x r:bs)
goLeft'' (Empty, _) = Nothing

goRight'' :: Zipper a -> Maybe (Zipper a)
goRight'' (Node x l r, bs) = Just (r, RightCrumb x l:bs)
goRight'' (Empty, _) = Nothing

goUp'' :: Zipper a -> Maybe (Zipper a)
goUp'' (t, LeftCrumb x r:bs) = Just (Node x t r, bs)
goUp'' (t, RightCrumb x l:bs) = Just (Node x l t, bs)
goUp'' (_, []) = Nothing