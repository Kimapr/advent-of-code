local it=io.lines()
local unpack = unpack or table.unpack

local function denumber(s)
	local t={}
	for s in s:gmatch("%d+") do
		t[#t+1]=tonumber(s)
	end
	return t
end

local function mapify(l)
	local t={}
	for k,v in pairs(l) do
		t[v]=true
	end
	return t
end

local seeds=mapify(denumber(it():match("seeds: (.+)")))
it()
local maps={}
local nmap={}
do
	local to,from,t
	for l in it do
		if l=="" then
			to,from,t=nil
		else
			print(("%q"):format(l))
			if not t then
				t={}
				from,to=l:match("(.-)%-to%-(.-) map:")
				print("map from "..from.." to "..to)
				nmap[from]=to
				maps[from]=t
			else
				local dst1,src1,len = l:match("(%d+)%s+(%d+)%s+(%d+)")
				print(dst1,src1,len)
				t[#t+1]={tonumber(dst1),tonumber(src1),tonumber(len)}
			end
		end
	end
end

local locs={}
for s in pairs(seeds) do
	print("MAPPING SEED "..s)
	local from="seed"
	while nmap[from] do
		print("mapping "..from.." to "..nmap[from])
		for _,map in pairs(maps[from]) do
			local dst1,src1,len=unpack(map)
			if s>=src1 and s<src1+len then
				s=s+(dst1-src1)
				print("remapped to "..s)
				break
			end
		end
		from=nmap[from]
	end
	print()
	locs[#locs+1]=s
end

print(math.min(unpack(locs)))
