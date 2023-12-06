local it=io.lines(...)
local function denumber(s)
	local t={}
	for s in s:gmatch("%d+") do
		t[#t+1]=tonumber(s)
	end
	return t
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
