# Седмица 5 - Задачи за в час

## Задача 1: `myMap` и `myFilter`

Реимплементирайте `map` и `filter`:

```haskell
myMap :: (a -> b) -> [a] -> [b]
myFilter :: (a -> Bool) -> [a] -> [a]
```

```haskell
>> myMap (+1) [1,2,3,4]
[2,3,4,5]
>> myMap length ["hi","haskell","abc"]
[2,7,3]
>> myMap even [1,2,3,4]
[False,True,False,True]

>> myFilter even [1,2,3,4,5,6]
[2,4,6]
>> myFilter (>3) [1,5,2,7,3]
[5,7]
>> myFilter (\x -> x `mod` 3 == 0) [3,4,6,7,9]
[3,6,9]
```
---

## Задача 2: `applyAll`

Напишете функция `applyAll :: [a -> a] -> a -> a`, която прилага **последователно** списък от функции върху стойност.

```haskell
>>> applyAll [(+1), (*2), (+3)] 5
17
```

> 💡 Подсказка: `applyAll [(+1), (*2), (+3)] 5 = ((5 + 3) * 2) + 1` - прилагаме от края!

---

## Задача 3: `countBy`

Напишете функция `countBy :: (a -> Bool) -> [a] -> Int`, която брои елементите, удовлетворяващи предикат.

```haskell
>>> countBy even [1..10]
5
>>> countBy (> 3) [1, 5, 2, 8, 3]
2
```

> 💡 Подсказка: комбинирайте `filter` и `length`, или използвайте `foldr`.

---

## Задача 4: Чрез `foldr`

Реимплементирайте следните функции чрез `foldr`:

```haskell
sumFoldr :: Num a => [a] -> a
lengthFoldr :: [a] -> Int
reverseFoldl :: [a] -> [a]  -- тази е чрез foldl
```
```haskell
>> sumFoldr [1,2,3,4]
10
>> lengthFoldr [1,2,3]
3
>> reverseFoldl [1,2,3,4]
[4,3,2,1]
```
---

## Задача 5: `partition'`

Напишете `partition' :: (a -> Bool) -> [a] -> ([a], [a])`, която разделя списък на два: елементи, за които предикатът е `True`, и елементи, за които е `False`.

```haskell
>>> partition' even [1..10]
([2,4,6,8,10], [1,3,5,7,9])
```

# Седмица 5 - Задачи за домашна работа

## Задача 1: `mapFoldr` и `filterFoldr`

Реализирайте `map` и `filter` чрез `foldr`:

```haskell
mapFoldr :: (a -> b) -> [a] -> [b]
filterFoldr :: (a -> Bool) -> [a] -> [a]
```

---

## Задача 2: `zipWith'`

Реимплементирайте `zipWith`:

```haskell
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
```

```haskell
>>> zipWith' (+) [1,2,3] [10,20,30]
[11,22,33]
>>> zipWith' max [1,5,3] [4,2,6]
[4,5,6]
```

---

## Задача 3: `takeWhile'` и `dropWhile'`

```haskell
takeWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' :: (a -> Bool) -> [a] -> [a]
```

```haskell
>>> takeWhile' (<5) [1, 3, 5, 2, 4]
[1, 3]
>>> dropWhile' (<5) [1, 3, 5, 2, 4]
[5, 2, 4]
```

---

## Задача 4: `maximumBy'`

Напишете `maximumBy' :: (a -> a -> Ordering) -> [a] -> a`, която намира максимума спрямо дадена сравняваща функция.

```haskell
>>> maximumBy' compare [3, 1, 4, 1, 5]
5
>>> maximumBy' (\x y -> compare (length x) (length y)) ["hi", "hello", "yo"]
"hello"
```

---

## Задача 5: `groupBy'`

Напишете `groupBy' :: (a -> a -> Bool) -> [a] -> [[a]]`, която групира **последователни** елементи по даден предикат.

```haskell
>>> groupBy' (==) [1,1,2,2,2,3,3,1]
[[1,1],[2,2,2],[3,3],[1]]
>>> groupBy' (<) [1,3,5,2,4,6]
[[1,3,5],[2,4,6]]
```

---

## Задача 6: `any'`, `all'`

Реализирайте `any` и `all` чрез `foldr`:

```haskell
any' :: (a -> Bool) -> [a] -> Bool
all' :: (a -> Bool) -> [a] -> Bool
```

```haskell
>>> any' even [1, 3, 5, 4]
True
>>> all' even [2, 4, 6]
True
```

---

## 🌟 Бонус: `concatMap'`

Реализирайте `concatMap` чрез `foldr`:

```haskell
concatMap' :: (a -> [b]) -> [a] -> [b]
```

```haskell
>>> concatMap' (\x -> [x, x*10]) [1, 2, 3]
[1, 10, 2, 20, 3, 30]
```