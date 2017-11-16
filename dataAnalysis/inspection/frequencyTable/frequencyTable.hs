import Data.List (group, sort)

-- define a type for colors
data Color = Red | Green | Blue deriving (Show, Ord, Eq)

main :: IO ()
main = do
  let items = [Green, Green, Blue, Red, Green, Red, Green]
  -- group :: Eq a => [a] -> [[a]]
  -- group 将数组中连续相同的元素，集合到一个数组中，最后把这些集合放到数组中
  -- sort 函数会将 数组 元素按照大小排序，因为 Color 继承了 Ord，所以 Red < Green < Blue，这一步耗费的资源比较多
  let freq = map (\x -> (head x, length x)) $ group $ sort items
  print freq
