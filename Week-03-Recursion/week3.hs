-- Tasks from Exercise - Week 3
-- Task 1
sumFirst :: Int -> Int
sumFirst n 
    | n <= 0 = 0
    | otherwise = n + sumFirst (n - 1)
-- Task 2
countDigits :: Int -> Int
countDigits n
    | n < 0 = countDigits (abs n)
    | n < 10 = 1
    | otherwise = 1 + countDigits (n `div` 10)
-- Task 3
isPrime :: Int -> Bool
isPrime n 
    | n <= 1 = False
    | otherwise = checkDiv 2
    where
        checkDiv d
            | d * d > n = True
            | n `mod` d == 0 = False
            | otherwise = checkDiv (d + 1)
-- Task 4
myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs
-- Task 5
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem el (x:xs) = el == x || myElem el xs

-- #Bonus Tasks
-- Task 1
isBalanced :: String -> Bool
isBalanced str = helper str 0

helper :: String -> Int -> Bool
helper [] counter = counter == 0
helper (x:xs) counter
    | counter < 0 = False
    | x == '(' = helper xs (counter + 1)
    | x == ')' = helper xs (counter - 1)
    | otherwise = helper xs counter
-- Task 2
merge :: [Int] -> [Int] -> [Int]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys
-- Task 3
compress:: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:y:xs) 
    | x == y = compress (y:xs)
    | otherwise = x : compress (y:xs)

main :: IO()
main = do
    putStrLn "Start"
-- Task 1
    --print(sumFirst 5)
-- Task 2
    --print(countDigits 123)
    --print(countDigits 0)
-- Task 3
    --print(isPrime 7)
    --print(isPrime 10)
-- Task 4
    --print(myLength [1, 2, 3, 4])
    --print(myLength [])
-- Task 5
    --print(myElem 3 [1, 2, 3, 4])
    --print(myElem 5 [1, 2, 3, 4])

-- Bonus Tasks
-- Task 1
    --print(isBalanced "(())()")
    --print(isBalanced "())(")
    --print(isBalanced "(()")
-- Task 2
    --print(merge [1, 4, 5] [2, 3, 6, 7])
    --print(merge [] [1, 2])
    --print(merge [] [])
-- Task 3
    --print(compress [1, 1, 2, 2, 2, 3, 1, 1])
    --print(compress "aaabbcca")