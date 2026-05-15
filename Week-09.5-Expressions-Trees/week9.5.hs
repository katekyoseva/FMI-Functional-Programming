-- Tasks from Exercise - Week 9.5
data IntTree = Empty | Node Int IntTree IntTree
                deriving(Show, Eq)
-- Part 1
data Expression = Constant Int
                | Var String
                | Op Expression Char Expression
                deriving (Show, Eq)

type Environment = [(String, Int)]
-- Task 1
evalSimple :: Expression -> Int
evalSimple (Constant n)   = n
evalSimple (Op expr1 '+' expr2) = evalSimple expr1 + evalSimple expr2
evalSimple (Op expr1 '-' expr2) = evalSimple expr1 - evalSimple expr2
evalSimple (Op expr1 '*' expr2) = evalSimple expr1 * evalSimple expr2
evalSimple (Var _) = error "Variables are not supported in evalSimple"
-- Task 2
eval :: Environment -> Expression -> Int
eval _ (Constant n) = n
eval env (Var name) =
    case lookup name env of
        Just val -> val
        Nothing  -> error $ "Variable " ++ name ++ " not found in environment"
eval env (Op expr1 '+' expr2) = eval env expr1 + eval env expr2
eval env (Op expr1 '-' expr2) = eval env expr1 - eval env expr2
eval env (Op expr1 '*' expr2) = eval env expr1 * eval env expr2
-- Task 3
insert :: Int -> IntTree -> IntTree
insert x Empty = Node x Empty Empty
insert x (Node val left right)
    | x == val  = Node val left right
    | x < val   = Node val (insert x left) right
    | otherwise = Node val left (insert x right)
-- Task 4
isBST :: IntTree -> Bool
isBST tree = isSorted (inOrder tree)

inOrder :: IntTree -> [Int]
inOrder Empty = []
inOrder (Node x left right) = inOrder left ++ [x] ++ inOrder right

isSorted :: [Int] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:xs) = x < y && isSorted (y:xs)
-- Task 5
getMin :: IntTree -> Int
getMin (Node x Empty _) = x
getMin (Node _ left _)  = getMin left

delete :: Int -> IntTree -> IntTree
delete _ Empty = Empty
delete v (Node x left right)
    | v < x = Node x (delete v left) right
    | v > x = Node x left (delete v right)
    | otherwise = case (left, right) of
        (Empty, rightTree) -> rightTree
        (leftTree, Empty)  -> leftTree
        (leftTree, rightTree) ->
            let minRight = getMin rightTree
            in Node minRight leftTree (delete minRight rightTree)
-- Task 6
getLeaves :: IntTree -> [Int]
getLeaves Empty = []
getLeaves (Node x Empty Empty) = [x]
getLeaves (Node _ left right)  = getLeaves left ++ getLeaves right
-- Task 7
getLevel :: Int -> IntTree -> [Int]
getLevel _ Empty = []
getLevel 0 (Node x _ _) = [x]
getLevel k (Node _ left right) = getLevel (k - 1) left ++ getLevel (k - 1) right
--Task 8
prune :: Int -> IntTree -> IntTree
prune _ Empty = Empty
prune 0 (Node x _ _) = Node x Empty Empty
prune k (Node x left right) = Node x (prune (k-1) left) (prune (k-1) right)
--Task 9
isSymmetric :: IntTree -> Bool
isSymmetric Empty = True
isSymmetric (Node _ left right) = isMirror left right

isMirror :: IntTree -> IntTree -> Bool
isMirror Empty Empty = True
isMirror (Node lVal lLeft lRight) (Node rVal rLeft rRight) =
    lVal == rVal &&
    isMirror lLeft rRight &&
    isMirror lRight rLeft
    isMirror _ _ = False
--Task 10
allPaths :: IntTree -> [[Int]]
allPaths Empty = []
allPaths (Node x Empty Empty) = [[x]]
allPaths (Node x left right) = map (x:) (allPaths left ++ allPaths right)
--Task 11
rotateLeft :: IntTree -> IntTree 
rotateLeft (Node x leftA (Node y leftB rightC)) =
    Node y (Node x leftA leftB) rightC
rotateLeft tree = tree
rotateRight :: IntTree -> IntTree
rotateRight (Node x (Node y leftA rightB) rightC) =
    Node y leftA (Node x rightB rightC)
rotateRight tree = tree

main :: IO ()
main = do
    putStrLn "Start"