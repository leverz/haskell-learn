import System.Mem.StableName

data Point = Point [Int]

main = do
  let p1 = Point [1..]
  let p2 = Point [2,4]
  sn1 <- makeStableName p1
  sn2 <- makeStableName p2
  sn3 <- makeStableName p1
  print $ hashStableName sn1
  print $ hashStableName sn2
  print $ hashStableName sn3
