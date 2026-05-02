# Седмица 9 - Задачи за в час

## Задача 1: `safeIndex`

Напишете `safeIndex :: [a] -> Int -> Maybe a`, която безопасно връща елемент по индекс.

```haskell
>>> safeIndex [10, 20, 30] 1
Just 20
>>> safeIndex [10, 20, 30] 5
Nothing
>>> safeIndex [10, 20, 30] (-1)
Nothing
```

---

## Задача 2: `safeMax` и `safeMin`

```haskell
safeMax :: Ord a => [a] -> Maybe a
safeMin :: Ord a => [a] -> Maybe a
```

```haskell
>>> safeMax [3, 1, 4, 1, 5]
Just 5
>>> safeMax ([] :: [Int])
Nothing
```

---

## Задача 3: `firstJust`

Напишете `firstJust :: [Maybe a] -> Maybe a`, която връща **първата** `Just` стойност от списък.

```haskell
>>> firstJust [Nothing, Just 3, Nothing, Just 5]
Just 3
>>> firstJust [Nothing, Nothing]
Nothing
```

---

## Задача 4: Валидиране на парола

Напишете `validatePassword :: String -> Either String String`:

- Ако дължината е < 8: `Left "Паролата е твърде кратка"`
- Ако няма цифра: `Left "Паролата трябва да съдържа цифра"`
- Ако няма главна буква: `Left "Паролата трябва да съдържа главна буква"`
- Иначе: `Right password`

```haskell
>>> validatePassword "abc"
Left "Паролата е твърде кратка"
>>> validatePassword "abcdefgh"
Left "Паролата трябва да съдържа цифра"
>>> validatePassword "Abcdefg1"
Right "Abcdefg1"
```

---

## Задача 5: `chainMaybe`

Напишете `chainMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b`.

```haskell
>>> chainMaybe (Just 10) (\x -> if x > 0 then Just (x * 2) else Nothing)
Just 20
>>> chainMaybe Nothing (\x -> Just (x * 2))
Nothing
```

Използвайте я за: `safeHead xs `chainMaybe` (\x -> safeDiv 100 x)`

# Седмица 9 - Задачи за домашна работа

## Задача 1: `mapMaybe'` и `catMaybes'`

Реимплементирайте:

```haskell
catMaybes' :: [Maybe a] -> [a]
mapMaybe'  :: (a -> Maybe b) -> [a] -> [b]
```

```haskell
>>> catMaybes' [Just 1, Nothing, Just 3]
[1, 3]
>>> mapMaybe' (\x -> if even x then Just (x `div` 2) else Nothing) [1..6]
[1, 2, 3]
```

---

## Задача 2: `lookupAll`

Напишете `lookupAll :: Eq a => [a] -> [(a, b)] -> [Maybe b]`, която търси всеки ключ в асоциативен списък.

```haskell
>>> lookupAll ["a","b","c"] [("a",1),("c",3)]
[Just 1, Nothing, Just 3]
```

Напишете и `lookupAllOrDefault :: Eq a => b -> [a] -> [(a, b)] -> [b]`, която заменя `Nothing` с default стойност.

---

## Задача 3: Calculator с грешки

Напишете калкулатор, който работи с `Either String Double`:

```haskell
data CalcExpr = Num Double
              | Plus CalcExpr CalcExpr
              | Minus CalcExpr CalcExpr
              | Times CalcExpr CalcExpr
              | Divide CalcExpr CalcExpr
              | Sqrt CalcExpr

evalCalc :: CalcExpr -> Either String Double
```

Правила:

- Деление на 0 → `Left "Division by zero"`
- Корен от отрицателно → `Left "Square root of negative number"`

```haskell
>>> evalCalc (Divide (Num 10) (Num 0))
Left "Division by zero"
>>> evalCalc (Sqrt (Num (-4)))
Left "Square root of negative number"
>>> evalCalc (Plus (Num 3) (Sqrt (Num 16)))
Right 7.0
```

---

## Задача 4: `traverse'`

Напишете `traverse' :: (a -> Maybe b) -> [a] -> Maybe [b]`, която прилага функция върху списък, но ако **поне един** елемент е `Nothing`, целият резултат е `Nothing`.

```haskell
>>> traverse' safeHead [[1,2], [3,4], [5,6]]
Just [1, 3, 5]
>>> traverse' safeHead [[1,2], [], [5,6]]
Nothing
```

> 💡 Разликата с `mapMaybe`: `mapMaybe` пропуска грешките, `traverse'` се проваля при първата грешка.

---

## Задача 5: Телефонен указател

```haskell
type PhoneBook = [(String, String)]  -- (име, телефон)

findPhone    :: String -> PhoneBook -> Maybe String
addEntry     :: String -> String -> PhoneBook -> Either String PhoneBook
removeEntry  :: String -> PhoneBook -> Either String PhoneBook
updatePhone  :: String -> String -> PhoneBook -> Either String PhoneBook
```

- `addEntry` връща `Left` ако вече съществува
- `removeEntry` и `updatePhone` връщат `Left` ако не е намерен

```haskell
>>> let pb = [("Ivan", "0888123"), ("Maria", "0899456")]
>>> findPhone "Ivan" pb
Just "0888123"
>>> addEntry "Ivan" "111" pb
Left "Записът вече съществува: Ivan"
>>> removeEntry "Pesho" pb
Left "Записът не е намерен: Pesho"
```

---

## 🌟 Бонус: `sequence'`

Напишете `sequence' :: [Maybe a] -> Maybe [a]`, която преобразува списък от `Maybe` стойности в `Maybe` списък. Ако **поне един** е `Nothing`, резултатът е `Nothing`.

```haskell
>>> sequence' [Just 1, Just 2, Just 3]
Just [1, 2, 3]
>>> sequence' [Just 1, Nothing, Just 3]
Nothing
```