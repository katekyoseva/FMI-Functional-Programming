-- Task 1
data Expr
    = Num Double
    | Add Expr Expr
    | Mul Expr Expr
    | Neg Expr

eval :: Expr -> Double
eval (Num x) = x
eval (Add a b) = eval a + eval b
eval (Mul a b) = eval a * eval b
eval (Neg x) = - (eval x)

prettyPrint :: Expr -> String
prettyPrint (Num x)   = show x
prettyPrint (Add a b) = "(" ++ prettyPrint a ++ " + " ++ prettyPrint b ++ ")"
prettyPrint (Mul a b) = "(" ++ prettyPrint a ++ " * " ++ prettyPrint b ++ ")"
prettyPrint (Neg x)   = "(-" ++ prettyPrint x ++ ")"
-- Task 2
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeOps :: [Int] -> Maybe Int
safeOps xs = do
    x <- safeHead xs
    if x <= 0 then Nothing else do
        if x == 0 then Nothing else Just (100 `div` x)
-- Task 3
class Serializable a where
    serialize :: a -> String
    deserialize :: String -> Maybe a

instance Serializable Int where
    serialize = show
    deserialize s = 
        case reads s of
        [(x, "")] -> Just x
        _ -> Nothing

instance Serializable Bool where
    serialize = show
    deserialize "True"  = Just True
    deserialize "False" = Just False
    deserialize _ = Nothing

instance Serializable a => Serializable [a] where
    serialize xs = show (map serialize xs)
    deserialize s = case reads s of
        [(xs, "")] -> mapM deserialize xs
        _ -> Nothing
-- Task 4
data Tree a = Empty | Node a (Tree a) (Tree a)

treeToList :: Tree a -> [a]
treeToList Empty = []
treeToList (Node x l r) = treeToList l ++ [x] ++ treeToList r

insert :: Ord a => a -> Tree a -> Tree a
insert x Empty = Node x Empty Empty
insert x (Node y l r)
    | x < y     = Node y (insert x l) r
    | otherwise = Node y l (insert x r)

treeFromList :: Ord a => [a] -> Tree a
treeFromList = foldl insert Empty

treeFoldr :: (a -> b -> b) -> b -> Tree a -> b
treeFoldr _ acc Empty = acc
treeFoldr f acc (Node x l r) =
    treeFoldr f (f x (treeFoldr f acc r)) l
-- Task 5
parseNum :: String -> Either String Double
parseNum s = case reads s of
    [(x, "")] -> Right x
    _ -> Left "Invalid number"

calc :: String -> Either String Double
calc input = do
    let parts = words input
    case parts of
        [a, "+", b] -> do
            x <- parseNum a
            y <- parseNum b
            return (x + y)

        [a, "-", b] -> do
            x <- parseNum a
            y <- parseNum b
            return (x - y)

        [a, "*", b] -> do
            x <- parseNum a
            y <- parseNum b
            return (x * y)

        [a, "/", b] -> do
            x <- parseNum a
            y <- parseNum b
            if y == 0 then Left "Division by zero"
                    else return (x / y)

        _ -> Left "Invalid format"

-- Task 6
-- Чете файл: content <- readFile "input.csv"
-- Разделя редовете: lines content
-- Парсва: split по , взема оценката read :: Double
-- Филтрира: filter (\(_, grade) -> grade >= 4.0)
-- Записва: writeFile "output.csv" result
-- Task 7
data JSON
    = JNull
    | JBool Bool
    | JNumber Double
    | JString String
    | JArray [JSON]
    | JObject [(String, JSON)]

jsonGet :: String -> JSON -> Maybe JSON
jsonGet key (JObject xs) = lookup key xs
jsonGet _ _ = Nothing

jsonToString :: JSON -> String
jsonToString JNull = "null"
jsonToString (JBool b) = if b then "true" else "false"
jsonToString (JNumber n) = show n
jsonToString (JString s) = show s
jsonToString (JArray xs) =
    "[" ++ unwords (map jsonToString xs) ++ "]"
jsonToString (JObject xs) =
    "{ " ++ unwords [k ++ ": " ++ jsonToString v | (k,v) <- xs] ++ " }"

instance Eq JSON where
    JNull == JNull = True
    JBool a == JBool b = a == b
    JNumber a == JNumber b = a == b
    JString a == JString b = a == b
    JArray a == JArray b = a == b
    JObject a == JObject b = a == b
    _ == _ = False

--------------------------------------------------
-- Task 1
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ acc []     = acc
myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

applyN :: Int -> (a -> a) -> a -> a
applyN 0 _ x = x
applyN n f x = applyN (n-1) f (f x)

myIterate :: (a -> a) -> a -> [a]
myIterate f x = x : myIterate f (f x)

composeAll :: [a -> a] -> a -> a
composeAll [] = id
composeAll (f:fs) = f . composeAll fs

myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
myUnfoldr f seed =
    case f seed of
        Nothing -> []
        Just (x, next) -> x : myUnfoldr f next

--Task 2
data Solid
    = Cube Double
    | Sphere Double
    | Cylinder Double Double

instance Eq Solid where
    Cube a == Cube b = a == b
    Sphere r1 == Sphere r2 = r1 == r2
    Cylinder r1 h1 == Cylinder r2 h2 = r1 == r2 && h1 == h2
    _ == _ = False

instance Show Solid where
    show (Cube a) = "Cube " ++ show a
    show (Sphere r) = "Sphere " ++ show r
    show (Cylinder r h) = "Cylinder " ++ show r ++ " " ++ show h

volume :: Solid -> Double
volume (Cube a) = a^3
volume (Sphere r) = (4/3) * pi * r^3
volume (Cylinder r h) = pi * r^2 * h

class Describable a where
    describe :: a -> String

instance Describable Solid where
    describe s = "Volume is " ++ show (volume s)

instance Ord Solid where
    compare a b = compare (volume a) (volume b)

-- Task 3
splitWhen :: (a -> Bool) -> [a] -> [[a]]
splitWhen _ [] = []
splitWhen p xs =
    let (chunk, rest) = span (not . p) xs
    in chunk : case rest of
        [] -> []
        (_:xs') -> splitWhen p xs'

windows :: Int -> [a] -> [[a]]
windows n xs
    | length xs < n = []
    | otherwise = take n xs : windows n (tail xs)

myTranspose :: [[a]] -> [[a]]
myTranspose xs
    | all null xs = []
    | otherwise =
        map head nonEmpty :
        myTranspose (map tail nonEmpty)
    where
        nonEmpty = filter (not . null) xs
    
frequencies :: Eq a => [a] -> [(a, Int)]
frequencies [] = []
frequencies (x:xs) =
    let count = 1 + length (filter (== x) xs)
        rest  = filter (/= x) xs
    in (x, count) : frequencies rest

rleEncode :: Eq a => [a] -> [(Int, a)]
rleEncode [] = []
rleEncode (x:xs) =
    let (same, rest) = span (== x) xs
    in (1 + length same, x) : rleEncode rest

rleDecode :: [(Int, a)] -> [a]
rleDecode [] = []
rleDecode ((n,x):xs) = replicate n x ++ rleDecode xs
-- Task 4
data NaryTree a = Node a [NaryTree a]

treeMap :: (a -> b) -> NaryTree a -> NaryTree b
treeMap f (Node x children) =
    Node (f x) (map (treeMap f) children)

extractStrings :: NaryTree (String, Int) -> NaryTree String
extractStrings (Node (s, _) children) =
    Node s (map extractStrings children)

sumTree :: NaryTree (String, Int) -> Int
sumTree (Node (_,n) children) =
    n + sum (map sumTree children)

incInts :: NaryTree (Either String Int) -> NaryTree (Either String Int)
incInts (Node x children) =
    Node (f x) (map incInts children)
    where
        f (Right n) = Right (n+1)
        f (Left s)  = Left s

instance Foldable NaryTree where
    foldr f acc (Node x children) =
    f x (foldr (\child acc' -> foldr f acc' child) acc children)

treeHeight :: NaryTree a -> Int
treeHeight (Node _ []) = 1
treeHeight (Node _ ch) =
    1 + maximum (map treeHeight ch)

nodesAtDepth :: Int -> NaryTree a -> [a]
nodesAtDepth 0 (Node x _) = [x]
nodesAtDepth n (Node _ ch) =
    concatMap (nodesAtDepth (n-1)) ch

parentOf :: Eq a => a -> NaryTree a -> Maybe a
parentOf target (Node x children)
    | any (\(Node y _) -> y == target) children = Just x
    | otherwise = findFirst (map (parentOf target) children)
    where
        findFirst [] = Nothing
        findFirst (m:ms) =
            case m of
                Just _  -> m
                Nothing -> findFirst ms

grandparentOf :: Eq a => a -> NaryTree a -> Maybe a
grandparentOf target tree = do
    parent <- parentOf target tree
    parentOf parent tree

greatGrandchildren :: NaryTree a -> [a]
greatGrandchildren (Node _ children) =
    concatMap level2 children
    where
        level2 (Node _ ch) =
            concatMap level3 ch

        level3 (Node _ ch) =
            map (\(Node x _) -> x) ch

import Data.Maybe (mapMaybe)

pathTo :: Eq a => a -> NaryTree a -> Maybe [a]
pathTo target (Node x children)
    | x == target = Just [x]
    | otherwise =
        case mapMaybe (pathTo target) children of
            (p:_) -> Just (x : p)
            [] -> Nothing

-- Task 5
data Deadline = Deadline Int Int Int

data WorkItem = WorkItem
    { title :: String
    , ticket :: Maybe String
    , deadline :: Deadline
    , subtasks :: [WorkItem]
    }

instance Eq WorkItem where
    w1 == w2 = ticket w1 == ticket w2

import Data.Char (isUpper, isDigit)

isValidTicket :: String -> Bool
isValidTicket s =
    length s == 10 &&
    all isUpper (take 2 s) &&
    all isDigit (take 4 (drop 2 s)) &&
    all isDigit (drop 6 s)

createWorkItem :: String -> [WorkItem] -> Deadline -> Maybe String -> WorkItem
createWorkItem t subs d (Just tk)
    | isValidTicket tk = WorkItem t (Just tk) d subs
    | otherwise = error "Invalid ticket"
createWorkItem t subs d Nothing =
    WorkItem t Nothing d subs

createWorkItemSafe :: String -> [WorkItem] -> Deadline -> Maybe String -> Either String WorkItem
createWorkItemSafe t subs d (Just tk)
    | isValidTicket tk = Right (WorkItem t (Just tk) d subs)
    | otherwise = Left "Invalid ticket"
createWorkItemSafe t subs d Nothing =
    Right (WorkItem t Nothing d subs)

allSubtasks :: WorkItem -> [WorkItem]
allSubtasks w =
    subtasks w ++ concatMap allSubtasks (subtasks w)

parentTask :: WorkItem -> WorkItem -> Maybe WorkItem
parentTask root target
    | target `elem` subtasks root = Just root
    | otherwise = findFirst (map (\c -> parentTask c target) (subtasks root))
    where
        findFirst [] = Nothing
        findFirst (m:ms) =
            case m of
                Just _  -> m
                Nothing -> findFirst ms

grandparentTask :: WorkItem -> WorkItem -> Maybe WorkItem
grandparentTask root target = do
    p <- parentTask root target
    parentTask root p

greatGrandSubtasks :: WorkItem -> [WorkItem]
greatGrandSubtasks w =
    [ z
    | x <- subtasks w
    , y <- subtasks x
    , z <- subtasks y
    ]

assign :: Int -> WorkItem -> (WorkItem, Int)
assign n w =
    let (newSubs, n') = assignList n (subtasks w)
        newTicket = case ticket w of
            Just t  -> t
            Nothing -> "AA2026" ++ pad n
    in (w { ticket = Just newTicket, subtasks = newSubs }, n'+1)

assignList :: Int -> [WorkItem] -> ([WorkItem], Int)
assignList n [] = ([], n)
assignList n (x:xs) =
    let (x', n1) = assign n x
        (xs', n2) = assignList n1 xs
    in (x':xs', n2)

pad n = let s = show n in replicate (4 - length s) '0' ++ s

flatten :: WorkItem -> [WorkItem]
flatten w = w : concatMap flatten (subtasks w)

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs)
    | x `elem` xs = unique xs
    | otherwise   = x : unique xs

allUnique :: [WorkItem] -> [WorkItem]
allUnique ws = unique (concatMap flatten ws)

data Project = Project
    { projectName :: String
    , projectCode :: String  -- 2 букви
    , projectTasks :: [WorkItem]
    }

leafSubtasks :: WorkItem -> [WorkItem]
leafSubtasks w
    | null (subtasks w) = [w]
    | otherwise = concatMap leafSubtasks (subtasks w)

allTasks :: WorkItem -> [WorkItem]
allTasks w = w : concatMap allTasks (subtasks w)

projectLeaves :: Project -> [(WorkItem, [WorkItem])]
projectLeaves (Project _ _ tasks) =
    [ (t, leafSubtasks t)
    | t <- concatMap allTasks tasks
    ]

pad :: Int -> String
pad n =
    let s = show n
    in replicate (4 - length s) '0' ++ s

assignFrom :: Int -> WorkItem -> (WorkItem, Int)
assignFrom n w =
    let (newSubs, n') = assignList n (subtasks w)
        newTicket = case ticket w of
            Just t  -> t
            Nothing -> "AA2026" ++ pad n
        newW = w { ticket = Just newTicket, subtasks = newSubs }
    in (newW, if ticket w == Nothing then n' + 1 else n')

assignList :: Int -> [WorkItem] -> ([WorkItem], Int)
assignList n [] = ([], n)
assignList n (x:xs) =
    let (x', n1) = assignFrom n x
        (xs', n2) = assignList n1 xs
    in (x':xs', n2)

assignTicketsFrom :: Int -> WorkItem -> WorkItem
assignTicketsFrom n w = fst (assignFrom n w)

-- Task 6
safeSqrt :: Double -> Maybe Double
safeSqrt x
    | x < 0     = Nothing
    | otherwise = Just (sqrt x)

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeLast :: [a] -> Maybe a
safeLast []     = Nothing
safeLast [x]    = Just x
safeLast (_:xs) = safeLast xs

chainMaybe :: [a -> Maybe a] -> a -> Maybe a
chainMaybe [] x = Just x
chainMaybe (f:fs) x =
    case f x of
        Nothing -> Nothing
        Just y  -> chainMaybe fs y

validateAll :: [a -> Either String ()] -> a -> Either String a
validateAll [] x = Right x
validateAll (f:fs) x =
    case f x of
        Left err -> Left err
        Right _  -> validateAll fs x

main :: IO ()
main = do
    nums <- readLoop
    let s = sum nums
        avg = s / fromIntegral (length nums)
    putStrLn ("Sum: " ++ show s)
    putStrLn ("Avg: " ++ show avg)

readLoop :: IO [Double]
readLoop = do
    line <- getLine
    if line == "0"
        then return []
        else do
            rest <- readLoop
            return (read line : rest)

assignFromIO :: WorkItem -> IO WorkItem
assignFromIO w = do
    line <- getLine
    let n = read line
    return (assignTicketsFrom n w)

parseCSV :: String -> [String]
parseCSV s = map trim (split s)
    where
        split [] = [""]
        split (',':xs) = "" : split xs
        split (x:xs) =
            let (y:ys) = split xs
            in (x:y) : ys

        trim = f . f
            where
                f = reverse . dropWhile (== ' ')

import Data.List (maximumBy)
import Data.Ord (comparing)

mainWords :: IO ()
mainWords = do
    ws <- loop
    let count = length ws
        longest = maximumBy (comparing length) ws
        avgLen = fromIntegral (sum (map length ws)) / fromIntegral count
        longer = filter (\w -> fromIntegral (length w) > avgLen) ws

    print count
    print longest
    print longer

loop :: IO [String]
loop = do
    w <- getLine
    if w == "СТОП"
        then return []
        else do
            rest <- loop
            return (w : rest)


