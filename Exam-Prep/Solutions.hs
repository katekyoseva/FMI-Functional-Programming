--Уводни задачи
--Задача 22.3:
devisibleBy4or7 :: Int -> Bool -- а
devisibleBy4or7 p = p `mod` 4 == 0 || p `mod` 7 == 0

realSolutions :: Int -> Int -> Int -> Bool -- б
realSolutions a b c = 
    let discrinante = b ^ 2 - 4 * a * c
    in discrinante < 0
    
inCircle :: (Double, Double) -> Bool -- в
inCircle (x,y) = x*x + (y - 1)^2 < 25

inCircle' :: (Double, Double) -> (Double, Double) -> Double -> Bool -- г
inCircle' (a,b) (c,d) r = (a-c)^2 + (b - d)^2 < r^2

inCircle'' ::(Double, Double) -> Bool -- г
inCircle'' (x,y) = x^2 + y^2 < 25 && x < 0 && y < 0

inAnnulus :: (Double,Double) -> Bool -- д
inAnnulus (x,y) =
    let d = x*x + y*y
    in d >= 25 && d <= 100

inInterval :: Double -> Bool -- е
inInterval x = x >= 0 && x <= 1

mid (a, b, c) = max a (min b c)
isMax :: Double -> (Double, Double, Double) -> Bool -- ж
isMax x (a,b,c) = x == max a (max b c)

notMax :: Double -> (Double, Double, Double) -> Bool -- з
notMax x (a,b,c) = x /= max a (max b c)

negative :: Int -> Int -> Int -> Bool -- и
negative a b c = a <= 0 && b <= 0 && c <= 0

contains7 :: Int -> Bool -- к
contains7 0 = False
contains7 n 
    | n `mod` 10 == 7 = True
    | otherwise = contains7 (n `div` 10)

diffDigits :: Int -> Bool -- л
diffDigits num = noDuplicates (intToList num)

intToList :: Int -> [Int]
intToList x 
    | x < 10 = [fromIntegral x]
    | otherwise = intToList (x `div` 10) ++ [fromIntegral (x `mod` 10)]

noDuplicates :: [Int] -> Bool
noDuplicates [] = True
noDuplicates (x:xs) = not (x `elem` xs) && noDuplicates xs

sameDigits :: Int -> Bool -- м
sameDigits num = hasDuplicates (intToList num)

hasDuplicates :: [Int] -> Bool 
hasDuplicates [] = False
hasDuplicates (x:xs) = x `elem` xs || hasDuplicates xs

isInOrder :: Int -> Bool -- н
isInOrder x =
    let ds = intToList x
    in strictlyIncreasing ds || strictlyDecreasing ds

strictlyIncreasing :: [Int] -> Bool
strictlyIncreasing xs = and [a < b | (a,b) <- zip xs (tail xs)]

strictlyDecreasing :: [Int] -> Bool
strictlyDecreasing xs = and [a > b | (a,b) <- zip xs (tail xs)]

isPalindrome :: Int -> Bool -- о
isPalindrome num = intToList num == reverse (intToList num)

isPrimeSmallerThan23 :: Int -> Bool -- п
isPrimeSmallerThan23 x = x < 23 && isPrime x

isPrime :: Int -> Bool
isPrime n 
    | n <= 1 = False
    | otherwise = checkDiv 2
    where
        checkDiv d
            | d * d > n = True
            | n `mod` d == 0 = False
            | otherwise = checkDiv (d + 1)

--Задача 22.4:
countDigits :: Int -> Int
countDigits n
    | num < 10 = 1
    | otherwise = 1 + countDigits (num `div` 10)
    where num = (abs n)

--Задача 22.5:
sumDigits :: Int -> Int
sumDigits 0 = 0
sumDigits n = n `mod` 10 + sumDigits (n `div` 10)
sumDigits' :: Int -> Int
sumDigits' n = sum (intToList n)

--Задача 22.6:
pow :: Int -> Int -> Double
pow x 0 = 1
pow x k 
    | k > 0 = fromIntegral x * pow x (k-1)
    | otherwise =   1 / (fromIntegral x * pow x (-k))

--Задача 22.10:
isExactPower :: Int -> Int -> Bool
isExactPower n k
    | n < 1 || k < 1 = False 
    | n == 1 = True
    | n `mod` k /= 0 = False
    | otherwise = isExactPower (n `div` k) k

main :: IO ()
main = do
    putStrLn "Start"
-- Task 22.3
    --print(devisibleBy4or7 1)
    --print(realSolutions 1 1 (-1))
    --print (inCircle (9, 1))
    --print (inCircle' (1,1) (0,1) 5)
    --print (inCircle'' (-1, -1))
    --print (inAnnulus (3, 4))
    --print (inInterval 0.5)
    --print (isMax 3 (1,2,3))
    --print (notMax 3 (1,2,3))
    --print (negative (-1) (12) (-3))
    --print (contains7 178)
    --print (diffDigits 12344)
    --print (sameDigits 1234)
    --print (isInOrder 54321)
    --print (isPalindrome 123321)
    --print (isPrimeSmallerThan23 12)
-- Task 22.4
    --print (countDigits 12345)
-- Task 22.5
    --print (sumDigits 123)
    --print (sumDigits' 123)
-- Task 22.6
    --print (pow 2 (-1))
-- Task 22.10
    --print (isExactPower 32 2)