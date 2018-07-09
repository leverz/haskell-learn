import Data.Heap (MinHeap, MaxHeap, empty, insert, view)

minHeapFromList :: [Int] -> MinHeap Int
minHeapFromList ls = foldr insert empty ls

maxHeapFromList :: [Int] -> MaxHeap Int
maxHeapFromList ls = foldr insert empty ls

main = do
  let myList = [11, 5, 3, 4, 8]
  let minHeap = minHeapFromList myList
  let maxHeap = maxHeapFromList myList
  print $ view minHeap
  print $ view maxHeap
