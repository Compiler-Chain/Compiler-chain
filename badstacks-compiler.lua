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
	NEGATE = "[->+<]>[-<->]<",
	STACKADD = "[-<<<<+>>>>]<-<<<",
	STACKSUB = "[-<<<<->>>>]<-<<<",
	STACKMULT = "<<<<[->>>>[->>>+>+<<<<]>>>[-<<<+>>>]<<<<<<<]>>>>>>>>[-<<<<<<<<+>>>>>>>>]<<<<[-]<-<<<",
	NOT = ">>>+<<<[[-]>>>-<<<]>>>[-<<<+>>>]<<<"
}

setmetatable(_G, {__index = funcs})
funcs.MOVE = FLIP .. PUSH .. FLIP .. "[-" .. FLIP .. "+" .. FLIP .. "]" .. POP .. FLIP
funcs.COPY = PEEK .. MOVE
funcs.READ = PUSH .. ","
funcs.ADD = FLIP .. COPY .. STACKADD
funcs.SUB = FLIP .. COPY .. STACKSUB
funcs.MULT = FLIP .. COPY .. STACKMULT
local charNames = {p=PUSH, P=POP,f=FLIP,c=PEEK,["["]=WHILE,["]"]=END,["."]=WRITE,[","]=READ,["?"]=RAND,["-"]=DEC,["+"]=INC,z=ZERO,n=NEGATE,a=STACKADD,A=ADD,m=STACKMULT,M=MULT,s=STACKSUB,S=SUB,F=MOVE,C=COPY,["!"]=NOT,["0"]=PUSH,["1"]=PUSH.."+",["2"]=PUSH.."++",["3"]=PUSH.."+++",["4"]=PUSH.."++++",["5"]=PUSH.."+++++",["6"]=PUSH.."++++++",["7"]=PUSH.."+++++++",["8"]=PUSH.."++++++++",["9"]=PUSH.."+++++++++"}
--local charNames = {p=PUSH}
local inStr = "WRITE_THE_HEADER\n"
for s in (">>>>+>>+>"):gmatch"." do
	inStr = inStr .. string.byte(s) .. " WRITE "
end
inStr = inStr .. "\nREAD WHILE\n"
for name,func in pairs(charNames) do
	inStr = inStr .. "\tPEEK "..string.byte(name).." STACKSUB NOT WHILE IF_CHAR_IS(" .. name .. ")\n\t\tWRITE("..func..")\n"
	for s in func:gmatch"." do
		inStr = inStr .. "\t\tPOP " .. string.byte(s) .. " WRITE\n"
	end
	inStr = inStr .. "\t\tPOP 0\n\tEND POP\n"
end

inStr = inStr .. "\tPOP READ\nEND"

print(inStr)
for S in inStr:gmatch"%S+" do
	if tonumber(S) then
		s = s .. funcs.PUSH .. ("+"):rep(tonumber(S))
	end
	if funcs[S] then
		s = s .. funcs[S]
	end
end

print(s)