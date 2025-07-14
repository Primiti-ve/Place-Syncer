local fs = require("@lune/fs")

local Roblox = require("@lune/roblox")
local Instance = Roblox.Instance

local Remodel = require("./Remodel")
local Maps = require("./Maps")

function GetOrCreateService(Combined, Parent, ServiceName)
	local Success, Service = pcall(function()
		return Parent:GetService(ServiceName)
	end)

	if Success then
		return Service
	else
		local NewFolder = Instance.new("Folder")

		NewFolder.Name = ServiceName
		NewFolder.Parent = Parent

		return NewFolder
	end
end

function GetTarget(Combined, SourcePlace, Path)
	local Target

	if typeof(Path) == "string" then
		Target = GetOrCreateService(Combined, Combined, Path)

		Path = SourcePlace:GetService(Path)
	else
		if Path.Name == "StarterPlayerScripts" and Path.Parent and Path.Parent.Name == "StarterPlayer" then
			local CombinedStarterPlayer = GetOrCreateService(Combined, Combined, "StarterPlayer")

			Target = CombinedStarterPlayer:FindFirstChild("StarterPlayerScripts")

			if not Target then
				Target = Instance.new("StarterPlayerScripts")
				Target.Name = "StarterPlayerScripts"
				Target.Parent = CombinedStarterPlayer
			end
		else
			Target = GetOrCreateService(Combined, Combined, Path.Name)
		end
	end

	return Target
end

function ResolvePath(Combined, Parent, ServicePath)
	local Parts = string.split(ServicePath, "|")
	local Current = Parent

	for Index, Part in ipairs(Parts) do
		local Child = Current:FindFirstChild(Part)

		if not Child then
			if Maps.Maps.ServiceClassMap[Part] and Current == Combined then
				Child = GetOrCreateService(Combined, Current, Part)
			elseif Maps.Maps.StarterPlayerSpecialMap[Part] and Current.Name == "StarterPlayer" then
				Child = Instance.new(Maps.Maps.StarterPlayerSpecialMap[Part])

				Child.Name = Part
				Child.Parent = Current
			else
				Child = Instance.new("Folder")

				Child.Name = Part
				Child.Parent = Current
			end
		end

		Current = Child
	end

	return Current
end

function ReplicatePath(Combined, SourcePlace, Path)
	for _, Object in pairs(Path:GetChildren()) do
		if table.find(Maps.Blacklist, Object.ClassName) then
			continue
		end

		local ServiceOverride = Object:GetAttribute("Service")
		local Target

		if ServiceOverride and ServiceOverride ~= "" then
			Target = ResolvePath(Combined, Combined, ServiceOverride)
		else
			Target = GetTarget(Combined, SourcePlace, Path)
		end

		local Cloned = Object:Clone()

		-- Cloned:SetAttribute("Service", nil)
		Cloned.Parent = Target
	end
end

return function(ID1, ID2, OutputName)
	local Combined = Instance.new("DataModel")

	local Place1 = Remodel.readPlaceAsset(ID1)
	local Place2 = Remodel.readPlaceAsset(ID2)

	ReplicatePath(Combined, Place1, Place1.Workspace)
	ReplicatePath(Combined, Place1, Place1.ReplicatedStorage)
	ReplicatePath(Combined, Place1, Place1.ServerScriptService)
	ReplicatePath(Combined, Place1, Place1.StarterPlayer.StarterPlayerScripts)

	ReplicatePath(Combined, Place2, Place2.Workspace)
	ReplicatePath(Combined, Place2, Place2.ReplicatedStorage)
	ReplicatePath(Combined, Place2, Place2.ServerScriptService)
	ReplicatePath(Combined, Place2, Place2.StarterPlayer.StarterPlayerScripts)

	for _, EntryName in fs.readDir("Place Files") do
		local Path = "Place Files/" .. EntryName

		if fs.isFile(Path) then
			if not fs.isFile(Path .. ".lock") then
				print("Removing " .. EntryName .. " from Place Files")

				fs.removeFile(Path)
			end
		elseif fs.isDir(Path) then
			print("Removing " .. EntryName .. " from Place Files")

			fs.removeDir(Path)
		end
	end

	if not fs.isFile("Place Files/" .. OutputName .. ".rbxlx") then
		print("Writing " .. OutputName .. ".rbxlx to Place Files")
		Remodel.writePlaceFile("Place Files/" .. OutputName .. ".rbxlx", Combined)
	end

	print("Finished!")
end
