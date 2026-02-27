# Седмица 2 - Задачи за в час

## Задача 1: `max3`

Напишете функция `max3 :: Int -> Int -> Int -> Int`, която връща максимума от три числа, използвайки **guards**.

```haskell
>>> max3 3 7 2
7
```

---

## Задача 2: `isTriangle`

Напишете функция `isTriangle :: Double -> Double -> Double -> Bool`, която проверява дали три отсечки могат да образуват триъгълник (неравенство на триъгълника).

```haskell
>>> isTriangle 3 4 5
True
>>> isTriangle 1 2 10
False
```

---

## Задача 3: `swap`

Напишете функция `swap :: (a, b) -> (b, a)`, която разменя елементите на двойка.

```haskell
>>> swap (1, 2)
(2, 1)
>>> swap ("hello", True)
(True, "hello")
```

---

## Задача 4: `matchDay`

Напишете функция `isWeekend :: Int -> Bool`, използвайки pattern matching (1 = понеделник, ..., 7 = неделя).

```haskell
>>> isWeekend 6
True
>>> isWeekend 3
False
```

---

## Задача 5: `signum'`

Реимплементирайте `signum` с **guards** (без `if-then-else`):

```haskell
signum' :: Int -> Int
```

```haskell
>>> signum' 5
1
>>> signum' 0
0
>>> signum' (-3)
-1
```
# Седмица 2 - Задачи за домашна работа

## Задача 1: `typeOfTriangle`

Напишете функция `typeOfTriangle :: Double -> Double -> Double -> String`, която определя типа на триъгълник:

- `"Равностранен"` - трите страни са равни
- `"Равнобедрен"` - две страни са равни
- `"Разностранен"` - всички страни са различни
- `"Невалиден"` - не образуват триъгълник

```haskell
>>> typeOfTriangle 3 3 3
"Равностранен"
>>> typeOfTriangle 3 3 5
"Равнобедрен"
>>> typeOfTriangle 3 4 5
"Разностранен"
>>> typeOfTriangle 1 2 10
"Невалиден"
```

---

## Задача 2: `dotProduct`

Напишете функция `dotProduct :: (Double, Double) -> (Double, Double) -> Double`, която пресмята скаларното произведение на два 2D вектора.

```haskell
>>> dotProduct (1, 2) (3, 4)
11.0
```

---

## Задача 3: `isValidDate`

Напишете функция `isValidDate :: Int -> Int -> Int -> Bool`, която проверява дали дата (ден, месец, година) е валидна. Отчетете високосните години за февруари.

```haskell
>>> isValidDate 29 2 2024
True
>>> isValidDate 29 2 2023
False
>>> isValidDate 31 4 2025
False
```

> 💡 Подсказка: Може да използвате guards за различните месеци.

---

## Задача 4: `approxEqual`

Напишете оператор `(~=) :: Double -> Double -> Bool`, който сравнява две числа с точност до `1e-9`.

```haskell
>>> 0.1 + 0.2 ~= 0.3
True
>>> 1.0 ~= 1.000000001
True
>>> 1.0 ~= 1.1
False
```

---

## Задача 5: `median3`

Напишете функция `median3 :: (Int, Int, Int) -> Int`, която приема **кортеж** от три числа (не три аргумента) и връща средното по големина.

```haskell
>>> median3 (3, 1, 2)
2
>>> median3 (5, 5, 3)
5
```