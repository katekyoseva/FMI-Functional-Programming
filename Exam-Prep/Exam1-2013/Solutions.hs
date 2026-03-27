-- A
-- Task 1
max-ord :: [Int] -> Int
max-ord [] = 0
max-ord [_] = 1
max-ord (x:y:xs)
    | x <= y = 1 + maxOrd (y:xs)
    | otherwise = 1
-- Task 2
countSq :: [Int] -> [Int] -> Int
countSq l1 l2 = length [x | x <- l1, x*x `elem` l2]
-- Task 3
least :: [(String, Int)] -> [String]
least xs = [name | (name, qty) <- xs, qty == minQty]
    where
        minQty = findMin xs

findMin :: [(String, Int)] -> Int
findMin [( _, q)] = q
findMin ((_,q):xs) = min q (findMin xs)
-- Task 4
prod :: Int -> Int -> Int -> Int
prod a b k = product [x | x <- [a..b], x `mod` k == 0]
-- Task 5
reverseOrdSuff :: Int -> Int
reverseOrdSuff n = digitsToNum (reverse suffix)
    where
        ds = reverse (toDigits n)
        suffix = takeDesc ds

takeDesc :: [Int] -> [Int]
takeDesc [] = []
takeDesc [x] = [x]
takeDesc (x:y:xs)
    | x >= y    = x : takeDesc (y:xs)
    | otherwise = [x]

toDigits :: Int -> [Int]
toDigits 0 = []
toDigits n = toDigits (n `div` 10) ++ [n `mod` 10]

digitsToNum :: [Int] -> Int
digitsToNum = foldl (\acc x -> acc*10 + x) 0

-- B
-- Task 1
maxConsec :: [Int] -> Int
maxConsec [] = 0
maxConsec [_] = 1
maxConsec (x:y:xs)
    | y == x + 1 = 1 + maxConsec (y:xs)
    | otherwise  = 1
-- Task 2
singletons :: [Int] -> [Int] -> [Int]
singletons l1 l2 = [x | x <- l1, count x l2 == 1]
    where
        count x xs = length [y | y <- xs, y == x]
-- Task 3
trickiest' :: [(String, Int)] -> [String]
trickiest' xs = [name | (name, pts) <- xs, pts == maxPts]
    where
        maxPts = findMax' xs

findMax' :: [(String, Int)] -> Int
findMax' [( _, p)] = p
findMax' ((_,p):xs) = max p (findMax' xs)
-- Task 4
prod' :: Int -> Int -> Int -> Int
prod' a b k = product [x | x <- [a..b], k `mod` x == 0]
-- Task 5
reverseOrdSuff' :: Int -> Int
reverseOrdSuff' n = digitsToNum (reverse suffix)
    where
        ds = reverse (toDigits n)
        suffix = takeAsc' ds

takeAsc' :: [Int] -> [Int]
takeAsc' [] = []
takeAsc' [x] = [x]
takeAsc' (x:y:xs)
    | x <= y    = x : takeAsc' (y:xs)
    | otherwise = [x]

toDigits' :: Int -> [Int]
toDigits' 0 = []
toDigits' n = toDigits' (n `div` 10) ++ [n `mod` 10]

digitsToNum' :: [Int] -> Int
digitsToNum' = foldl (\acc x -> acc*10 + x) 0

main :: IO ()
main = do
    putStrLn "Start"