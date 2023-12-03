local cubes={
	red=12,
	green=13,
	blue=14
}
local out=0
for l in io.lines(...) do
	local gid,l = l:match("Game (%d+): (.+)")
	local gg={}
	local magg={}
	local n,col
	local pun
	while l and not bad do
		n,col,l = l:match("(%d+) (%w+)(.*)")
		pun,l=l:match("(.) (.+)")
		gg[col]=(gg[col] or 0) + tonumber(n)
		magg[col]=not magg[col] and gg[col] or math.max(gg[col],magg[col])
		if not pun or pun==";" then
			gg={}
		end
	end
	local oo=1
	for k,v in pairs(magg) do
		print(gid,k,v)
		oo=oo*v
	end
	out=out+oo
end
print(out)
