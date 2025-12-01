P1, P2, DIAL = 0, 0, 50
for line in io.lines() do
	local dir, distance = line:sub(0, 1), tonumber(line:sub(2))
	for i = 1, distance do
		DIAL = DIAL + (dir == "R" and 1 or -1)
		if dir == "R" and DIAL > 99 then DIAL = 0 end
		if dir == "L" and DIAL < 0 then DIAL = 99 end
		if DIAL == 0 then P2 = P2 + 1 end
	end
	if DIAL == 0 then P1 = P1 + 1 end
end
print(P1, P2)
