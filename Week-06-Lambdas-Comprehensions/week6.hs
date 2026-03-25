import Data.List
-- Tasks from Exercise - Week 6
-- Task 1
-- а) от: f1 xs = length (filter even xs)
f1 :: [Int] -> Int
f1 = length . filter even
-- б) от: f2 xs = sum (map (*2) xs)
f2 :: [Int] -> Int
f2 = sum . map (*2)
-- в) от: f3 xs = reverse (map (+1) xs)
f3 :: [Int] -> [Int]
f3 = reverse . map (+1)
-- Task 2
squaresDiv3 :: Int -> [Int]
squaresDiv3 n = [x ^ 2 | x <- [1..n], mod (x ^ 2) 3 == 0]
sumPairs :: Int -> [(Int, Int)]
sumPairs n = [(x, y) | x <- [1..n], y <- [1..n], x + y == n] 
-- Task 3
quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = 
    quickSort [y | y <- xs, y <= x] ++ 
    [x] ++
    quickSort [y | y <- xs, y > x]
-- Task 4
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' xs ys = [x | x <- xs, x `elem` ys]
-- Task 5
histogram :: String -> [(Char, Int)]
histogram s =  [(c, count c) | c <- nub s]
    where 
        count c = length [x | x <- s, x == c]
-- #Bonus Task
divideInK :: Int -> Int -> [[Int]]
divideInK n k = groupK (intToList n) k

intToList :: Int -> [Int]
intToList x
    | x < 10 = [fromIntegral x]
    | otherwise = intToList (x `div` 10) ++ [fromIntegral (x `mod` 10)]

groupK :: [a] -> Int -> [[a]]
groupK [] _ = []
groupK xs k = take k xs : groupK (drop k xs) k

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 6
-- Task 1
    --print(f1 [1,2,3,4,5,6])
    --print(f2 [1,2,3])
    --print(f3 [1,2,3])
-- Task 2
    --print(squaresDiv3 15)
    --print(sumPairs 5)
-- Task 3
    --print(quickSort [5, 2, 8, 1, 4, 7, 3])
-- Task 4
    --print(intersect' [1,2,3,4] [3,4,5,6])
-- Task 5
    --print(histogram "hello")
-- #Bonus task
    --print(divideInK 123456 2)
    --print(divideInK 12345 3)