import Data.Char (isDigit)
-- Tasks for Homework - Week 10
-- Task 1
mapM' :: (a -> Maybe b) -> [a] -> Maybe [b]
mapM' _ [] = Just []
mapM' f (x:xs) = do
    res  <- f x
    rest <- mapM' f xs
    return (res : rest)

forM' :: [a] -> (a -> Maybe b) -> Maybe [b]
forM' = flip mapM'
-- Task 2
filterM' :: (a -> Maybe Bool) -> [a] -> Maybe [a]
filterM' _ [] = Just []
filterM' p (x:xs) = do
    keep <- p x
    rest <- filterM' p xs
    if keep then return (x : rest) else return rest
-- Task 3
type State s a = s -> Maybe (a, s)

get :: State s s
get = \s -> Just (s, s)

put :: s -> State s ()
put s = \_ -> Just ((), s)

modify :: (s -> s) -> State s ()
modify f = \s -> Just ((), f s)

runState :: State s a -> s -> Maybe (a, s)
runState m s = m s

counter :: State Int [Int]
counter s = do 
    (_, s1) <- modify (+1) s
    (v1, s2) <- get s1
    (_, s3) <- modify (+1) s2
    (v2, s4) <- get s3
    return ([v1, v2], s4)
-- Task 4
data Token = TNum Double 
            | TPlus 
            | TMinus 
            | TMul 
            | TDiv 
            | TLParen 
            | TRParen
    deriving (Show)

tokenize :: String -> Either String [Token]
tokenize [] = Right []
tokenize (c:cs)
    | c == ' ' = tokenize cs
    | c == '+' = fmap (TPlus :) (tokenize cs)
    | c == '-' = fmap (TMinus :) (tokenize cs)
    | c == '*' = fmap (TMul :) (tokenize cs)
    | c == '/' = fmap (TDiv :) (tokenize cs)
    | c == '(' = fmap (TLParen :) (tokenize cs)
    | c == ')' = fmap (TRParen :) (tokenize cs)
    | isDigit c || c == '.' = 
        let (numStr, rest) = span (\x -> isDigit x || x == '.') (c:cs)
        in fmap (TNum (read numStr) :) (tokenize rest)
    | otherwise = Left ("Unexpected symbol: '" ++ [c] ++ "'")
-- Task 5
type Writer w a = (a, [w])

tell :: w -> Writer w ()
tell msg = ((), [msg])

writerBind :: Writer w a -> (a -> Writer w b) -> Writer w b
writerBind (a, log1) f = 
    let (b, log2) = f a 
    in (b, log1 ++ log2)

wReturn :: a -> Writer w a
wReturn x = (x, [])

factWithLog :: Int -> Writer String Int
factWithLog 1 = (1, ["1 = 1"])
factWithLog n = 
    let (res, logs) = factWithLog (n-1)
        currentLog = show n ++ " * fact(" ++ show (n-1) ++ ")"
    in (n * res, currentLog : logs)
-- Bonus Task
powerset :: [a] -> [[a]]
powerset [] = [[]]
powerset (x:xs) = do
    include <- [False, True]
    rest <- powerset xs
    if include 
        then return (x : rest) 
        else return rest

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework - Week 10
-- Task 1
    --print(mapM' (\x -> if even x then Just (x `div` 2) else Nothing) [2, 4, 6])
    --print(mapM' (\x -> if even x then Just (x `div` 2) else Nothing) [2, 3, 6])
-- Task 2
    --print(filterM' (\x -> if x > 0 then Just (even x) else Nothing) [2, 4, 3, 6])
    --print(filterM' (\x -> if x > 0 then Just (even x) else Nothing) [2, -1, 6])
-- Task 4
    --print(tokenize "3 + 4.5 * (2 - 1)")
    --print(tokenize "3 + @ 4")
-- Task 5
    --print(factWithLog 5)
-- Bonus Task
    --print(powerset [1,2,3])