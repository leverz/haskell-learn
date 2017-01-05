module Tree
(
 Tree(..),
 singleton,
 treeInsert,
 treeElem,
 createTree
) where

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

-- 构造一个单节点的树，创建新节点的工厂，并且两颗子树都设为空
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

-- 像一棵树中插入一个元素
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x < a = Node a (treeInsert x left) right
    | x > a = Node a left (treeInsert x right)


-- 判断某个元素是否存在于一颗树中
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a = treeElem x left
    | x > a = treeElem x right


-- 构建一颗二叉树
createTree :: (Ord a) => [a] -> Tree a
createTree = foldr treeInsert EmptyTree