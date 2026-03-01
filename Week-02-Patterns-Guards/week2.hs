{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE UnicodeSyntax #-}

-- Tasks from Exercise - Week 2
-- Task 1
max3 :: Int -> Int -> Int -> Int
max3 x y z
    | x >= y && x >= z = x
    | y >= x && y >= z = y
    | z >= x && z >= y = z
    | otherwise = 0
-- Task 2
isTriangle :: Double -> Double -> Double -> Bool
isTriangle a b c
    | (a + b) > c && (b + c) > a && (a + c) > b = True
    | otherwise = False
-- Task 3
swap :: (a, b) -> (b, a)
swap (x, y) = (snd(x, y), fst(x, y))
-- Task 4
isWeekend :: Int -> Bool
isWeekend day
    | day == 6 || day == 7 = True
    | otherwise = False
-- Task 5
signNum' :: Int -> Int
signNum' num
    | num > 0 = 1
    | num == 0 = 0
    | otherwise = -1

-- Bonus Task 
classifyShipment :: (String, Double, String, Int) -> String
classifyShipment (contentType, weight, destination, priority)
    | not isValid = "Invalid"
    | contentType == "food" && weight <= 500 && priority > 8
        = "Urgent Refrigerated Transport"
    | contentType == "chemicals" && destination /= "Bulgaria"
        = "Dangerous Cargo"
    | contentType == "electronics" && weight > 1 && weight < 10 && destination /= "Sofia"
        = "Fragile Electronics"
    | otherwise = "Standard"
    where
    isValid =
        weight >= 0 &&
        priority >= 1 && priority <= 10 &&
        contentType `elem` ["food", "chemicals", "electronics"]
    
main :: IO ()
main = do
    putStrLn "Start"
-- Tasks from Exercise - Week 2
-- Task 1
    --print(max3 3 1 2)
-- Task 2
    --print(isTriangle 3 4 5)
    --print(isTriangle 1 2 10)
-- Task 3
    --print(swap (1, 2))
    --print(swap ("hello", True))
-- Task 4
    --print(isWeekend 6)
    --print(isWeekend 2)
-- Task 5
    --print(signNum' 5)
    --print(signNum' 0)
    --print(signNum' (-6))

-- Bonus Task
    --print(classifyShipment ("food", 200, "Bulgaria", 9))
    --print(classifyShipment ("chemicals", 50, "Germany", 5))
    --print(classifyShipment ("electronics", 5, "Plovdiv", 6))
    --print(classifyShipment ("food", -2, "Bulgaria", 5))
