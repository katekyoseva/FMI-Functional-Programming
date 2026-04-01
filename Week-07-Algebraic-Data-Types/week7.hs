-- Tasks from Exercise - Week 7
-- Task 1
data Shape = Circle Double
        | Rectangle Double Double 
        | Triangle Double Double Double 

area :: Shape -> Double
area (Circle r) = pi * r ^ 2
area (Rectangle w h) = w * h
area (Triangle a b c) = sqrt (hp * (hp-a) * (hp-b) * (hp-c))
    where hp = (a + b + c) / 2

perimeter :: Shape -> Double
perimeter (Circle r) = 2 * pi * r
perimeter (Rectangle w h) = 2 * (w + h)
perimeter (Triangle a b c) = a + b + c
-- Task 2
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

safeLast :: [a] -> Maybe a
safeLast [] = Nothing
safeLast [x] = Just x
safeLast (_:xs) = safeLast xs
-- Task 3
data Expr = Lit Double
        | Add Expr Expr
        | Mul Expr Expr
        | Neg Expr

eval :: Expr -> Double
eval (Lit x) = x
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
eval (Neg e) = -(eval e)
-- Task 4
data Weekday = Monday 
        | Tuesday 
        | Wednesday 
        | Thursday 
        | Friday 
        | Saturday 
        | Sunday
    deriving (Show, Eq, Ord, Enum, Bounded)

isWeekend :: Weekday -> Bool
isWeekend Saturday = True
isWeekend Sunday = True
isWeekend _ = False

nextDay :: Weekday -> Weekday
nextDay Sunday = Monday
nextDay d = succ d

daysUntilWeekend :: Weekday -> Int
daysUntilWeekend d
    | isWeekend d = 0
    | otherwise = 1 + daysUntilWeekend (nextDay d)
-- Task 5
data Fraction = Frac Int Int
    deriving (Show, Eq)

simplify :: Fraction -> Fraction
simplify (Frac a b) =
    let g = gcd a b
    in Frac (a `div` g) (b `div` g)

addFrac :: Fraction -> Fraction -> Fraction
addFrac (Frac a b) (Frac c d) = simplify (Frac (a*d + c*b) (b*d))

mulFrac :: Fraction -> Fraction -> Fraction
mulFrac (Frac a b) (Frac c d) = simplify (Frac (a*c) (b*d))

main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 7
-- Task 1
    --print(area (Circle 5))
    --print(perimeter (Rectangle 3 4))
-- Task 2
    --print(safeHead [1, 2, 3])
    --print(safeHead ([] :: [Int]))
-- Task 3
    --print(eval (Add (Lit 3) (Mul (Lit 2) (Lit 5))))
    --print(eval (Neg (Add (Lit 1) (Lit 2))))
-- Task 4
    --print(isWeekend Monday)
    --print(nextDay Sunday)
    --print(daysUntilWeekend Thursday)
    --print(daysUntilWeekend Saturday)
-- Task 5
    --print(simplify (Frac 6 8))
    --print(addFrac (Frac 1 3) (Frac 1 6))