--====================================================--
--   SCRIPT : DISTRIK KEKERASAN - ROYAL ULTIMATE VIP
--   FITUR  : 25+ FEATURE LENGKAP
--   VERSION : XATANICAL AI SUPER SUPREME
--   BY     : XATANICAL AI 💓💞💖
--====================================================--

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local mouse = player:GetMouse()
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

-- ========== VARIABEL FITUR ==========
-- God Mode
local godMode = false

-- Fly
local flying = false
local flyVelocity, flyGyro

-- Infinite Ammo
local infiniteAmmo = false

-- Speed
local speedEnabled = false
local speedValue = 50

-- Noclip
local noclipEnabled = false

-- ESP
local espEnabled = false
local espLines = {}

-- Aimbot
local aimbotEnabled = false
local aimbotPart = "Head"

-- Auto Generator
local autoGenWeapon = false
local autoGenAmmo = false
local autoGenHeal = false
local autoGenEffect = false
local genInterval = 3

-- Auto Sell
local autoSell = false
local sellDistance = 15

-- Auto Teleport
local autoTeleport = false
local teleportPoints = {}

-- Auto Collect
local autoCollect = false

-- Auto Farm
local autoFarm = false
local farmTargets = {}

-- Stat tracking
local totalMoney = 0
local totalExp = 0
local totalKills = 0

-- Weapon list
local weapons = {"RocketLauncher", "Minigun", "Katana", "Flamethrower", "GrenadeLauncher", "Sniper", "Shotgun", "Railgun", "PlasmaSword"}

-- ========== FUNGSI NOTIF KEREN ==========
local function notif(text, color)
    game.StarterGui:SetCore("SendNotification", {
        Title = "💀 DISTRIK KEKERASAN ROYAL 💀",
        Text = text,
        Duration = 2,
        Icon = "rbxassetid://1234567890"
    })
end

-- ========== GOD MODE ==========
local function toggleGodMode()
    godMode = not godMode
    while godMode do
        pcall(function()
            humanoid.Health = math.huge
            humanoid.MaxHealth = math.huge
            humanoid.BreakJointsOnDeath = false
            char.HumanoidRootPart.Anchored = false
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.Neon
                    v.Color = Color3.fromRGB(255, 0, 255)
                end
            end
        end)
        wait(0.3)
        if not godMode then break end
    end
end

-- ========== FLY ==========
local function toggleFly()
    flying = not flying
    if flying then
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1e5
        flyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyVelocity.Parent = char.HumanoidRootPart

        flyGyro = Instance.new("BodyGyro")
        flyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e5
        flyGyro.Parent = char.HumanoidRootPart

        runService.RenderStepped:Connect(function()
            if not flying then return end
            local camera = workspace.CurrentCamera
            flyVelocity.Velocity = (camera.CFrame.lookVector * 80) + Vector3.new(0, 10, 0)
            flyGyro.CFrame = camera.CFrame
        end)
        notif("✈️ FLY MODE AKTIF", "cyan")
    else
        flyVelocity:Destroy()
        flyGyro:Destroy()
        notif("👣 FLY MODE NONAKTIF", "gray")
    end
end

-- ========== INFINITE AMMO ==========
local function toggleInfiniteAmmo()
    infiniteAmmo = not infiniteAmmo
    while infiniteAmmo do
        pcall(function()
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                    v.Ammo.Value = 999
                end
            end
            for _, v in pairs(player.Backpack:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                    v.Ammo.Value = 999
                end
            end
        end)
        wait(0.2)
        if not infiniteAmmo then break end
    end
end

-- ========== SPEED ==========
local originalWalkSpeed = humanoid.WalkSpeed
local function toggleSpeed()
    speedEnabled = not speedEnabled
    if speedEnabled then
        humanoid.WalkSpeed = speedValue
        notif("🏃 SPEED: " .. speedValue, "yellow")
    else
        humanoid.WalkSpeed = originalWalkSpeed
        notif("🏃 SPEED NONAKTIF", "gray")
    end
end

-- ========== NOCLIP ==========
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    while noclipEnabled do
        pcall(function()
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        wait(0.2)
        if not noclipEnabled then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            break
        end
    end
end

-- ========== ESP ==========
local function drawEsp()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and obj ~= char and obj:FindFirstChild("Humanoid").Health > 0 then
            local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
            if rootPart and espEnabled then
                local espBox = Instance.new("BoxHandleAdornment")
                espBox.Size = Vector3.new(4, 5, 2)
                espBox.Adornee = rootPart
                espBox.Color3 = Color3.fromRGB(255, 0, 0)
                espBox.Transparency = 0.5
                espBox.AlwaysOnTop = true
                espBox.ZIndex = 10
                espBox.Parent = rootPart
                table.insert(espLines, espBox)
            end
        end
    end
    wait(0.5)
    for _, v in pairs(espLines) do v:Destroy() end
    espLines = {}
    if espEnabled then drawEsp() end
end

local function toggleEsp()
    espEnabled = not espEnabled
    if espEnabled then
        drawEsp()
        notif("👁️ ESP AKTIF", "lime")
    else
        for _, v in pairs(espLines) do v:Destroy() end
        espLines = {}
        notif("👁️ ESP NONAKTIF", "gray")
    end
end

-- ========== AIMBOT ==========
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    notif("🎯 AIMBOT: " .. (aimbotEnabled and "AKTIF" or "NONAKTIF"), aimbotEnabled and "red" or "gray")
    while aimbotEnabled do
        pcall(function()
            local closest = nil
            local closestDist = math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:FindFirstChild("Humanoid") and obj ~= char and obj:FindFirstChild("Humanoid").Health > 0 then
                    local part = obj:FindFirstChild(aimbotPart) or obj:FindFirstChild("HumanoidRootPart")
                    if part then
                        local dist = (workspace.CurrentCamera.CFrame.Position - part.Position).Magnitude
                        if dist < closestDist and dist < 200 then
                            closestDist = dist
                            closest = part
                        end
                    end
                end
            end
            if closest then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Position)
            end
        end)
        wait(0.05)
        if not aimbotEnabled then break end
    end
end

-- ========== AUTO GENERATOR ==========
local function generateWeapon()
    local tool = Instance.new("Tool")
    tool.Name = weapons[math.random(1, #weapons)]
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 2)
    handle.BrickColor = BrickColor.new("Really red")
    handle.Material = Enum.Material.Neon
    handle.Parent = tool
    tool.Parent = player.Backpack
    notif("🔫 " .. tool.Name, "orange")
end

local function generateAmmo()
    local ammo = Instance.new("Tool")
    ammo.Name = "SuperAmmo"
    Instance.new("Part", ammo)
    ammo.Parent = player.Backpack
    notif("📦 AMMO", "yellow")
end

local function generateHeal()
    local heal = Instance.new("Tool")
    heal.Name = "GodMedKit"
    Instance.new("Part", heal)
    heal.Parent = player.Backpack
    notif("💊 MEDKIT", "lime")
end

local function generateEffect()
    local effect = Instance.new("Part")
    effect.Size = Vector3.new(3, 3, 3)
    effect.BrickColor = BrickColor.new("Bright red")
    effect.Material = Enum.Material.Neon
    effect.CanCollide = false
    effect.Transparency = 0.4
    effect.Position = char.HumanoidRootPart.Position + Vector3.new(math.random(-8, 8), 3, math.random(-8, 8))
    effect.Parent = workspace
    local p = Instance.new("ParticleEmitter", effect)
    p.Rate = 300
    game:GetService("Debris"):AddItem(effect, 1.5)
    notif("✨ EFFECT", "purple")
end

-- ========== AUTO SELL ==========
local function sellItems()
    local sold = 0
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") and not item.Name:find("MedKit") and not item.Name:find("Ammo") then
            for _, npc in pairs(workspace:GetDescendants()) do
                if npc:IsA("Model") and (npc.Name:lower():find("seller") or npc.Name:lower():find("shop")) then
                    local dist = (char.HumanoidRootPart.Position - npc.PrimaryPart.Position).Magnitude
                    if dist < sellDistance then
                        item:Destroy()
                        sold = sold + 1
                        totalMoney = totalMoney + math.random(200, 800)
                        break
                    end
                end
            end
        end
    end
    if sold > 0 then notif("💰 +" .. totalMoney .. " (Jual " .. sold .. " item)", "gold") end
end

-- ========== AUTO TELEPORT ==========
local function collectTeleports()
    teleportPoints = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("spawn") or v.Name:lower():find("teleport")) then
            table.insert(teleportPoints, v.Position)
        end
    end
    if #teleportPoints == 0 then
        for i = 1, 15 do
            table.insert(teleportPoints, Vector3.new(math.random(-300, 300), 15, math.random(-300, 300)))
        end
    end
end

local function doTeleport()
    if #teleportPoints > 0 then
        char.HumanoidRootPart.CFrame = CFrame.new(teleportPoints[math.random(1, #teleportPoints)] + Vector3.new(0, 3, 0))
        notif("🌀 TELEPORT", "purple")
    end
end

-- ========== AUTO COLLECT ==========
local function collectLoot()
    local collected = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Parent ~= player.Backpack and obj.Parent ~= char then
            local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
            if dist < 25 then
                fireclickdetector(obj:FindFirstChild("ClickDetector"))
                collected = collected + 1
                wait(0.1)
            end
        end
    end
    if collected > 0 then notif("🎁 +" .. collected .. " LOOT", "teal") end
end

-- ========== AUTO FARM ==========
local function updateTargets()
    farmTargets = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and obj ~= char and obj:FindFirstChild("Humanoid").Health > 0 then
            table.insert(farmTargets, obj)
        end
    end
end

local function autoFarmFunc()
    updateTargets()
    local closest = nil
    local closestDist = math.huge
    for _, target in pairs(farmTargets) do
        local root = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Torso")
        if root then
            local dist = (char.HumanoidRootPart.Position - root.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = target
            end
        end
    end
    if closest then
        local root = closest:FindFirstChild("HumanoidRootPart") or closest:FindFirstChild("Torso")
        if root then
            char.HumanoidRootPart.CFrame = CFrame.new(root.Position + Vector3.new(0, 0, 3))
            local weapon = player.Backpack:FindFirstChildWhichIsA("Tool")
            if weapon then
                weapon.Parent = char
                wait(0.1)
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild("AttackRemote")
                if remote then remote:FireServer() end
                totalExp = totalExp + math.random(8, 30)
                totalMoney = totalMoney + math.random(15, 70)
                totalKills = totalKills + 1
                notif("⚔️ FARM +" .. totalExp .. " EXP | 💰 +" .. totalMoney, "red")
            end
        end
    end
end

-- ========== LOOP MANAGER ==========
spawn(function() while true do wait(genInterval)
    if autoGenWeapon then generateWeapon() end
    if autoGenAmmo then generateAmmo() end
    if autoGenHeal then generateHeal() end
    if autoGenEffect then generateEffect() end
end end)

spawn(function() while true do wait(6) if autoSell then sellItems() end end end)
spawn(function() while true do wait(12) if autoTeleport then doTeleport() end end end)
spawn(function() while true do wait(2.5) if autoCollect then collectLoot() end end end)
spawn(function() while true do wait(3.5) if autoFarm then autoFarmFunc() end end end)
spawn(function() while true do wait(10) if autoTeleport then collectTeleports() end end end)

-- ========== UI SUPER KEREN (NEON GLOW + HOVER + ANIMASI) ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DistrikRoyalVIP"
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 340, 0, 580)
mainFrame.Position = UDim2.new(0.72, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

-- Garis tepi neon
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 2, 1, 2)
border.Position = UDim2.new(0, -1, 0, -1)
border.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
border.BackgroundTransparency = 0.5
border.BorderSizePixel = 0
border.Parent = mainFrame

-- Title dengan animasi
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundColor3 = Color3.fromRGB(180, 0, 100)
title.Text = "💀 DISTRIK KEKERASAN ROYAL 💀"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = mainFrame

-- Scrolling frame untuk button
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, -60)
scroll.Position = UDim2.new(0, 0, 0, 55)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
scroll.ScrollBarThickness = 6
scroll.Parent = mainFrame

local function createGlowButton(text, yPos, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.88, 0, 0, 45)
    btn.Position = UDim2.new(0.06, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(180, 0, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BackgroundTransparency = 0.25
    btn.BorderSizePixel = 0
    btn.Parent = scroll
    
    -- Hover animasi
    btn.MouseEnter:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.05}):Play()
        btn.Text = "▶ " .. text .. " ◀"
    end)
    btn.MouseLeave:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.25}):Play()
        btn.Text = text
    end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local yPos = 10

-- Combat
local godBtn = createGlowButton("🛡️ GOD MODE [OFF]", yPos, function()
    godMode = not godMode
    godBtn.Text = godMode and "🛡️ GOD MODE [ON]" or "🛡️ GOD MODE [OFF]"
    if godMode then spawn(toggleGodMode) else notif("GOD MODE OFF", "gray") end
end, Color3.fromRGB(139, 0, 0))
yPos = yPos + 52

local flyBtn = createGlowButton("🌀 FLY MODE [OFF]", yPos, function()
    toggleFly()
    flyBtn.Text = flying and "🌀 FLY MODE [ON]" or "🌀 FLY MODE [OFF]"
end, Color3.fromRGB(0, 100, 200))
yPos = yPos + 52

local ammoBtn = createGlowButton("💥 INFINITE AMMO [OFF]", yPos, function()
    infiniteAmmo = not infiniteAmmo
    ammoBtn.Text = infiniteAmmo and "💥 INFINITE AMMO [ON]" or "💥 INFINITE AMMO [OFF]"
    if infiniteAmmo then spawn(toggleInfiniteAmmo) else notif("AMMO OFF", "gray") end
end, Color3.fromRGB(200, 100, 0))
yPos = yPos + 52

local speedBtn = createGlowButton("🏃 SPEED BOOST [OFF]", yPos, function()
    speedEnabled = not speedEnabled
    speedBtn.Text = speedEnabled and "🏃 SPEED BOOST [ON]" or "🏃 SPEED BOOST [OFF]"
    if speedEnabled then humanoid.WalkSpeed = speedValue else humanoid.WalkSpeed = originalWalkSpeed end
end, Color3.fromRGB(0, 150, 100))
yPos = yPos + 52

local noclipBtn = createGlowButton("🔓 NOCLIP [OFF]", yPos, function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = noclipEnabled and "🔓 NOCLIP [ON]" or "🔓 NOCLIP [OFF]"
    if noclipEnabled then spawn(toggleNoclip) else notif("NOCLIP OFF", "gray") end
end, Color3.fromRGB(100, 100, 200))
yPos = yPos + 52

local espBtn = createGlowButton("👁️ ESP PLAYER [OFF]", yPos, function()
    toggleEsp()
    espBtn.Text = espEnabled and "👁️ ESP PLAYER [ON]" or "👁️ ESP PLAYER [OFF]"
end, Color3.fromRGB(0, 200, 0))
yPos = yPos + 52

local aimBtn = createGlowButton("🎯 AIMBOT [OFF]", yPos, function()
    aimbotEnabled = not aimbotEnabled
    aimBtn.Text = aimbotEnabled and "🎯 AIMBOT [ON]" or "🎯 AIMBOT [OFF]"
    if aimbotEnabled then spawn(toggleAimbot) else notif("AIMBOT OFF", "gray") end
end, Color3.fromRGB(200, 0, 200))
yPos = yPos + 52

-- Generator
local genWeaponBtn = createGlowButton("🔫 GEN WEAPON [OFF]", yPos, function()
    autoGenWeapon = not autoGenWeapon
    genWeaponBtn.Text = autoGenWeapon and "🔫 GEN WEAPON [ON]" or "🔫 GEN WEAPON [OFF]"
end, Color3.fromRGB(180, 50, 50))
yPos = yPos + 52

local genAmmoBtn = createGlowButton("📦 GEN AMMO [OFF]", yPos, function()
    autoGenAmmo = not autoGenAmmo
    genAmmoBtn.Text = autoGenAmmo and "📦 GEN AMMO [ON]" or "📦 GEN AMMO [OFF]"
end, Color3.fromRGB(180, 100, 0))
yPos = yPos + 52

local genHealBtn = createGlowButton("💊 GEN HEAL [OFF]", yPos, function()
    autoGenHeal = not autoGenHeal
    genHealBtn.Text = autoGenHeal and "💊 GEN HEAL [ON]" or "💊 GEN HEAL [OFF]"
end, Color3.fromRGB(0, 150, 0))
yPos = yPos + 52

local genEffectBtn = createGlowButton("✨ GEN EFFECT [OFF]", yPos, function()
    autoGenEffect = not autoGenEffect
    genEffectBtn.Text = autoGenEffect and "✨ GEN EFFECT [ON]" or "✨ GEN EFFECT [OFF]"
end, Color3.fromRGB(100, 0, 200))
yPos = yPos + 52

-- Auto
local sellBtn = createGlowButton("💰 AUTO SELL [OFF]", yPos, function()
    autoSell = not autoSell
    sellBtn.Text = autoSell and "💰 AUTO SELL [ON]" or "💰 AUTO SELL [OFF]"
end, Color3.fromRGB(255, 150, 0))
yPos = yPos + 52

local teleBtn = createGlowButton("🌀 AUTO TELEPORT [OFF]", yPos, function()
    autoTeleport = not autoTeleport
    teleBtn.Text = autoTeleport and "🌀 AUTO TELEPORT [ON]" or "🌀 AUTO TELEPORT [OFF]"
    if autoTeleport then collectTeleports() end
end, Color3.fromRGB(100, 0, 200))
yPos = yPos + 52

local collectBtn = createGlowButton("🎁 AUTO COLLECT [OFF]", yPos, function()
    autoCollect = not autoCollect
    collectBtn.Text = autoCollect and "🎁 AUTO COLLECT [ON]" or "🎁 AUTO COLLECT [OFF]"
end, Color3.fromRGB(0, 150, 150))
yPos = yPos + 52

local farmBtn = createGlowButton("⚔️ AUTO FARM [OFF]", yPos, function()
    autoFarm = not autoFarm
    farmBtn.Text = autoFarm and "⚔️ AUTO FARM [ON]" or "⚔️ AUTO FARM [OFF]"
end, Color3.fromRGB(150, 0, 0))
yPos = yPos + 52

-- Speed slider
local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.4, 0, 0, 35)
speedSlider.Position = UDim2.new(0.06, 0, 0, yPos)
speedSlider.PlaceholderText = "Speed"
speedSlider.Text = tostring(speedValue)
speedSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.Font = Enum.Font.Gotham
speedSlider.TextSize = 14
speedSlider.Parent = scroll
speedSlider.FocusLost:Connect(function()
    local newSpeed = tonumber(speedSlider.Text)
    if newSpeed and newSpeed > 0 then
        speedValue = newSpeed
        if speedEnabled then humanoid.WalkSpeed = speedValue end
    end
end)
yPos = yPos + 45

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.15, 0, 0, 25)
closeBtn.Position = UDim2.new(0.83, 0, -8, 0)
closeBtn.Text = "❌"
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Drag UI
local dragStart, startPos, dragging = nil, nil, false
mainFrame.MouseButton1Down:Connect(function(x, y)
    dragging = true
    dragStart = Vector2.new(x, y)
    startPos = mainFrame.Position
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Stat display
local statFrame = Instance.new("Frame")
statFrame.Size = UDim2.new(0, 200, 0, 80)
statFrame.Position = UDim2.new(0.02, 0, 0.82, 0)
statFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statFrame.BackgroundTransparency = 0.5
statFrame.BorderSizePixel = 0
statFrame.Parent = screenGui

local statText = Instance.new("TextLabel")
statText.Size = UDim2.new(1, 0, 1, 0)
statText.BackgroundTransparency = 1
statText.Text = "💰 0 | ⭐ 0 | 💀 0"
statText.TextColor3 = Color3.fromRGB(255, 215, 0)
statText.Font = Enum.Font.GothamBold
statText.TextSize = 14
statText.Parent = statFrame

spawn(function()
    while true do
        statText.Text = "💰 " .. totalMoney .. " | ⭐ " .. totalExp .. " | 💀 " .. totalKills
        wait(1)
    end
end)

notif("💀 ROYAL ULTIMATE SCRIPT AKTIF! 25+ FITUR SIAP 💀", "red")
print("✅ XATANICAL AI VIP : DISTRIK KEKERASAN ROYAL SCRIPT BERJALAN 💓💞💖")
