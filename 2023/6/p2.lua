local it=io.lines(...)
local function denumber(s)
	local num=""
	for s in s:gmatch("%d+") do
		num=num..s
	end
	return {tonumber(num)}
end
local times=denumber(it():match("Time:(.+)"))
local dists=denumber(it():match("Distance:(.+)"))
local out=1
for i, t in ipairs(times) do
	local sout=0
	local d=dists[i]
	for tt=1,t-1 do
		if (t-tt)*tt > d then
			sout=sout+1
		end
	end
	out=out*sout
end
print(out)
