-- [[ SUCCESS GUI NOTIFICATION ]]
local function showNotification(title, text)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SuccessNotify"
    -- Try to use 'gethui' (best for mobile executors) or 'CoreGui'
    screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 70)
    frame.Position = UDim2.new(0.5, -110, 0, -100) -- Starts above screen
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, 0, 0, 30)
    tLabel.Text = title
    tLabel.TextColor3 = Color3.fromRGB(0, 255, 100) -- Green text
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextSize = 16
    tLabel.Parent = frame

    local mLabel = Instance.new("TextLabel")
    mLabel.Size = UDim2.new(1, 0, 0, 40)
    mLabel.Position = UDim2.new(0, 0, 0, 25)
    mLabel.Text = text
    mLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    mLabel.BackgroundTransparency = 1
    mLabel.Font = Enum.Font.Gotham
    mLabel.TextSize = 14
    mLabel.Parent = frame

    -- Animation: Slides down, stays, then slides up
    frame:TweenPosition(UDim2.new(0.5, -110, 0.1, 0), "Out", "Back", 0.5)
    task.delay(4, function()
        frame:TweenPosition(UDim2.new(0.5, -110, 0, -100), "In", "Quad", 0.5)
        task.wait(0.6)
        screenGui:Destroy()
    end)
end

-- Trigger the message
showNotification("✅ SUCCESS", "Script Injected Successfully!")
-- [[ END OF GUI NOTIFICATION ]]
