-- Naming: n - number of subintervals
--         f - function (RealFunction)
--         a - start of interval
--         b - end of interval

type RealFunction = Double -> Double
--type Integrator = Int -> RealFunction -> Double -> Double -> Double

-- Task 1
interpolationNodes :: Int -> (Double, Double) -> [Double]
interpolationNodes n (a, b) =
    --works but looses precision 
    --[a + (fromIntegral i * step) | i <- [0..n]]
    --where 
    --    step = (b - a) / fromIntegral n
    take (k + 1) (iterate (+ step) a)
    where
        k = max 1 n
        step = (b - a) / fromIntegral k
-- Task 2
interpolationIntervals:: Int -> (Double, Double) -> [(Double, Double)]
interpolationIntervals n (a, b) =
    zip nodes (tail nodes)
    where
        nodes = interpolationNodes n (a, b)
-- Task 3
data IntegralInfo = IntegralInfo RealFunction (Double, Double)
-- Task 4
midpoint :: (Double, Double) -> Double
midpoint (x, y) = (x + y) / 2

quadRect :: Integrator Uniform
quadRect (Uniform n) f a b = 
    sum [f (midpoint(x1, x2)) * (x2 - x1) | (x1, x2) <- intervals]
    where
        intervals = interpolationIntervals n (a, b)
-- Task 5
quadTrap :: Integrator Uniform
quadTrap (Uniform n) f a b = 
    sum [((f x1 + f x2) / 2) * (x2 - x1) | (x1, x2) <- intervals]
    where
        intervals = interpolationIntervals n (a, b)
-- Task 6
quadSimpson :: Integrator Uniform
quadSimpson (Uniform n) f a b = 
    sum [simpson x0 x1 x2 | (x0,x1,x2) <- triples]
    where
        n' = if even n then n else n + 1
        intervals = interpolationNodes n' (a, b)
        h = (b - a) / fromIntegral n'
        triples = [(intervals!!i, intervals!!(i+1), intervals!!(i+2)) | i <- [0,2..n'-2]]
        simpson x y z = (h / 3) * (f x + 4 * f y + f z)
-- Task 7
data Uniform = Uniform Int 
    deriving (Eq, Show)
data Adaptive = Adaptive Double Int
    deriving (Eq, Show)
-- Task 8
type Integrator cfg = cfg -> RealFunction -> Double -> Double -> Double
-- Task 9
simpsonEstimate :: RealFunction -> Double -> Double -> Double
simpsonEstimate f x y =
  (h / 3) * (f x + 4 * f m + f y)
    where
        m = midpoint (x, y)
        h = (y - x) / 2

quadSimpsonAdaptive :: Integrator Adaptive
quadSimpsonAdaptive (Adaptive tolerance maxDepth) f a b = 
    simpsonAdapt a b tolerance maxDepth
    where
        simpsonAdapt x y epsilon depth
            | depth <= 0 = leftValue + rightValue
            | abs (leftValue + rightValue - whole) < 15 * epsilon = leftValue + rightValue
            | otherwise = simpsonAdapt x m (epsilon / 2) (depth - 1) + simpsonAdapt m y (epsilon / 2) (depth - 1)
            where
                m = midpoint (x, y)
                whole = simpsonEstimate f x y
                leftValue = simpsonEstimate f x m
                rightValue = simpsonEstimate f m y
-- Task 10
data Method = Rectangle
            | Trapezoidal
            | SimpsonUniform
            | SimpsonAdaptive Adaptive
            deriving (Eq, Show)
-- Task 11
refine :: Int -> Method -> IntegralInfo -> [Double]
refine step method (IntegralInfo f (a, b)) = 
    case method of
        Rectangle -> map (\n -> quadRect (Uniform n) f a b) ns
        Trapezoidal -> map (\n -> quadTrap (Uniform n) f a b) ns
        SimpsonUniform -> map (\n -> quadSimpson (Uniform n) f a b) ns
        SimpsonAdaptive cfg -> repeat (quadSimpsonAdaptive cfg f a b)
        where
            multiplier = max 1 step
            ns = iterate (* multiplier) 1
-- Task 12
convergesIn :: Int -> Double -> Int -> Method -> IntegralInfo -> Either () Int
convergesIn maxApplications eps step method info =
    converge 1 approximations
    where
        approximations = take (maxApplications + 1) (convergenceApproximations step method info)

        converge _ [] = Left ()
        converge _ [_] = Left ()
        converge count (x : y : rest)
            | closeEnough x y =
                let answer = if maxApplications == 1 then 1 else count + 1
                in if answer <= maxApplications then Right answer else Left ()
            | count >= maxApplications = Left ()
            | otherwise = converge (count + 1) (y : rest)

        closeEnough x y = abs (y - x) <= eps * (1 + 14 * sqrt eps)

convergenceApproximations :: Int -> Method -> IntegralInfo -> [Double]
convergenceApproximations step method (IntegralInfo f (a, b)) =
    case method of
        Rectangle -> [quadRect (Uniform n) f a b | n <- ns]
        Trapezoidal -> [quadTrap (Uniform n) f a b | n <- ns]
        SimpsonUniform -> [quadSimpson (Uniform n) f a b | n <- ns]
        SimpsonAdaptive cfg -> repeat (quadSimpsonAdaptive cfg f a b)
    where
        increment = max 1 step
        ns = iterate (+ increment) 1
-- Task 13
data SIIntervalTree = Leaf Double (Double, Double)
                    | Branch Double (Double, Double) SIIntervalTree SIIntervalTree
                    deriving (Eq, Show)
-- Task 14
treeValue :: SIIntervalTree -> Double
treeValue (Leaf value _) = value
treeValue (Branch value _ _ _) = value

generate :: Adaptive -> IntegralInfo -> SIIntervalTree
generate (Adaptive tolerance maxDepth) (IntegralInfo f (a, b)) =
    generateFrom tolerance maxDepth f a b

generateFrom :: Double -> Int -> RealFunction -> Double -> Double -> SIIntervalTree
generateFrom tolerance depth f x y
    | depth <= 0 = Leaf (leftValue + rightValue) (x, y)
    | abs (leftValue + rightValue - whole) < 15 * tolerance =
        Branch (leftValue + rightValue) (x, y) (Leaf leftValue (x, m)) (Leaf rightValue (m, y))
    | otherwise =
        Branch (treeValue leftTree + treeValue rightTree) (x, y) leftTree rightTree
    where
        m = (x + y) / 2
        whole = simpsonEstimate f x y
        leftValue = simpsonEstimate f x m
        rightValue = simpsonEstimate f m y
        leftTree = generateFrom (tolerance / 2) (depth - 1) f x m
        rightTree = generateFrom (tolerance / 2) (depth - 1) f m y

-- Task 9 made with the generate function
--quadSimpsonAdaptive :: Integrator Adaptive
--quadSimpsonAdaptive cfg f a b =
--    treeValue (generate cfg (IntegralInfo f (a, b)))

main :: IO ()
main = do
    putStrLn "Start"
-- Task 1
    putStrLn "Task 1"
    print(interpolationNodes 4 (0,1))
-- Task 2
    putStrLn "Task 2"
    print(interpolationIntervals 4 (0,1))
-- Task 4
    putStrLn "Task 4"
    print(quadRect (Uniform 4) abs (-1) 1)
    print(quadRect (Uniform 4) (^2) 0 1)
    print(quadRect (Uniform 100) (^2) 0 1)
-- Task 5
    putStrLn "Task 5"
    print(quadTrap (Uniform 4) abs (-1) 1)
    print(quadTrap (Uniform 4) id 0 1)
    print(quadTrap (Uniform 4) (^2) 0 1)
    print(quadTrap (Uniform 100) (^2) 0 1)
-- Task 6
    putStrLn "Task 6"
    print(quadSimpson (Uniform 4) abs (-1) 1)
    print(quadSimpson (Uniform 4) id 0 1)
    print(quadSimpson (Uniform 4) (^2) 0 1)
-- Task 9
    putStrLn "Task 9"
    print(quadSimpsonAdaptive (Adaptive 1e-6 10) id 0 1)
    print(quadSimpsonAdaptive (Adaptive 1e-6 10) (^2) 0 1)
    print(quadSimpsonAdaptive (Adaptive 1e-14 10) sin 0 pi)
    print(quadSimpsonAdaptive (Adaptive 1e-16 10) sin 0 pi)
-- Task 11
    putStrLn "Task 11"
    print(take 4 $ refine 2 Rectangle (IntegralInfo (^2) (0, 1)))
    print(take 4 $ refine 2 Trapezoidal (IntegralInfo (^2) (0, 1)))
    print(take 4 $ refine 2 SimpsonUniform (IntegralInfo (^2) (0, 1)))
    print(take 4 $ refine 2 (SimpsonAdaptive (Adaptive 1e-16 10)) (IntegralInfo (^2) (0, 1)))
-- Task 12
    putStrLn "Task 12"
    print (convergesIn 20 1e-3 2 Rectangle (IntegralInfo (^2) (0,1)))
    print (convergesIn 20 1e-5 2 Rectangle (IntegralInfo (^2) (0,1)))
    print (convergesIn 20 1e-3 2 Trapezoidal (IntegralInfo (^2) (0,1)))
    print (convergesIn 20 1e-5 2 Trapezoidal (IntegralInfo (^2) (0,1)))
    print (convergesIn 30 1e-5 2 Trapezoidal (IntegralInfo (^2) (0,1)))
    print (convergesIn 1 1e-16 2 SimpsonUniform (IntegralInfo (^2) (0,1)))
    print (convergesIn 1 1e-16 2 (SimpsonAdaptive (Adaptive 1e-16 10)) (IntegralInfo (^2) (0,1)))
-- Task 14
    putStrLn "Task 14"
    print(generate (Adaptive 1e-18 20) (IntegralInfo (*2) (0,1)))
    print(generate (Adaptive 1e-6 20) (IntegralInfo sin (0,1)))