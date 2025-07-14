local stdio = require("@lune/stdio")
local process = require("@lune/process")
local fs = require("@lune/fs")

local Module = require("./Module")
local FilesPath = "src/Syncer/Files/"

local Arguments = process.args
local NewArguments = {}

if not Arguments[1] then
	NewArguments[1] = stdio.prompt("Text", "Enter first place ID or file path:")
else
	NewArguments[1] = Arguments[1]
end

if not Arguments[2] then
	NewArguments[2] = stdio.prompt("Text", "Enter second place ID or file path:")
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

if tonumber(ID1) == nil then
	ID1 = fs.readFile(FilesPath .. ID1)
else
	ID1 = tonumber(ID1)
end

print(typeof(ID2))
if tonumber(ID2) == nil then
	ID2 = fs.readFile(FilesPath .. ID2)
else
	ID2 = tonumber(ID2)
end

Module(ID1, ID2, OutputName)
