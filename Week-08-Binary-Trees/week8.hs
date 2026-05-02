-- Tasks from Exercise - Week 8
data Tree a = Empty | Node (Tree a) a (Tree a)
    deriving (Show, Eq, Ord)
-- Task 1
treeSize :: Tree a -> Int
treeSize Empty = 0
treeSize (Node l _ r) = 1 + treeSize l + treeSize r

treeHeight :: Tree a -> Int
treeHeight Empty = 0
treeHeight (Node l _ r) = 1 + max (treeHeight l) (treeHeight r)

treeSum :: Num a => Tree a -> a
treeSum Empty = 0
treeSum (Node l root r) = root + treeSum l + treeSum r

countLeaves :: Tree a -> Int
countLeaves Empty = 0
countLeaves (Node Empty _ Empty) = 1
countLeaves (Node l _ r) = countLeaves l + countLeaves r
-- Task 2
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node l root r) = inorder l ++ [root] ++ inorder r

preorder :: Tree a -> [a]
preorder Empty = []
preorder (Node l root r) =  [root] ++ preorder l ++ preorder r

postorder :: Tree a -> [a]
postorder Empty = []
postorder (Node l root r) = postorder l ++ postorder r ++ [root] 
-- Task 3
bstInsert :: Ord a => a -> Tree a -> Tree a
bstInsert x Empty = Node Empty x Empty
bstInsert x (Node l root r)
    | x <= root = Node (bstInsert x l) root r
    | otherwise = Node l root (bstInsert x r)

bstSearch :: Ord a => a -> Tree a -> Bool
bstSearch _ Empty = False
bstSearch x (Node l root r)
    | x == root = True
    | x < root  = bstSearch x l
    | otherwise = bstSearch x r

fromList :: Ord a => [a] -> Tree a
fromList = foldr bstInsert Empty
-- Task 4
treeMap _ Empty = Empty
treeMap f (Node l root r) = Node (treeMap f l) (f root) (treeMap f r)
-- Task 5
treePaths :: Tree a -> [[a]]
treePaths Empty = []
treePaths (Node Empty root Empty) = [[root]]
treePaths (Node l root r) =
    map (root:) (treePaths l) ++ map (root:) (treePaths r)

-- Tree for testing
tree :: Tree Int
tree =
    Node
        (Node
            (Node Empty 1 Empty)
            3
            (Node Empty 4 Empty))
        5
        (Node
            Empty
            7
            (Node Empty 9 Empty))

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 8
-- Task 1
    --print(treeSize tree)
    --print(treeHeight tree)
    --print(treeSum tree)
    --print(countLeaves tree)
-- Task 2
    --print(inorder tree)
    --print(preorder tree)
    --print(postorder tree)
-- Task 3
    --print(inorder (fromList [5, 3, 7, 1, 4]))
    --print(bstSearch 4 (fromList [5, 3, 7, 1, 4]))
-- Task 4
    --print(inorder (treeMap (*2) (fromList [1,2,3])))
    --print(inorder (treeMap show (fromList [1,2,3])))
-- Task 5
    --print(treePaths (fromList [5, 3, 7, 1, 4, 9]))