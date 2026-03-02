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
    