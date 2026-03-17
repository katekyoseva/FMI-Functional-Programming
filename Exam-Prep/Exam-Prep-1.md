# Задачи за подготовка за контрлоно 1

Задачите са дадени от Богомил Стоянов (асистент на 2. група ИС)

## Задача 1: `incrementAllBy`
Да се дефинира функция `incrementAllBy :: [Int] -> Int -> [Int]`, която получава списък и число и го добавя към всеки елемент на списъка.

```haskell
>> incrementAllBy [1,2,3] 2
[3,4,5]
>> incrementAllBy [10,20,30] 5
[15,25,35]
>> incrementAllBy [] 3
[]
```

---

## Задача 2: `multiplyAllBy`
Да се дефинира функция `multiplyAllBy :: [Int] -> Int -> [Int]`, която получава списък и число  и умножава всеки елемент на списъка по числото.

```haskell
>> multiplyAllBy [1,2,3] 2
[2,4,6]
>> multiplyAllBy [5,10] 3
[15,30]
>> multiplyAllBy [] 4
[]
```

---

## Задача 3: `filterSamllerThan`
Да се дефинира функция filterSamllerThan, която получава списък и число и премахва елеминтет на списъка, които са по-малки от числото.

```haskell
>> filterSamllerThan [1,5,8,2,10] 5
[5,8,10]
>> filterSamllerThan [3,4,5] 4
[4,5]
>> filterSamllerThan [1,2,3] 10
[]
```
---

## Задача 4: `isAscending`
Да се дефинира функция `isAscending :: Integer -> Bool`, която проверява дали цифрите на число са във възходящ ред. Функцията да получава число, но да работи със списък от цифрите му.

```haskell
>> isAscending 1234
True
>> isAscending 1129
True
>> isAscending 1324
False
>> isAscending 987
False
```
---

## Задача 5: `digits`
Да се дефинира фунцкия `digits :: String -> String`, която получава низ и намира цифрите в него.

```haskell
>> isAscending 1234
True
>> isAscending 1129
True
>> isAscending 1324
False
>> isAscending 987
False
```
---

## Задача 6: `digitsSum`
Да се дефинира функция `digitsSum :: String -> Int`, която намира сумата на цифрите в даден низ.

```haskell
>> digitsSum "abc123"
6
>> digitsSum "a1b2c3"
6
>> digitsSum "2024"
8
>> digitsSum "hello"
0
```
---

## Задача 7: `capitalize`
Да се дефинира функция `capitalize :: String -> String`, която прави всички малки бувки в даден String главни.

```haskell
>> capitalize "hello"
"HELLO"
>> capitalize "Hello World"
"HELLO WORLD"
>> capitalize "abc123"
"ABC123"
```
---

## Задача 8: `isCapitalized`
Да се дефинира функция `isCapitalized :: String -> Bool`, която проверява дали всички букви в даден String са главни.

```haskell
>> isCapitalized "HELLO"
True
>> isCapitalized "HELLO123"
True
>> isCapitalized "Hello"
False
>> isCapitalized "abc"
False
```
---

## Задача 9: `prodSumDiv`
Да се дефинира функция `prodSumDiv :: [Integer] -> Integer -> Integer`, която намира произведението на естествените числа в списък, сумата от делителите, на който е кратна на `k`.

```haskell
>> prodSumDiv [6, 10, 3] 4
18
>> prodSumDiv [4, 5, 8] 3
40
```
> 💡 Подсказка/ Обяснение на първия вход: 
> 1. Намираме сумата от делителите на 6. 
> 2. Проверяваме дали тази сума се дели на 4. 
> 3. Ако се дели трябва да го добавим в произведението (12 се дели на 4 => добавяме 6).
> 4. Така правим и за другите елементи на списъка - намираме сумата от делителите на 10, която е 18, което не се дели на 4 - не го добавяме, после намираме сумата от делителите на 3, която е 4, което се дели на 4 - добавяме 3.
> 5. Извеждаме произведението като резултат -> 6 * 3 = 18
