local function max_joltage(bank, num_batteries)
	local last_pick, turned_on_joltages = 0, {}
	local can_take = #bank - num_batteries - last_pick

	while num_batteries > 0 do
		local max_n = -1
		for i = last_pick + 1, last_pick + 1 + can_take do
			if bank[i] > max_n then
				max_n, last_pick = bank[i], i
			end
		end
		num_batteries = num_batteries - 1
		can_take = #bank - num_batteries - last_pick
		table.insert(turned_on_joltages, max_n)
	end

	return tonumber(table.concat(turned_on_joltages))
end

P1, P2 = 0, 0
for line in io.lines() do
	local nums = {}
	for char in line:gmatch(".") do
		table.insert(nums, tonumber(char))
	end
	P1, P2 = P1 + max_joltage(nums, 2), P2 + max_joltage(nums, 12)
end
print(P1, P2)
