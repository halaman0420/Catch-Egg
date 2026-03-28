-- [[ SIMPLEST VERSION FOR DELTA ]]
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- SIMPLE NOTIFICATION
local function notify(msg)
    local sg = Instance.new("ScreenGui", pgui)
    local f = Instance.new("Frame", sg)
    f.Size = UDim2.new(0, 200, 0, 50)
    f.Position = UDim2.new(0.5, -100, 0.1, 0)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, 0, 1, 0)
    t.Text = msg
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.BackgroundTransparency = 1
    task.delay(3, function() sg:Destroy() end)
end

-- SIMPLE BUTTON
local sg = Instance.new("ScreenGui", pgui)
sg.ResetOnSpawn = false
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 120, 0, 40)
btn.Position = UDim2.new(0.5, -60, 0.2, 0)
btn.Text = "START EGG"
btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

_G.Running = false

btn.MouseButton1Click:Connect(function()
    _G.Running = not _G.Running
    btn.Text = _G.Running and "STOP EGG" or "START EGG"
    btn.BackgroundColor3 = _G.Running and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    notify(_G.Running and "Running!" or "Stopped!")
end)

-- EGG LOGIC
local islands = {"Starter Island", "Volcano Island", "Frost Isle", "Neverland", "Duneveil Isle", "Skyheart Isle"}

task.spawn(function()
    while true do
        if _G.Running then
            for _, islandName in pairs(islands) do
                if not _G.Running then break end
                -- Teleport
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find(islandName:lower()) then
                        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then 
                            hrp.CFrame = obj:GetPivot() + Vector3.new(0, 10, 0)
                            task.wait(3)
                            break
                        end
                    end
                end
                -- Collect
                for i = 1, 5 do
                    if not _G.Running then break end
                    for _, egg in pairs(workspace:GetChildren()) do
                        if egg.Name:lower():find("egg") then
                            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = egg:GetPivot()
                                task.wait(0.5)
                                if egg:FindFirstChildWhichIsA("ProximityPrompt", true) then
                                    fireproximityprompt(egg:FindFirstChildWhichIsA("ProximityPrompt", true))
                                end
                            end
                        end
                    end
                    task.wait(2)
                end
            end
        end
        task.wait(1)
    end
end)
