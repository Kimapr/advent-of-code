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
for y1=1,#gr do
	local numx
	local num
	for x1=1,#gr[y1]+1 do
		local c=gr[y1][x1]
		if c and c:match("[0-9]") then
			if not numx then
				numx=x1
				num=""
			end
			num=num..c
		elseif numx then
			local obj={n=tonumber(num)}
			for x=numx,x1-1 do
				gr[y1][x]=obj
			end
			numx=nil
			num=nil
		end
	end
end
local out=0
for y1=1,#gr do
	for x1=1,#gr[y1] do
		local c=gr[y1][x1]
		if c=="*" then
			local t={}
			local cc=0
			for y=y1-1,y1+1 do
			for x=x1-1,x1+1 do
				local b=gr[y][x]
				if type(b)=="table" then
					if not t[b] then
						cc=cc+1
						t[b]=b.n
					end
				end
			end end
			if cc==2 then
				local nn=1
				for _,n in pairs(t) do nn=nn*n end
				out=out+nn
			end
		end
	end
end
print(out)
