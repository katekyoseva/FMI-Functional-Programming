# Седмица 7 - Задачи за в час

## Задача 1: `Shape`

Дефинирайте тип `Shape` с конструктори `Circle Double`, `Rectangle Double Double` и `Triangle Double Double Double`.

Напишете:

- `area :: Shape -> Double` - лице
- `perimeter :: Shape -> Double` - обиколка

```haskell
>>> area (Circle 5)
78.53981633974483
>>> perimeter (Rectangle 3 4)
14.0
```

---

## Задача 2: `safeHead` и `safeLast`

Напишете безопасни версии на `head` и `last`, които връщат `Maybe`:

```haskell
safeHead :: [a] -> Maybe a
safeLast :: [a] -> Maybe a
```

```haskell
>>> safeHead [1, 2, 3]
Just 1
>>> safeHead ([] :: [Int])
Nothing
```

---

## Задача 3: `Expr`

Дефинирайте тип за прости аритметични изрази:

```haskell
data Expr = Lit Double
          | Add Expr Expr
          | Mul Expr Expr
          | Neg Expr
```

Напишете `eval :: Expr -> Double`:

```haskell
>>> eval (Add (Lit 3) (Mul (Lit 2) (Lit 5)))
13.0
>>> eval (Neg (Add (Lit 1) (Lit 2)))
-3.0
```

---

## Задача 4: `Weekday`

Дефинирайте тип `Weekday` с `deriving (Show, Eq, Ord, Enum, Bounded)`.

Напишете:

- `isWeekend :: Weekday -> Bool`
- `nextDay :: Weekday -> Weekday` (неделя → понеделник)
- `daysUntilWeekend :: Weekday -> Int`

```haskell
>>> isWeekend Monday
False
>>> nextDay Sunday
Monday
>>> daysUntilWeekend Thursday
2
>>> daysUntilWeekend Saturday
0
```

---

## Задача 5: `Fraction`

Дефинирайте тип `Fraction` за рационални числа:

```haskell
data Fraction = Frac Int Int  -- числител, знаменател
```

Напишете:

- `simplify :: Fraction -> Fraction`
- `addFrac :: Fraction -> Fraction -> Fraction`
- `mulFrac :: Fraction -> Fraction -> Fraction`

```haskell
>>> simplify (Frac 6 8)
Frac 3 4
>>> addFrac (Frac 1 3) (Frac 1 6)
Frac 1 2
```

# Седмица 7 - Задачи за домашна работа

## Задача 1: `MyList`

Дефинирайте свой тип за списък:

```haskell
data MyList a = Nil | Cons a (MyList a)
  deriving (Show)
```

Имплементирайте:

- `fromList :: [a] -> MyList a`
- `toList :: MyList a -> [a]`
- `myLength :: MyList a -> Int`
- `myMap :: (a -> b) -> MyList a -> MyList b`
- `myFilter :: (a -> Bool) -> MyList a -> MyList a`

```haskell
>>> fromList [1,2,3]
Cons 1 (Cons 2 (Cons 3 Nil))
>>> toList (Cons 1 (Cons 2 (Cons 3 Nil)))
[1,2,3]
>>> myLength (fromList [1,2,3,4])
4
>>> toList (myMap (*2) (fromList [1,2,3]))
[2,4,6]
>>> toList (myFilter even (fromList [1,2,3,4]))
[2,4]
```
---

## Задача 2: `Nat` (естествени числа)

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)
```

Имплементирайте:

- `toNat :: Int -> Nat` (за неотрицателни числа)
- `fromNat :: Nat -> Int`
- `addNat :: Nat -> Nat -> Nat`
- `mulNat :: Nat -> Nat -> Nat`

```haskell
>>> fromNat (addNat (toNat 3) (toNat 4))
7
```

---

## Задача 3: `CardGame`

Моделирайте карти за игра:

```haskell
data Suit = Hearts | Diamonds | Clubs | Spades
  deriving (Show, Eq)

data Rank = Two | Three | Four | Five | Six | Seven | Eight
          | Nine | Ten | Jack | Queen | King | Ace
  deriving (Show, Eq, Ord, Enum, Bounded)

data Card = Card { rank :: Rank, suit :: Suit }
  deriving (Show, Eq)
```

Напишете:

- `fullDeck :: [Card]` - всички 52 карти
- `cardValue :: Card -> Int` - стойност (2-10, J/Q/K=10, A=11)
- `handValue :: [Card] -> Int` - сума на стойностите
- `isFlush :: [Card] -> Bool` - всички карти от една боя

```haskell
>>> length fullDeck
52
>>> cardValue (Card Ace Hearts)
11
>>> handValue [Card Ace Hearts, Card King Hearts, Card Ten Hearts]
31
>>> isFlush [Card Ace Hearts, Card King Hearts, Card Ten Hearts]
True
>>> isFlush [Card Ace Hearts, Card King Spades]
False
```

---

## Задача 4: `JSON`

Дефинирайте тип за JSON стойности:

```haskell
data JSON = JNull
           | JBool Bool
           | JNum Double
           | JStr String
           | JArr [JSON]
           | JObj [(String, JSON)]
  deriving (Show, Eq)
```

Напишете:

- `prettyPrint :: JSON -> String` - форматиран текстов изход
- `jsonGet :: String -> JSON -> Maybe JSON` - достъп до поле на обект

```haskell
>>> jsonGet "name" (JObj [("name", JStr "Ivan"), ("age", JNum 20)])
Just (JStr "Ivan")
```

---

## 🌟 Бонус: `Expr` с променливи

Разширете типа `Expr` с поддръжка на променливи и let-изрази:

```haskell
data Expr = Lit Double
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          | Let String Expr Expr  -- let x = e1 in e2

type Env = [(String, Double)]

eval :: Env -> Expr -> Maybe Double
```

```haskell
>>> eval [] (Let "x" (Lit 3) (Add (Var "x") (Lit 2)))
Just 5.0
```