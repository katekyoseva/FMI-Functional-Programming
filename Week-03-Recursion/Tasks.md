# Седмица 3 - Задачи за в час

## Задача 1: `sumFirst`

Напишете функция `sumFirst :: Int -> Int`, която пресмята сумата $1 + 2 + \ldots + n$.

```haskell
>>> sumFirst 5
15
```

---

## Задача 2: `countDigits`

Напишете функция `countDigits :: Int -> Int`, която брои цифрите на число.

```haskell
>>> countDigits 123
3
>>> countDigits 0
1
```

---

## Задача 3: `isPrime`

Напишете функция `isPrime :: Int -> Bool`, която проверява дали число е просто.

```haskell
>>> isPrime 7
True
>>> isPrime 10
False
```

> 💡 Подсказка: Проверете делители до $\sqrt{n}$.

---

## Задача 4: `myLength`

Реимплементирайте `length` рекурсивно:

```haskell
myLength :: [a] -> Int
```

```haskell
>>> myLength [1, 2, 3, 4]
4
>>> myLength []
0
```

---

## Задача 5: `myElem`

Реимплементирайте `elem` рекурсивно:

```haskell
myElem :: Eq a => a -> [a] -> Bool
```
> `Eq a` гарантира, че типът данни може да бъде сравнен (като използваме ==)

```haskell
>>> myElem 3 [1, 2, 3, 4]
True

>>> myElem 5 [1, 2, 3, 4]
False
```
## #Bonus Tasks 
## Задача 1: `isBalanced`
Напишете функция `isBalanced :: String -> Bool`, която проверява дали низ (списък от символи) съдържа правилно затворени кръгли скоби.

```haskell
>>> isBalanced "(())()"
True
>>> isBalanced "())("
False
>>> isBalanced "(()"
False
```

> 💡 Подсказка: Направете помощна функция с акумулатор `counter`. При "(" увеличавате с 1, при ")" намалявате с 1. Ако `counter` стане отрицателен в даден момент – връщате False. Накрая трябва да е точно 0.

## Задача 2: `merge`
Дадени са два списъка, сортирани във възходящ ред. Напишете функция `merge :: [Int] -> [Int] -> [Int]`, която ги слива в един общ сортиран списък.

```haskell
>>> merge [1, 4, 5] [2, 3, 6, 7]
[1, 2, 3, 4, 5, 6, 7]
>>> merge [] [1, 2]
[1, 2]
```
## Задача 3: `compress`
Напишете функция `compress :: Eq a => [a] -> [a]`, която премахва последователни еднакви елементи в списък.

```haskell
>>> compress [1, 1, 2, 2, 2, 3, 1, 1]
[1, 2, 3, 1]
>>> compress "aaabbcca"
"abca"
```

# Седмица 3 - Задачи за домашна работа

## Задача 1: `digitSum`

Напишете функция `digitSum :: Int -> Int`, която пресмята сумата на цифрите.

```haskell
>>> digitSum 123
6
>>> digitSum 9999
36
```

---

## Задача 2: `toBinary`

Напишете функция `toBinary :: Int -> [Int]`, която преобразува неотрицателно число в списък от двоични цифри.

```haskell
>>> toBinary 13
[1,1,0,1]
>>> toBinary 0
[0]
```

**Бонус:** Напишете `fromBinary :: [Int] -> Int` - обратната операция.

---

## Задача 3: `fibonacci` (tail-recursive)

Напишете tail-recursive версия на Fibonacci:

```haskell
fibonacci :: Int -> Int
```

```haskell
>>> fibonacci 10
55
>>> fibonacci 30
832040
```

---

## Задача 4: `isPalindrome`

Напишете функция `isPalindrome :: Int -> Bool`, която проверява дали число е палиндром (чете се еднакво отляво и отдясно).

```haskell
>>> isPalindrome 12321
True
>>> isPalindrome 123
False
```

> 💡 Подсказка: Обърнете числото и сравнете с оригинала.

---

## Задача 5: `sumDivisors`

Напишете функция `sumDivisors :: Int -> Int`, която връща сумата на всички делители на число.

```haskell
>>> sumDivisors 12
28
>>> sumDivisors 7
8
```

---

## Задача 6: `perfectNumber`

Напишете функция `isPerfect :: Int -> Bool`, която проверява дали число е перфектно (равно на сумата на собствените си делители).

```haskell
>>> isPerfect 6
True
>>> isPerfect 28
True
>>> isPerfect 12
False
```

---

## Задача 7: `horner`

Напишете функция `horner :: [Double] -> Double -> Double`, която оценява полином по схемата на Хорнер. Коефициентите са подадени от най-младшия (a₀) към най-старшия.

```haskell
-- 1 + 2x + 3x² за x = 2:  1 + 2*2 + 3*4 = 17
>>> horner [1, 2, 3] 2
17.0
```

> 💡 Подсказка: Обърнете списъка и приложете схемата $(\ldots((a_n \cdot x + a_{n-1}) \cdot x + a_{n-2}) \cdot x + \ldots)$