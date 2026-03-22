-- Tasks for Homework - Week 5
-- Task 1
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f l = foldr (\x acc -> (f x) : acc) [] l
filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr pred l = foldr (\x acc -> if pred x then x : acc else acc) [] l
-- Task 2
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
-- Task 3
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' pred (x:xs)
    | pred x = x : takeWhile' pred xs
    | otherwise = []
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' pred (x:xs) 
    | pred x = dropWhile' pred xs
    | otherwise = x : xs
-- Task 4
maximumBy' :: (a -> a -> Ordering) -> [a] -> a
maximumBy' _ [] = error "empty list"
maximumBy' cmp (x:xs) =
    foldr (\y acc -> if cmp y acc == GT then y else acc) x xs
-- Task 5
groupBy' :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy' _ [] = []
groupBy' f (x:xs) = (x : ys) : groupBy' f zs
    where
        ys = takeWhile (f x) xs
        zs = dropWhile (f x) xs
-- Task 6
any' :: (a -> Bool) -> [a] -> Bool
any' pred l = foldr (\x acc -> pred x || acc) False l
all' :: (a -> Bool) -> [a] -> Bool
all' pred l = foldr(\x acc -> pred x && acc) True l
-- Bonus Task
concatMap' :: (a -> [b]) -> [a] -> [b]
concatMap' f l = foldr (\x acc -> f x ++ acc) [] l

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework - Week 5
-- Task 1
    --print(mapFoldr (+1) [1,2,3,4])
    --print(filterFoldr even [1..10])
-- Task 2
    --print(zipWith' (+) [1,2,3] [10,20,30])
    --print(zipWith' max [1,5,3] [4,2,6])
-- Task 3
    --print(takeWhile' (<5) [1, 3, 5, 2, 4])
    --print(dropWhile' (<5) [1, 3, 5, 2, 4])
-- Task 4
    --print(maximumBy' compare [3, 1, 4, 1, 5])
    --print(maximumBy' (\x y -> compare (length x) (length y)) ["hi", "hello", "yo"])
-- Task 5
    print(groupBy' (==) [1,1,2,2,2,3,3,1])
    print(groupBy' (<) [1,3,5,2,4,6])
-- Task 6
    --print(any' even [1, 3, 5, 4])
    --print(all' even [2, 4, 6])
-- Bonus Task
    --print(concatMap' (\x -> [x, x*10]) [1, 2, 3])