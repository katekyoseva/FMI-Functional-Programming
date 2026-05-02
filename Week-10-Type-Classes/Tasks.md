# Седмица 10 - Задачи за в час

## Задача 1: `Eq` и `Show` за `Fraction`

Дефинирайте типа `Fraction` и напишете ръчни инстанции:

```haskell
data Fraction = Frac Int Int

instance Eq Fraction where ...    -- сравнение след опростяване
instance Show Fraction where ...  -- "3/4"
```

```haskell
>>> Frac 1 2 == Frac 2 4
True
>>> show (Frac 6 8)
"3/4"
```

---

## Задача 2: `Printable`

Дефинирайте типов клас `Printable` с метод `prettyShow :: a -> String`.

Напишете инстанции за:

- `Int` - число като текст
- `Bool` - `"yes"` / `"no"`
- `[a]` (ако `a` е `Printable`) - елементите, разделени със запетая

```haskell
>>> prettyShow (42 :: Int)
"42"
>>> prettyShow True
"yes"
>>> prettyShow [1 :: Int, 2, 3]
"1, 2, 3"
```

---

## Задача 3: `Ord` за `Card`

Дефинирайте ръчна `Ord` инстанция за карти за игра, където картите се сравняват **първо по ранг, после по боя**:

```haskell
data Suit = Clubs | Diamonds | Hearts | Spades
  deriving (Eq, Ord, Show)

data Rank = Two | Three | Four | Five | Six | Seven | Eight
          | Nine | Ten | Jack | Queen | King | Ace
  deriving (Eq, Ord, Show, Enum, Bounded)

data Card = Card Rank Suit
  deriving (Eq, Show)

instance Ord Card where ...
```

```haskell
>>> Card Ace Spades > Card King Hearts
True
>>> Card Ten Clubs < Card Ten Spades
True
>>> import Data.List (sort)
>>> sort [Card King Hearts, Card Ace Clubs, Card King Diamonds]
[Card King Diamonds, Card King Hearts, Card Ace Clubs]
```

---

## Задача 4: `Measurable`

Дефинирайте типов клас:

```haskell
class Measurable a where
  size :: a -> Int
```

Напишете инстанции за:

- `String` - дължина
- `[a]` - брой елементи
- `Maybe a` - 0 за `Nothing`, 1 за `Just`

---

## Задача 5: `Vector2D`

```haskell
data Vector2D = Vec2D Double Double
```

Напишете инстанции за `Eq`, `Show`, `Num`:

```haskell
>>> Vec2D 1 2 + Vec2D 3 4
(4.0, 6.0)
>>> Vec2D 1 2 * Vec2D 3 4   -- покомпонентно
(3.0, 8.0)
>>> negate (Vec2D 1 2)
(-1.0, -2.0)
```

# Седмица 10 - Задачи за домашна работа

## Задача 1: `MyMatrix`

```haskell
data MyMatrix = Mat [[Double]]
```

Напишете инстанции:

- `Show` - отпечатва матрицата ред по ред
- `Eq` - сравнява елемент по елемент
- `Num` - събиране, изваждане, умножение (матрично), `negate`, `abs` (поелементно), `fromInteger` (единична матрица с дадена размерност)

```haskell
>>> Mat [[1,2],[3,4]] + Mat [[5,6],[7,8]]
Mat [[6.0,8.0],[10.0,12.0]]
```

---

## Задача 2: `Convertible`

Дефинирайте типов клас за преобразуване между типове:

```haskell
class Convertible a b where
  convert :: a -> b
```

Напишете инстанции:

- `Convertible Int Double`
- `Convertible String [Char]` (тривиална)
- `Convertible Celsius Fahrenheit` и обратно

```haskell
newtype Celsius    = Celsius Double deriving (Show)
newtype Fahrenheit = Fahrenheit Double deriving (Show)
```

---

## Задача 3: `Collection`

```haskell
class Collection c where
  empty     :: c a
  insert    :: a -> c a -> c a
  member    :: Eq a => a -> c a -> Bool
  toList    :: c a -> [a]
  fromList  :: [a] -> c a
  fromList  = foldr insert empty
```

Напишете инстанции за `[]` и за `Set`:

```haskell
newtype Set a = Set [a] deriving (Show)
-- Set пази елементите уникални!
```

---

## Задача 4: `Functor`-подобен клас

Дефинирайте собствен `Mappable`:

```haskell
class Mappable f where
  myFmap :: (a -> b) -> f a -> f b
```

Напишете инстанции за:

- `[]`
- `Maybe`
- `Either e` (map-ва само `Right`)
- `Pair a` (map-ва втория елемент): `data Pair a b = Pair a b`

---

## Задача 5: `Priority Queue`

```haskell
data PQueue a = PQueue [(Int, a)]  -- (приоритет, стойност)
  deriving (Show)

class PriorityQueue pq where
  emptyPQ  :: pq a
  enqueue  :: Int -> a -> pq a -> pq a
  dequeue  :: pq a -> Maybe (a, pq a)  -- връща елемента с най-нисък приоритет
  peekPQ   :: pq a -> Maybe a
```

Напишете `PriorityQueue` инстанция за `PQueue`.

```haskell
>>> let pq = enqueue 3 "low" $ enqueue 1 "high" $ enqueue 2 "med" (emptyPQ :: PQueue String)
>>> peekPQ pq
Just "high"
>>> case dequeue pq of Just (v, rest) -> (v, peekPQ rest)
("high", Just "med")
```

---

## 🌟 Бонус: `Foldable'`

Дефинирайте типов клас `Foldable'` с метод `myFoldr`:

```haskell
class Foldable' f where
  myFoldr :: (a -> b -> b) -> b -> f a -> b
```

Напишете инстанции за `[]`, `Maybe` и `data Tree a = Leaf | Node (Tree a) a (Tree a)`.

Изразете `toList`, `sum'`, `length'` чрез `myFoldr`.