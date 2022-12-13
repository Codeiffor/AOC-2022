import std/tables

var matrix: seq[string]
for line in lines "input.txt":
  matrix.add(line)
var m = len(matrix)
var n = len(matrix[0])
var si, sj, di, dj: int
for i in countup(0, m - 1):
  for j in countup(0, n - 1):
    if matrix[i][j] == 'S':
      matrix[i][j] = 'a'
      si = i
      sj = j
    elif matrix[i][j] == 'E':
      matrix[i][j] = 'z'
      di = i
      dj = j

var minSteps = m * n
var visited = initTable[(int, int), int]()

proc traverse(i, j, count : int, matchAny: bool): void =
  if (i == si and j == sj and not matchAny) or (matchAny and matrix[i][j] == 'a'):
    if count < minSteps:
      minSteps = count
    return
  if not visited.contains((i, j)) or count < visited[(i, j)]:
    visited[(i, j)] = count
    for (x, y) in [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)]:
        if x > -1 and x < m and y > -1 and y < n:
          if int(matrix[x][y]) - int(matrix[i][j]) >= -1:
            traverse(x, y, count + 1, matchAny)
 
traverse(di, dj, 0, false)
echo "part 1: ", minSteps

minSteps = m * n
visited = initTable[(int, int), int]()
traverse(di, dj, 0, true)
echo "part 2: ", minSteps
