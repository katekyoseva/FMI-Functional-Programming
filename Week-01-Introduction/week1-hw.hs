-- Tasks for Homework
-- Task 1
isLeapYear :: Int -> Bool
isLeapYear y = (y `mod` 4 == 0 && y `mod` 100 /= 0) || y `mod` 400 == 0
--Task 2
triangleArea :: Double -> Double -> Double -> Double
triangleArea a b c = 
    let halfPerimeter = (a + b + c) / 2
    in sqrt(halfPerimeter * (halfPerimeter - a) * (halfPerimeter - b) * (halfPerimeter - c))
-- Task 3
distance :: (Double, Double) -> (Double, Double) -> Double
distance (x1, y1) (x2, y2) = 
    sqrt ((x2 - x1)^2 + (y2 - y1)^2)
-- Task 4
sumInterval :: Int -> Int -> Int
sumInterval x y =
    let a = min x y
        b = max x y
    in (b - a + 1) * (a + b) `div` 2
-- Task 5
reverseDigits :: Int -> Int
reverseDigits num  = helper num 0
    where
        helper 0 res = res
        helper x res = helper (x `div` 10) (res * 10 + x `mod` 10)
-- Task 6
complexModulus :: (Double, Double) -> Double
complexModulus (a, b) = sqrt (a^2 + b^2)

main :: IO()
main = do
    putStrLn "Start"
-- Tasks from Homework 
-- Task 1
    --print (isLeapYear 2024)
    --print (isLeapYear 2000)
    --print (isLeapYear 1900)
-- Task 2
    --print(triangleArea 3 4 5)
-- Task 3
    --print (distance (0, 0) (3, 4))
-- Task 4
    --print(sumInterval 1 5)
    --print(sumInterval 3 3)
-- Task 5
    --print(reverseDigits 123)
    --print(reverseDigits 1000)
-- Task 6
    --print (complexModulus (3, 4))