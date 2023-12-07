
local tunrk ={
"A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"
}
local ranks={}
for i,v in ipairs(tunrk) do
	ranks[v]=#tunrk-i
end

local bids={}
for l in io.lines(...) do
	local hand,bid = l:match("(%S+)%s+(%S+)")
	bid=tonumber(bid)
	if not bid then break end
	local pp={}
	local bigpp=0
	local ppid
	hand:gsub('.',function(c)
		pp[c]=(pp[c] or 0) +1
		if pp[c]>bigpp and c~='J' then
			bigpp=pp[c]
			ppid=c
		end
	end)
	local score=0
	if pp.J and ppid then
		pp[ppid]=pp[ppid]+pp.J
		pp.J=nil
	end
	for k,v in pairs(pp) do
		score=score+(#hand)^(v)
	end
	bids[#bids+1]={hand,bid,score}
end
local function cmp(a,b)
	if a[3]~=b[3] then return a[3]<b[3] end
	for i=1,math.min(#a[1],#b[1]) do
		local as,bs=a[1]:sub(i,i),b[1]:sub(i,i)
		local a,b=ranks[a[1]:sub(i,i)],ranks[b[1]:sub(i,i)]
		if a~=b then return a<b end
		assert(as==bs)
	end
	return false
end
table.sort(bids,cmp)
local out=0
local rank=0
for k=1,#bids do
	local v=bids[k]
	local pv=bids[k-1] or v
	if k==1 or not (not cmp(v,pv) and not cmp(pv,v)) then
		rank=rank+1
	end
	print(v[1],v[2],v[3],rank,cmp(v,pv),cmp(pv,v))
	out=out+v[2]*rank
end
print(out)
