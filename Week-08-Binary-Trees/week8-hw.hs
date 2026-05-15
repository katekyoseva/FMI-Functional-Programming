-- Tasks for Homework - Week 8
data Tree a = Empty | Node a (Tree a) (Tree a)
    deriving (Show, Eq)
-- Task 1
bstDelete :: Ord a => a -> Tree a -> Tree a
bstDelete _ Empty = Empty
bstDelete x (Node root l r)
    | x < root = Node root (bstDelete x l) r
    | x > root = Node root l (bstDelete x r)
    | otherwise = deleteNode (Node root l r)

deleteNode :: Ord a => Tree a -> Tree a
deleteNode (Node _ Empty Empty) = Empty
deleteNode (Node _ l Empty) = l
deleteNode (Node _ Empty r) = r
deleteNode (Node _ l r) =
    let m = findMin r
    in Node m l (bstDelete m r)

findMin :: Tree a -> a
findMin (Node root Empty _) = root
findMin (Node _ l _) = findMin l
-- Task 2
mirrorTree :: Tree a -> Tree a
mirrorTree Empty = Empty
mirrorTree (Node root l r) =
    Node root (mirrorTree r) (mirrorTree l)
-- Task 3
treeLevel :: Int -> Tree a -> [a]
treeLevel _ Empty = []
treeLevel 0 (Node v _ _) = [v]
treeLevel n (Node _ l r)
    | n > 0 = treeLevel (n-1) l ++ treeLevel (n-1) r
    | otherwise = []
-- Task 4
balancedFromList :: Ord a => [a] -> Tree a
balancedFromList [] = Empty
balancedFromList list =
    let mid = length list `div` 2
        (left, (x:right)) = splitAt mid list
    in Node x (balancedFromList left) (balancedFromList right)
-- Task 5
data ExprTree = Lit Double
            | Add ExprTree ExprTree
            | Mul ExprTree ExprTree
            | Neg ExprTree

eval :: ExprTree -> Double
eval (Lit x) = x
eval (Add a b) = eval a + eval b
eval (Mul a b) = eval a * eval b
eval (Neg x) = -(eval x)

toRPN :: ExprTree -> String
toRPN (Lit x) = show x
toRPN (Add a b) = toRPN a ++ " " ++ toRPN b ++ " +"
toRPN (Mul a b) = toRPN a ++ " " ++ toRPN b ++ " *"
toRPN (Neg x) = toRPN x ++ " neg"

simplify :: ExprTree -> ExprTree
simplify (Add a b) =
    case (simplify a, simplify b) of
        (x, Lit 0) -> x
        (Lit 0, x) -> x
        (x, y) -> Add x y

simplify (Mul a b) =
    case (simplify a, simplify b) of
        (_, Lit 0) -> Lit 0
        (Lit 0, _) -> Lit 0
        (x, Lit 1) -> x
        (Lit 1, x) -> x
        (x, y) -> Mul x y

simplify (Neg x) =
    case simplify x of
        Lit v -> Lit (-v)
        y -> Neg y

simplify x = x
-- Task 6
instance Functor Tree where
    fmap _ Empty = Empty
    fmap f (Node v l r) =
        Node (f v) (fmap f l) (fmap f r)

instance Foldable Tree where
    foldr _ acc Empty = acc
    foldr f acc (Node v l r) =
        foldr f (f v (foldr f acc r)) l
-- Bonus Task 
data AVL a = AVLEmpty | AVLNode Int (AVL a) a (AVL a)
    deriving Show
avlInsert :: Ord a => a -> AVL a -> AVL a

height :: AVL a -> Int
height AVLEmpty = 0
height (AVLNode h _ _ _) = h

updateHeight :: AVL a -> AVL a
updateHeight AVLEmpty = AVLEmpty
updateHeight (AVLNode _ l root r) =
    AVLNode (1 + max (height l) (height r)) l root r

balanceFactor :: AVL a -> Int
balanceFactor AVLEmpty = 0
balanceFactor (AVLNode _ l _ r) = height l - height r

makeNode :: AVL a -> a -> AVL a -> AVL a
makeNode l v r =
    AVLNode (1 + max (height l) (height r)) l v r

rotateRight :: AVL a -> AVL a
rotateRight (AVLNode _ (AVLNode _ l x r1) y r2) =
    makeNode l x (makeNode r1 y r2)
rotateRight t = t

rotateLeft :: AVL a -> AVL a
rotateLeft (AVLNode _ l x (AVLNode _ r1 y r2)) =
    makeNode (makeNode l x r1) y r2
rotateLeft t = t

rotateLeftRight :: AVL a -> AVL a
rotateLeftRight (AVLNode _ l v r) =
    rotateRight (makeNode (rotateLeft l) v r)
rotateLeftRight t = t

rotateRightLeft :: AVL a -> AVL a
rotateRightLeft (AVLNode _ l v r) =
    rotateLeft (makeNode l v (rotateRight r))
rotateRightLeft t = t

balance :: AVL a -> AVL a
balance t@(AVLNode _ l v r)
    | bf > 1 && balanceFactor l >= 0 = rotateRight t        -- LL
    | bf > 1 = rotateLeftRight t     -- LR
    | bf < -1 && balanceFactor r <= 0 = rotateLeft t        -- RR
    | bf < -1 = rotateRightLeft t     -- RL
    | otherwise = makeNode l v r
    where bf = balanceFactor t
balance t = t

avlInsert :: Ord a => a -> AVL a -> AVL a
avlInsert x AVLEmpty = AVLNode 1 AVLEmpty x AVLEmpty

avlInsert x (AVLNode _ l v r)
    | x < v     = balance (makeNode (avlInsert x l) v r)
    | x > v     = balance (makeNode l v (avlInsert x r))
    | otherwise = makeNode l v r

-- Functions from class
bstInsert :: Ord a => a -> Tree a -> Tree a
bstInsert x Empty = Node x Empty Empty
bstInsert x (Node root l r)
    | x < root = Node root (bstInsert x l) r
    | x > root = Node root l (bstInsert x r)
    | otherwise = Node root l r

fromList :: Ord a => [a] -> Tree a
fromList = foldl (flip bstInsert) Empty

inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node root l r) = inorder l ++ [root] ++ inorder r

treeHeight :: Tree a -> Int
treeHeight Empty = 0
treeHeight (Node _ l r) = 1 + max (treeHeight l) (treeHeight r)

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework - Week 8
-- Task 1
    --print(inorder (bstDelete 3 (fromList [5, 3, 7, 1, 4])))
-- Task 2
    --print(inorder (mirrorTree (fromList [5, 3, 7])))
-- Task 3
    --print(treeLevel 0 (fromList [5, 3, 7, 1, 4, 9]))
    --print(treeLevel 1 (fromList [5, 3, 7, 1, 4, 9]))
    --print(treeLevel 2 (fromList [5, 3, 7, 1, 4, 9]))
-- Task 4
    --print(treeHeight (balancedFromList [1..7]))
    --print(treeHeight (fromList [1..7]))
-- Task 6
    --print(fmap (*2) (fromList [1,2,3,4,5]))
    --print(foldr (+) 0 (fromList [1,2,3]))
    --print(inorder (fromList [5,3,7,1,4]))
    --print(elem 4 (fromList [5,3,7,1,4]))