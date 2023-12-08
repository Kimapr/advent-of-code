-- NOTE: does not work

local it=io.lines(...)
local ins=it()it()
local f=load((("return function(n,f) %s return n end"):format(ins:gsub(".",function(c)
	if c=="L" then
		return "n=n[1]f(n)"
	elseif c=="R" then
		return "n=n[2]f(n)"
	end
	error("meow")
end))))()

local nodes={}
for l in it do
	local n,a,b = l:match("(.-) = %((.-), (.-)%)")
	if not n then break end
	n={n=n,a,b}
	nodes[n.n]=n
end
for _,n in pairs(nodes) do
	n[1]=nodes[n[1]]
	n[2]=nodes[n[2]]
end

local ns={}
local ends={}
for k,v in pairs(nodes) do
	if k:match("A$") then
		print("S",k)
		ns[#ns+1]=v
	elseif k:match("Z$") then
		print("E",k)
		ends[k]=true
	end
end

local s=0
local np=0
local is={L=1,R=2}
while true do
	s=s+#ins
	local gg=false
	for i=1,#ins do
		local c=ins:sub(i,i)
		local good=true
		local hs=false
		for k,v in pairs(ns) do
			if not ends[v.n] then
				good=false
				break
			else
				hs=true
			end
		end
		if hs and s>np then
			np=s+100000
			for k,v in pairs(ns) do
				io.write(ends[v.n] and "#" or ".")
			end
			print("",s)
		end
		if good then gg=true break end
		for k,v in pairs(ns) do
			ns[k]=v[is[c]]
		end
		s=s+1
	end
	if gg then break end
end
for k,v in pairs(ns) do
	io.write(v.n)
end
print()
print(s)
