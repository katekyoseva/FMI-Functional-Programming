-- Tasks for Homework - Week 7
-- Task 1
data MyList a = Nil | Cons a (MyList a)
    deriving (Show)

fromList :: [a] -> MyList a
fromList [] = Nil
fromList (x:xs) = Cons x (fromList xs)

toList :: MyList a -> [a]
toList Nil = []
toList (Cons x xs) = x : toList xs

myLength :: MyList a -> Int
myLength Nil = 0
myLength (Cons _ xs) = 1 + myLength xs

myMap :: (a -> b) -> MyList a -> MyList b
myMap _ Nil = Nil
myMap f (Cons x xs) = Cons (f x) (myMap f xs)

myFilter :: (a -> Bool) -> MyList a -> MyList a
myFilter _ Nil = Nil
myFilter f (Cons x xs)
    | f x = Cons x (myFilter f xs)
    | otherwise = myFilter f xs
-- Task 2
data Nat = Zero | Succ Nat
    deriving (Show)

toNat :: Int -> Nat
toNat 0 = Zero
toNat n = Succ (toNat (n - 1))

fromNat :: Nat -> Int
fromNat Zero = 0
fromNat (Succ n) = 1 + fromNat n

addNat :: Nat -> Nat -> Nat
addNat Zero n = n
addNat n Zero = n
addNat (Succ m) n = Succ (addNat m n)

mulNat :: Nat -> Nat -> Nat
mulNat Zero _ = Zero
mulNat _ Zero = Zero
mulNat (Succ m) n = addNat n (mulNat m n)
-- Task 3
data Suit = Hearts | Diamonds | Clubs | Spades
    deriving (Show, Eq)

data Rank = Two | Three | Four | Five | Six | Seven | Eight
        | Nine | Ten | Jack | Queen | King | Ace
    deriving (Show, Eq, Ord, Enum, Bounded)

data Card = Card { rank :: Rank, suit :: Suit }
    deriving (Show, Eq)

fullDeck :: [Card]
fullDeck = [Card r s | r <- [minBound .. maxBound], s <- [Hearts, Diamonds, Clubs, Spades]]

cardValue :: Card -> Int
cardValue (Card r _) =
    case r of
        Two -> 2; Three -> 3; Four -> 4; Five -> 5; Six -> 6
        Seven -> 7; Eight -> 8; Nine -> 9; Ten -> 10
        Jack -> 10; Queen -> 10; King -> 10; Ace -> 11

handValue :: [Card] -> Int
handValue = sum . map cardValue

isFlush :: [Card] -> Bool
isFlush [] = True
isFlush (Card _ s : xs) = all (\(Card _ s2) -> s2 == s) xs
-- Task 4
data JSON = JNull
        | JBool Bool
        | JNum Double
        | JStr String
        | JArr [JSON]
        | JObj [(String, JSON)]
    deriving (Show, Eq)

prettyPrint :: JSON -> String
prettyPrint JNull = "null"
prettyPrint (JBool b) = show b
prettyPrint (JNum n) = show n
prettyPrint (JStr s) = show s
prettyPrint (JArr xs) = "[" ++ unwords (map prettyPrint xs) ++ "]"
prettyPrint (JObj kvs) =
    "{ " ++ unwords [k ++ ": " ++ prettyPrint v | (k,v) <- kvs] ++ " }"

jsonGet :: String -> JSON -> Maybe JSON
jsonGet _ JNull = Nothing
jsonGet key (JObj kvs) = lookup key kvs
jsonGet _ _ = Nothing
-- Bonus
data Expr = Lit Double
        | Var String
        | Add Expr Expr
        | Mul Expr Expr
        | Let String Expr Expr

type Env = [(String, Double)]

eval :: Env -> Expr -> Maybe Double
eval _ (Lit x) = Just x

eval env (Var x) = lookup x env
eval env (Add e1 e2) = do
    v1 <- eval env e1
    v2 <- eval env e2
    return (v1 + v2)

eval env (Mul e1 e2) = do
    v1 <- eval env e1
    v2 <- eval env e2
    return (v1 * v2)

eval env (Let x e1 e2) = do
    v1 <- eval env e1
    eval ((x, v1) : env) e2

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks for Homework - Week 7
-- Task 1
    --print (fromList [1,2,3])
    --print (toList (Cons 1 (Cons 2 (Cons 3 Nil))))
    --print (myLength (fromList [1,2,3,4]))
    --print (toList (myMap (*2) (fromList [1,2,3])))
    --print (toList (myFilter even (fromList [1,2,3,4])))
-- Task 2
    --print(fromNat (addNat (toNat 3) (toNat 4)))
-- Task 3
    --print(length fullDeck)
    --print(cardValue (Card Ace Hearts))
    --print(handValue [Card Ace Hearts, Card King Hearts, Card Ten Hearts])
    --print(isFlush [Card Ace Hearts, Card King Hearts, Card Ten Hearts])
    --print(isFlush [Card Ace Hearts, Card King Spades])
-- Task 4
    --print(jsonGet "name" (JObj [("name", JStr "Ivan"), ("age", JNum 20)]))
-- Bonus
    --print(eval [] (Let "x" (Lit 3) (Add (Var "x") (Lit 2))))