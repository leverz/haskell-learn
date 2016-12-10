-- 等号左侧是一个类型构造器，右侧是一个值构造器
-- 声明函数是，必须用类型限定而不是值，要注意区分类型构造器和值构造器

data Vector a = Vector a a a deriving (Show)

vplus :: (Num a) => Vector a -> Vector a -> Vector a
(Vector i j k) `vplus` (Vector l m n) = Vector (i + l) (j + m) (k + n)

dotProd :: (Num a) => Vector a -> Vector a -> a
(Vector i j k) `dotProd` (Vector l m n) = i * l + j * m + k * n

vmult :: (Num a) => Vector a -> a -> Vector a
(Vector i j k) `vmult` m = Vector (i * m) (j * m) (k * m)