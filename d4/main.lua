G = {}
for line in io.lines() do
	local row = {}
	for ch in line:gmatch(".") do
		table.insert(row, ch)
	end
	table.insert(G, row)
end

local function extract_paper(g)
	local todo = {}
	for y, row in ipairs(g) do
		for x, cell in ipairs(row) do
			local adj_paper = 0
			for _, vec in ipairs {
				{ -1, -1 },
				{ 0, -1 },
				{ 1, -1 },
				{ 1, 0 },
				{ 1, 1 },
				{ 0, 1 },
				{ -1, 1 },
				{ -1, 0 },
			} do
				local x2, y2 = x + vec[1], y + vec[2]
				if (g[y2] or {})[x2] == "@" then
					adj_paper = adj_paper + 1
				end
			end
			if cell == "@" and adj_paper < 4 then
				table.insert(todo, { x, y })
			end
		end
	end
	for _, pos in ipairs(todo) do
		g[pos[2]][pos[1]] = "."
	end
	return #todo
end

local P2, rounds = 0, 1
repeat
	local extracted = extract_paper(G)
	if rounds == 1 then print(extracted) end
	P2, rounds = P2 + extracted, rounds + 1
until extracted == 0
print(P2)
