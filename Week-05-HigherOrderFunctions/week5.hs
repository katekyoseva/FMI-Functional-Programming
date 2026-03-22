-- Tasks from Exercise - Week 5
-- Task 1
myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : myMap f xs
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter pred [] = []
myFilter pred (x:xs) 
    | pred x = x : myFilter pred xs
    | otherwise = myFilter pred xs
-- Task 2
applyAll :: [a -> a] -> a -> a
applyAll fs x = foldr (\f acc -> f acc) x fs
-- Task 3
countBy :: (a -> Bool) -> [a] -> Int
countBy pred list = length (filter pred list)
countBy' :: (a -> Bool) -> [a] -> Int
countBy' pred = foldr (\x acc -> if pred x then acc + 1 else acc) 0
-- Task 4
sumFoldr :: Num a => [a] -> a
sumFoldr = foldr (+) 0
lengthFoldr :: [a] -> Int
lengthFoldr = foldr (\_ acc -> acc + 1) 0
reverseFoldl :: [a] -> [a]
reverseFoldl =  foldl (flip(:)) []
-- Task 5
partition' :: (a -> Bool) -> [a] -> ([a], [a])
partition' _ [] = ([], [])
partition' pred (x:xs)
    | pred x = (x:l, r)
    | otherwise = (l, x:r)
    where
        (l, r) = partition' pred xs

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 5
-- Task 1
    --print(myMap (+1) [1,2,3,4])
    --print(myMap length ["hi","haskell","abc"])
    --print(myMap even [1,2,3,4])
    --print(myFilter even [1,2,3,4,5,6])
    --print(myFilter (>3) [1,5,2,7,3])
    --print(myFilter (\x -> x `mod` 3 == 0) [3,4,6,7,9])
-- Task 2
    --print(applyAll [(+1), (*2), (+3)] 5)
-- Task 3
    --print(countBy even [1..10])
    --print(countBy' even [1..10])
    --print(countBy (> 3) [1, 5, 2, 8, 3])
    --print(countBy' (> 3) [1, 5, 2, 8, 3])
-- Task 4
    --print(sumFoldr [1,2,3,4])
    --print(lengthFoldr [1,2,3])
    --print(reverseFoldl [1,2,3,4])
-- Task 5
    --print(partition' even [1..10])