import Data.List (delete)
-- Tasks from Exercise - Week 10
-- Task 1
andThenMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
andThenMaybe Nothing _  = Nothing
andThenMaybe (Just x) f = f x

andThenEither :: Either e a -> (a -> Either e b) -> Either e b
andThenEither (Left err) _ = Left err
andThenEither (Right x) f  = f x
-- Task 2
type FileSystem = [(String, Either String [(String, String)])]

safePath :: FileSystem -> [String] -> Maybe String
safePath _ [] = Nothing
safePath fs [name] = do
    entry <- lookup name fs
    case entry of
        Left content -> Just content
        Right _ -> Nothing
safePath fs (dir:rest) = do
    entry <- lookup dir fs
    case entry of
        Left _ -> Nothing
        Right subdirs -> do
            next <- lookup (head rest) subdirs
            safePath [(head rest, Left next)] (rest)
-- Task 3
collectResults :: [Maybe a] -> Maybe [a]
collectResults [] = Just []
collectResults (x:xs) = do
    y <- x
    ys <- collectResults xs
    return (y:ys)
-- Task 4
pythTriples :: Int -> [(Int, Int, Int)]
pythTriples n = do
    a <- [1..n]
    b <- [a..n]
    c <- [b..n]
    if a*a + b*b == c*c 
        then return (a, b, c) 
        else []

permutations' :: Eq a => [a] -> [[a]]
permutations' [] = [[]]
permutations' xs = do
    x <- xs
    rest <- permutations' (delete x xs)
    return (x : rest)
-- Task 5
type Pipeline a = [a -> Either String a]
runPipeline :: Pipeline a -> a -> Either String a
runPipeline [] x = Right x
runPipeline (f:fs) x = do
    res <- f x
    runPipeline fs res

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 10
-- Task 3
    --print(collectResults [Just 1, Just 2, Just 3])
    --print(collectResults [Just 1, Nothing, Just 3])
-- Task 4
    --print()
-- Task 5
    let pipe = [\x -> if x > 0 then Right (x * 2) else Left "negative"
            ,\x -> if x < 100 then Right (x + 1) else Left "too large"]
    --print(runPipeline pipe 5)
    --print(runPipeline pipe (-3))
    --print(runPipeline pipe 60)