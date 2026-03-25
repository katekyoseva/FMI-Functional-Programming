# Седмица 6 - Задачи за в час

## Задача 1: Безточков стил

Пренапишете следните функции в **безточков стил** (point-free), използвайки композиция:

```haskell
-- а) от:
f1 xs = length (filter even xs)
-- б) от:
f2 xs = sum (map (*2) xs)
-- в) от:
f3 xs = reverse (map (+1) xs)
```

```haskell
>>> f1 [1,2,3,4,5,6]
3
>>> f2 [1,2,3]
12
>>> f3 [1,2,3] 
[4,3,2]
```

---

## Задача 2: List comprehension

Използвайте list comprehension за:

**а)** Списък на квадратите на числата от 1 до n, които се делят на 3:

```haskell
squaresDiv3 :: Int -> [Int]
```

```haskell
>>> squaresDiv3 15
[9, 36, 81, 144, 225]
```

**б)** Всички двойки `(x, y)` от `[1..n]`, където `x + y == n`:

```haskell
sumPairs :: Int -> [(Int, Int)]
```

```haskell
>>> sumPairs 5
[(1,4),(2,3),(3,2),(4,1)]
```

---

## Задача 3: `quickSort`

Реализирайте QuickSort чрез list comprehension:

```haskell
quickSort :: Ord a => [a] -> [a]
```

```haskell
>>> quickSort [5, 2, 8, 1, 4, 7, 3]
[1, 2, 3, 4, 5, 7, 8]
```

> 💡 Подсказка: pivot е `head`, елементите по-малки от pivot отиват в ляво comprehension, по-големите - в дясно.

---

## Задача 4: `intersect'`

Напишете `intersect' :: Eq a => [a] -> [a] -> [a]` чрез comprehension:

```haskell
>>> intersect' [1,2,3,4] [3,4,5,6]
[3, 4]
```

---

## Задача 5: `histogram`

Напишете `histogram :: String -> [(Char, Int)]`, която за даден низ връща списък от двойки `(символ, брой_появявания)`.

```haskell
>>> histogram "hello"
[('h',1),('e',1),('l',2),('o',1)]
```

> 💡 Подсказка: Може да използвате `removeDuplicates` или `nub` от `Data.List`.

## #Бонус: `divideInK`
Функция за дадено число, го разделя на `k-торки`

```haskell
>>> divideInK 123456 2
[[1,2], [3,4], [5,6]]
>>> divideInK 12345 3
[[1,2,3],[4,5]]
```

# Седмица 6 - Задачи за домашна работа

## Задача 1: `primes`

Напишете функция `primes :: Int -> [Int]`, която връща всички прости числа до `n`, използвайки list comprehension.

```haskell
>>> primes 30
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
```

> 💡 Подсказка: число е просто, ако няма делители в `[2..x-1]`. Може да изразите проверката като comprehension.

---

## Задача 2: `encode` / `decode` (Run-Length Encoding)

```haskell
encode :: Eq a => [a] -> [(Int, a)]
decode :: [(Int, a)] -> [a]
```

```haskell
>>> encode "aaabbcccc"
[(3,'a'),(2,'b'),(4,'c')]
>>> decode [(3,'a'),(2,'b'),(4,'c')]
"aaabbcccc"
```

---

## Задача 3: `matrixMultiply`

Напишете функция за умножение на матрици (представени като списък от списъци):

```haskell
type Matrix = [[Int]]

matrixMultiply :: Matrix -> Matrix -> Matrix
```

```haskell
>>> matrixMultiply [[1,2],[3,4]] [[5,6],[7,8]]
[[19,22],[43,50]]
```

> 💡 Подсказка: `transpose` от `Data.List` е полезна. Или използвайте comprehension с `zip`/`zipWith`.

---

## Задача 4: `nQueens`

Напишете функция `nQueens :: Int -> [[Int]]`, която връща всички решения на задачата за **N кралици** (N-Queens).

Решението е списък `[c1, c2, ..., cn]`, където `ci` е колоната на кралицата на ред `i`.

```haskell
>>> length (nQueens 8)
92
>>> head (nQueens 4)
[2, 4, 1, 3]
```

> 💡 Подсказка: Генерирайте пермутации и филтрирайте тези без диагонални конфликти.

---

## Задача 5: `crossword`

Напишете функция `crossword :: [String] -> Char -> [(String, String)]`, която за даден списък от думи и символ, намира всички двойки думи, които се пресичат в дадения символ.

```haskell
>>> crossword ["hello", "world", "haskell", "loop"] 'l'
[("hello","world"),("hello","loop"),("hello","haskell"),("haskell","world"),("haskell","loop"),("loop","world")]
```

---

## 🌟 Бонус: `subsequences'`

Напишете функция `subsequences' :: [a] -> [[a]]`, която генерира **всички** подпоследователности на даден списък.

```haskell
>>> subsequences' [1, 2, 3]
[[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]
```

> 💡 Подсказка: Всеки елемент или участва в подпоследователността, или не.

