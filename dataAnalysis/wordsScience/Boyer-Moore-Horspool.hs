import Data.Map (fromList, (!), findWithDefault)

-- 为文本添加索引
indexMap xs = fromList $ zip [0..] xs

-- 为逆序检索字符串添加索引，逆序主要是为了找到与 n 匹配的最前面的字符
revIndexMap xs = fromList $ zip (reverse xs) [0..]

bmh :: Ord a => [a] -> [a] -> Maybe Int
bmh pat xs = bmh' (length pat - 1) (reverse pat) xs pat

-- 参数顺序: 检索的字符串的长度 - 1, 反序检索字符串，文本，检索字符串原文
bmh' :: Ord a => Int -> [a] -> [a] -> [a] -> Maybe Int
-- 检索内容为空，则认为第一个字符就检索成功
bmh' n [] xs pat = Just (n + 1)
bmh' n (p:ps) xs pat
  -- 检索内容比原文本长，则一定不匹配，直接返回 Nothing
  | n >= length xs = Nothing
  -- 为文本惰性建立索引，比较文本中第 n 位的字符是否与检索字符串的最后一位相同，如果相同则将索引向左移动，继续比较前面的字符是否相同
  | p == (indexMap xs) ! n = bmh' (n - 1) ps xs pat
  -- 文本中的第 n 位与检索字符串的最后一位不同. findWithDefault: http://hackage.haskell.org/package/containers-0.5.10.2/docs/Data-IntMap-Strict.html#v:findWithDefault
  -- 这里其实有些激进，直接找最头上的匹配字符很容易漏掉的，应该找最近的
  | otherwise = bmh' (n + findWithDefault
                     -- 找到文本中的第 n 位，找到该字符在检索字符串中的位置，如果没有，默认返回检索字符串的长度。（这里主要是确认向右推进多少位, 找到两者相同的地方，再次进行对比）
                     (length pat) (sMap ! n) pMap)
                     -- 必须再次 reverse 一次，因为无法确定是否已经递归过了
                     (reverse pat) xs pat

  where sMap = indexMap xs
        pMap = revIndexMap pat

main :: IO ()
main = print $ bmh "Wor" "Hello World"
