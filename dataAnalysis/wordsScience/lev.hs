import qualified Data.MemoCombinators as Memo

-- 莱温斯坦距离: 两个字符串之间，由一个转换为另一个所需的最少编辑次数
-- 应用: DNA 分析, 拼写检查, 语音辨识, 抄袭侦测

lev :: Eq a => [a] -> [a] -> Int
lev a b = levM (length a) (length b)
  where levM = memoize lev'
        lev' i j
          -- 有个字符串为空，则直接返回最长的字符串
          | min i j == 0 = max i j
          -- 同时计算三种情况
          | otherwise = minimum
                        [ ( 1 + levM (i - 1) j )
                        , ( 1 + levM i (j - 1) )
                        , ( ind i j + levM (i - 1) (j - 1) ) ]
        ind i j
          -- 两个字符相等，则操作次数不做变化
          | a !! (i - 1) == b !! (j - 1) = 0
          -- 两个字符不相等，操作次数 +1
          | otherwise = 1

memoize = Memo.memo2 (Memo.integral) (Memo.integral)

main = print $ lev "mercury" "sylvester"
