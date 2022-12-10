import System.IO (isEOF)

getContainers :: IO [String]
getContainers = do
  line <- getLine
  if line == ""
    then return []
    else fmap (line :) getContainers

getInstructions :: IO [(Int, Int, Int)]
getInstructions = do
  end <- isEOF
  if end
    then return []
    else do
      line <- getLine
      let b1 = drop 1 (dropWhile (/= ' ') line)
      let a = (read (takeWhile (/= ' ') b1) :: Int)
      let b2 = drop 2 (dropWhile (/= 'm') b1)
      let b = (read (takeWhile (/= ' ') b2) :: Int) - 1
      let c = (read (drop 2 (dropWhile (/= 'o') b2)) :: Int) - 1
      fmap ((a, b, c) :) getInstructions

transpose :: [String] -> [String]
transpose ([] : _) = []
transpose x = map head x : transpose (map tail x)

removeSpaces :: String -> String
removeSpaces [] = []
removeSpaces x =
  if head x == ' '
    then []
    else head x : removeSpaces (tail x)

clean :: Integral a => ([String], a) -> [String]
clean ([], i) = []
clean (x : xs, i) =
  if i >= 0 && mod i 4 == 0
    then removeSpaces x : clean (xs, i + 1)
    else clean (xs, i + 1)

move1 (0, c1, c2) = (c1, c2)
move1 (c, c1, c2) = do
  if not (null c1)
    then do
      let c1u = tail c1
      let c2u = head c1 : c2
      move1 (c - 1, c1u, c2u)
    else (c1, c2)

move2 (c, c1, c2) = (drop c c1, take c c1 ++ c2)

run ([], c, move) = c
run (i : is, c, move) = do
  let (n, a, b) = i
  let (c1, c2) = move (n, c !! a, c !! b)
  let cu1 = take a c ++ [c1] ++ drop (a + 1) c
  let cu2 = take b cu1 ++ [c2] ++ drop (b + 1) cu1
  run (is, cu2, move)

topElems = foldr ((:) . head) ""

main :: IO (Maybe a)
main = do
  c1 <- getContainers
  let c2 = reverse c1
  let c3 = transpose (tail c2)

  let containers = map reverse (clean (c3, -1))
  instructions <- getInstructions

  let updatedContainers = run (instructions, containers, move1)
  let updatedContainers2 = run (instructions, containers, move2)
  
  -- print updatedContainers

  let ans1 = topElems updatedContainers
  let ans2 = topElems updatedContainers2
  print ans1
  print ans2

  return Nothing
