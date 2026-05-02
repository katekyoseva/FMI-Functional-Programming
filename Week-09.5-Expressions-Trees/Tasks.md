# Седмица 9.5 - Задачи за в час

В тази седмица ще разгледаме по-сложни задачи за дървета, затова към всяка задача е приложено решение.
Опитайте се да ги решите сами първо (можете да "разпънете" секцията с решението, когато сте готови)!

## Част 1: Абстрактни синтактични дървета (AST)

Дадени са следните типове за представяне на математически изрази:

```haskell
data Expression = Constant Int
                | Var String
                | Op Expression Char Expression
                deriving (Show, Eq)

type Environment = [(String, Int)]
```

### Задача 1: Оценка на израз без променливи

Напишете функция `evalSimple :: Expression -> Int`, която оценява израз, в който сме сигурни, че няма променливи (`Var`). Поддържайте събиране `+`, изваждане `-` и умножение `*`.

<details>
<summary><b>Виж решението</b></summary>

```haskell
evalSimple :: Expression -> Int
evalSimple (Constant n)   = n
evalSimple (Op expr1 '+' expr2) = evalSimple expr1 + evalSimple expr2
evalSimple (Op expr1 '-' expr2) = evalSimple expr1 - evalSimple expr2
evalSimple (Op expr1 '*' expr2) = evalSimple expr1 * evalSimple expr2
-- За `Var` не правим нищо или хвърляме грешка, тъй като по условие нямаме такива.
evalSimple (Var _) = error "Variables are not supported in evalSimple"
```

</details>

### Задача 2: Оценка на израз с променливи (Environment)

Напишете функция `eval :: Environment -> Expression -> Int`, която прави същото като `evalSimple`, но може да връща стойността на променливи, като ги търси в подадената среда `Environment`. Ако променливата липсва в средата, върнете подходяща грешка.

<details>
<summary><b>Виж решението</b></summary>

```haskell
eval :: Environment -> Expression -> Int
eval _ (Constant n) = n
eval env (Var name) =
  case lookup name env of
    Just val -> val
    Nothing  -> error $ "Variable " ++ name ++ " not found in environment"
eval env (Op expr1 '+' expr2) = eval env expr1 + eval env expr2
eval env (Op expr1 '-' expr2) = eval env expr1 - eval env expr2
eval env (Op expr1 '*' expr2) = eval env expr1 * eval env expr2
```

</details>

---

## Част 2: Двоични наредени дървета (BST)

Даден е следният тип за дърво:

```haskell
data IntTree = Empty | Node Int IntTree IntTree
             deriving (Show, Eq)
```

### Задача 3: Добавяне в наредено дърво

Напишете функция `insert :: Int -> IntTree -> IntTree`, която добавя елемент в двоично наредено дърво, запазвайки наредбата. Ако елементът вече съществува в дървото, върнете дървото непроменено.

<details>
<summary><b>Виж решението</b></summary>

```haskell
insert :: Int -> IntTree -> IntTree
insert x Empty = Node x Empty Empty
insert x (Node val left right)
  | x == val  = Node val left right
  | x < val   = Node val (insert x left) right
  | otherwise = Node val left (insert x right)
```

</details>

### Задача 4: Проверка за нареденост (isBST)

Напишете функция `isBST :: IntTree -> Bool`, която проверява дали дадено произволно двоично дърво е правилно наредено (всяко ляво е по-малко, всяко дясно - по-голямо).

_Упътване: Можете първо да създадете списък от `InOrder` (Ляво-Корен-Дясно) обхождане и да проверите дали той е сортиран._

<details>
<summary><b>Виж решението</b></summary>

```haskell
-- Решение 1: Чрез изравняване (flatten) до списък
isBST :: IntTree -> Bool
isBST tree = isSorted (inOrder tree)

-- Помощни функции
inOrder :: IntTree -> [Int]
inOrder Empty = []
inOrder (Node x left right) = inOrder left ++ [x] ++ inOrder right

isSorted :: [Int] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:xs) = x < y && isSorted (y:xs)


-- Решение 2 (по-ефективно): Чрез поддържане на минимални/максимални граници.
-- Използваме Nothing за безкрайност и Just x за ограничение.
-- Оставяме това за разписване от студентите!
```

</details>

### Задача 5: Изтриване от наредено дърво

Напишете функция `delete :: Int -> IntTree -> IntTree`, която изтрива възел със зададената стойност от нареденото дърво.
_Припомнете си алгоритъма за изтриване: при два наследника вземаме най-малкия (или най-големия) от останалите елементи, който да замести корена._

<details>
<summary><b>Виж решението</b></summary>

```haskell
-- Помощна функция за намиране на най-малкия елемент в непразно дърво
getMin :: IntTree -> Int
getMin (Node x Empty _) = x
getMin (Node _ left _)  = getMin left

delete :: Int -> IntTree -> IntTree
delete _ Empty = Empty
delete v (Node x left right)
  | v < x = Node x (delete v left) right
  | v > x = Node x left (delete v right)
  -- Намерихме възела, който трябва да бъде изтрит (v == x).
  | otherwise = case (left, right) of
      -- 1. Няма наследници или има само десен
      (Empty, rightTree) -> rightTree
      -- 2. Има само ляв наследник
      (leftTree, Empty)  -> leftTree
      -- 3. Има два наследника
      (leftTree, rightTree) ->
        let minRight = getMin rightTree
        -- Качваме минималния елемент от дясното поддърво като нов корен
        -- и го изтриваме оттам
        in Node minRight leftTree (delete minRight rightTree)
```

</details>

---

## Част 3: Разнообразни операции над двоични дървета

Още няколко функции, които са много полезни за работа с дървовидни структури:

### Задача 6: Намиране на листа

Функция `getLeaves :: IntTree -> [Int]`, която връща списък със стойностите на всички листа в дървото (отляво надясно).

<details>
<summary><b>Виж решението</b></summary>

```haskell
getLeaves :: IntTree -> [Int]
getLeaves Empty = []
getLeaves (Node x Empty Empty) = [x]
getLeaves (Node _ left right)  = getLeaves left ++ getLeaves right
```

</details>

### Задача 7: Елементи на ниво k

Напишете функция `getLevel :: Int -> IntTree -> [Int]`, която връща списък от стойностите на всички възли, намиращи се на ниво `k` (приемаме, че коренът е на ниво 0).

<details>
<summary><b>Виж решението</b></summary>

```haskell
getLevel :: Int -> IntTree -> [Int]
getLevel _ Empty = []
getLevel 0 (Node x _ _) = [x]
getLevel k (Node _ left right) = getLevel (k - 1) left ++ getLevel (k - 1) right
```

</details>

### Задача 8: Подкастряне на дърво (Pruning)

Напишете функция `prune :: Int -> IntTree -> IntTree`, която премахва всичко в дървото след дадено ниво `k` (т.е. възлите на ниво `k` стават листа).

<details>
<summary><b>Виж решението</b></summary>

```haskell
prune :: Int -> IntTree -> IntTree
prune _ Empty = Empty
prune 0 (Node x _ _) = Node x Empty Empty
prune k (Node x left right) = Node x (prune (k - 1) left) (prune (k - 1) right)
```

</details>

### Задача 9: Проверка за симетрично дърво

Напишете функция `isSymmetric :: IntTree -> Bool`, която проверява дали дървото е симетрично спрямо корена си (т.е. лявото му поддърво е структурно и стойностно огледален образ на дясното).

<details>
<summary><b>Виж решението</b></summary>

```haskell
-- Решение чрез помощна функция, която проверява дали две дървета са огледални
isSymmetric :: IntTree -> Bool
isSymmetric Empty = True
isSymmetric (Node _ left right) = isMirror left right

isMirror :: IntTree -> IntTree -> Bool
isMirror Empty Empty = True
isMirror (Node lVal lLeft lRight) (Node rVal rLeft rRight) =
    lVal == rVal &&
    isMirror lLeft rRight &&   -- Външните клони
    isMirror lRight rLeft      -- Вътрешните клони
isMirror _ _ = False
```

</details>

### Задача 10: Пътища от корен до листо

Напишете функция `allPaths :: IntTree -> [[Int]]`, която генерира всички пътища от корена до някое листо като списъци от числа.

<details>
<summary><b>Виж решението</b></summary>

```haskell
allPaths :: IntTree -> [[Int]]
allPaths Empty = []
-- Ако сме стигнали листо, връщаме списък от един елемент (самия път до него: [x])
allPaths (Node x Empty Empty) = [[x]]
-- Иначе слагаме текущия връх отпред на всички под-пътища от наследниците
allPaths (Node x left right) = map (x :) (allPaths left ++ allPaths right)
```

</details>

### Задача 11: Леви и Десни Ротации

Напишете функции `rotateLeft :: IntTree -> IntTree` и `rotateRight :: IntTree -> IntTree`. При ротация коренът отива надолу, а един от неговите наследници застава на мястото на корена, запазвайки наредбата.

<details>
<summary><b>Виж решението</b></summary>

```haskell
-- Лява ротация (Left Rotation) - Коренът х отива наляво, дясното дете y се качва нагоре
--     x                   y
--    / \                 / \
--   A   y      =>       x   C
--      / \             / \
--     B   C           A   B
rotateLeft :: IntTree -> IntTree
rotateLeft (Node x leftA (Node y leftB rightC)) =
    Node y (Node x leftA leftB) rightC
rotateLeft tree = tree -- Ако нямаме достатъчно възли вдясно, връщаме дървото непроменено

-- Дясна ротация (Right Rotation) - Аналогично, коренът y отива надясно
--       y               x
--      / \             / \
--     x   C    =>     A   y
--    / \                 / \
--   A   B               B   C
rotateRight :: IntTree -> IntTree
rotateRight (Node y (Node x leftA rightB) rightC) =
    Node x leftA (Node y rightB rightC)
rotateRight tree = tree
```

</details>

# Седмица 9.5 - Задачи за домашна работа

## Задача 1: Опростяване на изрази (Constant Folding)

Напишете функция `simplify :: Expression -> Expression`, която оптимизира аритметичното дърво.
Ако имаме операция над две константи `Op (Constant a) op (Constant b)`, те трябва да се изчислят предварително до `Constant (a op b)`.
Функцията трябва да опростява дървото рекурсивно от листата към корена.

_Пример:_
Изразът `1 + (2 * 3) + x`
Ще бъде представен като: `Op (Op (Constant 1) '+' (Op (Constant 2) '*' (Constant 3))) '+' (Var "x")`
Трябва да се опрости до `Op (Constant 7) '+' (Var "x")`.

<details>
<summary><b>Виж решението</b></summary>

```haskell
simplify :: Expression -> Expression
simplify (Constant n) = Constant n
simplify (Var v) = Var v
simplify (Op left op right) =
  let sLeft = simplify left
      sRight = simplify right
  in case (sLeft, sRight) of
       -- Ако и лявото, и дясното поддърво са константи, пресмятаме ги!
       (Constant c1, Constant c2) -> Constant (compute c1 op c2)
       -- Ако ли не, ги оставяме опростени.
       _ -> Op sLeft op sRight

-- Помощна функция
compute :: Int -> Char -> Int -> Int
compute a '+' b = a + b
compute a '-' b = a - b
compute a '*' b = a * b
compute _ _ _ = error "Unsupported operator"
```

</details>

## Задача 2: Пресичане на наредени дървета

Напишете функция `intersection :: IntTree -> IntTree -> IntTree`, която приема две двоични наредени дървета и връща ново двоично наредено дърво, съдържащо само елементите, които присъстват и в двете начални дървета.

<details>
<summary><b>Виж решението</b></summary>

```haskell
-- Решение чрез изравняване:
-- Правим едното дърво на списък и после филтрираме елементите му,
-- като проверяваме дали се съдържат в другото дърво. Накрая от списъка строим ново.

toList :: IntTree -> [Int]
toList Empty = []
toList (Node x left right) = toList left ++ [x] ++ toList right

member :: Int -> IntTree -> Bool
member _ Empty = False
member x (Node val left right)
  | x == val  = True
  | x < val   = member x left
  | otherwise = member x right

-- Добавяне от списък
fromList :: [Int] -> IntTree
fromList = foldl (flip insert) Empty

-- Моля, уверете се, че използвате функцията insert, която написахте в Task 3
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
```

</details>


## Задача 3: Проверка за еднакви дървета
Напишете функция `areEqual :: IntTree -> IntTree -> Bool`, която проверява дали две дървета съвпадат както по структура, така и по стойностите във възлите си.

<details>
<summary><b>Виж решението</b></summary>

```haskell
areEqual :: IntTree -> IntTree -> Bool
areEqual Empty Empty = True
areEqual (Node x1 l1 r1) (Node x2 l2 r2) =
    x1 == x2 && areEqual l1 l2 && areEqual r1 r2
areEqual _ _ = False
```

</details>

## Задача 4: Намиране на братя (siblings) в дървото

Напишете функция `siblings :: Int -> IntTree -> [Int]`, която връща списък (или единствен елемент, но в списък за удобство) от стойностите на братята (siblings) на дадена стойност `v`. Ако тя няма брат или възелът изобщо не се среща в дървото, да върне празен списък.

<details>
<summary><b>Виж решението</b></summary>

```haskell
-- Трябва да намерим възел, чиито деца (или поне едното) са равно на v,
-- след което връщаме стойността на другото дете, ако съществува.
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
```

</details>