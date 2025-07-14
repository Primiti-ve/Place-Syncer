local stdio = require("@lune/stdio")
local process = require("@lune/process")

local Module = require("./Module")

local Arguments = process.args
local NewArguments = {}

if not Arguments[1] then
	NewArguments[1] = stdio.prompt("Text", "Enter first place ID:")
else
	NewArguments[1] = Arguments[1]
end

if not Arguments[2] then
	NewArguments[2] = stdio.prompt("Text", "Enter second place ID:")
else
	NewArguments[2] = Arguments[2]
end

if not Arguments[3] then
	NewArguments[3] = stdio.prompt("Text", "Enter output name:")
else
	NewArguments[3] = Arguments[3]
end

local ID1 = NewArguments[1]
local ID2 = NewArguments[2]
local OutputName = NewArguments[3]

Module(ID1, ID2, OutputName)