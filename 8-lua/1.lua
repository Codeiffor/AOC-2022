local graph = {}
for line in io.lines("./input.txt") do
  graph[#graph + 1] = {}
  for i = 1, #line do
    graph[#graph][i] = { value = tonumber(line:sub(i, i)), visible = false }
  end
end

function value (i, j)
  return graph[i][j]["value"]
end
function visible (i, j)
  return graph[i][j]["visible"]
end

local height = #graph
local width = #graph[1]

for i = 1, height do
  graph[i][1]["visible"] = true
  graph[i][width]["visible"] = true
end
for j = 1, width do
  graph[1][j]["visible"] = true
  graph[height][j]["visible"] = true
end

function iterate(outer_start, outer_end, inner_start, inner_end, increment, horizontal)
  for i = outer_start, outer_end do
    local maxj = inner_start - increment
    local max = horizontal and value(i, maxj) or value(maxj, i)
    for j = inner_start, inner_end, increment do
      local x = horizontal and i or j
      local y = horizontal and j or i
      if value(x, y) > max then
        graph[x][y]["visible"] = true
        max = value(x, y)
      end
    end
  end
end

iterate(2, height - 1, 2, width -1, 1, true)
iterate(2, height - 1, width -1, 2, -1, true)
iterate(2, width - 1, 2, height -1, 1, false)
iterate(2, width - 1, height -1, 2, -1, false)

local visible_count = 0
for i = 1, height do
  for j = 1, width do
    if visible(i, j) then visible_count = visible_count + 1 end
    -- io.write(visible(i, j) and "1" or "0")
  end
  -- print()
end
print(visible_count)
