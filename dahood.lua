-- Dahood
if game.PlaceId then -- Game Check
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() -- Init
local Window = OrionLib:MakeWindow({Name = "Network Sense | Dahood | Made By NetCat", HidePremium = false, IntroText = "Network Sense | Dahood | Made By NetCat", SaveConfig = true, ConfigFolder = "NetworkSettings"}) -- Init

-- Visuals
local Visuals = Window:MakeTab({
        Name = "Visual",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    Visuals:AddButton({
        Name = "ESP",
        Default = false,
        Callback = function(Value)
            pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/networkcatwork/dagood/main/esp.lua'))() end)
            OrionLib:MakeNotification({
                Name = "ESP!",
                Content = "ESP Activated!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end    
    })
    Visuals:AddButton({
        Name = "Chat Spy",
        Default = false,
        Callback = function(Value)
                local ChatFrame = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame 
            ChatFrame.ChatChannelParentFrame.Visible = true 
            ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), ChatFrame.ChatChannelParentFrame.Size.Y)
            OrionLib:MakeNotification({
                Name = "Chat Spy!",
                Content = "Chat Spy Activated!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end    
    })
-- End of Visuals

-- Extra
local Extra = Window:MakeTab({
    Name = "Extra",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
Extra:AddButton({
    Name = "Admin",
    Default = false,
    Callback = function(Value)
        pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
        OrionLib:MakeNotification({
            Name = "Admin!",
            Content = "Admin Activated!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end    
})
-- End of Extra

-- General
local General = Window:MakeTab({
	Name = "General",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
General:AddButton({
    Name = "Aimbot | Press E",
    Default = false,
    Callback = function(Value)
        pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/networkcatwork/dagood/main/aimbot.lua'))() end)
        OrionLib:MakeNotification({
            Name = "Aimbot!",
            Content = "Press E to Activate!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end    
})
General:AddButton({
    Name = "AimbotNoCircle | Press Q",
    Default = false,
    Callback = function(Value)
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
        OrionLib:MakeNotification({
            Name = "Aimbot!",
            Content = "Press Q to Activate!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end    
})
General:AddButton({
	Name = "TP to Player",
	Callback = function()
local player = game.Players.LocalPlayer

local targetUsername = ""

local gui = Instance.new("ScreenGui")
gui.Name = "TP to Player"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 10
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100) 
frame.BackgroundColor3 = Color3.fromRGB(101, 7, 173) 
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 0) 
frame.Parent = gui

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20, 0, 0) 
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0) 
closeButton.BackgroundColor3 = Color3.fromRGB(101, 7, 173)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Name = "Enter Username"
textBox.PlaceholderText = "Enter username..."
textBox.Text = ""
textBox.Size = UDim2.new(0.8, 0, 0, 30)
textBox.Position = UDim2.new(0.1, 0, 0.3, -15)
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 2
textBox.Parent = frame

local updateButton = Instance.new("TextButton")
updateButton.Name = "Teleport"
updateButton.Text = "TP to Player"
updateButton.Size = UDim2.new(0.8, 0, 0, 30)
updateButton.Position = UDim2.new(0.1, 0, 0.7, -15)
updateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
updateButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215) 
updateButton.BorderSizePixel = 0
updateButton.Font = Enum.Font.SourceSansBold
updateButton.TextSize = 16
updateButton.Parent = frame

local function closeGUI()
    gui:Destroy()
end

local function updateTargetAndMove()
    targetUsername = textBox.Text
    local players = game:GetService("Players")
    local targetPlayer = players:FindFirstChild(targetUsername)
    if targetPlayer then
        player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
    else
        warn("Player not found with username:", targetUsername)
    end
end

closeButton.MouseButton1Click:Connect(closeGUI)

updateButton.MouseButton1Click:Connect(updateTargetAndMove)

  	end    
})
-- End of General

end
OrionLib:Init()
