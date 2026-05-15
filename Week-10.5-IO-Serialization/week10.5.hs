import System.IO
import Data.List (isPrefixOf)

main :: IO ()
main = do
-- Tasks from Exercise - Week 10.5
-- Task 1
    line <- getLine
    if line == "quit"
        then putStrLn "Goodbye!"
        else do
            putStrLn (reverse line)
            main
-- Task 2
calculator :: IO ()
calculator = do
    putStr "Operations (+, -, *, /): "
    op <- getLine
    putStr "First number: "
    n1 <- readLn :: IO Double
    putStr "Second number: "
    n2 <- readLn :: IO Double
    case op of
        "+" -> print (n1 + n2)
        "-" -> print (n1 - n2)
        "*" -> print (n1 * n2)
        "/" -> if n2 == 0 
            then putStrLn "Error: division by 0!" 
            else print (n1 / n2)
        _   -> putStrLn "Invalid operation!"
-- Task 3
fileStats :: FilePath -> IO ()
fileStats path = do
    content <- readFile path
    let ls = lines content
    let ws = words content
    putStrLn $ "Rows: " ++ show (length ls)
    putStrLn $ "Words: " ++ show (length ws)
    putStrLn $ "Symbols: " ++ show (length content)
    putStrLn $ "Longest row: " ++ show (maximum (map length ls))
-- Task 4
printCSV :: FilePath -> IO ()
printCSV path = do
    content <- readFile path
    let (header:rows) = map (splitBy ',') (lines content)
    let pad s = s ++ replicate (9 - length s) ' '
    let printRow cells = putStrLn $ unwords (map (\x -> "| " ++ x) (map pad cells)) ++ " |"
    
    printRow header
    putStrLn "|-----------|-----------|-----------|"
    mapM_ printRow rows

splitBy :: Char -> String -> [String]
splitBy c s = case dropWhile (== c) s of
                "" -> []
                s' -> let (w, s'') = break (== c) s'
                    in w : splitBy c s''
-- Task 5
todoFile :: FilePath
todoFile = "todo.txt"

main' :: IO ()
main' = do
    putStrLn "--- TODO list ---"
    putStrLn "Commands: add <task>, done <number>, list, save, load, quit"
    todoLoop []

todoLoop :: [String] -> IO ()
todoLoop tasks = do
    putStr "todo> "
    hFlush stdout
    input <- getLine
    let parts = words input
    
    if null parts then todoLoop tasks
    else case head parts of
        "add" -> do
            let newTask = unwords (tail parts)
            if null newTask 
                then putStrLn "Error: No description!" >> todoLoop tasks
                else do
                    let newTasks = tasks ++ [newTask]
                    putStrLn "Added!"
                    todoLoop newTasks

        "list" -> do
            if null tasks 
                then putStrLn "Empty list!"
                else mapM_ (\(i, t) -> putStrLn $ show i ++ ". [ ] " ++ t) (zip [1..] tasks)
            todoLoop tasks

        "done" -> do
            let rest = tail parts
            if null rest then putStrLn "Error: enter number!" >> todoLoop tasks
            else do
                let idx = read (head rest) - 1
                if idx < 0 || idx >= length tasks
                    then putStrLn "Invalid number!" >> todoLoop tasks
                    else do
                        let newTasks = take idx tasks ++ drop (idx + 1) tasks
                        putStrLn "Task was removed!"
                        todoLoop newTasks

        "save" -> do
            writeFile todoFile (unlines tasks)
            putStrLn $ "Added to " ++ todoFile
            todoLoop tasks

        "load" -> do
            content <- readFile todoFile
            let loadedTasks = lines content
            putStrLn "Loaded!"
            todoLoop loadedTasks

        "quit" -> putStrLn "Goodbye!"

        _ -> do
            putStrLn "Invalid command!"
            todoLoop tasks