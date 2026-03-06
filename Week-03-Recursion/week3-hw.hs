-- Tasks for Homework 
-- Task 1
digitSum :: Int -> Int
digitSum 0 = 0
digitSum x = (x `mod` 10) + digitSum (x `div` 10)
-- Task 2
toBinary :: Int -> [Int]
toBinary 0 = [0]
toBinary x = helper x

helper :: Int -> [Int]
helper 0 = []
helper x = helper (x `div` 2) ++ [x `mod` 2]
-- Task 3
fibonacci :: Int -> Int
fibonacci n = fibHelper n 0 1

fibHelper :: Int -> Int -> Int -> Int
fibHelper 0 a _ = a
fibHelper n a b = fibHelper (n - 1) b (a + b)
-- Task 4
isPalindrome :: Int -> Bool
isPalindrome n = n == reverseNum n

reverseNum :: Int -> Int
reverseNum n = helperRev (abs n) 0

helperRev :: Int -> Int -> Int
helperRev 0 acc = acc
helperRev n acc = helperRev (n `div` 10) (acc * 10 + n `mod` 10)
-- Task 5
sumDivisors :: Int -> Int
sumDivisors n = helperDiv n 1

helperDiv :: Int -> Int -> Int
helperDiv n divisor
    | divisor > n = 0
    | n `mod` divisor == 0 = divisor + helperDiv n (divisor + 1)
    | otherwise = helperDiv n (divisor + 1)
-- Task 6
isPerfect :: Int -> Bool
isPerfect x = x == sumDivisors x - x
-- Task 7
horner :: [Double] -> Double -> Double
horner [] _ = 0
horner coefficient x = hornerHelper (reverse coefficient) x 0
    where
        hornerHelper [] _ acc = acc
        hornerHelper (a:as) x acc = hornerHelper as x (a + x * acc)

main :: IO()
main = do
    putStrLn "Start"
-- Task 1
    --print(digitSum 123)
    --print(digitSum 9999)
-- Task 2
    --print(toBinary 13)
    --print(toBinary 0)
-- Task 3
    --print(fibonacci 10)
    --print(fibonacci 30)
-- Task 4
    --print(isPalindrome 12321)
    --print(isPalindrome 123)
-- Task 5
    --print(sumDivisors 12)
    --print(sumDivisors 7)
-- Task 6
    --print(isPerfect 6)
    --print(isPerfect 28)
    --print(isPerfect 12)
-- Task 7
    --print(horner [1, 2, 3] 2)
