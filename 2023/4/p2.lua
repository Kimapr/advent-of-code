local out=0
local ls={}
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
	table.insert(ls,count)
end
local function win(i,v)
	out=out+1
	for i=i+1,i+v do
		if ls[i] then
			win(i,ls[i])
		end
	end
end
for i,v in ipairs(ls) do
	win(i,v)
end
print(out)
