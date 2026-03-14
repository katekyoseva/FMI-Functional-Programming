-- Tasks for Homework 
-- Task 1
myAppend :: [a] -> [a] -> [a]
myAppend list [] = list
myAppend [] list = list
myAppend (x:xs) ys = x : myAppend xs ys
-- Task 2
rotateLeft :: Int -> [a] -> [a]
rotateLeft rotations l = drop rotations l ++ take rotations l
rotateRight :: Int -> [a] -> [a]
rotateRight rotations l = drop (length l - rotations) l ++ take (length l - rotations) l
-- Task 3
compress :: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:y:xs) 
    | x == y = compress (y:xs)
    | otherwise = x : compress (y:xs)
-- Task 4
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys
-- Task 5
removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs)
    | elem x xs = x : removeDuplicates (filter (/= x) xs)
    | otherwise = x : removeDuplicates xs
-- Task 6
isPrefixOf' :: Eq a => [a] -> [a] -> Bool
isPrefixOf' [] _ = True
isPrefixOf' _ [] = False
isPrefixOf' (x:xs) (y:ys) = x == y && isPrefixOf' xs ys

isInfixOf' :: Eq a => [a] -> [a] -> Bool
isInfixOf' [] _ = True
isInfixOf' _ [] = False
isInfixOf' l1 l2
    | isPrefixOf' l1 l2 = True
    | otherwise = isInfixOf' l1 (tail l2)

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework 
-- Task 1
    --print(myAppend [1,2] [3,4,5])
-- Task 2
    --print(rotateLeft 2 [1, 2, 3, 4, 5])
    --print(rotateRight 2 [1, 2, 3, 4, 5])
-- Task 3
    --print(compress [1,1,2,2,2,3,1,1])
    --print(compress "aaabbc")
-- Task 4
    --print(merge [1, 3, 5] [2, 4, 6])
-- Task 5
    --print(removeDuplicates [1, 3, 2, 1, 3, 4])
-- Task 6
    print(isInfixOf' [2, 3] [1, 2, 3, 4])
    print(isInfixOf' [2, 4] [1, 2, 3, 4])