local stdio = require("@lune/stdio")
local process = require("@lune/process")
local fs = require("@lune/fs")

local Module = require("./Module")
local FilesPath = "src/Files/"

local Arguments = process.args
local NewArguments = {}

if not Arguments[1] then
	NewArguments[1] = stdio.prompt("Text", "Enter output name:")
else
	NewArguments[1] = Arguments[1]
end

local PlaceCount

if not Arguments[2] then
	PlaceCount = tonumber(stdio.prompt("Text", "How many places would you like to combine?"))
else
	PlaceCount = tonumber(Arguments[2])
end

if not PlaceCount or PlaceCount <= 1 then
	warn("Invalid place count provided.")
	process.exit()
end

NewArguments[2] = PlaceCount

for Index = 1, PlaceCount do
	local ID = Arguments[Index + 2]
	local Attempts = 0
	local MaxAttempts = 3

	while not ID do
		Attempts += 1

		if Attempts > MaxAttempts then
			warn("Too many invalid attempts for place #" .. Index .. ". Aborting.")
			process.exit()
		end

		local Input = stdio.prompt("Text", "Enter place ID or file path #" .. Index .. " (or type 'exit' to cancel):")

		if Input == "exit" then
			warn("Operation canceled by user.")
			process.exit()
		elseif tonumber(Input) then
			ID = tonumber(Input)
		elseif fs.isFile(FilesPath .. Input) then
			ID = FilesPath .. Input
		else
			print("Invalid input. Please enter a valid numeric place ID or a file name in 'src/Files/'.")

			ID = nil
		end
	end

	NewArguments[Index + 2] = ID
end

local OutputName = NewArguments[1]
local IDs = {}

for Index = 1, PlaceCount do
	local Raw = NewArguments[Index + 2]

	IDs[Index] = tonumber(Raw) or Raw
end

Module(IDs, OutputName)