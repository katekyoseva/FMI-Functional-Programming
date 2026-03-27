import Data.List (nub)
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
    | otherwise = 1 / (fromIntegral x * pow x (-k))

--Задача 22.10:
isExactPower :: Int -> Int -> Bool
isExactPower n k
    | n < 1 || k < 1 = False 
    | n == 1 = True
    | n `mod` k /= 0 = False
    | otherwise = isExactPower (n `div` k) k

-- Проста рекурсия над списъци
-- Задача 23.1:
myLen :: [a] -> Int
myLen [] = 0
myLen (_:xs) = 1 + myLen xs

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem target (x:xs) = target == x || myElem target xs

mySum :: [Double] -> Double
mySum [] = 0
mySum (x:xs) = x + mySum xs

-- Задача 23.2:
count :: Eq a => a -> [a] -> Int
count _ [] = 0
count el (x:xs) 
    | el == x = 1 + count el xs
    | otherwise = count el xs

-- Задача 23.3:
index :: Eq a => a -> [a] -> Int
index el list = helper el list 1
    where
        helper _ [] _ = -1
        helper el (x:xs) i
            | el == x = i
            | otherwise = helper el xs (i + 1)

-- Задача 23.4:
sublist :: Eq a => [a] -> [a] -> Bool
sublist [] _ = True
sublist (x:xs) l2 = elem x l2 && sublist xs l2

-- Задача 23.5:
common :: Eq a => [a] -> [a] -> Int
common l1 l2 = length (filter (`elem` l2) l1)

intersection l1 l2 = (filter (`elem` l2) l1)

-- Задача 23.6:
duplicates :: Eq a => [a] -> Bool 
duplicates [] = False
duplicates (x:xs) = x `elem` xs || duplicates xs

dup :: Eq a => [a] -> [a]
dup [] = []
dup l = [x | x <- nub l, count' x l > 1]
    where
        count' x = length . filter (== x)

-- Конструиране на списъци
-- Задача 24.1
evens :: Int -> [Int]
evens n = take n [0,2..]

arith :: Int -> Int -> Int -> [Int]
arith n a d = take n [a, a+d ..]

facts :: Int -> [Int]
facts n = map fact [1..n]
    where
        fact 0 = 1
        fact k = k * fact (k - 1)

allEvens :: [Int]
allEvens = [0,2..]

arithInf :: Int -> Int -> [Int]
arithInf a d = [a, a+d ..]

factsInf :: [Integer]
factsInf = scanl (*) 1 [1..]

-- Задача 24.2
digitsRev :: Int -> [Int]
digitsRev 0 = []
digitsRev n = n `mod` 10 : digitsRev (n `div` 10)

-- Задача 24.3
digitsRevUnique :: Int -> [Int]
digitsRevUnique = nub . digitsRev

digitsRevUnique' = removeConsecutive . digitsRev
removeConsecutive [] = []
removeConsecutive [x] = [x]
removeConsecutive (x:y:xs)
    | x == y    = removeConsecutive (y:xs)
    | otherwise = x : removeConsecutive (y:xs)

-- Задача 24.4
perfects :: Int -> [Int]
perfects n = [x | x <- [2..n], isPerfect x]
    where
        isPerfect x = sum (divisors x) == x
        divisors x = [d | d <- [1..x-1], x `mod` d == 0]

-- Задача 24.5
histogram :: String -> [(Char, Int)]
histogram s =  [(c, count c) | c <- nub s]
    where 
        count c = length [x | x <- s, x == c]

-- Работа със списъци и образци
-- Задача 25.2:
commonPrefix :: Eq a => [a] -> [a] -> Int
commonPrefix [] _ = 0
commonPrefix _ [] = 0
commonPrefix (x:xs) (y:ys)
    | x == y    = 1 + commonPrefix xs ys
    | otherwise = 0

-- Задача 25.3:
countEvenOddl :: [Int] -> (Int, Int)
countEvenOddl [] = (0, 0)
countEvenOddl (x:xs) 
    | even x    = (evens+1, odds)
    | otherwise = (evens, odds+1)
    where 
        (evens, odds) = countEvenOddl xs

-- Задача 25.4:
pivot :: Ord a => [a] -> a -> ([a], [a])
pivot [] _ = ([], [])
pivot (x:xs) p
    | x < p     = (x:l1, l2)
    | otherwise = (l1, x:l2)
    where
        (l1, l2) = pivot xs p

-- Задача 25.7:
pairs :: [Int] -> [(Int, Int)]
pairs [] = []
pairs [_] = []
pairs (x:y:xs)
    | x < y     = (x,y) : pairs (y:xs)
    | otherwise = pairs (y:xs)

-- Задача 25.8:
groupsof :: [a] -> Int -> [[a]]
groupsof [] _ = []
groupsof xs n = take n xs : groupsof (drop n xs) n

-- Задача 25.9:
flatten :: [[a]] -> [a]
flatten [] = []
--flatten (x:xs) = x ++ flatten xs
flatten l = concat l

-- Задача 25.10:
decode :: [(Int, a)] → [a]
decode [] = []
decode ((n,x):xs) = replicate n x ++ decode xs

-- Функции от по-висок ред
-- Задача 28.1:
myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : myMap f xs

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x:xs)
    | p x       = x : myFilter p xs
    | otherwise = myFilter p xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ acc [] = acc
myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

-- Задача 28.2:
sumTriples :: [(Int,Int,Int)] -> [Int]
sumTriples l = map (\(a,b,c) -> a+b+c) l1

sumComponents :: [(Int,Int,Int)] -> (Int,Int,Int)
sumComponents = foldr (\(a,b,c) (sa,sb,sc) -> (sa+a, sb+b, sc+c)) (0,0,0)

countCond :: [(Int,Int,Int)] -> Int
countCond = length . filter (\(a,b,c) -> a+b > c)

hasEqual :: [(Int,Int,Int)] -> Bool
hasEqual xs = or (map (\(a,b,c) -> a==b && b==c) xs)

matchIndex :: [Int] -> [Int]
matchIndex l = [x | (i,x) <- zip [1..] l, i == x]

pairSums :: [Int] -> [Int]
pairSums xs = map (uncurry (+)) (zip xs (tail xs))

isSorted :: [Int] -> Bool
isSorted xs = fst $ foldr step (True, maxBound) xs
    where
        step x (ok, prev) = (ok && x <= prev, x)

-- λ функции
dlin :: Double -> Double -> (Double -> Double)
dlin a1 a2 = \x -> if x <= 0 then a1*x else a2*x

rectfn :: Double -> Double -> Double -> (Double -> Double)
rectfn low high step = \x ->
    let k = floor (x / step)
    in if even k then low else high

createfn :: Eq a => [(a,b)] -> (a -> b)
createfn xs = \x -> head [b | (a,b) <- xs, a == x]

caseof :: [(a->Bool, a->b)] -> (a -> b)
caseof fs = \x ->
    case filter (\(p,_) -> p x) fs of
        ((_,f):_) -> f x
        []        -> snd (last fs) x

member :: Eq a => [a] -> (a -> Bool)
member xs = \x -> x `elem` xs

integrate :: (Double -> Double) -> Int -> Double -> Double -> Double
integrate f n a b =
    let h = (b - a) / fromIntegral n
        xs = [a + h * fromIntegral k | k <- [0..n]]
        ys = map f xs
    in h * ( (head ys + last ys)/2 + sum (init (tail ys)) )

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
-- Task 23.1
    --print (myLen [1,2,3,4,5,6])
    --print (myElem 1 [2,3,4,1])
    --print (mySum [1,2,3,4])
-- Task 23.2
    --print (count 3 [1, 2, 3, 4, 3, 3, 4])
-- Task 23.3
    --print (index 7 [1,2,7,3,2])
-- Task 23.4
    --print (sublist [1, 2] [1, 2, 3, 4])
-- Task 23.5
    --print (common [1, 2, 3] [1])
    --print (intersection [1, 2, 3, 4, 5] [1, 4, 5])
-- Task 23.6
    --print (duplicates [1, 2, 3, 3])
    --print (dup [1, 2, 3, 3, 4, 4, 4, 5 ,5])
-- Task 24.2
    --print (digitsRev 1234)
-- Task 24.3
    --print (digitsRevUnique 123444442222)
    --print (digitsRevUnique' 123444442222)
-- Task 24.4
    --print (perfects 10)
-- Task 24.5
    --print (histogram "abracadabra")
-- Task 25.9
    --print (flatten [[1], [2], [3], [4]])