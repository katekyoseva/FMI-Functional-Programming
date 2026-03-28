import Data.List (nub)
-- Task 1
compress:: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:y:xs) 
    | x == y = compress (y:xs)
    | otherwise = x : compress (y:xs)
-- Task 2
countSignChanges :: [Int] -> Int
countSignChanges xs = snd $ foldl step (0,0) xs
    where
        step (prev, count) x
            | prev == 0 = (x, count)
            | x == 0    = (prev, count)
            | prev * x < 0 = (x, count + 1)
            | otherwise = (x, count)
-- Task 3
splitByPredicate :: (a -> Bool) -> [a] -> ([a], [a])
splitByPredicate p = foldr step ([],[])
    where
        step x (ts, fs)
            | p x       = (x:ts, fs)
            | otherwise = (ts, x:fs)
-- Task 4
countValid :: [Int] -> Int
countValid = length . filter (>=0) . map (\x -> x*x - 10)
-- Task 5
adjacentDiffs :: Num a => [a] -> [a]
adjacentDiffs [] = []
adjacentDiffs [_] = []
adjacentDiffs (x:y:xs) = (y - x) : adjacentDiffs (y:xs)
-- Task 6
frequency :: Eq a => [a] -> [(a, Int)]
frequency xs = [(x, count x xs) | x <- nub xs]
    where
        count c l = length [y | y <- l, y == c]
-- Task 7
findIndices :: (a -> Bool) -> [a] -> [Int]
findIndices p xs = helper xs 0
    where
        helper [] _ = []
        helper (x:xs) i
            | p x       = i : helper xs (i+1)
            | otherwise = helper xs (i+1)
-- Task 8
insertSorted :: Ord a => a -> [a] -> [a]
insertSorted x [] = [x]
insertSorted x (y:ys)
    | x <= y = x : y : ys
    | otherwise = y : insertSorted x ys
-- Task 9
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeLast :: [a] -> Maybe a
safeLast []     = Nothing
safeLast [x]    = Just x
safeLast (_:xs) = safeLast xs
-- Task 10
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

main :: IO ()
main = do
    print (rotate 2 [1, 2, 3, 4])