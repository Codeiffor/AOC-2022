graph = fill(".", (1000, 1000))
depth = 0

lines = readlines("./input.txt")
for line in lines
	line = split(replace(line, " " => ""), "->")
	p1 = -1
	p2 = -1
	for pair in line
		pair = split(pair, ",")
		n1 = parse(Int64, pair[2])
		n2 = parse(Int64, pair[1])
		if n1 > depth
			global depth = n1
		end
		graph[n1, n2] = "#"
		if p1 > -1
			for i = min(n1, p1):max(n1, p1)
				for j = min(n2, p2):max(n2, p2)
					graph[i, j] = "#"
				end
			end
		end
		p1 = n1
		p2 = n2
	end
end

function simulate_fall()
	i = 0
	j = 500
	count = 0
	while(i <= depth)
		if graph[i + 1,j] == "."
			i += 1
		elseif graph[i + 1, j - 1] == "."
			i += 1
			j -= 1
		elseif graph[i + 1, j + 1] == "."
			i += 1
			j += 1
		elseif i == 0
			count += 1
			break
		else
			count += 1
			graph[i, j] = "o"
			i = 0
			j = 500
		end
	end
	return count
end

ans1 = simulate_fall()

depth += 2
for j = 1:1000
	graph[depth, j] = "#"
end

ans2 = ans1 + simulate_fall()


println("part 1: ", ans1)
println("part 2: ", ans2)

#=
for i = 1:150
for j in 300:700
print(graph[i,j], " ")
end
println()
end
=#
