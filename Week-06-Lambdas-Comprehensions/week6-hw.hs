import Data.List (transpose)
import Data.List (permutations)
import Data.List (sortOn)
-- Tasks for Homework - Week 6
-- Task 1
primes :: Int -> [Int]
primes n = [x | x <- [2..n], null [d | d <- [2..x-1], x `mod` d == 0]]
-- Task 2
encode :: Eq a => [a] -> [(Int, a)]
encode [] = []
encode (x:xs) = (1 + length (takeWhile (== x) xs), x)
                : encode (dropWhile (== x) xs)
decode :: [(Int, a)] -> [a]
decode [] = []
decode ((n, x):xs) = replicate n x ++ decode xs
-- Task 3
type Matrix = [[Int]]
matrixMultiply :: Matrix -> Matrix -> Matrix
matrixMultiply a b =
    [ [ sum (zipWith (*) row col) | col <- transpose b ]
    | row <- a ]
-- Task 4
nQueens :: Int -> [[Int]]
nQueens n = [ qs | qs <- permutations [1..n] , safe qs]

safe :: [Int] -> Bool
safe qs =
    and [ abs (qi - qj) /= abs (i - j) 
        | (i, qi) <- zip [1..] qs, (j, qj) <- zip [1..] qs 
        , i < j
        ]
-- Task 5
crossword :: [String] -> Char -> [(String, String)]
crossword words c =[ (w1, w2) | w1 <- words , w2 <- words
        , w1 < w2, c `elem` w1 , c `elem` w2]
-- Bonus Task
subsequences' :: [a] -> [[a]]
subsequences' [] = [[]]
subsequences' (x:xs) =
    sortOn length (map (x:) rest ++ rest)
    where
        rest = subsequences' xs

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework - Week 6
-- Task 1
    --print(primes 30)
-- Task 2
    --print(encode "aaabbcccc")
    --print(decode [(3,'a'),(2,'b'),(4,'c')])
-- Task 3
    --print(matrixMultiply [[1,2],[3,4]] [[5,6],[7,8]])
-- Task 4
    --print(length (nQueens 8))
    --print(head (nQueens 4))
-- Task 5
    --print(crossword ["hello", "world", "haskell", "loop"] 'l')
-- Bonus Task
    --print(subsequences' [1, 2, 3])