-- Tasks for Homework 
-- Task 1
isTriangle :: Double -> Double -> Double -> Bool
isTriangle a b c
    | (a + b) > c && (b + c) > a && (a + c) > b = True
    | otherwise = False
    
typeOfTriangle :: Double -> Double -> Double -> String
typeOfTriangle a b c
    | isTriangle a b c == False = "Invalid"
    | a == b && b == c = "Equilateral"
    | a == b || b == c || a == c = "Isosceles"
    | otherwise = "Scalene"
-- Task 2
dotProduct :: (Double, Double) -> (Double, Double) -> Double
dotProduct (x1, y1) (x2, y2) = x1*x2 + y1*y2
-- Task 3
isLeapYear :: Int -> Bool
isLeapYear y = (y `mod` 4 == 0 && y `mod` 100 /= 0) || y `mod` 400 == 0

isValidDate :: Int -> Int -> Int -> Bool
isValidDate day month year
    | day >= 1 && day <= 31 && (month == 1 || month == 3 || month == 5 || month == 7 ||
        month == 8 || month == 10 || month == 12) = True
    | day >= 1 && day <= 30 && (month == 4 || month == 6 || month == 9 || month == 11) = True
    | day >= 1 && day <= 28 && month == 2 && isLeapYear(year) == False = True
    | day >= 1 && day <= 29 && month == 2 && isLeapYear(year) == True = True
    | otherwise = False
-- Task 4
--(~=) :: Double -> Double -> Bool
--(~=) a b 
--  | a == b = True
--  | otherwise = False
-- Task 5
--median3 :: (Int, Int, Int) -> Int

main :: IO()
main = do
    putStrLn "Start"
-- Tasks for Homework 
-- Task 1
    --print(typeOfTriangle 3 3 3)
    --print(typeOfTriangle 3 3 5)
    --print(typeOfTriangle 3 4 5)
    --print(typeOfTriangle 1 2 10)
-- Task 2
    --print(dotProduct (1, 2) (3, 4))
-- Task 3
    --print(isValidDate 29 2 2024)
    --print(isValidDate 29 2 2023)
    --print(isValidDate 31 4 2025)
-- Task 4
    --print(0.1 + 0.2 ~= 0.3)
    --print(1.0 ~= 1.000000001)
    --print(1.0 ~= 1.1)
-- Task 5
    --print(median3 (3, 1, 2))
    --print(median3 (5, 5, 3))