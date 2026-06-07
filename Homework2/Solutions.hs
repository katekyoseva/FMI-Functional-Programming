-- ════════════════════════════════════════
-- ФМИ София · Функционално програмиране 2025/2026
-- Домашна задача: Операция Нова Звезда
-- Факултетен номер: _
-- Група: _
-- ════════════════════════════════════════

module NovaZvezda where

import Data.List (nub)
-- Задача 1.1
data Resource = Fuel Int | Oxygen Int | Food Int
    deriving (Show, Eq)

data CrewMember = CrewMember
    { name :: String
    , rank :: Int
    , role :: String
    }
-- Задача 1.2
data Planet = Planet
    { planetName :: String
    , distance :: Int
    }

data Ship = Ship
    { shipName :: String
    , crew :: [CrewMember] 
    , cargo :: [Resource]
    }
    deriving (Show, Eq)
-- Задача 1.3
instance Show CrewMember where
    show :: CrewMember -> String
    show c =
        "CrewMember { name = " ++ name c
        ++ ", rank = " ++ show (rank c)
        ++ ", role = " ++ role c ++ " }"
instance Eq CrewMember where
    (==) :: CrewMember -> CrewMember -> Bool
    c1 == c2 = name c1 == name c2

instance Show Planet where
    show :: Planet -> String
    show p =
        "Planet { name = " ++ planetName p
        ++ ", distance = " ++ show (distance p) ++ " }"
instance Eq Planet where
    (==) :: Planet -> Planet -> Bool
    p1 == p2 = planetName p1 == planetName p2
-- Задача 2.1
seniorCrew :: Ship -> [CrewMember]
seniorCrew ship = filter (\member -> rank member >= 5) (crew ship)
-- Задача 2.2
totalFuel :: Ship -> Int
totalFuel ship = sum [n | Fuel n <- cargo ship]
-- Задача 2.3
crewRoles :: Ship -> [String]
crewRoles ship = nub (map role (crew ship))
-- Задача 2.4
consolidateCargo :: [Resource] -> [Resource]
consolidateCargo res =
    [ Fuel (sum [n | Fuel n <- res])
    , Oxygen (sum [n | Oxygen n <- res])
    , Food (sum [n | Food n <- res])
    ]
-- Задача 3.1
findPlanet :: [Planet] -> String -> Maybe Planet
findPlanet [] _ = Nothing
findPlanet (p:ps) name'
    | planetName p == name' = Just p
    | otherwise = findPlanet ps name'
-- Задача 3.2
navigate :: Ship -> Planet -> Either String Ship
navigate ship planet
    | totalFuel ship >= distance planet =
        Right ship { cargo = reduceFuel (distance planet) (cargo ship) }
    -- Right consolidatedShip { cargo = reduceFuel (distance planet) (cargo consolidatedShip) }
    | otherwise = Left "Insufficient fuel"
--where
--    consolidatedShip = ship { cargo = consolidateCargo (cargo ship) }

reduceFuel :: Int -> [Resource] -> [Resource]
reduceFuel _ [] = []
reduceFuel usedFuel (Fuel amount : rest) = Fuel (amount - usedFuel) : rest
reduceFuel usedFuel (resource : rest) = resource : reduceFuel usedFuel rest
-- Задача 3.3
safeMission :: [Planet] -> String -> Ship -> Either String Ship
safeMission planets name' ship =
    case findPlanet planets name' of
        Nothing -> Left "Planet not found"
        Just p  -> navigate ship p

--maybeToEither :: String -> Maybe a -> Either String a
--maybeToEither errorMessage = maybe (Left errorMessage) Right

--safeMission :: [Planet] -> String -> Ship -> Either String Ship
--safeMission planets targetName ship =
--    maybeToEither "Planet not found" (findPlanet planets targetName)
--    >>= navigate ship

-- Задача 4.1
data StarTree = Empty | Node Planet StarTree StarTree
        deriving (Show, Eq)

insertPlanet :: Planet -> StarTree -> StarTree
insertPlanet planet Empty = Node planet Empty Empty
insertPlanet p (Node x left right)
    | distance p <= distance x = Node x (insertPlanet p left) right
    | otherwise = Node x left (insertPlanet p right)
-- Задача 4.2
nearestPlanets :: Int -> StarTree -> [Planet]
nearestPlanets _ Empty = []
nearestPlanets n (Node p left right)
    | distance p > n = nearestPlanets n left
    | otherwise =
        nearestPlanets n left
        ++ [p]
        ++ nearestPlanets n right
-- Задача 5.1
reportShip :: Ship -> IO ()
reportShip s = do
    putStrLn ("Ship: " ++ shipName s)
    putStrLn ("Crew count: " ++ show (length (crew s)))
    putStrLn ("Total fuel: " ++ show (totalFuel s))
-- Задача 5.2
interactiveMission :: IO ()
interactiveMission = do
    putStrLn "Enter destination planet:"
    name' <- getLine
    let result = safeMission examplePlanets name' exampleShip
    print result
-- Задача 5.1 - Бонус
class Describable a where
    describe :: a -> String

instance Describable CrewMember where
    describe :: CrewMember -> String
    describe member =
        name member ++ " serves as " ++ role member ++ " with rank " ++ show (rank member)

instance Describable Planet where
    describe :: Planet -> String
    describe planet =
        planetName planet ++ " is " ++ show (distance planet) ++ " light years away"

instance Describable Ship where
    describe :: Ship -> String
    describe ship =
        shipName ship ++ " has " ++ show (length (crew ship)) ++ " crew members"

missionLog :: Ship -> Planet -> String
missionLog ship planet =
    describe ship ++ " and is travelling to " ++ describe planet

-- Задача 5.2 - Бонус
interactiveMissionWithCommandCenter :: IO ()
interactiveMissionWithCommandCenter = commandLoop exampleShip

commandLoop :: Ship -> IO ()
commandLoop ship = do
    putStrLn "Enter command:"
    command <- getLine
    case words command of
        ["quit"] -> putStrLn "Mission ended."
        ["report"] -> do
            reportShip ship
            commandLoop ship
        ["nav", targetName] ->
            case safeMission examplePlanets targetName ship of
                Left err -> do
                    putStrLn err
                    commandLoop ship
                Right updatedShip -> do
                    print updatedShip
                    commandLoop updatedShip
        _ -> do
            putStrLn "Unknown command."
            commandLoop ship

-- Примерни данни
-- Преведени са имената, за да няма проблем с пизхода на терминала
exampleCrew :: [CrewMember]
exampleCrew =
    [ CrewMember { name = "Captain Ivanov", rank = 9, role = "Captain" }
    , CrewMember { name = "Doctor Petrova", rank = 6, role = "Medic" }
    , CrewMember { name = "Engineer Georgiev", rank = 3, role = "Engineer" }
    , CrewMember { name = "Pilot Stoyanov", rank = 5, role = "Pilot" }
    ]

exampleCargo :: [Resource]
exampleCargo = [Fuel 120, Oxygen 80, Food 50, Fuel 30]

exampleShip :: Ship
exampleShip = Ship
    { shipName = "USS Haskell"
    , crew     = exampleCrew
    , cargo    = consolidateCargo exampleCargo
    }

examplePlanets :: [Planet]
examplePlanets =
    [ Planet { planetName = "Alpha Centavra", distance = 4 }
    , Planet { planetName = "Sirius", distance = 9 }
    , Planet { planetName = "Vega", distance = 25 }
    , Planet { planetName = "Betelgeize", distance = 700 }
    ]

exampleStarTree :: StarTree
exampleStarTree = foldr insertPlanet Empty examplePlanets

assert :: String -> Bool -> IO ()
assert testName condition =
    putStrLn (testName ++ ": " ++ if condition then "OK" else "FAIL")

main :: IO ()
main = do
    assert "seniorCrew returns crew with rank >= 5" $ 
        map name (seniorCrew exampleShip) == ["Captain Ivanov", "Doctor Petrova", "Pilot Stoyanov"]

    assert "totalFuel sums all Fuel resources" $
        totalFuel exampleShip == 150

    assert "crewRoles returns all roles without duplicates" $
        crewRoles exampleShip == ["Captain", "Medic", "Engineer", "Pilot"]

    assert "consolidateCargo combines resources by type" $
        consolidateCargo [Fuel 120, Oxygen 80, Food 50, Fuel 30] == [Fuel 150, Oxygen 80, Food 50]

    assert "findPlanet finds an existing planet" $
        findPlanet examplePlanets "Sirius" == Just (Planet "Sirius" 9)

    assert "findPlanet returns Nothing for missing planet" $
        findPlanet examplePlanets "Mars" == Nothing

    assert "navigate decreases fuel on success" $
        case navigate exampleShip (Planet "Sirius" 9) of
            Right updatedShip -> totalFuel updatedShip == 141
            Left _ -> False

    assert "navigate fails when fuel is insufficient" $
        navigate exampleShip (Planet "Betelgeize" 700) == Left "Insufficient fuel"

    assert "safeMission fails when planet is missing" $
        safeMission examplePlanets "Mars" exampleShip == Left "Planet not found"

    assert "safeMission succeeds for reachable planet" $
        case safeMission examplePlanets "Vega" exampleShip of
            Right updatedShip -> totalFuel updatedShip == 125
            Left _ -> False

    assert "nearestPlanets returns planets up to max distance" $
        map planetName (nearestPlanets 25 exampleStarTree) == ["Alpha Centavra", "Sirius", "Vega"]

    assert "CrewMember equality compares only names" $
        CrewMember "A" 1 "Pilot" == CrewMember "A" 9 "Captain"

    assert "Planet equality compares only names" $
        Planet "X" 10 == Planet "X" 999

    assert "Describable Ship contains ship name" $
        take 11 (describe exampleShip) == "USS Haskell"
