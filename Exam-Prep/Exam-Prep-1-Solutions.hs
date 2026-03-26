-- Task 1
incrementAllBy :: [Int] -> Int -> [Int]
incrementAllBy l incr = map (\x -> x + incr) l
-- Task 2
multiplyAllBy :: [Int] -> Int -> [Int]
multiplyAllBy l n = map (\x -> x * n) l
-- Task 3
filterSmallerThan :: [Int] -> Int -> [Int]
filterSmallerThan l n = filter (\x -> x >= n) l
-- Task 4
isAscending :: Integer -> Bool
isAscending n = isSorted (intToList n)

intToList :: Integer -> [Int]
intToList x
    | x < 10 = [fromIntegral x]
    | otherwise = intToList (x `div` 10) ++ [fromIntegral (x `mod` 10)]

isSorted :: [Int] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:xs) = x <= y && isSorted (y:xs)
-- Task 5
digits :: String -> String
digits = filter (\c -> c >= '0' && c <= '9')
-- Task 6
digitsSum :: String -> Int
digitsSum s = foldr (\c acc -> 
    if c >= '0' && c <= '9'
    then (fromEnum c - fromEnum '0') + acc
    else acc) 0 s
-- Task 7
capitalize :: String -> String
capitalize s = map (\c -> 
    if c >= 'a' && c <= 'z'
    then toEnum(fromEnum c - (fromEnum 'a' - fromEnum 'A'))
    else c) s
-- Task 8
isCapitalized :: String -> Bool
isCapitalized s = foldr (\c acc -> (not (isLetter c) || isUpper c) && acc) True s
    where
        isLetter c = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
        isUpper c  = (c >= 'A' && c <= 'Z')
-- Task 9
prodSumDiv :: [Integer] -> Integer -> Integer
prodSumDiv xs k = product (filter (\x -> sumDiv x `mod` k == 0) xs)
    where
        sumDiv n = sum [d | d <- [1..n], n `mod` d == 0]
-- Task 10
toDigits :: Int -> [Int]
toDigits 0 = []
toDigits n =  toDigits (n `div` 10 ) ++ [n`mod`10]

fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits l = foldl (\acc x -> acc * 10 + x) 0 l

sortDigits :: Int -> Int
sortDigits n = fromDigits $ sortedEvens ++ sortedOdds
    where
        digits = toDigits n
        evens = filter even digits
        odds = filter odd digits
        sortedEvens = sortBy' (<) evens
        sortedOdds = sortBy' (>) odds

sortBy' :: (a -> a -> Bool) -> [a] -> [a]
sortBy' _ [] = []
sortBy' cmp (x:xs) = insert x (sortBy' cmp xs)
    where
        insert x [] = [x]
        insert x (y:ys)
            | cmp x y  = x : y : ys
            | otherwise = y : insert x ys

-- Task 11
students :: [(String,Int,[(String,Double)])] =
        [("Ivan",42424,[("fp",6),("oop",6),("dis",5)]),
        ("Maria",757575,[("fp",6),("oop",5),("dis",6)]),
        ("Petyr",2424,[("fp",6),("fp",5),("oop",5),("oop",6)])]

avgGrade :: String -> [(String, Int, [(String, Double)])] -> Double
avgGrade subj students = 
    let grades = allGrades students
        onlys = getOnlySubj subj grades 
        marks = justMarks onlys
    in avg marks

allGrades st = concat(map(\(_,_,grades) -> grades) st)

getOnlySubj target grades = filter(\(subj, _) -> subj == target) grades 

justMarks subjGrades = map (\(_, grades) -> grades) subjGrades

avg grades 
    | null grades = 0
    | otherwise = sum grades / fromIntegral (length grades)
-- Task 12
needToExamine :: String -> [(String,Int,[(String,Double)])] -> [String]
needToExamine subj ss = map (\(f,_,_)->f) $ filter (\stud->not $ elem subj (subjectforstudent stud)) ss
    where
        subjectforstudent (_,_,gs) = map fst gs

main :: IO ()
main = do
    putStrLn "Start"
-- Task 1
    --print(incrementAllBy [1,2,3] 2)
    --print(incrementAllBy [10,20,30] 5)
    --print(incrementAllBy [] 3)
-- Task 2
    --print(multiplyAllBy [1,2,3] 2)
    --print(multiplyAllBy [5,10] 3)
    --print(multiplyAllBy [] 4)
-- Task 3
    --print(filterSmallerThan [1,5,8,2,10] 5)
    --print(filterSmallerThan [3,4,5] 4)
    --print(filterSmallerThan [1,2,3] 10)
-- Task 4
    --print(isAscending 1234)
    --print(isAscending 987)
-- Task 5
    --print(digits "abc123")
    --print(digits "no digits here")
-- Task 6
    --print(digitsSum "abc123")
    --print(digitsSum "a1b2c3")
    --print(digitsSum "2026")
    --print(digitsSum "hello")
-- Task 7
    --print(capitalize "hello")
    --print(capitalize "Hello World")
    --print(capitalize "abc123")
-- Task 8
    --print(isCapitalized "HELLO")
    --print(isCapitalized "HELLO123")
    --print(isCapitalized "Hello")
    --print(isCapitalized "")
-- Task 9
    --print(prodSumDiv [6, 10, 3] 4)
    --print(prodSumDiv [4, 5, 8] 3)
-- Task 10
    --print(sortDigits 123456)
-- Task 11
    --print(avgGrade "fp" students)
-- Task 12
    --print(needToExamine "dis" students)
