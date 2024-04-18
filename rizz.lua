
local teleportGap = 2 -- Adjust this value to change the distance between you and the target player
local teleportDelay = 0 -- Delay between each teleport in seconds

local CoreGui = game:GetService("StarterGui")

CoreGui:SetCore("SendNotification", {
    Title = "Script Made By",
    Text = "Aedus (Subscribe him on yt)",
    Duration = 2.5,
})

local lplayer = game:GetService('Players').LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 255) -- Blue color
Frame.BorderColor3 = Color3.fromRGB(0, 0, 255)
Frame.Position = UDim2.new(0.9, 0, 0.3, 0)
Frame.Size = UDim2.new(0.07, 0, 0.1, 0)
Frame.Active = true
Frame.Draggable = true

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 0
TextBox.Position = UDim2.new(0.103524067, 0, 0.200333327, 0)
TextBox.Size = UDim2.new(0.8, 0, 0.3, 0)
TextBox.Font = Enum.Font.SourceSansLight
TextBox.FontSize = Enum.FontSize.Size14
TextBox.Text = "Name"
TextBox.TextScaled = true
TextBox.TextSize = 8
TextBox.TextWrapped = true

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 0
TextButton.Position = UDim2.new(0.103524067, 0, 0.500333327, 0)
TextButton.Size = UDim2.new(0.8, 0, 0.3, 0)
TextButton.Font = Enum.Font.SourceSansLight
TextButton.FontSize = Enum.FontSize.Size14
TextButton.Text = "Teleport"
TextButton.TextScaled = true
TextButton.TextSize = 8
TextButton.TextWrapped = true

function TeleportBehindPlayer(player)
    local targetCharacter = player.Character
    if targetCharacter then
        local targetPosition = targetCharacter.HumanoidRootPart.Position
        local targetLookDirection = targetCharacter.HumanoidRootPart.CFrame.lookVector

        local offsetX = -targetLookDirection.X * teleportGap
        local offsetY = -targetLookDirection.Z * teleportGap

        local newX = targetPosition.X + offsetX
        local newY = targetPosition.Y
        local newZ = targetPosition.Z + offsetY

        local newTargetPosition = Vector3.new(newX, newY, newZ)
        local newRotation = CFrame.new(newTargetPosition, targetPosition + targetLookDirection)

        lplayer.Character:SetPrimaryPartCFrame(newRotation)
    else
        warn("Target player's character not found.")
    end
end

TextButton.MouseButton1Click:Connect(function()
    local targetPlayer = unpack(GetPlayer(TextBox.Text))
    
    if targetPlayer then
        TeleportBehindPlayer(targetPlayer)
    else
        warn("Target player not found.")
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        local targetPlayer = unpack(GetPlayer(TextBox.Text))
        
        if targetPlayer then
            TeleportBehindPlayer(targetPlayer)
        else
            warn("Target player not found.")
        end
    end
end)

function GetPlayer(String)
    local Found = {}
    local strl = String:lower()
    if strl == "all" then
        for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
            table.insert(Found,v)
        end
    elseif strl == "random" then
        for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= lplayer.Name then
                table.insert(Found,v)
            end
        end 
    elseif strl == "me" then
        for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
            if v.Name == lplayer.Name then
                table.insert(Found,v)
            end
        end 
    else
        for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() or v.DisplayName:lower():sub(1, #String) == String:lower() then
                table.insert(Found,v)
            end
        end 
    end
    return Found 
end

