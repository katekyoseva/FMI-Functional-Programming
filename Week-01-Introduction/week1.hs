-- Tasks from Exercise - Week 1
-- Task 1
sign :: Int -> Int 
sign x = if x > 0 then 1
        else if x == 0 then 0 
        else -1
-- Task 2
myAbs :: Int -> Int 
myAbs x = if x > 0 then x else -x
-- Task 3
lastDigit :: Int -> Int
lastDigit x = abs x `mod` 10
--Task 4
isInInterval :: Int -> Int -> Int -> Bool
isInInterval x a b = (x >= a) && (x <= b)
--Task 5
mid :: Int -> Int -> Int -> Int
mid x y z = 
    let minFromXY = min x y
        minFromYZ = min y z
        minFromXZ = min x z
        maxFromFirstMins = max minFromXY minFromYZ
        maxFromMins = max maxFromFirstMins minFromXZ
    in maxFromMins

main :: IO()
main = do
    putStrLn "Start"
--Tasks from Exercise - Week 1
-- Task 1
    --print (sign 5)
    --print (sign (-2))
    --print (sign 0)
-- Task 2
    --print (myAbs 13)
    --print (myAbs (-7))
-- Task 3
    --print (lastDigit 123)
    --print (lastDigit (-16))
-- Task 4
    --print (isInInterval 3 1 5)
    --print (isInInterval 3 4 5)
-- Task 5
    --print (mid 3 1 2)
