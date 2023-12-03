#!/usr/bin/env lua
local out=0
local sdigs={
	"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
}
local digs={}
for n=0,9 do
	digs[tostring(n)]=n
end
for k,v in ipairs(sdigs) do
	digs[v]=k
end
for l in io.lines() do
	local nf,nl
	--[[l:gsub("[0-9]",function(c)
		nf=nf or c
		nl=c
	end)]]
	local i=1
	while i<=#l do
		for k,v in pairs(digs) do
			if l:sub(i,i+#k-1)==k then
				--i=i-1+#k
				nf=nf or v
				nl=v
				break
			end
		end
		i=i+1
	end
	out=out+tonumber(nf..nl)
end
print(out)
