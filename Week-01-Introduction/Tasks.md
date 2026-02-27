# Седмица 1 - Задачи за в час

## Задача 1: `sign`

Напишете функция `sign :: Int -> Int`, която връща:

- `1` ако числото е положително
- `0` ако е нула
- `-1` ако е отрицателно

```haskell
>>> sign 5
1
>>> sign 0
0
>>> sign (-3)
-1
```

---

## Задача 2: `myAbs`

Напишете функция `myAbs :: Int -> Int`, която връща абсолютната стойност на число (без да използвате `abs`).

```haskell
>>> myAbs (-7)
7
>>> myAbs 3
3
```

---

## Задача 3: `lastDigit`

Напишете функция `lastDigit :: Int -> Int`, която връща последната цифра на числото.

```haskell
>>> lastDigit 123
3
>>> lastDigit (-456)
6
```

---

## Задача 4: `isInInterval`

Напишете функция `isInInterval :: Int -> Int -> Int -> Bool`, която проверява дали число `x` е в интервала `[a, b]`.

```haskell
>>> isInInterval 3 1 5
True
>>> isInInterval 7 1 5
False
```

---

## Задача 5: `mid`

Напишете функция `mid :: Int -> Int -> Int -> Int`, която връща средното по големина от три числа.

```haskell
>>> mid 3 1 2
2
>>> mid 5 5 3
5
```

> 💡 Опитайте да използвате `min` и `max`.

# Седмица 1 - Задачи за домашна работа

## Задача 1: `isLeapYear`

Напишете функция `isLeapYear :: Int -> Bool`, която проверява дали дадена година е високосна.

Правило: Годината е високосна ако се дели на 4, но не на 100, освен ако се дели на 400.

```haskell
>>> isLeapYear 2024
True
>>> isLeapYear 1900
False
>>> isLeapYear 2000
True
```

---

## Задача 2: `triangleArea`

Напишете функция `triangleArea :: Double -> Double -> Double -> Double`, която пресмята лицето на триъгълник по формулата на Херон.

```haskell
>>> triangleArea 3 4 5
6.0
```

---

## Задача 3: `distance`

Напишете функция `distance :: (Double, Double) -> (Double, Double) -> Double`, която пресмята разстоянието между две точки в равнината.

```haskell
>>> distance (0, 0) (3, 4)
5.0
```

---

## Задача 4: `sumInterval`

Напишете функция `sumInterval :: Int -> Int -> Int`, която пресмята сумата на числата от `a` до `b` (включително).

```haskell
>>> sumInterval 1 5
15
>>> sumInterval 3 3
3
```

> 💡 Подсказка: Използвайте формулата за сума на аритметична прогресия.

---

## Задача 5: `reverseDigits`

Напишете функция `reverseDigits :: Int -> Int`, която обръща цифрите на **неотрицателно** число до 10000.

```haskell
>>> reverseDigits 123
321
>>> reverseDigits 1000
1
```

> 💡 Подсказка: Какво правят `div` и `mod` при работа с цифри?

---

## Задача 6: `complexModulus`

Нека комплексно число е представено като двойка `(Double, Double)` - `(реална, имагинерна)` част. Напишете функция `complexModulus :: (Double, Double) -> Double`, която пресмята модула $|z| = \sqrt{a^2 + b^2}$.

```haskell
>>> complexModulus (3, 4)
5.0
```