-- Catch a Monster | Light Mobile-Friendly Egg Collector
-- Type in chat: /egg on   /egg off   /egg stop

local Players = game:GetService("Players")
local player = Players.LocalPlayer

_G.Running = false

local islands = {"Starter Island", "Volcano Island", "Frost Isle", "Neverland", "Duneveil Isle", "Skyheart Isle"}

local function safeTeleport(islandName)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(islandName:lower()) and (obj:IsA("Part") or obj:IsA("Model")) then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = obj:GetPivot() + Vector3.new(math.random(-12,12), 10, math.random(-12,12))
                task.wait(math.random(3,6))
                break
            end
        end
    end
end

local function collectEggs()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name:lower():find("egg") then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root and (obj.Position - root.Position).Magnitude < 40 then
                root.CFrame = CFrame.new(obj.Position + Vector3.new(0,5,0))
                task.wait(math.random(0.6, 1.2))
                if obj:FindFirstChild("ProximityPrompt") then
                    fireproximityprompt(obj.ProximityPrompt)
                end
            end
        end
    end
end

-- Chat commands for mobile
player.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg == "/egg on" then
        _G.Running = true
        print("🥚 Egg collector STARTED")
    elseif msg == "/egg off" then
        _G.Running = false
        print("⏸️ Egg collector PAUSED")
    elseif msg == "/egg stop" then
        _G.Running = false
        print("⛔ Egg collector STOPPED")
    end
end)

print("📱 Mobile Egg Script Ready!")
print("Chat commands: /egg on | /egg off | /egg stop")

while true do
    if _G.Running then
        for _, island in ipairs(islands) do
            if not _G.Running then break end
            print("Moving to: " .. island)
            safeTeleport(island)
            task.wait(math.random(6,12))
            
            for i = 1, 6 do
                if not _G.Running then break end
                collectEggs()
                task.wait(math.random(2.5, 4.5))
            end
        end
        task.wait(8)
    else
        task.wait(1)
    end
end
