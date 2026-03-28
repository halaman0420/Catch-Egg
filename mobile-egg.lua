-- Catch a Monster | Egg Collector V2
-- Type in chat: /egg on | /egg off | /egg stop

print("---------------------------------")
print("✅ SCRIPT INJECTED SUCCESSFULLY")
print("---------------------------------")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()

_G.Running = false

-- Make sure these names match the Workspace EXACTLY
local islands = {"Starter Island", "Volcano Island", "Frost Isle", "Neverland", "Duneveil Isle", "Skyheart Isle"}

local function safeTeleport(islandName)
    local found = false
    -- Look for the island part/model
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(islandName:lower()) and (obj:IsA("BasePart") or obj:IsA("Model")) then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                print("✈️ Teleporting to: " .. islandName)
                root.CFrame = obj:GetPivot() + Vector3.new(math.random(-10,10), 15, math.random(-10,10))
                found = true
                task.wait(2)
                break
            end
        end
    end
    if not found then print("❌ Could not find island: " .. islandName) end
end

local function collectEggs()
    local count = 0
    for _, obj in pairs(workspace:GetChildren()) do
        -- Check if the object name contains "egg" (case insensitive)
        if obj.Name:lower():find("egg") and (obj:IsA("BasePart") or obj:IsA("Model")) then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local targetPos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
            
            if root and (targetPos - root.Position).Magnitude < 100 then -- Increased range
                root.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
                task.wait(0.5)
                
                -- Attempt to fire prompt
                local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    fireproximityprompt(prompt)
                    count = count + 1
                end
            end
        end
    end
    if count > 0 then print("🥚 Collected " .. count .. " eggs nearby") end
end

-- Chat command listener
player.Chatted:Connect(function(msg)
    local cmd = msg:lower()
    if cmd == "/egg on" then
        _G.Running = true
        print("▶️ STARTED")
    elseif cmd == "/egg off" or cmd == "/egg stop" then
        _G.Running = false
        print("⏹️ STOPPED")
    end
end)

-- Main Loop
task.spawn(function()
    while true do
        if _G.Running then
            for _, island in ipairs(islands) do
                if not _G.Running then break end
                safeTeleport(island)
                
                -- Check for eggs multiple times per island
                for i = 1, 5 do
                    if not _G.Running then break end
                    collectEggs()
                    task.wait(3)
                end
            end
        end
        task.wait(1)
    end
end)
