-- Tasks for Homework - Week 9
-- Task 1
catMaybes' :: [Maybe a] -> [a]
catMaybes' [] = []
catMaybes' (Just x : xs) = x : catMaybes' xs
catMaybes' (Nothing : xs) = catMaybes' xs

mapMaybe'  :: (a -> Maybe b) -> [a] -> [b]
mapMaybe' _ [] = []
mapMaybe' f (x:xs) =
    case f x of
        Just y -> y : mapMaybe' f xs
        Nothing -> mapMaybe' f xs
-- Task 2
lookupOne :: Eq a => a -> [(a,b)] -> Maybe b
lookupOne _ [] = Nothing
lookupOne k ((x,v):xs)
    | k == x = Just v
    | otherwise = lookupOne k xs

lookupAll :: Eq a => [a] -> [(a, b)] -> [Maybe b]
lookupAll keys table = map (`lookupOne` table) keys

lookupAllOrDefault :: Eq a => b -> [a] -> [(a, b)] -> [b]
lookupAllOrDefault def keys table =
    map (\k -> maybe def id (lookupOne k table)) keys
-- Task 3
data CalcExpr = Num Double
            | Plus CalcExpr CalcExpr
            | Minus CalcExpr CalcExpr
            | Times CalcExpr CalcExpr
            | Divide CalcExpr CalcExpr
            | Sqrt CalcExpr

evalCalc :: CalcExpr -> Either String Double
evalCalc (Num x) = Right x

evalCalc (Plus a b) =
    case (evalCalc a, evalCalc b) of
        (Right x, Right y) -> Right (x + y)
        (Left e, _) -> Left e
        (_, Left e) -> Left e

evalCalc (Minus a b) =
    case (evalCalc a, evalCalc b) of
        (Right x, Right y) -> Right (x - y)
        (Left e, _) -> Left e
        (_, Left e) -> Left e

evalCalc (Times a b) =
    case (evalCalc a, evalCalc b) of
        (Right x, Right y) -> Right (x * y)
        (Left e, _) -> Left e
        (_, Left e) -> Left e

evalCalc (Divide a b) =
    case (evalCalc a, evalCalc b) of
        (Right _, Right 0) -> Left "Division by zero"
        (Right x, Right y) -> Right (x / y)
        (Left e, _) -> Left e
        (_, Left e) -> Left e

evalCalc (Sqrt x) =
    case evalCalc x of
        Right v | v < 0 -> Left "Square root of negative number"
                | otherwise -> Right (sqrt v)
        Left e -> Left e
-- Task 4
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x

traverse' :: (a -> Maybe b) -> [a] -> Maybe [b]
traverse' _ [] = Just []
traverse' f (x:xs) =
    case (f x, traverse' f xs) of
        (Just y, Just ys) -> Just (y:ys)
        _ -> Nothing
-- Task 5
type PhoneBook = [(String, String)]

findPhone :: String -> PhoneBook -> Maybe String
findPhone name [] = Nothing
findPhone name ((n,p):xs)
    | name == n = Just p
    | otherwise = findPhone name xs

addEntry :: String -> String -> PhoneBook -> Either String PhoneBook
addEntry name phone pb =
    case findPhone name pb of
        Just _  -> Left ("Record already existing: " ++ name)
        Nothing -> Right ((name, phone) : pb)

removeEntry :: String -> PhoneBook -> Either String PhoneBook
removeEntry name pb =
    if any (\(n,_) -> n == name) pb
        then Right (filter (\(n,_) -> n /= name) pb)
        else Left ("There is no such record: " ++ name)

updatePhone :: String -> String -> PhoneBook -> Either String PhoneBook
updatePhone name phone pb =
    if any (\(n,_) -> n == name) pb
        then Right (map (\(n,p) -> if n == name then (n,phone) else (n,p)) pb)
        else Left ("Record not found: " ++ name)
-- Bonus Task
sequence' :: [Maybe a] -> Maybe [a]
sequence' [] = Just []
sequence' (x:xs) =
    case (x, sequence' xs) of
        (Just v, Just vs) -> Just (v:vs)
        _ -> Nothing

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework - Week 9
-- Task 1
    --print(catMaybes' [Just 1, Nothing, Just 3])
    --print(mapMaybe' (\x -> if even x then Just (x `div` 2) else Nothing) [1..6])
-- Task 2
    --print(lookupAll ["a","b","c"] [("a",1),("c",3)])
    --print(lookupAllOrDefault 0 ["a","b","c"] [("a",1),("c",3)])
-- Task 3
    --print(evalCalc (Divide (Num 10) (Num 0)))
    --print(evalCalc (Sqrt (Num (-4))))
    --print(evalCalc (Plus (Num 3) (Sqrt (Num 16))))
-- Task 4
    --print(traverse' safeHead [[1,2], [3,4], [5,6]])
    --print(traverse' safeHead [[1,2], [], [5,6]])
-- Task 5
    --let pb = [("Ivan", "0888123"), ("Maria", "0899456")]
    --print(findPhone "Ivan" pb)
    --print(addEntry "Ivan" "111" pb)
    --print(removeEntry "Pesho" pb)
-- Bonus Task
    --print(sequence' [Just 1, Just 2, Just 3])
    --print(sequence' [Just 1, Nothing, Just 3])