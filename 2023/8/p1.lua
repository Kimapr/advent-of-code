local it=io.lines(...)
local ins=it()it()
local f=load((("return function(n) %s return n end"):format(ins:gsub(".",function(c)
	if c=="L" then
		return "n=n[1]"
	elseif c=="R" then
		return "n=n[2]"
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

local n=nodes.AAA

local s=0
while n~=nodes.ZZZ do
	s=s+#ins
	n=f(n)
end
print(s)
