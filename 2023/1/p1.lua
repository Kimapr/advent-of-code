#!/usr/bin/env lua
local out=0
for l in io.lines() do
	local nf,nl
	l:gsub("[0-9]",function(c)
		nf=nf or c
		nl=c
	end)
	out=out+tonumber(nf..nl)
end
print(out)
