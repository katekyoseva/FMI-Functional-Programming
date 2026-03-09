# Седмица 4 - Задачи за в час

## Задача 1: `myReverse`

Реимплементирайте `reverse`:

```haskell
myReverse :: [a] -> [a]
```

```haskell
>>> myReverse [1, 2, 3]
[3, 2, 1]
```

---

## Задача 2: `myZip`

Реимплементирайте `zip`:

```haskell
myZip :: [a] -> [b] -> [(a, b)]
```

```haskell
>>> myZip [1, 2] ["a", "b", "c"]
[(1,"a"), (2,"b")]
```

---

## Задача 3: `myConcat`

Реимплементирайте `concat`:

```haskell
myConcat :: [[a]] -> [a]
```

```haskell
>>> myConcat [[1,2], [3], [4,5]]
[1,2,3,4,5]
```

---

## Задача 4: `isSorted`

Напишете `isSorted :: Ord a => [a] -> Bool`, която проверява дали списък е сортиран във възходящ ред.

```haskell
>>> isSorted [1, 3, 5]
True
>>> isSorted [1, 5, 3]
False
```

---

## Задача 5: `removeAt`

Напишете `removeAt :: Int -> [a] -> [a]`, която премахва елемента на позиция `n` (от 0).

```haskell
>>> removeAt 1 [1, 2, 3, 4]
[1, 3, 4]
```

# Седмица 4 - Задачи за домашна работа

## Задача 1: `myAppend`

Реимплементирайте `(++)`:

```haskell
myAppend :: [a] -> [a] -> [a]
```

```haskell
>>> myAppend [1,2] [3,4,5]
[1,2,3,4,5]
```

---

## Задача 2: `rotateLeft` и `rotateRight`

```haskell
rotateLeft :: Int -> [a] -> [a]
rotateRight :: Int -> [a] -> [a]
```

```haskell
>>> rotateLeft 2 [1, 2, 3, 4, 5]
[3, 4, 5, 1, 2]
>>> rotateRight 2 [1, 2, 3, 4, 5]
[4, 5, 1, 2, 3]
```

---

## Задача 3: `compress`

Напишете функция `compress :: Eq a => [a] -> [a]`, която премахва **последователни** дублирани елементи.

```haskell
>>> compress [1,1,2,2,2,3,1,1]
[1,2,3,1]
>>> compress "aaabbc"
"abc"
```

---

## Задача 4: `merge`

Напишете функция `merge :: Ord a => [a] -> [a] -> [a]`, която слива два **сортирани** списъка в един сортиран списък.

```haskell
>>> merge [1, 3, 5] [2, 4, 6]
[1, 2, 3, 4, 5, 6]
```

---

## Задача 5: `removeDuplicates`

Напишете функция `removeDuplicates :: Eq a => [a] -> [a]`, която премахва **всички** дублирани елементи, запазвайки реда на първата поява.

```haskell
>>> removeDuplicates [1, 3, 2, 1, 3, 4]
[1, 3, 2, 4]
```

---

## Задача 6: `isInfixOf'`

Напишете функция `isInfixOf' :: Eq a => [a] -> [a] -> Bool`, която проверява дали първият списък е подсписък на втория.

```haskell
>>> isInfixOf' [2, 3] [1, 2, 3, 4]
True
>>> isInfixOf' [2, 4] [1, 2, 3, 4]
False
```

> 💡 Подсказка: Може да реализирате помощна `isPrefixOf'` и да я приложите за всяка суфикс.