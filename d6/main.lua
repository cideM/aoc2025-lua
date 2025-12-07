local ops, nums, lines = {}, {}, {}

-- Part 1
for line in io.lines() do
	table.insert(lines, line)
	if line:match("*") then
		for char in line:gmatch("[+*]") do
			table.insert(ops, char)
		end
	else
		for char in line:gmatch("(%d+)") do
			local n = tonumber(char)
			table.insert(nums, tonumber(n))
		end
	end
end

local P1 = 0
for col, op in ipairs(ops) do
	local out = nums[col]
	for i = col + #ops, #nums, #ops do
		if op == "*" then
			out = out * nums[i]
		else
			out = out + nums[i]
		end
	end
	P1 = P1 + out
end

-- Part 2
local lines_without_ops_line = table.move(lines, 1, #lines - 1, 1, {})
local P2 = 0
local start_col = #lines[1]

for op_idx = #ops, 1, -1 do
	local cur_nums, op = {}, ops[op_idx]
	for col = start_col, 1, -1 do
		local buf = {}
		for line = 1, #lines - 1 do
			table.insert(
				buf,
				lines_without_ops_line[line]:sub(col, col)
			)
		end

		local n = tonumber(table.concat(buf))

		if n == nil then
			start_col = col - 1
			goto continue
		else
			table.insert(cur_nums, n)
		end
	end

	::continue::

	local result = cur_nums[1]
	for i, n in ipairs(cur_nums) do
		if i > 1 then
			if op == "*" then
				result = result * n
			else
				result = result + n
			end
		end
	end

	P2 = P2 + result
end

print(P1, P2)
