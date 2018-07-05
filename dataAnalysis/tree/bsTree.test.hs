import BSTree

someTree :: Tree Int
someTree = root
  where root = Node 0 n1 n4
        n1   = Node 1 n2 n3
        n2   = Node 2 Null Null
        n3   = Node 3 Null Null
        n4   = Node 4 Null Null

main = do
  let tree = single 5
  let nodes = [6,4,8,2,9]
  let bst = foldl insert tree nodes
  print bst
  print $ find bst 1
  print $ find bst 2
  print $ valid bst
  print $ valid someTree
