# Алгебрични типове данни

## Въведение

В Haskell можем да дефинираме свои собствени типове чрез ключовата дума `data`. Тези типове се наричат **алгебрични типове данни** (Algebraic Data Types - ADTs).

---

## 1. Изброени типове (Enumerations)

```haskell
data Color = Red | Green | Blue

data Direction = North | South | East | West

data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun
```

> 💡 `Red`, `Green`, `Blue` са **конструктори на данни** (data constructors). Те са стойности от тип `Color`.

### Pattern matching

```haskell
colorToString :: Color -> String
colorToString Red   = "Червено"
colorToString Green = "Зелено"
colorToString Blue  = "Синьо"

isWeekend :: Day -> Bool
isWeekend Sat = True
isWeekend Sun = True
isWeekend _   = False
```

---

## 2. Конструктори с параметри

Конструкторите могат да носят данни:

```haskell
data Shape = Circle Double              -- радиус
           | Rectangle Double Double    -- ширина, височина
           | Triangle Double Double Double  -- три страни
```

```haskell
area :: Shape -> Double
area (Circle r)        = pi * r ^ 2
area (Rectangle w h)   = w * h
area (Triangle a b c)  = sqrt (s * (s-a) * (s-b) * (s-c))
  where s = (a + b + c) / 2

perimeter :: Shape -> Double
perimeter (Circle r)        = 2 * pi * r
perimeter (Rectangle w h)   = 2 * (w + h)
perimeter (Triangle a b c)  = a + b + c
```

```haskell
ghci> area (Circle 5)
78.53981633974483
ghci> area (Rectangle 3 4)
12.0
ghci> perimeter (Triangle 3 4 5)
12.0
```

---

## 3. Type synonyms (`type`)

`type` създава **алтернативно име** за съществуващ тип (не е нов тип):

```haskell
type Name   = String
type Age    = Int
type Point  = (Double, Double)
type Matrix = [[Double]]

distance :: Point -> Point -> Double
distance (x1, y1) (x2, y2) = sqrt ((x2-x1)^2 + (y2-y1)^2)
```

> ⚠️ `type` НЕ създава нов тип - `Name` и `String` са напълно взаимозаменяеми.

---

## 4. `newtype`

`newtype` създава **нов тип** с точно един конструктор и едно поле. По-ефективен е от `data`:

```haskell
newtype Meters = Meters Double
newtype Seconds = Seconds Double

speed :: Meters -> Seconds -> Double
speed (Meters m) (Seconds s) = m / s
```

> 💡 `newtype` е полезен за type safety - не можем случайно да смесим `Meters` и `Seconds`.

---

## 5. Record syntax

За типове с много полета, record syntax автоматично генерира getter функции:

```haskell
data Student = Student
  { studentName  :: String
  , studentAge   :: Int
  , studentGrade :: Double
  }

-- Автоматично генерирани:
-- studentName  :: Student -> String
-- studentAge   :: Student -> Int
-- studentGrade :: Student -> Double
```

```haskell
ivan :: Student
ivan = Student { studentName = "Иван", studentAge = 20, studentGrade = 5.5 }

-- Или позиционно:
maria :: Student
maria = Student "Мария" 21 6.0

-- Достъп до полета:
ghci> studentName ivan    -- "Иван"
ghci> studentGrade maria  -- 6.0

-- Обновяване с record update:
ivan' :: Student
ivan' = ivan { studentGrade = 5.75 }
```

---

## 6. Полиморфни типове

Типовете могат да имат **типови параметри**:

```haskell
data Pair a b = Pair a b

data List a = Empty | Cons a (List a)

data Maybe a = Nothing | Just a   -- вграден в Prelude

data Either a b = Left a | Right b  -- вграден в Prelude
```

```haskell
safeDivide :: Double -> Double -> Maybe Double
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)
```

```haskell
ghci> safeDivide 10 3
Just 3.3333333333333335
ghci> safeDivide 10 0
Nothing
```

---

## 7. `deriving`

Haskell може автоматично да генерира инстанции на стандартни типови класове:

```haskell
data Color = Red | Green | Blue
  deriving (Show, Eq, Ord, Enum, Bounded)
```

```haskell
ghci> show Red       -- "Red"
ghci> Red == Blue    -- False
ghci> Red < Blue     -- True  (по реда на деклариране)
ghci> [Red ..]       -- [Red, Green, Blue]
ghci> minBound :: Color  -- Red
```

| Клас      | Какво генерира          |
| --------- | ----------------------- |
| `Show`    | Преобразуване до String |
| `Read`    | Четене от String        |
| `Eq`      | `==` и `/=`             |
| `Ord`     | `<`, `>`, `compare`     |
| `Enum`    | `succ`, `pred`, `[..]`  |
| `Bounded` | `minBound`, `maxBound`  |

---

## Обобщение

| Концепция           | Синтаксис                      | Пример                              |
| ------------------- | ------------------------------ | ----------------------------------- |
| Изброен тип         | `data T = A \| B \| C`         | `data Color = Red \| Green \| Blue` |
| Конструктор с данни | `data T = C Type1 Type2`       | `data Shape = Circle Double`        |
| Type synonym        | `type T = ExistingType`        | `type Name = String`                |
| Newtype             | `newtype T = C Type`           | `newtype Meters = Meters Double`    |
| Record              | `data T = T { field :: Type }` | getter функции                      |
| Полиморфен тип      | `data T a = ...`               | `data Maybe a = Nothing \| Just a`  |
| Deriving            | `deriving (Show, Eq, ...)`     | автоматични инстанции               |

# Двоични дървета

## Въведение

Двоичното дърво е **индуктивна** (рекурсивна) структура от данни: или е празно, или съдържа стойност и две поддървета. В Haskell дефинирането и обработката на дървета е изключително естествено.

---

## 1. Дефиниция

```haskell
data Tree a = Empty
            | Node (Tree a) a (Tree a)
  deriving (Show, Eq)
```

- `Empty` - празно дърво (лист)
- `Node left value right` - възел със стойност и две поддървета

```haskell
--       5
--      / \
--     3   7
--    / \   \
--   1   4   9

exampleTree :: Tree Int
exampleTree = Node
  (Node (Node Empty 1 Empty) 3 (Node Empty 4 Empty))
  5
  (Node Empty 7 (Node Empty 9 Empty))
```

---

## 2. Основни операции

```haskell
-- Брой елементи
treeSize :: Tree a -> Int
treeSize Empty          = 0
treeSize (Node l _ r)   = 1 + treeSize l + treeSize r

-- Височина
treeHeight :: Tree a -> Int
treeHeight Empty        = 0
treeHeight (Node l _ r) = 1 + max (treeHeight l) (treeHeight r)

-- Сума (за числа)
treeSum :: Num a => Tree a -> a
treeSum Empty          = 0
treeSum (Node l x r)   = treeSum l + x + treeSum r

-- Търсене на елемент
treeElem :: Eq a => a -> Tree a -> Bool
treeElem _ Empty        = False
treeElem x (Node l v r) = x == v || treeElem x l || treeElem x r

-- Брой на листата
countLeaves :: Tree a -> Int
countLeaves Empty                = 0
countLeaves (Node Empty _ Empty) = 1
countLeaves (Node l _ r)         = countLeaves l + countLeaves r
```

```haskell
ghci> treeSize exampleTree
5
ghci> treeHeight exampleTree
3
ghci> treeElem 4 exampleTree
True
ghci> countLeaves exampleTree
3
```

---

## 3. Обхождания (Traversals)

```haskell
-- Inorder: ляво → корен → дясно
inorder :: Tree a -> [a]
inorder Empty          = []
inorder (Node l x r)   = inorder l ++ [x] ++ inorder r

-- Preorder: корен → ляво → дясно
preorder :: Tree a -> [a]
preorder Empty          = []
preorder (Node l x r)   = [x] ++ preorder l ++ preorder r

-- Postorder: ляво → дясно → корен
postorder :: Tree a -> [a]
postorder Empty          = []
postorder (Node l x r)   = postorder l ++ postorder r ++ [x]

-- Level order (BFS) - по нива
levelOrder :: Tree a -> [a]
levelOrder tree = go [tree]
  where
    go [] = []
    go (Empty : rest)      = go rest
    go (Node l x r : rest) = x : go (rest ++ [l, r])
```

```haskell
ghci> inorder exampleTree     -- [1,3,4,5,7,9]
ghci> preorder exampleTree    -- [5,3,1,4,7,9]
ghci> postorder exampleTree   -- [1,4,3,9,7,5]
ghci> levelOrder exampleTree  -- [5,3,7,1,4,9]
```

> 💡 За BST, `inorder` дава елементите в **сортиран ред**.

---

## 4. Двоично наредено дърво (BST)

BST (Binary Search Tree) поддържа инвариант: за всеки възел, лявото поддърво съдържа по-малки стойности, дясното - по-големи.

```haskell
-- Търсене в BST: O(log n) за балансирано дърво
bstSearch :: Ord a => a -> Tree a -> Bool
bstSearch _ Empty = False
bstSearch x (Node l v r)
  | x == v    = True
  | x < v     = bstSearch x l
  | otherwise  = bstSearch x r

-- Вмъкване в BST
bstInsert :: Ord a => a -> Tree a -> Tree a
bstInsert x Empty = Node Empty x Empty
bstInsert x (Node l v r)
  | x < v     = Node (bstInsert x l) v r
  | x > v     = Node l v (bstInsert x r)
  | otherwise  = Node l v r  -- вече съществува

-- Построяване на BST от списък
fromList :: Ord a => [a] -> Tree a
fromList = foldr bstInsert Empty
```

```haskell
ghci> let bst = fromList [5, 3, 7, 1, 4, 9]
ghci> inorder bst
[1,3,4,5,7,9]
ghci> bstSearch 4 bst
True
ghci> bstSearch 6 bst
False
```

---

## 5. Изтриване от BST

```haskell
-- Намира минималния елемент
bstMin :: Tree a -> a
bstMin (Node Empty x _) = x
bstMin (Node l _ _)     = bstMin l

-- Изтриване
bstDelete :: Ord a => a -> Tree a -> Tree a
bstDelete _ Empty = Empty
bstDelete x (Node l v r)
  | x < v     = Node (bstDelete x l) v r
  | x > v     = Node l v (bstDelete x r)
  | otherwise  = deleteNode (Node l v r)
  where
    deleteNode (Node Empty _ Empty) = Empty         -- лист
    deleteNode (Node Empty _ r')    = r'            -- само дясно дете
    deleteNode (Node l' _ Empty)    = l'            -- само ляво дете
    deleteNode (Node l' _ r')       =               -- две деца
      let minRight = bstMin r'
      in Node l' minRight (bstDelete minRight r')
```

Трите класически случая при изтриване:

- Лист (няма деца): Просто връщаме Empty. Възелът изчезва.
- Едно дете: Ако лявото е празно, връщаме дясното (и обратно). Детето "заема мястото" на изтрития възел, запазвайки връзката с горната част на дървото.
- Две деца (най-интересният случай):
  Не можем просто да изтрием възела, защото ще "скъсаме" дървото на две части.
  Стратегия: Намираме най-малкия елемент в дясното поддърво (minRight = bstMin r'). Той е идеалният заместник, защото е по-голям от всичко вляво и по-малък от всичко останало вдясно.
  Действие: Заменяме стойността на текущия възел с minRight и след това рекурсивно изтриваме оригиналния minRight от дясното поддърво, за да няма дублиране.

---

## 6. `map` и `fold` за дървета

```haskell
treeMap :: (a -> b) -> Tree a -> Tree b
treeMap _ Empty          = Empty
treeMap f (Node l x r)   = Node (treeMap f l) (f x) (treeMap f r)

treeFoldr :: (a -> b -> b) -> b -> Tree a -> b
treeFoldr _ acc Empty        = acc
treeFoldr f acc (Node l x r) = treeFoldr f (f x (treeFoldr f acc r)) l
```

```haskell
ghci> treeMap (*2) exampleTree   -- всички стойности × 2
ghci> treeFoldr (+) 0 exampleTree  -- сума = 29
ghci> treeFoldr (:) [] exampleTree -- inorder списък
```

---

## Обобщение

| Операция     | Сложност (BST баланс.) | Сложност (общо) |
| ------------ | ---------------------- | --------------- |
| `bstSearch`  | O(log n)               | O(n)            |
| `bstInsert`  | O(log n)               | O(n)            |
| `bstDelete`  | O(log n)               | O(n)            |
| `inorder`    | O(n)                   | O(n)            |
| `treeSize`   | O(n)                   | O(n)            |
| `treeHeight` | O(n)                   | O(n)            |

| Обхождане   | Ред                  | Приложение             |
| ----------- | -------------------- | ---------------------- |
| Inorder     | ляво → корен → дясно | Сортиран ред в BST     |
| Preorder    | корен → ляво → дясно | Копиране, сериализация |
| Postorder   | ляво → дясно → корен | Изтриване, eval        |
| Level order | по нива              | BFS, визуализация      |

# Maybe, Either и обработка на грешки

## Въведение

В Haskell няма `null` и няма изключения (exceptions) в класическия смисъл. Вместо тях използваме **типове**, за да изразим липса на стойност или грешка: `Maybe` и `Either`.

---

## 1. `Maybe` - може да има или да няма стойност

```haskell
data Maybe a = Nothing | Just a
```

- `Nothing` - липса на стойност (аналог на `null`)
- `Just x` - наличие на стойност `x`

```haskell
safeDiv :: Double -> Double -> Maybe Double
safeDiv _ 0 = Nothing
safeDiv x y = Just (x / y)

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeLookup :: Eq a => a -> [(a, b)] -> Maybe b
safeLookup _ []          = Nothing
safeLookup key ((k,v):xs)
  | key == k  = Just v
  | otherwise = safeLookup key xs
```

```haskell
ghci> safeDiv 10 3
Just 3.3333333333333335
ghci> safeDiv 10 0
Nothing
ghci> safeHead [1,2,3]
Just 1
ghci> safeHead ([] :: [Int])
Nothing
```

---

## 2. Работа с `Maybe` стойности

### Pattern matching

```haskell
showResult :: Maybe Double -> String
showResult Nothing  = "Грешка!"
showResult (Just x) = "Резултат: " ++ show x
```

### `case` израз

```haskell
describeHead :: [Int] -> String
describeHead xs = case safeHead xs of
  Nothing -> "Празен списък"
  Just x  -> "Първият елемент е " ++ show x
```

### Полезни функции от `Data.Maybe`

```haskell
fromMaybe :: a -> Maybe a -> a
fromMaybe defaultVal Nothing  = defaultVal
fromMaybe _          (Just x) = x

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing  = False

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _       = False

catMaybes :: [Maybe a] -> [a]
-- Премахва Nothing стойностите и разопакова Just

mapMaybe :: (a -> Maybe b) -> [a] -> [b]
-- map + филтриране на Nothing
```

```haskell
ghci> fromMaybe 0 (Just 5)       -- 5
ghci> fromMaybe 0 Nothing        -- 0
ghci> catMaybes [Just 1, Nothing, Just 3]  -- [1, 3]
ghci> mapMaybe safeHead [[1,2], [], [3]]   -- [1, 3]
```

---

## 3. Верижно свързване на `Maybe` операции

Когато имаме поредица от операции, всяка от които може да върне `Nothing`:

```haskell
-- Без верижно свързване (грозно!):
process :: [(String, String)] -> String -> Maybe Int
process env key = case safeLookup key env of
  Nothing  -> Nothing
  Just val -> case safeRead val of
    Nothing -> Nothing
    Just n  -> if n > 0 then Just n else Nothing

-- С помощна функция:
andThen :: Maybe a -> (a -> Maybe b) -> Maybe b
andThen Nothing  _ = Nothing
andThen (Just x) f = f x
```

> 💡 `andThen` всъщност е операторът `>>=` за `Maybe` - ще го разгледаме по-подробно при монадите.

---

## 4. `Either` - стойност или грешка с описание

```haskell
data Either a b = Left a | Right b
```

- `Left` - грешка (по конвенция) с описание
- `Right` - успешна стойност (мнемоника: "right" = "correct")

```haskell
safeDivE :: Double -> Double -> Either String Double
safeDivE _ 0 = Left "Деление на нула!"
safeDivE x y = Right (x / y)

parseAge :: String -> Either String Int
parseAge s
  | all isDigit s && not (null s) = let n = read s
                                     in if n >= 0 && n <= 150
                                        then Right n
                                        else Left ("Невалидна възраст: " ++ s)
  | otherwise = Left ("Не е число: " ++ s)
  where isDigit c = c >= '0' && c <= '9'
```

```haskell
ghci> safeDivE 10 3
Right 3.3333333333333335
ghci> safeDivE 10 0
Left "Деление на нула!"
ghci> parseAge "25"
Right 25
ghci> parseAge "abc"
Left "Не е число: abc"
ghci> parseAge "200"
Left "Невалидна възраст: 200"
```

---

## 5. Работа с `Either`

```haskell
-- Pattern matching
handleResult :: Either String Int -> String
handleResult (Left err) = "Грешка: " ++ err
handleResult (Right n)  = "Успех: " ++ show n

-- Верижно свързване
andThenE :: Either e a -> (a -> Either e b) -> Either e b
andThenE (Left err) _ = Left err
andThenE (Right x)  f = f x
```

### Полезни функции

```haskell
-- either :: (a -> c) -> (b -> c) -> Either a b -> c
ghci> either (\e -> "Error: " ++ e) show (Right 42)
"42"
ghci> either (\e -> "Error: " ++ e) show (Left "oops")
"Error: oops"

-- fromRight :: b -> Either a b -> b  (от Data.Either)
ghci> fromRight 0 (Right 5)  -- 5
ghci> fromRight 0 (Left "err")  -- 0
```

---

## 6. `Maybe` vs `Either`

| Свойство   | `Maybe a`                  | `Either e a`                    |
| ---------- | -------------------------- | ------------------------------- |
| При грешка | `Nothing` (без информация) | `Left e` (с описание)           |
| При успех  | `Just a`                   | `Right a`                       |
| Кога       | Резултатът може да липсва  | Искаме да знаем _защо_ е грешка |
| Пример     | `safeLookup`               | `parseAge`                      |

---

## Обобщение

| Концепция         | Описание                                       |
| ----------------- | ---------------------------------------------- |
| `Maybe a`         | `Nothing` или `Just a`                         |
| `Either e a`      | `Left e` (грешка) или `Right a` (успех)        |
| `fromMaybe`       | Стойност по подразбиране за `Maybe`            |
| `catMaybes`       | Филтрира `Nothing` от списък                   |
| `mapMaybe`        | `map` + филтриране на `Nothing`                |
| `case ... of`     | Pattern matching като израз                    |
| `andThen` / `>>=` | Верижно свързване на `Maybe`/`Either` операции |

# Типови класове

## Въведение

**Типов клас** (type class) е механизъм за **ad-hoc полиморфизъм** в Haskell - позволява една и съща функция да работи по различен начин за различни типове. Аналогия: интерфейси в Java/C#.

---

## 1. Стандартни типови класове

### `Eq` - равенство

```haskell
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  x /= y = not (x == y)    -- дефиниция по подразбиране
```

### `Ord` - наредба

```haskell
class Eq a => Ord a where
  compare :: a -> a -> Ordering  -- LT | EQ | GT
  (<), (<=), (>), (>=) :: a -> a -> Bool
  max, min :: a -> a -> a
```

> 💡 `Eq a => Ord a` означава: за да има `Ord`, трябва да има и `Eq` (суперклас).

### `Show` - преобразуване в `String`

```haskell
class Show a where
  show :: a -> String
```

### `Read` - четене от `String`

```haskell
class Read a where
  read :: String -> a    -- опростено
```

```haskell
ghci> show 42              -- "42"
ghci> show [1,2,3]         -- "[1,2,3]"
ghci> read "42" :: Int     -- 42
ghci> read "[1,2]" :: [Int]  -- [1,2]
```

---

## 2. Дефиниране на инстанция

За наш тип, не можем да използваме `==` автоматично - трябва да дефинираме инстанция:

```haskell
data Color = Red | Green | Blue

instance Eq Color where
  Red   == Red   = True
  Green == Green = True
  Blue  == Blue  = True
  _     == _     = False

instance Show Color where
  show Red   = "Червено"
  show Green = "Зелено"
  show Blue  = "Синьо"

instance Ord Color where
  compare Red   Red   = EQ
  compare Red   _     = LT
  compare _     Red   = GT
  compare Green Green = EQ
  compare Green Blue  = LT
  compare Blue  Green = GT
  compare Blue  Blue  = EQ
```

```haskell
ghci> Red == Blue    -- False
ghci> show Green     -- "Зелено"
ghci> Red < Blue     -- True
ghci> sort [Blue, Red, Green]  -- [Red, Green, Blue]
```

---

## 3. `deriving` - автоматично генериране

Вместо ръчно, Haskell може да генерира инстанции автоматично:

```haskell
data Color = Red | Green | Blue
  deriving (Eq, Ord, Show, Read, Enum, Bounded)
```

Автоматичното `Ord` сравнява по **реда на деклариране** (`Red < Green < Blue`).

---

## 4. Инстанции за типове с параметри

```haskell
data Pair a b = Pair a b

instance (Show a, Show b) => Show (Pair a b) where
  show (Pair x y) = "(" ++ show x ++ ", " ++ show y ++ ")"

instance (Eq a, Eq b) => Eq (Pair a b) where
  Pair a1 b1 == Pair a2 b2 = a1 == a2 && b1 == b2
```

> 💡 Контекстът `(Show a, Show b) =>` казва: за да покажем `Pair a b`, `a` и `b` трябва да са `Show`.

---

## 5. Дефиниране на собствен типов клас

```haskell
class Container f where
  empty  :: f a
  insert :: a -> f a -> f a
  toList :: f a -> [a]
```

```haskell
instance Container [] where
  empty   = []
  insert  = (:)
  toList  = id

data Stack a = Stack [a] deriving (Show)

instance Container Stack where
  empty              = Stack []
  insert x (Stack xs) = Stack (x:xs)
  toList (Stack xs)   = xs
```

---

## 6. Полезни типови класове от Prelude

| Клас         | Ключови функции                     | Предназначение          |
| ------------ | ----------------------------------- | ----------------------- |
| `Eq`         | `==`, `/=`                          | Сравняване за равенство |
| `Ord`        | `compare`, `<`, `>`, `max`, `min`   | Наредба                 |
| `Show`       | `show`                              | Преобразуване до String |
| `Read`       | `read`, `reads`                     | Четене от String        |
| `Num`        | `+`, `-`, `*`, `abs`, `fromInteger` | Числа                   |
| `Integral`   | `div`, `mod`, `toInteger`           | Цели числа              |
| `Fractional` | `/`, `fromRational`                 | Дробни числа            |
| `Enum`       | `succ`, `pred`, `[..]`              | Изброими типове         |
| `Bounded`    | `minBound`, `maxBound`              | Ограничени типове       |

### Йерархия

```
          Eq
          |
         Ord
        /   \
     Num    Enum
      |       |
  Integral  Bounded
      |
  Fractional
```

---

## 7. Ограничения в типови сигнатури

```haskell
-- Изисква Eq
elem' :: Eq a => a -> [a] -> Bool
elem' _ []     = False
elem' x (y:xs) = x == y || elem' x xs

-- Изисква Ord
sort :: Ord a => [a] -> [a]

-- Множество ограничения
showAndCompare :: (Show a, Ord a) => a -> a -> String
showAndCompare x y = show x ++ " vs " ++ show y ++ ": " ++ result
  where result = case compare x y of
                   LT -> "по-малко"
                   EQ -> "равно"
                   GT -> "по-голямо"
```

---

## Обобщение

| Концепция          | Синтаксис                   | Пример                               |
| ------------------ | --------------------------- | ------------------------------------ |
| Дефиниране на клас | `class C a where ...`       | `class Printable a where ...`        |
| Инстанция          | `instance C Type where ...` | `instance Eq Color where ...`        |
| Автоматично        | `deriving (...)`            | `deriving (Eq, Ord, Show)`           |
| Ограничение        | `C a =>`                    | `Eq a => a -> [a] -> Bool`           |
| Суперклас          | `class A a => B a`          | `class Eq a => Ord a`                |
| Контекст за инст.  | `instance (C a) => D (T a)` | `instance Show a => Show (MyList a)` |

# Монади и do-нотация

## Въведение

Монадите са **шаблон за верижно свързване** на изчисления, всяко от които може да „обвива" резултата си в контекст (неуспех, странични ефекти, множество резултати и т.н.).

---

## 1. Проблемът: верижни `Maybe` операции

```haskell
-- От Седмица 8 - грозно вложено case:
lookup' :: String -> [(String, String)] -> Maybe String
lookup' _ [] = Nothing
lookup' k ((k',v):rest)
  | k == k'   = Just v
  | otherwise  = lookup' k rest

process :: [(String, String)] -> Maybe Int
process env = case lookup' "x" env of
  Nothing  -> Nothing
  Just val -> case safeRead val of
    Nothing -> Nothing
    Just n  -> if n > 0 then Just n else Nothing
```

Виждаме повтарящ се паттерн: „ако е `Nothing` - спри, ако е `Just` - продължи".

---

## 2. Операторът `>>=` (bind)

Точно този паттерн изразява `>>=`:

```haskell
(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing >>= _ = Nothing
Just x  >>= f = f x
```

Сега `process` може да се напише:

```haskell
process :: [(String, String)] -> Maybe Int
process env = lookup' "x" env >>= safeRead >>= validate
  where
    validate n = if n > 0 then Just n else Nothing
```

> 💡 `>>=` се чете „bind" - свързва резултата от едно изчисление с функция, която продължава.

---

## 3. `>>` (then)

Когато не ни трябва резултатът от предишната стъпка:

```haskell
(>>) :: Maybe a -> Maybe b -> Maybe b
Nothing >> _ = Nothing
Just _  >> m = m
```

```haskell
ghci> Just 3 >> Just "hello"    -- Just "hello"
ghci> Nothing >> Just "hello"   -- Nothing
```

---

## 4. `return`

`return` поставя стойност в монадичен контекст:

```haskell
return :: a -> Maybe a
return x = Just x
```

> ⚠️ `return` в Haskell **НЕ** е като return в императивни езици! Не спира изпълнението.

---

## 5. `do`-нотация

`do`-нотацията е **синтактична захар** за верига от `>>=`:

```haskell
-- С >>=:
process env = lookup' "x" env >>= \val ->
              safeRead val >>= \n ->
              if n > 0 then Just n else Nothing

-- С do:
process env = do
  val <- lookup' "x" env
  n   <- safeRead val
  if n > 0 then Just n else Nothing
```

### Правила за `do`:

1. `x <- action` - изпълнява `action` и именува резултата `x`
2. `action` без `<-` - изпълнява `action`, игнорира резултата (като `>>`)
3. Последният ред е резултатът от целия `do` блок
4. `let x = expr` - обикновен `let` (без `in`!)

```haskell
example :: Maybe Int
example = do
  let x = 10
  y <- Just 5
  z <- Just 3
  return (x + y + z)  -- Just 18
```

---

## 6. `Maybe` като монада - примери

```haskell
-- Безопасно индексиране в матрица
type Matrix a = [[a]]

safeIndex :: [a] -> Int -> Maybe a
safeIndex xs i
  | i < 0 || i >= length xs = Nothing
  | otherwise                = Just (xs !! i)

matrixAt :: Matrix a -> Int -> Int -> Maybe a
matrixAt m row col = do
  r <- safeIndex m row
  safeIndex r col
```

```haskell
ghci> let m = [[1,2,3],[4,5,6],[7,8,9]]
ghci> matrixAt m 1 2
Just 6
ghci> matrixAt m 5 0
Nothing
```

---

## 7. `Either` като монада

```haskell
-- >>= за Either:
-- Left err >>= _ = Left err
-- Right x  >>= f = f x

validateAndProcess :: String -> String -> String -> Either String String
validateAndProcess name email age = do
  n <- validateName name
  e <- validateEmail email
  a <- validateAge age
  return ("Потребител: " ++ n ++ ", " ++ e ++ ", възраст " ++ a)
  where
    validateName  n = if null n then Left "Празно име" else Right n
    validateEmail e = if '@' `elem` e then Right e else Left "Невалиден имейл"
    validateAge   a = if all (`elem` "0123456789") a && not (null a) then Right a else Left "Невалидна възраст"
```

```haskell
ghci> validateAndProcess "Иван" "ivan@mail.bg" "25"
Right "Потребител: Иван, ivan@mail.bg, възраст 25"
ghci> validateAndProcess "" "ivan@mail.bg" "25"
Left "Празно име"
```

---

## 8. Списъкът като монада

`>>=` за списъци е `concatMap`:

```haskell
ghci> [1,2,3] >>= \x -> [x, x*10]
[1,10,2,20,3,30]

-- do нотация = list comprehension
pairs :: [(Int, Int)]
pairs = do
  x <- [1..3]
  y <- [x..3]
  return (x, y)
-- Еквивалентно на: [(x,y) | x <- [1..3], y <- [x..3]]
```

---

## 9. Монадичният типов клас

```haskell
class Monad m where
  return :: a -> m a
  (>>=)  :: m a -> (a -> m b) -> m b
```

| Монада     | `return x`  | `>>=` поведение              |
| ---------- | ----------- | ---------------------------- |
| `Maybe`    | `Just x`    | Спира при `Nothing`          |
| `Either e` | `Right x`   | Спира при `Left`             |
| `[]`       | `[x]`       | `concatMap`                  |
| `IO`       | Обвива в IO | Верижно изпълнение на ефекти |

---

## Обобщение

| Концепция    | Описание                   | Пример                        |
| ------------ | -------------------------- | ----------------------------- |
| `>>=` (bind) | Верижно свързване          | `Just 3 >>= \x -> Just (x+1)` |
| `>>` (then)  | Свързване без резултат     | `Just 3 >> Just "ok"`         |
| `return`     | Обвива стойност            | `return 5 :: Maybe Int`       |
| `do`-нотация | Синтактична захар за `>>=` | `do { x <- m; return (x+1) }` |
| `<-`         | Извлича стойност в `do`    | `x <- Just 5`                 |