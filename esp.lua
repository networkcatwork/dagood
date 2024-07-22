local Players = game:GetService("Players"):GetChildren()
local RunService = game:GetService("RunService")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

for i, v in pairs(Players) do
    repeat wait() until v.Character
    if v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") == nil then
    local highlightClone = highlight:Clone()
    highlightClone.Adornee = v.Character
    highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
    highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlightClone.Name = "Highlight"
    end
end

game.Players.PlayerAdded:Connect(function(player)
    repeat wait() until player.Character
    local highlightClone = highlight:Clone()
    highlightClone.Adornee = player.Character
    highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
    highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlightClone.Name = "Highlight"
end)

game.Players.PlayerRemoving:Connect(function(playerRemoved)
    playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
end)

RunService.RenderStepped:Connect(function()
    for i, v in pairs(Players) do
        repeat wait() until v.Character
        if v.Character:FindFirstChild("HumanoidRootPart").Highlight == nil then
        local highlightClone = highlight:Clone()
        highlightClone.Adornee = v.Character
        highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
        highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlightClone.Name = "Highlight"
        end
    end
end)
