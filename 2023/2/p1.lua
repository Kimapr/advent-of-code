local cubes={
	red=12,
	green=13,
	blue=14
}
local out=0
for l in io.lines(...) do
	local gid,l = l:match("Game (%d+): (.+)")
	local gg={}
	local n,col
	local pun
	local bad=false
	local function check()
		for k,v in pairs(gg) do
			if cubes[k]<v then
				print("BAD: "..gid.." "..v.." red > "..cubes[k])
				bad=true
			end
		end
	end
	while l and not bad do
		n,col,l = l:match("(%d+) (%w+)(.*)")
		pun,l=l:match("(.) (.+)")
		print(("%q %q %q"):format(n,col,pun))
		if gg[col] then
			error("WACK. "..col..": "..gg[col])
		end
		gg[col]=(gg[col] or 0) + tonumber(n)
		if not pun or pun==";" then
			print("RESET")
			check()
			gg={}
		end
	end
	if not bad then
		print("good",gid)
		out=out+tonumber(gid)
	end
end
print(out)
