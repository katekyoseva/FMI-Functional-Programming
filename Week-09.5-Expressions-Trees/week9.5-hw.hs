-- Tasks for Homework - Week 9.5
data IntTree = Empty | Node Int IntTree IntTree
                deriving(Show, Eq)
data Expression = Constant Int
                | Var String
                | Op Expression Char Expression
                deriving (Show, Eq)
-- Task 1
simplify :: Expression -> Expression
simplify (Constant n) = Constant n
simplify (Var v) = Var v
simplify (Op left op right) =
    let sLeft = simplify left
        sRight = simplify right
    in case (sLeft, sRight) of
        (Constant c1, Constant c2) -> Constant (compute c1 op c2)
        _ -> Op sLeft op sRight

compute :: Int -> Char -> Int -> Int
compute a '+' b = a + b
compute a '-' b = a - b
compute a '*' b = a * b
compute _ _ _ = error "Unsupported operator"
-- Task 2
toList :: IntTree -> [Int]
toList Empty = []
toList (Node x left right) = toList left ++ [x] ++ toList right

member :: Int -> IntTree -> Bool
member _ Empty = False
member x (Node val left right)
    | x == val  = True
    | x < val   = member x left
    | otherwise = member x right

fromList :: [Int] -> IntTree
fromList = foldl (flip insert) Empty

insert :: Int -> IntTree -> IntTree
insert x Empty = Node x Empty Empty
insert x (Node val left right)
    | x == val  = Node val left right
    | x < val   = Node val (insert x left) right
    | otherwise = Node val left (insert x right)

intersection :: IntTree -> IntTree -> IntTree
intersection t1 t2 =
    let elemsT1 = toList t1
        commonElems = filter (`member` t2) elemsT1
    in fromList commonElems
-- Task 3
areEqual :: IntTree -> IntTree -> Bool
areEqual Empty Empty = True
areEqual (Node x1 l1 r1) (Node x2 l2 r2) =
    x1 == x2 && areEqual l1 l2 && areEqual r1 r2
areEqual _ _ = False
-- Task 4
siblings :: Int -> IntTree -> [Int]
siblings _ Empty = []
siblings v (Node _ left right) =
    case (left, right) of
        (Node lVal _ _, Node rVal _ _)
            | lVal == v -> rVal : searchFurther
            | rVal == v -> lVal : searchFurther
        _ -> searchFurther
    where
        searchFurther = siblings v left ++ siblings v right

main :: IO ()
main = do
    putStrLn "Start"