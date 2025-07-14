local Maps = {}

Maps.ServiceClassMap = {
	["Workspace"] = "Workspace",
	["ReplicatedStorage"] = "ReplicatedStorage",
	["ServerScriptService"] = "ServerScriptService",
	["StarterPlayer"] = "StarterPlayer",
	["StarterGui"] = "StarterGui",
	["StarterPack"] = "StarterPack",
	["SoundService"] = "SoundService",
	["Lighting"] = "Lighting",
	["Teams"] = "Teams",
	["ReplicatedFirst"] = "ReplicatedFirst",
	["Players"] = "Players",
}

Maps.StarterPlayerSpecialMap = {
	["StarterPlayerScripts"] = "StarterPlayerScripts",
	["StarterCharacterScripts"] = "StarterCharacterScripts",
}

local Blacklist = {
    "Terrain",
    "Camera"
}

return {
    Maps = Maps,
    Blacklist = Blacklist
}
