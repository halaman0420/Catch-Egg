-- [[ DELTA FIXED SUCCESS GUI ]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function showNotification(title, text)
    -- Create ScreenGui inside PlayerGui (Best for Delta)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DeltaNotify"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 70)
    frame.Position = UDim2.new(0.5, -110, 0, -120) -- Starts off-screen
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    frame.ZIndex = 10
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke") -- Adds a nice border
    stroke.Color = Color3.fromRGB(0, 255, 127)
    stroke.Thickness = 2
    stroke.Parent = frame

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, 0, 0, 30)
    tLabel.Text = title
    tLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextSize = 18
    tLabel.Parent = frame

    local mLabel = Instance.new("TextLabel")
    mLabel.Size = UDim2.new(1, 0, 0, 40)
    mLabel.Position = UDim2.new(0, 0, 0, 30)
    mLabel.Text = text
    mLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    mLabel.BackgroundTransparency = 1
    mLabel.Font = Enum.Font.Gotham
    mLabel.TextSize = 14
    mLabel.Parent = frame

    -- Animation for Delta
    frame:TweenPosition(UDim2.new(0.5, -110, 0.15, 0), "Out", "Back", 0.6)
    
    task.wait(4)
    
    frame:TweenPosition(UDim2.new(0.5, -110, 0, -120), "In", "Quad", 0.5)
    task.wait(0.6)
    screenGui:Destroy()
end

showNotification("DELTA EXECUTOR", "Script Loaded Successfully! ✅")
-- [[ END OF GUI ]]
