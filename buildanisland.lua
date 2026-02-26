local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local LINKVERTISE = "https://direct-link.net/3106870/25XlkoEAfqer" -- Remplace par ton vrai lien
local API = "http://51.255.205.163:4000"

-- Interface
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = plr.PlayerGui

local frame = Instance.new("Frame", keyGui)
frame.Size = UDim2.fromOffset(400, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0.02, 0)
title.BackgroundTransparency = 1
title.Text = "🏝️ M2Script - Key System"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.85, 0, 0.18, 0)
input.Position = UDim2.new(0.075, 0, 0.25, 0)
input.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
input.TextColor3 = Color3.new(1, 1, 1)
input.PlaceholderText = "Entre ta clé ici..."
input.Font = Enum.Font.Gotham
input.TextScaled = true
input.BorderSizePixel = 0
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0.15, 0)
status.Position = UDim2.new(0, 0, 0.45, 0)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 80, 80)
status.Font = Enum.Font.Gotham
status.TextScaled = true

-- Bouton Vérifier
local btnVerify = Instance.new("TextButton", frame)
btnVerify.Size = UDim2.new(0.42, 0, 0.18, 0)
btnVerify.Position = UDim2.new(0.05, 0, 0.75, 0)
btnVerify.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
btnVerify.TextColor3 = Color3.new(1, 1, 1)
btnVerify.Text = "✅ Vérifier"
btnVerify.Font = Enum.Font.GothamBold
btnVerify.TextScaled = true
btnVerify.BorderSizePixel = 0
Instance.new("UICorner", btnVerify).CornerRadius = UDim.new(0, 6)

-- Bouton Obtenir clé
local btnGet = Instance.new("TextButton", frame)
btnGet.Size = UDim2.new(0.42, 0, 0.18, 0)
btnGet.Position = UDim2.new(0.53, 0, 0.75, 0)
btnGet.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
btnGet.TextColor3 = Color3.new(1, 1, 1)
btnGet.Text = "🔑 Obtenir clé"
btnGet.Font = Enum.Font.GothamBold
btnGet.TextScaled = true
btnGet.BorderSizePixel = 0
Instance.new("UICorner", btnGet).CornerRadius = UDim.new(0, 6)

-- Logique bouton Obtenir clé
btnGet.MouseButton1Click:Connect(function()
    setclipboard(LINKVERTISE)
    btnGet.Text = "✅ Lien copié !"
    task.wait(2)
    btnGet.Text = "🔑 Obtenir clé"
end)

-- Logique bouton Vérifier
local confirmed = false
btnVerify.MouseButton1Click:Connect(function()
    if input.Text == "" then
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
        status.Text = "❌ Entre une clé !"
        return
    end

    status.TextColor3 = Color3.fromRGB(255, 255, 0)
    status.Text = "⏳ Vérification..."
    btnVerify.Active = false

    local success, res = pcall(function()
        return (syn and syn.request or http_request or request)({
            Url = API .. "/check",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                key = input.Text,
                userid = tostring(plr.UserId)
            })
        })
    end)

    if not success then
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
        status.Text = "❌ Impossible de contacter le serveur !"
        btnVerify.Active = true
        return
    end

    local data = HttpService:JSONDecode(res.Body)
    if data.valid then
        status.TextColor3 = Color3.fromRGB(80, 255, 80)
        status.Text = "✅ Clé valide !"
        task.wait(1)
        keyGui:Destroy()
        confirmed = true
    else
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
        status.Text = "❌ " .. (data.message or "Clé invalide !")
        btnVerify.Active = true
    end
end)

repeat task.wait() until confirmed

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Build An Island",
    SubTitle = "Par nolan95160",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftAlt
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Auto Farm", Icon = "sword" }),
    Build = Window:AddTab({ Title = "Construction", Icon = "hammer" }),
    Buy = Window:AddTab({ Title = "Acheter", Icon = "shopping-cart" }),
    Misc = Window:AddTab({ Title = "Divers", Icon = "star" }),
    Config = Window:AddTab({ Title = "Config", Icon = "folder" }),
    Settings = Window:AddTab({ Title = "Paramètres", Icon = "settings" }),
}

-- Variables
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local plot = game:GetService("Workspace"):WaitForChild("Plots"):WaitForChild(plr.Name)
local land = plot:FindFirstChild("Land")
local resources = plot:WaitForChild("Resources")
local expand = plot:WaitForChild("Expand")

getgenv().settings = {
    farm = false,
    priority_farm = false,
    expand = false,
    craft = false,
    sell = false,
    gold = false,
    collect = false,
    harvest = false,
    hive = false,
    auto_buy = false,
    afk = false,
    infinitejump = false,
    fly = false
}

local expand_delay = 0.1
local craft_delay = 0.1
local BUY_ATTEMPTS = 99
local hit_count = 1
local flySpeed = 50
local priorityResources = {}

local farmThread, priorityFarmThread, expandThread, craftThread = nil, nil, nil, nil
local goldThread, collectThread, sellThread, harvestThread = nil, nil, nil, nil
local hiveThread, autoBuyThread, afkThread = nil, nil, nil

-- =====================
-- AUTO FARM
-- =====================
Tabs.Farm:AddToggle("FarmAuto", {
    Title = "Farm automatique",
    Default = false,
    Callback = function(Value)
        settings.farm = Value
        if Value then
            farmThread = task.spawn(function()
                while settings.farm do
                    for _, r in ipairs(resources:GetChildren()) do
                        if not settings.farm then break end
                        for i = 1, hit_count do
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("HitResource"):FireServer(r)
                            task.wait(.01)
                        end
                    end
                    task.wait(.1)
                end
            end)
        else
            if farmThread then task.cancel(farmThread) farmThread = nil end
        end
    end
})

Tabs.Farm:AddToggle("PriorityFarm", {
    Title = "Farm ressource prioritaire",
    Default = false,
    Callback = function(Value)
        settings.priority_farm = Value
        if Value then
            priorityFarmThread = task.spawn(function()
                while settings.priority_farm do
                    if #priorityResources > 0 then
                        for _, r in ipairs(resources:GetChildren()) do
                            if not settings.priority_farm then break end
                            for _, priorityName in ipairs(priorityResources) do
                                if r.Name == priorityName then
                                    for i = 1, hit_count do
                                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("HitResource"):FireServer(r)
                                        task.wait(.01)
                                    end
                                    break
                                end
                            end
                        end
                    end
                    task.wait(.1)
                end
            end)
        else
            if priorityFarmThread then task.cancel(priorityFarmThread) priorityFarmThread = nil end
        end
    end
})

Tabs.Farm:AddParagraph({
    Title = "Ressources prioritaires",
    Content = "Activez les ressources à farm en priorité puis activez le toggle"
})

local resourceNames = {}
local resourceNamesSet = {}
for _, r in ipairs(resources:GetChildren()) do
    if not resourceNamesSet[r.Name] then
        resourceNamesSet[r.Name] = true
        table.insert(resourceNames, r.Name)
    end
end

for _, resourceName in ipairs(resourceNames) do
    local key = "Priority_" .. resourceName:gsub(" ", "_")
    Tabs.Farm:AddToggle(key, {
        Title = resourceName,
        Default = false,
        Callback = function(Value)
            if Value then
                table.insert(priorityResources, resourceName)
            else
                for i, v in ipairs(priorityResources) do
                    if v == resourceName then
                        table.remove(priorityResources, i)
                        break
                    end
                end
            end
        end
    })
end

Tabs.Farm:AddButton({
    Title = "Rafraîchir la liste",
    Description = "Sauvegardez votre config avant de refresh !",
    Callback = function()
        Fluent:Destroy()
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nolan95160/Build-And-Island/refs/heads/main/buildanisland.lua"))()
    end
})

-- =====================
-- CONSTRUCTION
-- =====================
Tabs.Build:AddToggle("Expansion", {
    Title = "Expansion automatique",
    Default = false,
    Callback = function(Value)
        settings.expand = Value
        if Value then
            expandThread = task.spawn(function()
                while settings.expand do
                    for _, exp in ipairs(expand:GetChildren()) do
                        if not settings.expand then break end
                        local top = exp:FindFirstChild("Top")
                        if top then
                            local bGui = top:FindFirstChild("BillboardGui")
                            if bGui then
                                for _, contribute in ipairs(bGui:GetChildren()) do
                                    if contribute:IsA("Frame") and contribute.Name ~= "Example" then
                                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("ContributeToExpand"):FireServer(exp.Name, contribute.Name, 1)
                                    end
                                end
                            end
                        end
                        task.wait(0.01)
                    end
                    task.wait(expand_delay)
                end
            end)
        else
            if expandThread then task.cancel(expandThread) expandThread = nil end
        end
    end
})

Tabs.Build:AddToggle("Craft", {
    Title = "Fabrication automatique",
    Default = false,
    Callback = function(Value)
        settings.craft = Value
        if Value then
            craftThread = task.spawn(function()
                while settings.craft do
                    for _, c in pairs(plot:GetDescendants()) do
                        if not settings.craft then break end
                        if c.Name == "Crafter" then
                            local attachment = c:FindFirstChildOfClass("Attachment")
                            if attachment then
                                game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Craft"):FireServer(attachment)
                            end
                        end
                    end
                    task.wait(craft_delay)
                end
            end)
        else
            if craftThread then task.cancel(craftThread) craftThread = nil end
        end
    end
})

Tabs.Build:AddToggle("GoldMine", {
    Title = "Mine d'or automatique",
    Default = false,
    Callback = function(Value)
        settings.gold = Value
        if Value then
            goldThread = task.spawn(function()
                while settings.gold do
                    for _, mine in pairs(land:GetDescendants()) do
                        if not settings.gold then break end
                        if mine:IsA("Model") and mine.Name == "GoldMineModel" then
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Goldmine"):FireServer(mine.Parent.Name, 1)
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            if goldThread then task.cancel(goldThread) goldThread = nil end
        end
    end
})

Tabs.Build:AddToggle("GoldCollect", {
    Title = "Collecte d'or automatique",
    Default = false,
    Callback = function(Value)
        settings.collect = Value
        if Value then
            collectThread = task.spawn(function()
                while settings.collect do
                    for _, mine in pairs(land:GetDescendants()) do
                        if not settings.collect then break end
                        if mine:IsA("Model") and mine.Name == "GoldMineModel" then
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Goldmine"):FireServer(mine.Parent.Name, 2)
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            if collectThread then task.cancel(collectThread) collectThread = nil end
        end
    end
})

Tabs.Build:AddToggle("Sell", {
    Title = "Vente automatique",
    Default = false,
    Callback = function(Value)
        settings.sell = Value
        if Value then
            sellThread = task.spawn(function()
                while settings.sell do
                    for _, crop in pairs(plr.Backpack:GetChildren()) do
                        if not settings.sell then break end
                        if crop:GetAttribute("Sellable") then
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("SellToMerchant"):FireServer(false, { crop:GetAttribute("Hash") })
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            if sellThread then task.cancel(sellThread) sellThread = nil end
        end
    end
})

Tabs.Build:AddToggle("Harvest", {
    Title = "Récolte automatique",
    Default = false,
    Callback = function(Value)
        settings.harvest = Value
        if Value then
            harvestThread = task.spawn(function()
                while settings.harvest do
                    for _, crop in pairs(plot:FindFirstChild("Plants"):GetChildren()) do
                        if not settings.harvest then break end
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Harvest"):FireServer(crop.Name)
                    end
                    task.wait(1)
                end
            end)
        else
            if harvestThread then task.cancel(harvestThread) harvestThread = nil end
        end
    end
})

Tabs.Build:AddToggle("Hive", {
    Title = "Collecte de ruche automatique",
    Default = false,
    Callback = function(Value)
        settings.hive = Value
        if Value then
            hiveThread = task.spawn(function()
                while settings.hive do
                    for _, spot in ipairs(land:GetDescendants()) do
                        if not settings.hive then break end
                        if spot:IsA("Model") and spot.Name:match("Spot") then
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("Hive"):FireServer(spot.Parent.Name, spot.Name, 2)
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            if hiveThread then task.cancel(hiveThread) hiveThread = nil end
        end
    end
})

-- =====================
-- ACHETER
-- =====================
local allItems = {
    "Pineapple Seeds", "Strawberry Seeds", "Growth Potion", "Magma Bee",
    "Tomato Seeds", "Watermelon Seeds", "Autochopper Mk 1", "Starfruit Seeds",
    "Autominer Mk 1", "Multicast Potion", "Peach Seeds", "Galaxy Potion",
    "Pumpkin Seeds", "Corn Seeds", "Dragonfruit Seeds", "Busy Bee Potion",
    "Strength Potion", "Cherry Seeds", "Magic Durian Seeds", "Mango Seeds",
    "Honey Bee", "Blueberry Seeds", "Coal Crate", "Resource Potion",
    "Goji Berry Seeds", "Apple Seeds", "Coconut Seeds",
}

local selectedItems = {}
local timer = plr.PlayerGui.Main.Menus.Merchant.Inner.Timer
local hold = plr.PlayerGui.Main.Menus.Merchant.Inner.ScrollingFrame.Hold

local function buySelectedItems()
    if #selectedItems > 0 then
        for _, itemName in ipairs(selectedItems) do
            for _, item in ipairs(hold:GetChildren()) do
                if item:IsA("Frame") and item.Name == itemName then
                    for i = 1, BUY_ATTEMPTS do
                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("BuyFromMerchant"):FireServer(itemName, false)
                        task.wait(0.05)
                    end
                    break
                end
            end
        end
    end
end

for _, itemName in ipairs(allItems) do
    local key = "Buy_" .. itemName:gsub(" ", "_")
    Tabs.Buy:AddToggle(key, {
        Title = itemName,
        Default = false,
        Callback = function(Value)
            if Value then
                table.insert(selectedItems, itemName)
            else
                for i, v in ipairs(selectedItems) do
                    if v == itemName then
                        table.remove(selectedItems, i)
                        break
                    end
                end
            end
        end
    })
end

Tabs.Buy:AddButton({
    Title = "Acheter les items sélectionnés",
    Description = "Achète tous les items cochés",
    Callback = function()
        buySelectedItems()
    end
})

Tabs.Buy:AddToggle("AutoBuy", {
    Title = "Achat automatique au refresh",
    Default = false,
    Callback = function(Value)
        settings.auto_buy = Value
        if Value then
            autoBuyThread = task.spawn(function()
                buySelectedItems()
                hold.ChildAdded:Connect(function(child)
                    if not settings.auto_buy then return end
                    if child:IsA("Frame") then
                        for _, itemName in ipairs(selectedItems) do
                            if child.Name == itemName then
                                task.wait(0.1)
                                buySelectedItems()
                                break
                            end
                        end
                    end
                end)
            end)
        else
            if autoBuyThread then task.cancel(autoBuyThread) autoBuyThread = nil end
        end
    end
})

local timerParagraph = Tabs.Buy:AddParagraph({
    Title = "Timer marchand",
    Content = "Nouveaux items dans 00:00"
})

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if timer then
                local time = timer.Text:match("%d+:%d+") or "00:00"
                timerParagraph.Title:Set("Nouveaux items dans " .. time)
            end
        end)
    end
end)

-- =====================
-- DIVERS
-- =====================
Tabs.Misc:AddToggle("AFK", {
    Title = "Anti AFK",
    Default = false,
    Callback = function(Value)
        settings.afk = Value
        if Value then
            afkThread = task.spawn(function()
                while settings.afk do
                    local character = plr.Character
                    if character then
                        local humanoid = character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:Move(Vector3.new(0.1, 0, 0))
                            task.wait(0.5)
                            humanoid:Move(Vector3.new(-0.1, 0, 0))
                            task.wait(0.5)
                            humanoid:Move(Vector3.new(0, 0, 0))
                        end
                    end
                    task.wait(60)
                end
            end)
        else
            if afkThread then task.cancel(afkThread) afkThread = nil end
        end
    end
})

Tabs.Misc:AddToggle("InfiniteJump", {
    Title = "Saut infini",
    Default = false,
    Callback = function(Value)
        settings.infinitejump = Value
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if settings.infinitejump then
        local character = plr.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

Tabs.Misc:AddSlider("WalkSpeed", {
    Title = "Vitesse de déplacement",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        local character = plr.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then humanoid.WalkSpeed = Value end
        end
        plr.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid").WalkSpeed = Value
        end)
    end
})

Tabs.Misc:AddToggle("Fly", {
    Title = "Vol",
    Default = false,
    Callback = function(Value)
        settings.fly = Value
        local character = plr.Character
        if not character then return end
        local humanoid = character:FindFirstChild("Humanoid")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not humanoid or not hrp then return end

        if Value then
            humanoid.PlatformStand = true
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "FlyVelocity"
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyVelocity.Parent = hrp

            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.Name = "FlyGyro"
            bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bodyGyro.P = 1e4
            bodyGyro.Parent = hrp

            task.spawn(function()
                local UIS = game:GetService("UserInputService")
                local camera = workspace.CurrentCamera
                while settings.fly and character and hrp do
                    local moveDir = Vector3.new(0, 0, 0)
                    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                    bodyVelocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * flySpeed or Vector3.new(0, 0, 0)
                    bodyGyro.CFrame = camera.CFrame
                    task.wait()
                end
            end)
        else
            humanoid.PlatformStand = false
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end
})

Tabs.Misc:AddSlider("FlySpeed", {
    Title = "Vitesse de vol",
    Default = 50,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        flySpeed = Value
    end
})

-- =====================
-- CONFIG
-- =====================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("BuildAnIsland")
SaveManager:SetFolder("BuildAnIsland/configs")
SaveManager:BuildConfigSection(Tabs.Config)
InterfaceManager:BuildInterfaceSection(Tabs.Config)

-- =====================
-- PARAMÈTRES
-- =====================
Tabs.Settings:AddInput("HitCount", {
    Title = "Nombre de coups par resource",
    Default = "1",
    Placeholder = "1",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        hit_count = tonumber(Value) or hit_count
    end
})

Tabs.Settings:AddInput("ExpandDelay", {
    Title = "Délai d'expansion",
    Default = "0.1",
    Placeholder = "0.1",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        expand_delay = tonumber(Value) or expand_delay
    end
})

Tabs.Settings:AddInput("CraftDelay", {
    Title = "Délai de fabrication",
    Default = "0.1",
    Placeholder = "0.1",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        craft_delay = tonumber(Value) or craft_delay
    end
})

Tabs.Settings:AddInput("BuyAttempts", {
    Title = "Tentatives d'achat",
    Default = "99",
    Placeholder = "99",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        BUY_ATTEMPTS = tonumber(Value) or BUY_ATTEMPTS
    end
})

Tabs.Settings:AddButton({
    Title = "Supprimer l'interface",
    Description = "Désactive tout et ferme le script",
    Callback = function()
        for k in pairs(settings) do settings[k] = false end
        local character = plr.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.PlatformStand = false
            end
            if hrp then
                local bv = hrp:FindFirstChild("FlyVelocity")
                local bg = hrp:FindFirstChild("FlyGyro")
                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end
        end
        Fluent:Destroy()
    end
})

Tabs.Settings:AddParagraph({
    Title = "Crédits",
    Content = "Script par nolan95160"
})

Window:SelectTab(1)

Fluent:Notify({
    Title = "Build An Island",
    Content = "Script chargé avec succès !",
    Duration = 5
})

SaveManager:LoadAutoloadConfig()
