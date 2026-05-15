import Data.Char (isDigit, isUpper)
-- Tasks from Exercise - Week 9
-- Task 1
safeIndex :: [a] -> Int -> Maybe a
safeIndex [] _ = Nothing
safeIndex list index
    | index < 0 = Nothing 
    | index < (length list) = Just (list !! index)
    | otherwise = Nothing 
-- Task 2
safeMax :: Ord a => [a] -> Maybe a
safeMax [] = Nothing
safeMax list = Just (maximum list)
    
safeMin :: Ord a => [a] -> Maybe a
safeMin [] = Nothing
safeMin list = Just (minimum list)
-- Task 3
firstJust :: [Maybe a] -> Maybe a
firstJust [] = Nothing
firstJust (Just x:_) = Just x
firstJust (Nothing:xs) = firstJust xs
-- Task 4
validatePassword :: String -> Either String String
validatePassword pass
    | length pass < 8 = Left "Password is too short"
    | not (any isDigit pass) = Left "Password should contain at least one digit"
    | not (any isUpper pass) = Left "Password should contain at least one uppercase letter"
    | otherwise = Right pass
-- Task 5
chainMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
chainMaybe Nothing _ = Nothing
chainMaybe (Just x) f = f x

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 9
-- Task 1
    --print(safeIndex [10, 20, 30] 1)
    --print(safeIndex [10, 20, 30] 5)
    --print(safeIndex [10, 20, 30] (-1))
-- Task 2
    --print(safeMax [3, 1, 4, 1, 5])
    --print(safeMax ([] :: [Int]))
-- Task 3
    --print(firstJust [Nothing, Just 3, Nothing, Just 5])
    --print(firstJust [Nothing, Nothing] :: Maybe Int)
-- Task 4
    --print(validatePassword "abc")
    --print(validatePassword "abcdefgh")
    --print(validatePassword "Abcdefg1")
-- Task 5
    --print(chainMaybe (Just 10) (\x -> if x > 0 then Just (x * 2) else Nothing))
    --print(chainMaybe Nothing (\x -> Just (x * 2)))