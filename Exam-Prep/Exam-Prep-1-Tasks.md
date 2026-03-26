# Задачи за подготовка за контрлоно 1

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

## Задача 3: `filterSmallerThan`
Да се дефинира функция `filterSmallerThan`, която получава списък и число и премахва елеминтет на списъка, които са по-малки от числото.

```haskell
>> filterSmallerThan [1,5,8,2,10] 5
[5,8,10]
>> filterSmallerThan [3,4,5] 4
[4,5]
>> filterSmallerThan [1,2,3] 10
[]
```
---

## Задача 4: `isAscending`
Да се дефинира функция `isAscending :: Integer -> Bool`, която проверява дали цифрите на число са във възходящ ред. Функцията да получава число, но да работи със списък от цифрите му.

```haskell
>> isAscending 1234
True
>> isAscending 987
False
```
---

## Задача 5: `digits`
Да се дефинира фунцкия `digits :: String -> String`, която получава низ и намира цифрите в него.

```haskell
>>> digits "abc123"
"123"
>>> digits "no digits here"
""
```
---

## Задача 6: `digitsSum`
Да се дефинира функция `digitsSum :: String -> Int`, която намира сумата на цифрите в даден низ.

```haskell
>> digitsSum "abc123"
6
>> digitsSum "a1b2c3"
6
>> digitsSum "2026"
10
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
>> isCapitalized ""
True
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

## Задача 10
Дефинирайте функция `sortDigits :: Int -> Int`, която приема число и го пренарежда по следният начин: започва с четните числа, подредени във възходящ ред, и долепя отдясно всичнки нечетни, подредени в низходящ ред.

```haskell
>>> sortDigits 123456
246531
```

## Задача 11
Имаме списък от наредени тройки `students :: [(String,Int,[(String,Double)])]`, който за първа компонента приема име на студент, за втора - факултетен номер и за трета - списък от наредени двойки от предмет и оценка. 

```haskell
>>> Example for students:
students :: [(String,Int,[(String,Double)])] 
         =   [("Ivan",42424,[("fp",6),("oop",6),("dis",5)]),
              ("Maria",757575,[("fp",6),("oop",5),("dis",6)]),
              ("Petyr",2424,[("fp",6),("fp",5),("oop",5),("oop",6)])]
```

Да се дефинира функция `avgGrade :: String ->[(String,Int,[(String,Double)])] -> Double`, която изчислява средния успех по даден предмет.

```haskell
>>> avgGrade "fp" students
5.75
```

## Задача 12 
Като използвате списъка от наредени тройки students от предишната задача, дефинирайте функция `needToExamine :: String -> [(String,Int,[(String,Double)])] -> [String]`, която връща стъдентите, които нямат оценки по подадения предмет.

```haskell
>>> needToExamine "dis" students
["Petyr"]
```
