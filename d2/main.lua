function str_repeats(sub_str_len, str)
	local first_sub_str, to = str:sub(0, sub_str_len), sub_str_len * 2
	while to <= #str do
		if str:sub(to - sub_str_len + 1, to) ~= first_sub_str then
			return false
		end
		to = to + sub_str_len
	end
	return true
end

function invalid_p1(n)
	local str = tostring(n)
	if #str % 2 ~= 0 then return false end
	return str_repeats(#str / 2, str)
end

function invalid_p2(n)
	local str = tostring(n)
	local cur_size = #str // 2
	while cur_size >= 1 do
		if #str % cur_size ~= 0 then goto continue end
		if str_repeats(cur_size, str) then return true end
		::continue::
		cur_size = cur_size - 1
	end
	return false
end

local P1, P2 = 0, 0
for from, to in io.read():gmatch("(%d+)-(%d+)") do
	from, to = tonumber(from), tonumber(to)
	for i = from, to do
		if invalid_p1(i) then P1 = P1 + i end
		if invalid_p2(i) then P2 = P2 + i end
	end
end
print(P1, P2)
