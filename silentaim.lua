getgenv().Xaco = {
    SilentEnabled = true,
    SilentPrediction = 0.15781912,
    RainbowHighlight = true,
    antiGroundShots = false,
    groundShotsValue = 0.5,
    AutoPred = true,
    ClosestPart = true,
    JumpOffset = 0.065,
    FallOffset = -0.1245, -- Auto if you use auto pred
    Resolver = true, -- Resolves everything that legit aim can
    FOV = {
        Visible = true,
        Filled = false,
        Transparency = 1,
        Size = 250,
        Thickness = 5,
        Color = Color3.fromRGB(186, 181, 255),
        Outline = false,
        OutlineColor = Color3.fromRGB(0, 0, 0),
        OutlineThickness = 0.3
    },
}

local Xaco = getgenv().Xaco

local Circle = Drawing.new("Circle")
Circle.Radius = Xaco.FOV.Size
Circle.Filled = Xaco.FOV.Filled
Circle.Visible = Xaco.FOV.Visible
Circle.Transparency = Xaco.FOV.Transparency
Circle.Color = Xaco.FOV.Color
Circle.Thickness = Xaco.FOV.Thickness

local outline = Drawing.new("Circle")
outline.Thickness = Xaco.FOV.OutlineThickness
outline.Radius = Xaco.FOV.Size
outline.Filled = false
outline.Visible = Xaco.FOV.Outline
outline.ZIndex = 999
outline.Transparency = 1
outline.Color = Xaco.FOV.OutlineColor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Client = Players.LocalPlayer
local Character = Client.Character
local Mouse = Client:GetMouse()
local Camera = workspace.CurrentCamera

local SilentTarget = nil
local Highlight = nil

local ClosestParts = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "RightFoot", "RightUpperLeg"}

local function GetClosestToMouse()
    local Target, Closest = nil, math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and v ~= Client then
            for _, partName in ipairs(ClosestParts) do
                local part = v.Character:FindFirstChild(partName)
                if part then
                    local Position, OnScreen = Camera:WorldToScreenPoint(part.Position)
                    local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

                    if Circle.Radius > Distance and Distance < Closest and OnScreen then
                        Closest = Distance
                        Target = v
                        if Xaco.ClosestPart then
                            Xaco.HitPart = partName
                        end
                    end
                end
            end
        end
    end
    return Target
end

local function UpdateDrawings()
    Circle.Position = Vector2.new(Mouse.X, Mouse.Y + GuiService:GetGuiInset().Y)
    outline.Position = Vector2.new(Mouse.X, Mouse.Y + GuiService:GetGuiInset().Y)
end

local function get_calculated_velocity(obj)
    if obj and obj.Character and obj.Character:FindFirstChild(Xaco.HitPart) then
        local root = obj.Character.HumanoidRootPart
        local currentPosition = root.Position
        local currentTime = tick()

        wait(0.1)

        local newPosition = root.Position
        local newTime = tick()

        local distanceTraveled = newPosition - currentPosition
        local timeInterval = newTime - currentTime
        local velocity = distanceTraveled / timeInterval
        return velocity
    end
    return Vector3.new(0, 0, 0)
end

local function calculatePosition(victim, velocity)
    local prediction = Xaco.SilentPrediction
    local newYVelocity = velocity.Y + (prediction * 1)
    local jumpOffset = Vector3.new(0, Xaco.JumpOffset, 0)
    local fallOffset = Vector3.new(0, Xaco.FallOffset, 0)
    local pos

    if Xaco.antiGroundShots then
        pos = Vector3.new(
            victim.Position.X,
            victim.Position.Y,
            victim.Position.Z
        ) + Vector3.new(
            velocity.X,
            newYVelocity * Xaco.groundShotsValue,
            velocity.Z
        ) * prediction
    else
        pos = Vector3.new(
            victim.Position.X,
            victim.Position.Y,
            victim.Position.Z
        ) + Vector3.new(
            velocity.X,
            newYVelocity,
            velocity.Z
        ) * prediction
    end

    if newYVelocity > 0 then
        pos = pos + jumpOffset
    elseif newYVelocity < 0 then
        pos = pos + fallOffset
    end

    return pos
end

local hue = 0
local function UpdateRainbowHighlight()
    if Xaco.RainbowHighlight and SilentTarget then
        hue = hue + 0.01
        if hue > 1 then hue = 0 end
        local color = Color3.fromHSV(hue, 1, 1)

        if not Highlight then
            Highlight = Instance.new("Highlight")
            Highlight.Parent = SilentTarget.Character
            Highlight.Adornee = SilentTarget.Character
        end

        Highlight.FillColor = color
        Highlight.OutlineColor = color
    elseif Highlight then
        Highlight:Destroy()
        Highlight = nil
    end
end

local function calculateVelocity(initialPos, finalPos, timeInterval)
    local displacement = finalPos - initialPos
    local velocity = displacement / timeInterval
    return velocity
end

RunService.RenderStepped:Connect(function(deltaTime)
    UpdateDrawings()
    local closestPlayer = GetClosestToMouse()

    if SilentTarget ~= closestPlayer then
        if Highlight then
            Highlight:Destroy()
            Highlight = nil
        end
        SilentTarget = closestPlayer
    end

    UpdateRainbowHighlight()

    if Xaco.AutoPred then
        local pingValue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingValue, '(')
        local ping = tonumber(split[1])

        if ping then
            if ping < 30 then
                Xaco.SilentPrediction = 0.1130
                Xaco.FallOffset = -0.1130
            elseif ping < 40 then
                Xaco.SilentPrediction = 0.13544
                Xaco.FallOffset = -0.13544
            elseif ping < 50 then
                Xaco.SilentPrediction = 0.13575
                Xaco.FallOffset = -0.13575
            elseif ping < 60 then
                Xaco.SilentPrediction = 0.13598
                Xaco.FallOffset = -0.13598
            elseif ping < 70 then
                Xaco.SilentPrediction = 0.13892
                Xaco.FallOffset = -0.13892
            elseif ping < 80 then
                Xaco.SilentPrediction = 0.1403
                Xaco.FallOffset = -0.1403
            elseif ping < 90 then
                Xaco.SilentPrediction = 0.1446
                Xaco.FallOffset = -0.1446
            elseif ping < 100 then
                Xaco.SilentPrediction = 0.1475
                Xaco.FallOffset = -0.1475
            elseif ping < 110 then
                Xaco.SilentPrediction = 0.1502
                Xaco.FallOffset = -0.1502
            end
        end
    end

    if SilentTarget and Xaco.Resolver then
        local character = SilentTarget.Character.HumanoidRootPart
        local lastPosition = character.Position
        task.wait()
        local currentPosition = character.Position
        local velocity = calculateVelocity(lastPosition, currentPosition, deltaTime)
        character.AssemblyLinearVelocity = velocity
        character.Velocity = velocity
        lastPosition = currentPosition
    end
end)

local Argument = ""

function getargument()
    local bytecode = getscriptbytecode(game:GetService("Players").LocalPlayer.PlayerGui.Framework)
    local convertreadable = tostring(bytecode)

    for line in convertreadable:gmatch("%w+") do
        if line:match("UpdateMousePos") then
            print(line)
            Argument = line
        end
    end
end

for i = 1, 5 do
    getargument()
end

warn(Argument)

local function CharAdded()
    Character.ChildAdded:Connect(function(tool)
        if tool:IsA("Tool") then
            tool.Activated:Connect(function()
                if SilentTarget and Xaco.SilentEnabled then
                    local predictedPos = calculatePosition(SilentTarget.Character[Xaco.HitPart], SilentTarget.Character[Xaco.HitPart].Velocity)
game:GetService("ReplicatedStorage").MainEvent:FireServer(Argument, predictedPos)
end
end)
end
end)
end

Client.CharacterAdded:Connect(function(newchar)
Character = newchar
CharAdded()
end)

CharAdded()
