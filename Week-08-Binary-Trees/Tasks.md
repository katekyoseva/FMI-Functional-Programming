# Седмица 8 - Задачи за в час

## Задача 1: Основни операции

Дефинирайте `data Tree a = Empty | Node (Tree a) a (Tree a)` и реализирайте:

```haskell
treeSize    :: Tree a -> Int
treeHeight  :: Tree a -> Int
treeSum     :: Num a => Tree a -> a
countLeaves :: Tree a -> Int
```

```haskell
>>> treeSize tree
6
>>> treeHeight tree
3
>>> treeSum tree
29
>>> countLeaves tree
3
```

```haskell
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
```

---

## Задача 2: Обхождания

Реализирайте:

```haskell
inorder   :: Tree a -> [a]
preorder  :: Tree a -> [a]
postorder :: Tree a -> [a]
```

Тествайте с:

```haskell
--       5
--      / \
--     3   7
--    / \   \
--   1   4   9
```

```haskell
>>> inorder tree
[1,3,4,5,7,9]
```

---

## Задача 3: BST операции

Реализирайте:

```haskell
bstInsert :: Ord a => a -> Tree a -> Tree a
bstSearch :: Ord a => a -> Tree a -> Bool
fromList  :: Ord a => [a] -> Tree a
```

```haskell
>>> inorder (fromList [5, 3, 7, 1, 4])
[1,3,4,5,7]
>>> bstSearch 4 (fromList [5, 3, 7, 1, 4])
True
```

---

## Задача 4: `treeMap`

Реализирайте:

```haskell
treeMap :: (a -> b) -> Tree a -> Tree b
```

```haskell
>>> inorder (treeMap (*2) (fromList [1,2,3]))
[2,4,6]
>>> inorder (treeMap show (fromList [1,2,3]))
["1","2","3"]
```

---

## Задача 5: `treePaths`

Напишете функция `treePaths :: Tree a -> [[a]]`, която връща всички пътища от корена до листата:

```haskell
>>> treePaths (fromList [5, 3, 7, 1, 4, 9])
[[5,3,1],[5,3,4],[5,7,9]]
```

---

# Седмица 8 - Задачи за домашна работа

## Задача 1: BST изтриване

Реализирайте изтриване от BST:

```haskell
bstDelete :: Ord a => a -> Tree a -> Tree a
```

Три случая: лист, един наследник, два наследника (замести с min от дясното поддърво).

```haskell
>>> inorder (bstDelete 3 (fromList [5, 3, 7, 1, 4]))
[1,4,5,7]
```

---

## Задача 2: `mirrorTree`

```haskell
mirrorTree :: Tree a -> Tree a
```

Огледално обръща дървото (ляво ↔ дясно).

```haskell
>>> inorder (mirrorTree (fromList [5, 3, 7]))
[7,5,3]
```

---

## Задача 3: `treeLevel`

Напишете `treeLevel :: Int -> Tree a -> [a]`, която връща елементите на дадено ниво (корен = ниво 0):

```haskell
>>> treeLevel 0 (fromList [5, 3, 7, 1, 4, 9])
[5]
>>> treeLevel 1 (fromList [5, 3, 7, 1, 4, 9])
[3,7]
>>> treeLevel 2 (fromList [5, 3, 7, 1, 4, 9])
[1,4,9]
```

---

## Задача 4: Балансирано BST

Напишете `balancedFromList :: Ord a => [a] -> Tree a`, която създава **балансирано** BST от **сортиран** списък.

```haskell
>>> treeHeight (balancedFromList [1..7])
3
>>> treeHeight (fromList [1..7])
7
```

> 💡 Подсказка: Вземете средния елемент за корен, рекурсивно за лявата и дясната половина.

---

## Задача 5: Дърво на изрази

Дефинирайте:

```haskell
data ExprTree = Lit Double
              | Add ExprTree ExprTree
              | Mul ExprTree ExprTree
              | Neg ExprTree
```

Реализирайте:

- `eval :: ExprTree -> Double`
- `toRPN :: ExprTree -> String` (Reverse Polish Notation)
- `simplify :: ExprTree -> ExprTree` (опростява: `x + 0 = x`, `x * 1 = x`, `x * 0 = 0`)

---

## Задача 6: `Functor` и `Foldable` за `Tree`

Реализирайте ръчни инстанции:

```haskell
instance Functor Tree where
  fmap = ...

instance Foldable Tree where
  foldr = ...
```

Проверете:

```haskell
>>> fmap (*2) (fromList [1,2,3,4,5])   -- дърво с удвоени стойности
>>> foldr (+) 0 (fromList [1,2,3])     -- 6
>>> toList (fromList [5,3,7,1,4])      -- inorder: [1,3,4,5,7]
>>> elem 4 (fromList [5,3,7,1,4])      -- True
```

---

## 🌟 Бонус: AVL дърво

Реализирайте самобалансиращо се AVL дърво:

```haskell
data AVL a = AVLEmpty | AVLNode Int (AVL a) a (AVL a)
-- Int е височината

avlInsert :: Ord a => a -> AVL a -> AVL a
-- Вмъкване с ротации за запазване на баланс
```

Ротации: лява, дясна, ляво-дясна, дясно-лява.