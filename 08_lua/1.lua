local graph = {}
for line in io.lines("./input.txt") do
  graph[#graph + 1] = {}
  for i = 1, #line do
    graph[#graph][i] = { value = tonumber(line:sub(i, i)), visible = false, score = 1 }
  end
end

function value (i, j)
  return graph[i][j]["value"]
end
function visible (i, j)
  return graph[i][j]["visible"]
end
function score (i, j)
  return graph[i][j]["score"]
end

local height = #graph
local width = #graph[1]

for i = 1, height do
  graph[i][1]["score"] = 0
  graph[i][width]["score"] = 0
  graph[i][1]["visible"] = true
  graph[i][width]["visible"] = true
end
for j = 1, width do
  graph[1][j]["score"] = 0
  graph[height][j]["score"] = 0
  graph[1][j]["visible"] = true
  graph[height][j]["visible"] = true
end

function iterate(outer_start, outer_end, inner_start, inner_end, increment, horizontal)
  for i = outer_start, outer_end do
    local sizeMap = {}
    local edge = inner_start - increment
    local edgeV = horizontal and value(i, edge) or value(edge, i)
    sizeMap[edgeV] = edge
    local max = edgeV
    for j = inner_start, inner_end, increment do
      local x = horizontal and i or j
      local y = horizontal and j or i
      -- part 1
      if value(x, y) > max then
        graph[x][y]["visible"] = true
        max = value(x, y)
      end
      -- part 2
      local v = value(x, y)
      local closest_idx = edge
      for k = v, 9 do
        if sizeMap[k] ~= nil then
          if increment * sizeMap[k] > increment * closest_idx then
            closest_idx = sizeMap[k]
          end
        end 
      end
      graph[x][y]["score"] = increment * (j - closest_idx) * score(x, y)
      sizeMap[v] = j
    end
  end
end

iterate(2, height - 1, 2, width - 1, 1, true)
iterate(2, height - 1, width -1, 2, -1, true)
iterate(2, width - 1, 2, height - 1, 1, false)
iterate(2, width - 1, height -1, 2, -1, false)

local visible_count = 0
local max_score = 0
for i = 1, height do
  for j = 1, width do
    if visible(i, j) then visible_count = visible_count + 1 end
    if score(i, j) > max_score then max_score = score(i, j) end
  end
end
print("part 1:", visible_count)
print("part 2:", max_score)
