local out=0
for l in io.lines(...) do
	local i,win,me = l:match("Card (.-): (.-) | (.+)")
	local wins={}
	for d in win:gmatch("%d+") do
		wins[tonumber(d)]=true
	end
	local count=0
	for d in me:gmatch("%d+") do
		if wins[tonumber(d)] then
			count=count+1
		end
	end
	if count>0 then
		out=out+2^(count-1)
	end
end
print(out)
