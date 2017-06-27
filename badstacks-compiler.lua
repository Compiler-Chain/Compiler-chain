local s = ">>>>+>>+>"

local funcs = {
	PUSH = ">>>+>",
	POP = "<<<<<[>>>>>[-]<-]>>>>[>[-]>>>>>>>]<<<<<<<",
	FLIP = ">[>>>>]-[+<<<<-]+>",
	PEEK = "[->>>+>+<<<<]>>>[-<<<+>>>]+>",
	WHILE = "[",
	END = "]",
	WRITE = ".",
	RAND = "?",
	DEC = "-",
	INC = "+",
	ZERO = "[-]",
	STACKADD = "[-<<<<+>>>>]<-<<<",
	STACKSUB = "[-<<<<->>>>]<-<<<"
}

setmetatable(_G, {__index = funcs})
funcs.MOVE = FLIP .. PUSH .. FLIP .. "[-" .. FLIP .. "+" .. FLIP .. "]" .. POP .. FLIP
funcs.COPY = PEEK .. MOVE
funcs.READ = PUSH .. ","
funcs.ADD = FLIP .. COPY .. STACKADD
funcs.NEGATE = "[->+<]>[-<->]<"
funcs.SUB = FLIP .. COPY .. STACKSUB

local inStr = "80 3 STACKSUB"

for S in inStr:gmatch"%S+" do
	if tonumber(S) then
		s = s .. funcs.PUSH .. ("+"):rep(tonumber(S))
	end
	if funcs[S] then
		s = s .. funcs[S]
	end
end

print(s)