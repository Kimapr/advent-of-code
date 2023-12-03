local gr={}
setmetatable(gr,{
	__index=function(s,k)
		s[k]={}
		return s[k]
	end
})
do
	local y=0
	for l in io.lines() do
		y=y+1
		local x=0
		l:gsub('.',function(c)
			x=x+1
			gr[y][x]=c
		end)
	end
end
local out=0
for y1=1,#gr do
	local numx
	local num
	for x1=1,#gr[y1]+1 do
		local c=gr[y1][x1]
		local numed=false
		if c and c:match("[0-9]") then
			if not numx then
				numx=x1
				num=""
			end
			num=num..c
		elseif numx then
			local symb=false
			for y=y1-1,y1+1 do
			for x=numx-1,x1 do
				local c=gr[y][x]
				if c and c:match("[^.0-9]") then
					symb=true
				end
			end end
			if symb then
				--print("+",num)
				out=out+tonumber(num)
				numed=true
			else
				--print("-",num)
			end
			numx=nil
			num=nil
		end
		io.write((not numed) and (c or "") or "X")
	end
	print()
	--print("##--##--##")
end
print(out)
