local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() -- Init
local Window = OrionLib:MakeWindow({Name = "Network Sense | Made By NetCat", HidePremium = false, IntroText = "Network Sense | Made By NetCat", SaveConfig = true, ConfigFolder = "NetworkSettings"}) -- Init

local Scripts = Window:MakeTab({
	Name = "Dahood",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
Scripts:AddButton({
	Name = "Launch Dahood Script",
	Callback = function()
        pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/networkcatwork/dagood/main/dahood.lua'))() end)
  	end    
})
Scripts:AddButton({
	Name = "Launch Doors Script",
	Callback = function()
        pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/networkcatwork/dagood/main/doors.lua'))() end)
  	end    
})

OrionLib:Init()
