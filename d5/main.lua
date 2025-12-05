-- Only works on ranges sorted from left to right.
--              xoooooox
--           xoooooooooooox
-- In this case (not sorted), neither the start nor the end of the second range
-- overlaps with the first, and the function would return false.
local function overlap_sorted(r1, r2)
	return r2[1] >= r1[1] and r2[1] <= r1[2]
		or r2[2] >= r1[1] and r2[2] <= r1[2]
end

local ranges, numbers = {}, {}
for line in io.lines() do
	if line:match("-") then
		local from, to = line:match("(%d+)-(%d+)")
		table.insert(ranges, { tonumber(from), tonumber(to) })
	elseif line:match("%d") then
		table.insert(numbers, tonumber(line))
	end
end

table.sort(ranges, function(a, b)
	if a[1] == b[1] then return a[2] < b[2] end
	return a[1] <= b[1]
end)

-- Merge overlapping ranges
local new_ranges = { ranges[1] }
for i, range in ipairs(ranges) do
	if i > 1 then
		local last = new_ranges[#new_ranges]
		if overlap_sorted(last, range) then
			new_ranges[#new_ranges] = {
				math.min(last[1], range[1]),
				math.max(last[2], range[2]),
			}
		else
			table.insert(new_ranges, range)
		end
	end
end

local P2 = 0
for _, r in ipairs(new_ranges) do
	P2 = P2 + (r[2] - r[1]) + 1 -- + 1 because of inclusive range end
end

local P1 = 0
for _, n in ipairs(numbers) do
	for _, range in ipairs(ranges) do
		if n >= range[1] and n <= range[2] then
			P1 = P1 + 1
			goto continue
		end
	end
	::continue::
end

print(P1, P2)
