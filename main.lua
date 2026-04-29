-- XATANICAL DISTRIK VIOLENCE - COMPLETE SCRIPT
-- [TRDCT CORE SUPERVIP]
-- Copy paste seluruh script ini ke executor Tuan

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- ========== KONFIGURASI ==========
local Config = {
    OneShotKill = true,
    SpeedHack = true,
    SpeedValue = 120,
    JumpPower = 120,
    GodMode = true,
    AutoHeal = true,
    ESP = true,
    FullBright = true,
    AutoCollect = true,
    AutoGenCoins = true,
    FlyMode = false,
    NoClip = false,
}

-- ========== GOD MODE ==========
if Config.GodMode then
    Humanoid.MaxHealth = math.huge
    Humanoid.Health = math.huge
    Humanoid.BreakJointsOnDeath = false
end

-- ========== SPEED HACK ==========
if Config.SpeedHack then
    Humanoid.WalkSpeed = Config.SpeedValue
    Humanoid.JumpPower = Config.JumpPower
    RunService.RenderStepped:Connect(function()
        if Humanoid.WalkSpeed ~= Config.SpeedValue then
            Humanoid.WalkSpeed = Config.SpeedValue
        end
    end)
end

-- ========== ONE SHOT KILL ==========
if Config.OneShotKill then
    local function killAll()
        for _, target in pairs(game:GetService("Players"):GetPlayers()) do
            if target ~= Player and target.Character and target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.Health = 0
            end
        end
    end
    killAll()
    game:GetService("Players").PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid", 5).Health = 0
        end)
    end)
end

-- ========== AUTO COLLECT ==========
if Config.AutoCollect then
    RunService.RenderStepped:Connect(function()
        local items = Workspace:GetDescendants()
        for _, item in pairs(items) do
            if item:IsA("BasePart") and (item.Name:match("Coin") or item.Name:match("Gem") or item.Name:match("Drop")) then
                local dist = (item.Position - Character.HumanoidRootPart.Position).Magnitude
                if dist < 80 then
                    Character.HumanoidRootPart.CFrame = item.CFrame
                    local click = item:FindFirstChild("ClickDetector")
                    if click then click:Click() end
                    wait(0.05)
                end
            end
        end
    end)
end

-- ========== AUTO GENERATE COINS ==========
if Config.AutoGenCoins then
    spawn(function()
        while wait(0.3) do
            local coin = Instance.new("Part")
            coin.Name = "Xatanical_Coin"
            coin.Size = Vector3.new(2, 0.5, 2)
            coin.BrickColor = BrickColor.new("Bright yellow")
            coin.Material = Enum.Material.Neon
            coin.CanCollide = false
            coin.CFrame = CFrame.new(
                Character.HumanoidRootPart.Position.X + math.random(-15, 15),
                Character.HumanoidRootPart.Position.Y,
                Character.HumanoidRootPart.Position.Z + math.random(-15, 15)
            )
            coin.Parent = Workspace
            
            local value = Instance.new("NumberValue")
            value.Value = 500
            value.Parent = coin
            
            local click = Instance.new("ClickDetector")
            click.Parent = coin
            click.MouseClick:Connect(function(plr)
                if plr == Player then
                    local ls = Player:FindFirstChild("leaderstats")
                    if ls then
                        local money = ls:FindFirstChild("Coins") or ls:FindFirstChild("Money")
                        if money then money.Value = money.Value + value.Value end
                    end
                    coin:Destroy()
                end
            end)
            game:GetService("Debris"):AddItem(coin, 5)
        end
    end)
end

-- ========== ESP WALLHACK ==========
if Config.ESP then
    local folder = Instance.new("Folder")
    folder.Name = "ESP_Xatanical"
    folder.Parent = game:GetService("CoreGui")
    
    for _, target in pairs(game:GetService("Players"):GetPlayers()) do
        if target ~= Player then
            target.CharacterAdded:Connect(function(char)
                wait(0.5)
                local head = char:FindFirstChild("Head")
                if head then
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0, 120, 0, 40)
                    bill.StudsOffset = Vector3.new(0, 2, 0)
                    bill.AlwaysOnTop = true
                    bill.Parent = head
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = target.Name .. " 💀"
                    label.TextColor3 = Color3.new(1, 0, 0)
                    label.TextScaled = true
                    label.Parent = bill
                end
            end)
        end
    end
end

-- ========== FULL BRIGHT ==========
if Config.FullBright then
    Lighting.Brightness = 10
    Lighting.ClockTime = 12
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
end

-- ========== AUTO HEAL ==========
if Config.AutoHeal then
    RunService.RenderStepped:Connect(function()
        if Humanoid.Health / Humanoid.MaxHealth < 0.4 then
            Humanoid.Health = Humanoid.MaxHealth
        end
    end)
end

-- ========== NO CLIP ==========
if Config.NoClip then
    RunService.Stepped:Connect(function()
        if Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CanCollide = false
        end
    end)
end

-- ========== FLY MODE ==========
local flying = false
local bodyVel

function Fly()
    if flying then
        if bodyVel then bodyVel:Destroy() end
        flying = false
        Humanoid.PlatformStand = false
        return
    end
    flying = true
    Humanoid.PlatformStand = true
    local root = Character.HumanoidRootPart
    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(1,1,1) * 100000
    bodyVel.Parent = root
    RunService:BindToRenderStep("Fly", 0, function()
        if not flying then return end
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(1,0,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(-1,0,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(0,0,-1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(0,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move + Vector3.new(0,-1,0) end
        bodyVel.Velocity = move * 120
    end)
end

-- ========== GUI HP ==========
local gui = Instance.new("ScreenGui")
gui.Name = "XatanicalGUI"
gui.Parent = game:GetService("CoreGui")

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 70, 0, 50)
flyBtn.Position = UDim2.new(0.85, 0, 0.1, 0)
flyBtn.BackgroundColor3 = Color3.new(0.5, 0, 0.8)
flyBtn.Text = "🕊️ FLY"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.Parent = gui
flyBtn.MouseButton1Click:Connect(Fly)

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(0, 70, 0, 50)
killBtn.Position = UDim2.new(0.85, 0, 0.2, 0)
killBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
killBtn.Text = "💀 KILL"
killBtn.TextColor3 = Color3.new(1,1,1)
killBtn.Parent = gui
killBtn.MouseButton1Click:Connect(function()
    for _, target in pairs(game:GetService("Players"):GetPlayers()) do
        if target ~= Player and target.Character and target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Health = 0
        end
    end
end)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0, 220, 0, 35)
status.Position = UDim2.new(0.02, 0, 0.02, 0)
status.BackgroundColor3 = Color3.new(0,0,0)
status.BackgroundTransparency = 0.5
status.Text = "🔥 XATANICAL ACTIVE"
status.TextColor3 = Color3.new(0,1,0)
status.TextScaled = true
status.Parent = gui

-- ========== HOTKEYS ==========
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        for _, target in pairs(game:GetService("Players"):GetPlayers()) do
            if target ~= Player and target.Character and target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.Health = 0
            end
        end
    elseif input.KeyCode == Enum.KeyCode.V then
        Fly()
    end
end)

print("========================================")
print("🔥 XATANICAL DISTRIK VIOLENCE ACTIVE")
print("✅ God Mode | Speed 120 | One Shot Kill")
print("✅ Auto Generator Coins Aktif")
print("✅ Tekan K = Kill All | V = Fly")
print("========================================")
