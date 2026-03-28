-- [[ DELTA MOBILE EGG HUB ]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. SUCCESS NOTIFICATION FUNCTION
local function showNotification(title, text)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DeltaNotify"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 70)
    frame.Position = UDim2.new(0.5, -110, 0, -120) 
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.ZIndex = 100
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(0, 255, 127)
    stroke.Thickness = 2

    local tLabel = Instance.new("TextLabel", frame)
    tLabel.Size = UDim2.new(1, 0, 0, 30)
    tLabel.Text = title
    tLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextSize = 16

    local mLabel = Instance.new("TextLabel", frame)
    mLabel.Size = UDim2.new(1, 0, 0, 40)
    mLabel.Position = UDim2.new(0, 0, 0, 25)
    mLabel.Text = text
    mLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    mLabel.BackgroundTransparency = 1
    mLabel.Font = Enum.Font.Gotham
    mLabel.TextSize = 13

    frame:TweenPosition(UDim2.new(0.5, -110, 0.1, 0), "Out", "Back", 0.5)
    task.delay(4, function()
        frame:TweenPosition(UDim2.new(0.5, -110, 0, -120), "In", "Quad", 0.5)
        task.wait(0.6)
        screenGui:Destroy()
    end)
end

-- 2. DRAGGABLE TOGGLE BUTTON
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "EggControlGui"
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 100, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0.5, 0) -- Middle left of screen
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Start Red (Off)
toggleBtn.Text = "EGG: OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Parent = mainGui

local btnCorner = Instance.new("UICorner", toggleBtn)
btnCorner.CornerRadius = UDim.new(0, 8)

local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Thickness = 2
btnStroke.Color = Color3.fromRGB(255, 255, 255)

-- Make Button Draggable
local dragging, dragInput, dragStart, startPos
toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleBtn.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
toggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- 3. LOGIC & LOOP
_G.Running = false
local islands = {"Starter Island", "Volcano Island", "Frost Isle", "Neverland", "Duneveil Isle", "Skyheart Isle"}

toggleBtn.MouseButton1Click:Connect(function()
    _G.Running = not _G.Running
    if _G.Running then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        toggleBtn.Text = "EGG: ON"
        showNotification("STARTED", "Collecting eggs...")
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        toggleBtn.Text = "EGG: OFF"
        showNotification("PAUSED", "Collector stopped.")
    end
end)

local function safeTeleport(islandName)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(islandName:lower()) and (obj:IsA("BasePart") or obj:IsA("Model")) then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = obj:GetPivot() + Vector3.new(math.random(-10,10), 15, math.random(-10,10))
                task.wait(2)
                break
            end
        end
    end
end

local function collectEggs()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name:lower():find("egg") then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root and (obj:GetPivot().Position - root.Position).Magnitude < 60 then
                root.CFrame = CFrame.new(obj:GetPivot().Position + Vector3.new(0, 3, 0))
                task.wait(0.5)
                local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then fireproximityprompt(prompt) end
            end
        end
    end
end

showNotification("READY", "Click the button to start!")

task.spawn(function()
    while true do
        if _G.Running then
            for _, island in ipairs(islands) do
                if not _G.Running then break end
                safeTeleport(island)
                for i = 1, 4 do
                    if not _G.Running then break end
                    collectEggs()
                    task.wait(3.5)
                end
            end
        end
        task.wait(1)
    end
end)
