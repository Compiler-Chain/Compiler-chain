-- MEMORY
-- ...[VARTYPE][NA][FALSEY][CHUNK][RAIL][CHUNK][VARTYPE]
-- [VARTYPE][CHUNK][RAIL][CHUNK][FALSEY][NA]

io.write("01")

local CYCLELEFT = "Ff"
local CYCLERIGHT = "fF"
local VARLEFT = "[" .. CYCLELEFT .. CYCLELEFT .. "]" .. CYCLELEFT .. CYCLELEFT .. "c![P+pz]P"
local VARRIGHT = CYCLERIGHT .. CYCLERIGHT .. CYCLERIGHT .. CYCLERIGHT .. "[" .. CYCLERIGHT .. CYCLERIGHT .. "]"..CYCLELEFT .. CYCLELEFT .. "c![P"..CYCLERIGHT..CYCLERIGHT.."+pz]P"
local WHILE = CYCLELEFT .. "[" .. CYCLERIGHT
local END = CYCLELEFT .. "]" .. CYCLERIGHT
local WRITEBYTES = "[" .. CYCLELEFT .. "." .. CYCLELEFT .. "]" .. CYCLERIGHT .. CYCLERIGHT .. "[" .. CYCLERIGHT .. CYCLERIGHT .. "]" .. CYCLELEFT .. CYCLELEFT
local INC = CYCLELEFT .. "+c![P"..CYCLELEFT.."c![Ppp1pz]P"..CYCLELEFT.."+c!]P"..CYCLERIGHT.."["..CYCLERIGHT..CYCLERIGHT.."]"..CYCLELEFT..CYCLELEFT
local DEC = CYCLELEFT .. "-c+![Ppz"..CYCLELEFT.."c![P-"..CYCLERIGHT.."Pc!pz]P]P"..CYCLERIGHT.."["..CYCLERIGHT..CYCLERIGHT.."]"..CYCLELEFT..CYCLELEFT
local CONCAT = CYCLERIGHT .. CYCLERIGHT .. CYCLERIGHT .. CYCLERIGHT ..
		"[" .. CYCLELEFT .. CYCLELEFT .. CYCLELEFT .. CYCLELEFT ..
			"[" .. CYCLELEFT .. CYCLELEFT .. "]" ..
			"pp+[" .. CYCLERIGHT .. CYCLERIGHT .. "]" .. CYCLERIGHT ..
			"[-" .. CYCLELEFT .. CYCLELEFT .. CYCLELEFT .. "[" .. CYCLELEFT .. CYCLELEFT .. "]" .. CYCLERIGHT .. "+" .. CYCLERIGHT .. "[" .. CYCLERIGHT .. CYCLERIGHT .. "]" .. CYCLERIGHT .. "]" ..
			"PP"..CYCLERIGHT..CYCLERIGHT.."]" ..
		"PP" .. CYCLELEFT
local CLIPEND = "["..CYCLELEFT .. CYCLELEFT .. "]"..CYCLERIGHT .. CYCLERIGHT .. "PP" .. CYCLERIGHT .. CYCLERIGHT .. "["..CYCLERIGHT .. CYCLERIGHT .. "]" .. CYCLELEFT .. CYCLELEFT


local commands = {["+"]=INC, ["-"]=DEC, p=WRITEBYTES, ["["]=WHILE, ["]"]=END, ["<"]=VARLEFT, [">"]=VARRIGHT, c=CONCAT}

local inp = [=[
	"Hello, World">'!<cp
]=]

local i = 1
while i <= #inp do
	local Nxt = inp:sub(i,i)
	local nxt = commands[Nxt]
	if type(nxt) == "string" then
		io.write(nxt)
	elseif Nxt == "'" then
		i = i + 1
		io.write(CYCLELEFT .. ("+"):rep(inp:sub(i,i):byte()) .. CYCLERIGHT)
	elseif Nxt == "\"" then
		local newString = CYCLELEFT
		i = i + 1
		while i <= #inp do
			local s = inp:sub(i,i)
			if s == "\\" then
				i = i + 1
			elseif s == "\""then
				break
			end
			newString = newString .. ("+"):rep(inp:sub(i,i):byte()) .. CYCLELEFT .. "c![Ppp+pz]P" .. CYCLELEFT
			i = i + 1
		end
		io.write(newString .. CYCLERIGHT .. "[" .. CYCLERIGHT .. CYCLERIGHT .. "]" .. CYCLELEFT .. CYCLELEFT .. CLIPEND)
	end
	i = i + 1
end

--print("58m")