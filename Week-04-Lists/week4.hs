-- Tasks from Exercise - Week 4
-- Task 1
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]
-- Task 2
myZip :: [a] -> [b] -> [(a, b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x, y) : (myZip xs ys)
-- Task 3
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs
-- Task 4
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:xs) =  x <= y && isSorted (y:xs)
-- Task 5
removeAt :: Int -> [a] -> [a]
removeAt _ [] = []
removeAt 0 (_:xs) = xs
removeAt index (x:xs) = x : removeAt (index - 1) xs

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 4
-- Task 1
    --print(myReverse [1, 2, 3])
-- Task 2
    --print(myZip [1, 2] ["a", "b", "c"])
-- Task 3
    --print(myConcat [[1,2], [3], [4,5]])
-- Task 4
    --print(isSorted [1, 3, 5])
    --print(isSorted [1, 5, 3])
-- Task 5
    --print(removeAt 1 [1, 2, 3, 4])