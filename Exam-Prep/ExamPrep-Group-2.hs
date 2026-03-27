import Data.List (nub)

-- Task 1
pack :: Eq a => [a] -> [[a]]
pack [] = []
pack (x:xs) = packHelper x [x] xs
    where
        packHelper current acc [] = [acc]
        packHelper current acc (y:ys)
            | y == current = packHelper current (acc ++ [y]) ys
            | otherwise = acc : packHelper y [y] ys
-- Task 2
myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x acc -> f x : acc) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p = foldr (\x acc -> if p x then x:acc else acc) []

myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []
-- Task 3
pythagoreanTriples :: Int -> [(Int, Int, Int)]
pythagoreanTriples n = [(a,b,c) | c <- [1..n], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]
-- Task 4
f :: [Int] -> Int
f = length . filter (>10) . map (*3)
-- Task 5
mostFrequent :: Ord a => [a] -> a
mostFrequent l = selectMax (histogram l)
    where
        selectMax [(c,_)] = c
        selectMax ((c,n):(d,m):rest)
        | n > m = selectMax ((c,n):rest)
        | n < m = selectMax ((d,m):rest)
        | otherwise = selectMax ((min c d, n):rest)

histogram l = [(c, count c) | c <- nub s]
    where 
        count c = length [x | x <- l, x == c]

-- Task 5
foldr (-) 0 [1,2,3] 
-- 1 - (2 - (3 - 0)) = 1 - (2 - 3) = 1 - (-1) = 2

foldl (-) 0 [1,2,3]
-- ((0 - 1) - 2) - 3 = (-1 - 2) - 3 = -3 - 3 = -6

-- Task 7
f1 :: Num a => a -> a -> a
f1 x y = x + y

f2 :: Num a => [a] -> [a]
f2 xs = map (+1) xs

f3 :: (a -> Bool) -> [a] -> [a]
f3 f xs = filter f xs

f4 :: (b -> c) -> (a -> b) -> a -> c
f4 f g x = f (g x)

main :: IO ()
main = do
    putStrLn "Start"