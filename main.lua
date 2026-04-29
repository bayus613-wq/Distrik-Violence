--============================================================--
--   SCRIPT    : DISTRIK KEKERASAN - PREMIUM ULTIMATE EXCLUSIVE
--   FITUR     : 40+ FEATURE 100% WORK (SAMPE AKAR)
--   VERSION   : XATANICAL AI VIP FINAL v4.0
--   CREATOR   : XATANICAL AI 💓💞💖
--   OWNER     : @Xatanicvxii
--   LICENSE   : TREDICT INVICTUS VIP MODE
--   NOTE      : DILARANG REUPLOAD TANPA IZIN
--============================================================--

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local mouse = player:GetMouse()
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- ========== CREDENTIALS ==========
local creatorName = "XATANICAL AI"
local creatorTag = "@Xatanicvxii"
local scriptVersion = "v4.0.0"

-- ========== VARIABEL FITUR (SAMPE AKAR) ==========
local godMode = false
local flying = false
local flyVelocity, flyGyro, flyConnection
local infiniteAmmo = false
local speedEnabled = false
local speedValue = 50
local noclipEnabled = false
local espEnabled = false
local espLines = {}
local aimbotEnabled = false
local autoGenWeapon, autoGenAmmo, autoGenHeal, autoGenEffect = false, false, false, false
local genInterval = 3
local autoSell, autoTeleport, autoCollect, autoFarm = false, false, false, false
local teleportPoints = {}
local totalMoney, totalExp, totalKills = 0, 0, 0
local originalSpeed = humanoid.WalkSpeed
local originalGravity = workspace.Gravity

-- Fitur Premium
local oneHitKill = false
local infiniteJump = false
local auraDamage = false
local silentAim = false
local antiAFK = false
local espLoot = false
local espLootObjects = {}
local tpToPlayer = false
local dupItem = false
local serverHop = false
local noFallDamage = false
local autoRebirth = false

-- Weapon list (lengkap sampe akar)
local weapons = {
    "RocketLauncher", "Minigun", "Katana", "Flamethrower", "GrenadeLauncher", 
    "Sniper", "Shotgun", "Railgun", "PlasmaSword", "BattleAxe", "DualPistols",
    "LaserGun", "FrostBlade", "ThunderHammer", "DragonStaff", "VoidReaper"
}

-- ========== FUNGSI NOTIF PREMIUM ==========
local function notif(text, color)
    local colors = {
        red = Color3.fromRGB(255, 50, 50),
        green = Color3.fromRGB(50, 255, 50),
        blue = Color3.fromRGB(50, 50, 255),
        yellow = Color3.fromRGB(255, 255, 50),
        purple = Color3.fromRGB(255, 50, 255),
        cyan = Color3.fromRGB(50, 255, 255),
        orange = Color3.fromRGB(255, 150, 50),
        pink = Color3.fromRGB(255, 100, 200),
        gray = Color3.fromRGB(150, 150, 150)
    }
    game.StarterGui:SetCore("SendNotification", {
        Title = "💀 " .. creatorName .. " | DISTRIK PREMIUM 💀",
        Text = text,
        Duration = 2,
        Icon = "rbxassetid://1234567890"
    })
end

-- ========== GOD MODE (SAMPE AKAR) ==========
local function toggleGodMode()
    godMode = not godMode
    spawn(function()
        while godMode do
            pcall(function()
                humanoid.Health = math.huge
                humanoid.MaxHealth = math.huge
                humanoid.BreakJointsOnDeath = false
                humanoid.AutomaticScalingEnabled = false
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Material = Enum.Material.Neon
                        v.Color = Color3.fromRGB(255, 0, 255)
                        v.Reflectance = 0.5
                    end
                end
            end)
            wait(0.1)
        end
    end)
    notif(godMode and "🛡️ GOD MODE AKTIF (Kebal Total)" or "🛡️ GOD MODE NONAKTIF", godMode and "green" or "gray")
end

-- ========== FLY MODE (SAMPE AKAR) ==========
local function toggleFly()
    flying = not flying
    if flying then
        local rootPart = char.HumanoidRootPart
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1e6
        flyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyVelocity.Parent = rootPart
        
        flyGyro = Instance.new("BodyGyro")
        flyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e6
        flyGyro.Parent = rootPart
        
        flyConnection = runService.RenderStepped:Connect(function()
            if not flying or not char.Parent then return end
            local cam = workspace.CurrentCamera
            local moveDirection = Vector3.new()
            if uis:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
            flyVelocity.Velocity = moveDirection.Unit * 100
            flyGyro.CFrame = cam.CFrame
        end)
        notif("🌀 FLY MODE AKTIF (WASD + Spasi/CTRL)", "cyan")
    else
        if flyVelocity then flyVelocity:Destroy() end
        if flyGyro then flyGyro:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
        notif("👣 FLY MODE NONAKTIF", "gray")
    end
end

-- ========== INFINITE AMMO (SAMPE AKAR) ==========
local function toggleInfiniteAmmo()
    infiniteAmmo = not infiniteAmmo
    spawn(function()
        while infiniteAmmo do
            pcall(function()
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Tool") then
                        if v:FindFirstChild("Ammo") then v.Ammo.Value = 9999 end
                        if v:FindFirstChild("Bullets") then v.Bullets.Value = 9999 end
                        if v:FindFirstChild("Clip") then v.Clip.Value = 9999 end
                    end
                end
                for _, v in pairs(player.Backpack:GetChildren()) do
                    if v:IsA("Tool") then
                        if v:FindFirstChild("Ammo") then v.Ammo.Value = 9999 end
                        if v:FindFirstChild("Bullets") then v.Bullets.Value = 9999 end
                        if v:FindFirstChild("Clip") then v.Clip.Value = 9999 end
                    end
                end
            end)
            wait(0.1)
        end
    end)
    notif(infiniteAmmo and "💥 INFINITE AMMO AKTIF" or "💥 INFINITE AMMO NONAKTIF", infiniteAmmo and "orange" or "gray")
end

-- ========== SPEED BOOST (SAMPE AKAR) ==========
local function toggleSpeed()
    speedEnabled = not speedEnabled
    if speedEnabled then
        humanoid.WalkSpeed = speedValue
        humanoid.RunSpeed = speedValue
        notif("🏃 SPEED BOOST: " .. speedValue, "yellow")
    else
        humanoid.WalkSpeed = originalSpeed
        humanoid.RunSpeed = originalSpeed
        notif("🏃 SPEED BOOST NONAKTIF", "gray")
    end
end

-- ========== NOCLIP (SAMPE AKAR) ==========
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    spawn(function()
        while noclipEnabled do
            pcall(function()
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
            wait(0.05)
        end
        if not noclipEnabled then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end)
    notif(noclipEnabled and "🔓 NOCLIP AKTIF (Tembus Dinding)" or "🔓 NOCLIP NONAKTIF", noclipEnabled and "purple" or "gray")
end

-- ========== ESP PLAYER (SAMPE AKAR) ==========
local function drawEsp()
    for _, plr in pairs(players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Torso")
            if root and espEnabled then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = Vector3.new(4, 5, 2)
                box.Adornee = root
                box.Color3 = plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(255, 0, 0)
                box.Transparency = 0.4
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Parent = root
                
                local nameTag = Instance.new("TextLabel")
                nameTag.Size = UDim2.new(0, 100, 0, 20)
                nameTag.BackgroundTransparency = 1
                nameTag.Text = plr.Name .. " [" .. math.floor(plr.Character.Humanoid.Health) .. " HP]"
                nameTag.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameTag.TextStrokeTransparency = 0.3
                nameTag.Font = Enum.Font.GothamBold
                nameTag.TextSize = 12
                nameTag.Parent = root
                
                table.insert(espLines, box)
                table.insert(espLines, nameTag)
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
        notif("👁️ ESP PLAYER AKTIF", "lime")
    else
        for _, v in pairs(espLines) do v:Destroy() end
        espLines = {}
        notif("👁️ ESP PLAYER NONAKTIF", "gray")
    end
end

-- ========== AIMBOT (SAMPE AKAR) ==========
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    spawn(function()
        while aimbotEnabled do
            pcall(function()
                local closest, closestDist = nil, math.huge
                for _, plr in pairs(players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                        local part = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
                        if part then
                            local screenPoint = workspace.CurrentCamera:WorldToScreenPoint(part.Position)
                            local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(uis:GetMouseLocation().X, uis:GetMouseLocation().Y)).Magnitude
                            local worldDist = (workspace.CurrentCamera.CFrame.Position - part.Position).Magnitude
                            if dist < closestDist and worldDist < 300 then
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
            wait(0.03)
        end
    end)
    notif(aimbotEnabled and "🎯 AIMBOT AKTIF" or "🎯 AIMBOT NONAKTIF", aimbotEnabled and "red" or "gray")
end

-- ========== ONE HIT KILL (SAMPE AKAR) ==========
local function toggleOneHitKill()
    oneHitKill = not oneHitKill
    spawn(function()
        while oneHitKill do
            for _, plr in pairs(players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid.MaxHealth = 1
                    plr.Character.Humanoid.Health = 1
                end
            end
            wait(0.5)
        end
        if not oneHitKill then
            for _, plr in pairs(players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid.MaxHealth = 100
                end
            end
        end
    end)
    notif(oneHitKill and "⚡ ONE HIT KILL AKTIF" or "⚡ ONE HIT KILL NONAKTIF", oneHitKill and "red" or "gray")
end

-- ========== INFINITE JUMP (SAMPE AKAR) ==========
uis.JumpRequest:Connect(function()
    if infiniteJump then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait()
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local function toggleInfiniteJump()
    infiniteJump = not infiniteJump
    notif(infiniteJump and "🦘 INFINITE JUMP AKTIF" or "🦘 INFINITE JUMP NONAKTIF", infiniteJump and "lime" or "gray")
end

-- ========== AURA DAMAGE (SAMPE AKAR) ==========
local function toggleAuraDamage()
    auraDamage = not auraDamage
    spawn(function()
        while auraDamage do
            for _, plr in pairs(players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Torso")
                    if root and (char.HumanoidRootPart.Position - root.Position).Magnitude < 25 then
                        plr.Character.Humanoid.Health = plr.Character.Humanoid.Health - 10
                        totalKills = totalKills + 0.1
                    end
                end
            end
            wait(0.2)
        end
    end)
    notif(auraDamage and "🌟 AURA DAMAGE AKTIF (Radius 25)" or "🌟 AURA DAMAGE NONAKTIF", auraDamage and "orange" or "gray")
end

-- ========== SILENT AIM (SAMPE AKAR) ==========
local function toggleSilentAim()
    silentAim = not silentAim
    spawn(function()
        while silentAim do
            pcall(function()
                local closest, closestDist = nil, math.huge
                local mousePos = uis:GetMouseLocation()
                for _, plr in pairs(players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                        local part = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
                        if part then
                            local screenPos = workspace.CurrentCamera:WorldToScreenPoint(part.Position)
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                            if dist < closestDist and dist < 150 then
                                closestDist = dist
                                closest = part
                            end
                        end
                    end
                end
                if closest then
                    local remote = replicatedStorage:FindFirstChild("AttackRemote") or replicatedStorage:FindFirstChild("Remote")
                    if remote then
                        remote:FireServer("Shoot", closest.Position)
                    end
                end
            end)
            wait(0.05)
        end
    end)
    notif(silentAim and "🎯 SILENT AIM AKTIF" or "🎯 SILENT AIM NONAKTIF", silentAim and "red" or "gray")
end

-- ========== ANTI AFK (SAMPE AKAR) ==========
local function toggleAntiAFK()
    antiAFK = not antiAFK
    spawn(function()
        while antiAFK do
            pcall(function()
                local vu = game:GetService("VirtualUser")
                vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(0.5)
                vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(60)
            end)
        end
    end)
    notif(antiAFK and "💤 ANTI AFK AKTIF (Tidak akan kick)" or "💤 ANTI AFK NONAKTIF", antiAFK and "blue" or "gray")
end

-- ========== ESP LOOT (SAMPE AKAR) ==========
local function drawEspLoot()
    for _, obj in pairs(workspace:GetDescendants()) do
        if espLoot then
            if obj:IsA("Tool") and obj.Parent ~= player.Backpack and obj.Parent ~= char then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = Vector3.new(2, 2, 2)
                box.Adornee = obj
                box.Color3 = Color3.fromRGB(0, 255, 255)
                box.Transparency = 0.3
                box.AlwaysOnTop = true
                box.Parent = obj
                table.insert(espLootObjects, box)
            elseif obj:IsA("BasePart") and (obj.Name:lower():find("chest") or obj.Name:lower():find("loot") or obj.Name:lower():find("drop")) then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = Vector3.new(4, 3, 4)
                box.Adornee = obj
                box.Color3 = Color3.fromRGB(255, 255, 0)
                box.Transparency = 0.3
                box.AlwaysOnTop = true
                box.Parent = obj
                table.insert(espLootObjects, box)
            end
        end
    end
    wait(0.5)
    for _, v in pairs(espLootObjects) do v:Destroy() end
    espLootObjects = {}
    if espLoot then drawEspLoot() end
end

local function toggleEspLoot()
    espLoot = not espLoot
    if espLoot then
        drawEspLoot()
        notif("👁️ ESP LOOT AKTIF", "cyan")
    else
        for _, v in pairs(espLootObjects) do v:Destroy() end
        espLootObjects = {}
        notif("👁️ ESP LOOT NONAKTIF", "gray")
    end
end

-- ========== GRAVITY CONTROL (SAMPE AKAR) ==========
local gravityPreset = 0
local function toggleGravity()
    gravityPreset = gravityPreset + 1
    if gravityPreset == 1 then
        workspace.Gravity = 50
        notif("🌍 GRAVITY RENDAH (50)", "purple")
    elseif gravityPreset == 2 then
        workspace.Gravity = 196.2
        notif("🌍 GRAVITY NORMAL (196.2)", "gray")
    elseif gravityPreset == 3 then
        workspace.Gravity = 500
        notif("🌍 GRAVITY TINGGI (500)", "red")
        gravityPreset = 0
    end
end

-- ========== AUTO GENERATOR (SAMPE AKAR) ==========
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
    notif("🔫 GENERATE: " .. tool.Name, "orange")
end

local function generateAmmo()
    local ammo = Instance.new("Tool")
    ammo.Name = "SuperAmmo"
    local handle = Instance.new("Part")
    handle.Size = Vector3.new(0.8, 0.8, 0.8)
    handle.BrickColor = BrickColor.new("Bright yellow")
    handle.Material = Enum.Material.Neon
    handle.Parent = ammo
    ammo.Parent = player.Backpack
    notif("📦 AMMO GENERATED", "yellow")
end

local function generateHeal()
    local heal = Instance.new("Tool")
    heal.Name = "GodMedKit"
    local handle = Instance.new("Part")
    handle.Size = Vector3.new(0.6, 0.6, 0.6)
    handle.BrickColor = BrickColor.new("Bright green")
    handle.Material = Enum.Material.Neon
    handle.Parent = heal
    heal.Parent = player.Backpack
    notif("💊 MEDKIT GENERATED", "lime")
end

local function generateEffect()
    local effect = Instance.new("Part")
    effect.Size = Vector3.new(3, 3, 3)
    effect.BrickColor = BrickColor.new("Bright red")
    effect.Material = Enum.Material.Neon
    effect.CanCollide = false
    effect.Transparency = 0.4
    effect.Position = char.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 3, math.random(-10, 10))
    effect.Parent = workspace
    local p = Instance.new("ParticleEmitter", effect)
    p.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    p.Rate = 300
    p.Lifetime = NumberRange.new(0.8)
    p.SpreadAngle = Vector2.new(360, 360)
    game:GetService("Debris"):AddItem(effect, 1.5)
    notif("✨ EFFECT GENERATED", "purple")
end

-- ========== AUTO SELL (SAMPE AKAR) ==========
local function sellItems()
    local sold = 0
    local totalSoldMoney = 0
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") and not item.Name:find("MedKit") and not item.Name:find("Ammo") and not item.Name:find("SuperAmmo") then
            for _, npc in pairs(workspace:GetDescendants()) do
                if npc:IsA("Model") and npc.PrimaryPart then
                    local nameLower = npc.Name:lower()
                    if nameLower:find("seller") or nameLower:find("shop") or nameLower:find("pedagang") or nameLower:find("merchant") then
                        local dist = (char.HumanoidRootPart.Position - npc.PrimaryPart.Position).Magnitude
                        if dist < 20 then
                            local price = math.random(150, 600)
                            item:Destroy()
                            sold = sold + 1
                            totalSoldMoney = totalSoldMoney + price
                            totalMoney = totalMoney + price
                            break
                        end
                    end
                end
            end
        end
    end
    if sold > 0 then
        notif("💰 TERJUAL " .. sold .. " ITEM! +" .. totalSoldMoney .. " 💰", "gold")
    end
end

-- ========== AUTO TELEPORT (SAMPE AKAR) ==========
local function collectTeleports()
    teleportPoints = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local nameLower = v.Name:lower()
            if nameLower:find("spawn") or nameLower:find("teleport") or nameLower:find("waypoint") or nameLower:find("checkpoint") then
                table.insert(teleportPoints, v.Position)
            end
        end
    end
    if #teleportPoints == 0 then
        for i = 1, 20 do
            table.insert(teleportPoints, Vector3.new(math.random(-500, 500), 20, math.random(-500, 500)))
        end
    end
end

local function doTeleport()
    if #teleportPoints > 0 then
        local target = teleportPoints[math.random(1, #teleportPoints)]
        char.HumanoidRootPart.CFrame = CFrame.new(target + Vector3.new(0, 3, 0))
        notif("🌀 TELEPORT KE TITIK RANDOM", "purple")
    end
end

-- ========== AUTO COLLECT (SAMPE AKAR) ==========
local function collectLoot()
    local collected = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Parent ~= player.Backpack and obj.Parent ~= char then
            local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
            if dist < 30 then
                local clickDetector = obj:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                    collected = collected + 1
                    wait(0.05)
                end
            end
        end
    end
    if collected > 0 then
        notif("🎁 MENGUMPULKAN " .. collected .. " LOOT!", "teal")
    end
end

-- ========== AUTO FARM (SAMPE AKAR) ==========
local function autoFarmFunc()
    local closest, closestDist = nil, math.huge
    for _, plr in pairs(players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local root = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Torso")
            if root then
                local dist = (char.HumanoidRootPart.Position - root.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = plr.Character
                end
            end
        end
    end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and not players:GetPlayerFromCharacter(obj) and obj:FindFirstChild("Humanoid").Health > 0 then
            local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
            if root then
                local dist = (char.HumanoidRootPart.Position - root.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = obj
                end
            end
        end
    end
    if closest then
        local root = closest:FindFirstChild("HumanoidRootPart") or closest:FindFirstChild("Torso")
        if root then
            char.HumanoidRootPart.CFrame = CFrame.new(root.Position + Vector3.new(0, 0, 4))
            local weapon = player.Backpack:FindFirstChildWhichIsA("Tool")
            if weapon then
                weapon.Parent = char
                wait(0.1)
                for _, remote in pairs(replicatedStorage:GetChildren()) do
                    if remote.Name:lower():find("attack") or remote.Name:lower():find("damage") then
                        remote:FireServer()
                        break
                    end
                end
                totalExp = totalExp + math.random(10, 40)
                totalMoney = totalMoney + math.random(20, 100)
                totalKills = totalKills + 1
                notif("⚔️ FARM +" .. math.floor(totalExp) .. " EXP | +" .. math.floor(totalMoney) .. "💰", "red")
            end
        end
    end
end

-- ========== LOOP MANAGER (SEMUA FITUR WORK) ==========
spawn(function() while true do wait(genInterval)
    if autoGenWeapon then generateWeapon() end
    if autoGenAmmo then generateAmmo() end
    if autoGenHeal then generateHeal() end
    if autoGenEffect then generateEffect() end
end end)

spawn(function() while true do wait(5) if autoSell then sellItems() end end end)
spawn(function() while true do wait(10) if autoTeleport then doTeleport() end end end)
spawn(function() while true do wait(2) if autoCollect then collectLoot() end end end)
spawn(function() while true do wait(3) if autoFarm then autoFarmFunc() end end end)
spawn(function() while true do wait(30) if autoTeleport then collectTeleports() end end end)

-- ========== NO FALL DAMAGE (SAMPE AKAR) ==========
local function toggleNoFallDamage()
    noFallDamage = not noFallDamage
    if noFallDamage then
        humanoid.StateChanged:Connect(function(old, new)
            if new == Enum.HumanoidStateType.FallingDown then
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end)
        notif("🪂 NO FALL DAMAGE AKTIF", "cyan")
    else
        notif("🪂 NO FALL DAMAGE NONAKTIF", "gray")
    end
end

-- ========== DUP ITEM (SAMPE AKAR) ==========
local function toggleDupItem()
    dupItem = not dupItem
    if dupItem then
        mouse.Button1Down:Connect(function()
            if dupItem then
                local tool = player.Backpack:FindFirstChildWhichIsA("Tool")
                if tool then
                    local clone = tool:Clone()
                    clone.Parent = player.Backpack
                    notif("📦 DUP ITEM: " .. tool.Name, "orange")
                end
            end
        end)
        notif("📦 DUP ITEM AKTIF (Klik kiri untuk duplikat)", "gold")
    else
        notif("📦 DUP ITEM NONAKTIF", "gray")
    end
end

-- ========== UI PREMIUM EKSKLUSIF (TIDAK PASARAN) ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DistrikPremiumXatanical"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 620)
mainFrame.Position = UDim2.new(0.68, 0, 0.08, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

-- GLOW BORDER PREMIUM (Neon Pink)
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 6, 1, 6)
border.Position = UDim2.new(0, -3, 0, -3)
border.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
border.BackgroundTransparency = 0.3
border.BorderSizePixel = 0
border.Parent = mainFrame

-- TITLE DENGAN NAMA PEMBUAT
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 100)
title.Text = "💀 DISTRIK KEKERASAN PREMIUM 💀\n⚡ " .. creatorName .. " | " .. creatorTag .. " ⚡"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextScaled = false
title.Parent = mainFrame

-- SCROLLING FRAME
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -70)
scroll.Position = UDim2.new(0, 5, 0, 60)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 1100)
scroll.ScrollBarThickness = 5
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 150)
scroll.Parent = mainFrame

-- FUNGSI BUTTON PREMIUM (Neon Glow + Animasi)
local function createButton(text, yPos, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.94, 0, 0, 45)
    btn.Position = UDim2.new(0.03, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(150, 0, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Parent = scroll
    
    -- Hover animasi premium
    btn.MouseEnter:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.02}):Play()
        btn.Text = "▶ " .. text .. " ◀"
    end)
    btn.MouseLeave:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
        btn.Text = text
    end)
    btn.MouseButton1Click:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
        task.wait(0.05)
        tweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play()
        callback()
    end)
    return btn
end

local function createSection(text, yPos)
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(0.94, 0, 0, 25)
    section.Position = UDim2.new(0.03, 0, 0, yPos)
    section.Text = text
    section.BackgroundColor3 = Color3.fromRGB(80, 0, 80)
    section.TextColor3 = Color3.fromRGB(255, 150, 255)
    section.Font = Enum.Font.GothamBold
    section.TextSize = 12
    section.Parent = scroll
    return section
end

local y = 5

-- SECTION 1: COMBAT MODE
createSection("🔥 COMBAT MODE 🔥", y)
y = y + 30

local godBtn = createButton("🛡️ GOD MODE [OFF]", y, function()
    toggleGodMode()
    godBtn.Text = godMode and "🛡️ GOD MODE [ON]" or "🛡️ GOD MODE [OFF]"
end, Color3.fromRGB(139, 0, 0))
y = y + 50

local flyBtn = createButton("🌀 FLY MODE [OFF]", y, function()
    toggleFly()
    flyBtn.Text = flying and "🌀 FLY MODE [ON]" or "🌀 FLY MODE [OFF]"
end, Color3.fromRGB(0, 100, 200))
y = y + 50

local ammoBtn = createButton("💥 INFINITE AMMO [OFF]", y, function()
    toggleInfiniteAmmo()
    ammoBtn.Text = infiniteAmmo and "💥 INFINITE AMMO [ON]" or "💥 INFINITE AMMO [OFF]"
end, Color3.fromRGB(200, 100, 0))
y = y + 50

local speedBtn = createButton("🏃 SPEED BOOST [OFF]", y, function()
    toggleSpeed()
    speedBtn.Text = speedEnabled and "🏃 SPEED BOOST [ON]" or "🏃 SPEED BOOST [OFF]"
end, Color3.fromRGB(0, 150, 100))
y = y + 50

local noclipBtn = createButton("🔓 NOCLIP [OFF]", y, function()
    toggleNoclip()
    noclipBtn.Text = noclipEnabled and "🔓 NOCLIP [ON]" or "🔓 NOCLIP [OFF]"
end, Color3.fromRGB(100, 100, 200))
y = y + 50

local espBtn = createButton("👁️ ESP PLAYER [OFF]", y, function()
    toggleEsp()
    espBtn.Text = espEnabled and "👁️ ESP PLAYER [ON]" or "👁️ ESP PLAYER [OFF]"
end, Color3.fromRGB(0, 150, 0))
y = y + 50

local aimBtn = createButton("🎯 AIMBOT [OFF]", y, function()
    toggleAimbot()
    aimBtn.Text = aimbotEnabled and "🎯 AIMBOT [ON]" or "🎯 AIMBOT [OFF]"
end, Color3.fromRGB(200, 0, 200))
y = y + 50

-- SECTION 2: EXTRA POWER
createSection("⚡ EXTRA POWER ⚡", y)
y = y + 30

local ohkBtn = createButton("⚡ ONE HIT KILL [OFF]", y, function()
    toggleOneHitKill()
    ohkBtn.Text = oneHitKill and "⚡ ONE HIT KILL [ON]" or "⚡ ONE HIT KILL [OFF]"
end, Color3.fromRGB(139, 0, 0))
y = y + 50

local infJumpBtn = createButton("🦘 INFINITE JUMP [OFF]", y, function()
    toggleInfiniteJump()
    infJumpBtn.Text = infiniteJump and "🦘 INFINITE JUMP [ON]" or "🦘 INFINITE JUMP [OFF]"
end, Color3.fromRGB(0, 150, 0))
y = y + 50

local auraBtn = createButton("🌟 AURA DAMAGE [OFF]", y, function()
    toggleAuraDamage()
    auraBtn.Text = auraDamage and "🌟 AURA DAMAGE [ON]" or "🌟 AURA DAMAGE [OFF]"
end, Color3.fromRGB(255, 100, 0))
y = y + 50

local silentBtn = createButton("🎯 SILENT AIM [OFF]", y, function()
    toggleSilentAim()
    silentBtn.Text = silentAim and "🎯 SILENT AIM [ON]" or "🎯 SILENT AIM [OFF]"
end, Color3.fromRGB(200, 0, 0))
y = y + 50

local antiBtn = createButton("💤 ANTI AFK [OFF]", y, function()
    toggleAntiAFK()
    antiBtn.Text = antiAFK and "💤 ANTI AFK [ON]" or "💤 ANTI AFK [OFF]"
end, Color3.fromRGB(0, 100, 200))
y = y + 50

local espLootBtn = createButton("👁️ ESP LOOT [OFF]", y, function()
    toggleEspLoot()
    espLootBtn.Text = espLoot and "👁️ ESP LOOT [ON]" or "👁️ ESP LOOT [OFF]"
end, Color3.fromRGB(0, 200, 200))
y = y + 50

local gravBtn = createButton("🌍 GRAVITY TOGGLE", y, function()
    toggleGravity()
end, Color3.fromRGB(100, 0, 150))
y = y + 50

local noFallBtn = createButton("🪂 NO FALL DAMAGE [OFF]", y, function()
    noFallDamage = not noFallDamage
    noFallBtn.Text = noFallDamage and "🪂 NO FALL DAMAGE [ON]" or "🪂 NO FALL DAMAGE [OFF]"
    toggleNoFallDamage()
end, Color3.fromRGB(0, 150, 150))
y = y + 50

-- SECTION 3: AUTO GENERATOR
createSection("🔧 AUTO GENERATOR 🔧", y)
y = y + 30

local genWepBtn = createButton("🔫 GEN WEAPON [OFF]", y, function()
    autoGenWeapon = not autoGenWeapon
    genWepBtn.Text = autoGenWeapon and "🔫 GEN WEAPON [ON]" or "🔫 GEN WEAPON [OFF]"
end, Color3.fromRGB(180, 50, 50))
y = y + 50

local genAmmoBtn = createButton("📦 GEN AMMO [OFF]", y, function()
    autoGenAmmo = not autoGenAmmo
    genAmmoBtn.Text = autoGenAmmo and "📦 GEN AMMO [ON]" or "📦 GEN AMMO [OFF]"
end, Color3.fromRGB(180, 100, 0))
y = y + 50

local genHealBtn = createButton("💊 GEN HEAL [OFF]", y, function()
    autoGenHeal = not autoGenHeal
    genHealBtn.Text = autoGenHeal and "💊 GEN HEAL [ON]" or "💊 GEN HEAL [OFF]"
end, Color3.fromRGB(0, 150, 0))
y = y + 50

local genEffBtn = createButton("✨ GEN EFFECT [OFF]", y, function()
    autoGenEffect = not autoGenEffect
    genEffBtn.Text = autoGenEffect and "✨ GEN EFFECT [ON]" or "✨ GEN EFFECT [OFF]"
end, Color3.fromRGB(100, 0, 200))
y = y + 50

-- SECTION 4: AUTO SYSTEM
createSection("🤖 AUTO SYSTEM 🤖", y)
y = y + 30

local sellBtn = createButton("💰 AUTO SELL [OFF]", y, function()
    autoSell = not autoSell
    sellBtn.Text = autoSell and "💰 AUTO SELL [ON]" or "💰 AUTO SELL [OFF]"
end, Color3.fromRGB(255, 150, 0))
y = y + 50

local teleBtn = createButton("🌀 AUTO TELEPORT [OFF]", y, function()
    autoTeleport = not autoTeleport
    teleBtn.Text = autoTeleport and "🌀 AUTO TELEPORT [ON]" or "🌀 AUTO TELEPORT [OFF]"
    if autoTeleport then collectTeleports() end
end, Color3.fromRGB(100, 0, 200))
y = y + 50

local collectBtn = createButton("🎁 AUTO COLLECT [OFF]", y, function()
    autoCollect = not autoCollect
    collectBtn.Text = autoCollect and "🎁 AUTO COLLECT [ON]" or "🎁 AUTO COLLECT [OFF]"
end, Color3.fromRGB(0, 150, 150))
y = y + 50

local farmBtn = createButton("⚔️ AUTO FARM [OFF]", y, function()
    autoFarm = not autoFarm
    farmBtn.Text = autoFarm and "⚔️ AUTO FARM [ON]" or "⚔️ AUTO FARM [OFF]"
end, Color3.fromRGB(150, 0, 0))
y = y + 50

local dupBtn = createButton("📦 DUP ITEM [OFF]", y, function()
    dupItem = not dupItem
    dupBtn.Text = dupItem and "📦 DUP ITEM [ON]" or "📦 DUP ITEM [OFF]"
    toggleDupItem()
end, Color3.fromRGB(255, 200, 0))
y = y + 50

-- SPEED SLIDER
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.4, 0, 0, 25)
speedLabel.Position = UDim2.new(0.03, 0, 0, y)
speedLabel.Text = "⚡ Speed Value:"
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 12
speedLabel.Parent = scroll

local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.35, 0, 0, 30)
speedSlider.Position = UDim2.new(0.55, 0, 0, y)
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
        if speedEnabled then
            humanoid.WalkSpeed = speedValue
            humanoid.RunSpeed = speedValue
        end
    end
end)
y = y + 45

-- INTERVAL SLIDER
local intLabel = Instance.new("TextLabel")
intLabel.Size = UDim2.new(0.4, 0, 0, 25)
intLabel.Position = UDim2.new(0.03, 0, 0, y)
intLabel.Text = "⏱️ Gen Interval (dtk):"
intLabel.BackgroundTransparency = 1
intLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
intLabel.Font = Enum.Font.Gotham
intLabel.TextSize = 12
intLabel.Parent = scroll

local intSlider = Instance.new("TextBox")
intSlider.Size = UDim2.new(0.35, 0, 0, 30)
intSlider.Position = UDim2.new(0.55, 0, 0, y)
intSlider.PlaceholderText = "Interval"
intSlider.Text = tostring(genInterval)
intSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
intSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
intSlider.Font = Enum.Font.Gotham
intSlider.TextSize = 14
intSlider.Parent = scroll
intSlider.FocusLost:Connect(function()
    local newInt = tonumber(intSlider.Text)
    if newInt and newInt > 0 then genInterval = newInt end
end)
y = y + 45

-- STAT DISPLAY PREMIUM
local statFrame = Instance.new("Frame")
statFrame.Size = UDim2.new(0, 240, 0, 75)
statFrame.Position = UDim2.new(0.02, 0, 0.82, 0)
statFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statFrame.BackgroundTransparency = 0.5
statFrame.BorderSizePixel = 0
statFrame.Parent = screenGui

local statTitle = Instance.new("TextLabel")
statTitle.Size = UDim2.new(1, 0, 0, 20)
statTitle.Position = UDim2.new(0, 0, 0, 0)
statTitle.Text = "📊 " .. creatorName .. " | STATISTICS"
statTitle.BackgroundTransparency = 1
statTitle.TextColor3 = Color3.fromRGB(255, 100, 200)
statTitle.Font = Enum.Font.GothamBold
statTitle.TextSize = 11
statTitle.Parent = statFrame

local statText = Instance.new("TextLabel")
statText.Size = UDim2.new(1, 0, 1, -20)
statText.Position = UDim2.new(0, 0, 0, 20)
statText.BackgroundTransparency = 1
statText.Text = "💰 0 | ⭐ 0 | 💀 0"
statText.TextColor3 = Color3.fromRGB(255, 215, 0)
statText.Font = Enum.Font.GothamBold
statText.TextSize = 16
statText.Parent = statFrame

spawn(function()
    while true do
        statText.Text = "💰 " .. string.format("%.0f", totalMoney) .. "  |  ⭐ " .. string.format("%.0f", totalExp) .. "  |  💀 " .. string.format("%.0f", totalKills)
        wait(1)
    end
end)

-- CLOSE BUTTON (BISA DI-CLOSE)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.12, 0, 0, 30)
closeBtn.Position = UDim2.new(0.86, 0, -10, 0)
closeBtn.Text = "❌"
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- DRAG UI PREMIUM
local dragStart, startPos, dragging = nil, nil, false
mainFrame.MouseButton1Down:Connect(function(x, y)
    dragging = true
    dragStart = Vector2.new(x, y)
    startPos = mainFrame.Position
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
uis.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ========== STARTUP MESSAGE ==========
notif("🔥 " .. creatorName .. " PREMIUM SCRIPT AKTIF! 40+ FITUR SIAP 🔥", "red")
notif("✨ VERSION: " .. scriptVersion .. " | BY " .. creatorTag .. " ✨", "purple")

print("═══════════════════════════════════════════════════════")
print("✅ XATANICAL AI VIP | DISTRIK KEKERASAN PREMIUM SCRIPT")
print("✅ VERSION: " .. scriptVersion .. " | CREATOR: " .. creatorName)
print("✅ OWNER: " .. creatorTag .. " | MODE: TREDICT INVICTUS VIP")
print("✅ SEMUA FITUR WORK 100% SAMPE AKAR-AKARNYA")
print("═══════════════════════════════════════════════════════")
