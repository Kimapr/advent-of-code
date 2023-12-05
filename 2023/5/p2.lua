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

local seedsp=denumber(it():match("seeds: (.+)"))
local seeds={}
while true do
	local a,b=table.remove(seedsp,1),table.remove(seedsp,1)
	if not a then break end
	assert(b)
	a,b=tonumber(a),tonumber(b)
	seeds[{a,a+b-1}]=true
end
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
				local sa,sb=src1,src1+len-1
				local off=(dst1-src1)
				print(sa,sb,off)
				t[#t+1]={tonumber(dst1),tonumber(src1),tonumber(len)}
			end
		end
	end
end

local locs={}
local minloc = math.huge
local function consider(n)
	minloc=math.min(minloc,n)
end
print()
for t in pairs(seeds) do
	local a,b=unpack(t)
	print("MAPPING SEED "..a.." to "..b)
	local from="seed"
	local ranges={{a,b}}
	while nmap[from] do
		print("","mapping "..from.." to "..nmap[from])
		for k,v in ipairs(ranges) do
			v.mapped=nil
			print("","",v[1],v[2])
		end
		print("","I")
		for _,map in pairs(maps[from]) do
			local dst1,src1,len=unpack(map)
			local sa,sb=src1,src1+len-1
			local off=(dst1-src1)
			--local off=(src1-dst1)
			for ir,r in ipairs(ranges) do
				local a,b=r[1],r[2]
				if not r.mapped then
					if (
						a>=sa and a<=sb or
						sa>=a and sa<=b or
						b>=sa and b<=sb or
						sb>=a and sb<=b
					) then
						print("","","map "..a..".."..b.." in "..sa..".."..sb.." off "..off)
						local rr={}
						if sa>a then
							print("","","rr++A")
							rr[#rr+1]={a,sa-1}
						end
						rr[#rr+1]={math.max(sa,a)+off,math.min(sb,b)+off,mapped=true}
						if sb<b then
							print("","","rr++B")
							rr[#rr+1]={sb+1,b}
						end
						table.remove(ranges,ir)
						for k,v in ipairs(rr) do
							table.insert(ranges,ir-1+k,v)
							print("","","rr",v[1],v[2])
						end
					else
						print("","","dont map "..a..".."..b.." in "..sa..".."..sb.." off "..off)
					end
				end
			end
		end
		print("","O")
		for k,v in ipairs(ranges) do
			print("","",v[1],v[2],v.mapped)
		end
		print()
		from=nmap[from]
	end
	print()
	for k,v in pairs(ranges) do
		consider(v[1])
	end
end
print(minloc)
