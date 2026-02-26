local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local LINKVERTISE = "https://direct-link.net/3106870/25XlkoEAfqer"
local API = "http://51.255.205.163:4000"

local confirmed = false

local sg = Instance.new("ScreenGui")
sg.Name = "KeySystem"
sg.ResetOnSpawn = false
sg.DisplayOrder = 999
sg.Parent = plr.PlayerGui

-- Fond noir transparent
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.BackgroundTransparency = 0.5
bg.BorderSizePixel = 0
bg.Parent = sg

-- Fenêtre blanche
local win = Instance.new("Frame")
win.Size = UDim2.new(0, 420, 0, 280)
win.Position = UDim2.new(0.5, -210, 0.5, -140)
win.BackgroundColor3 = Color3.fromRGB(252, 252, 255)
win.BorderSizePixel = 0
win.Parent = sg
Instance.new("UICorner", win).CornerRadius = UDim.new(0, 10)

-- Titre
local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, -20, 0, 35)
t.Position = UDim2.new(0, 10, 0, 10)
t.BackgroundTransparency = 1
t.Text = "🏝️  M2Script — Key System"
t.TextColor3 = Color3.fromRGB(20, 20, 20)
t.Font = Enum.Font.GothamBold
t.TextSize = 15
t.TextXAlignment = Enum.TextXAlignment.Left
t.Parent = win

-- Ligne
local l = Instance.new("Frame")
l.Size = UDim2.new(1, -20, 0, 1)
l.Position = UDim2.new(0, 10, 0, 48)
l.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
l.BorderSizePixel = 0
l.Parent = win

-- Description
local d = Instance.new("TextLabel")
d.Size = UDim2.new(1, -20, 0, 25)
d.Position = UDim2.new(0, 10, 0, 55)
d.BackgroundTransparency = 1
d.Text = "Entrez votre clé ou obtenez-en une gratuitement via le lien."
d.TextColor3 = Color3.fromRGB(100, 100, 110)
d.Font = Enum.Font.Gotham
d.TextSize = 12
d.TextXAlignment = Enum.TextXAlignment.Left
d.TextWrapped = true
d.Parent = win

-- Input frame
local inf = Instance.new("Frame")
inf.Size = UDim2.new(1, -20, 0, 40)
inf.Position = UDim2.new(0, 10, 0, 88)
inf.BackgroundColor3 = Color3.fromRGB(240, 240, 248)
inf.BorderSizePixel = 0
inf.Parent = win
Instance.new("UICorner", inf).CornerRadius = UDim.new(0, 6)
local s = Instance.new("UIStroke", inf)
s.Color = Color3.fromRGB(200, 200, 215)
s.Thickness = 1

-- Input
local inp = Instance.new("TextBox")
inp.Size = UDim2.new(1, -16, 1, 0)
inp.Position = UDim2.new(0, 8, 0, 0)
inp.BackgroundTransparency = 1
inp.TextColor3 = Color3.fromRGB(20, 20, 20)
inp.PlaceholderText = "Entre ta clé ici..."
inp.PlaceholderColor3 = Color3.fromRGB(160, 160, 175)
inp.Font = Enum.Font.GothamMono
inp.TextSize = 14
inp.ClearTextOnFocus = false
inp.Parent = inf

-- Status
local st = Instance.new("TextLabel")
st.Size = UDim2.new(1, -20, 0, 22)
st.Position = UDim2.new(0, 10, 0, 135)
st.BackgroundTransparency = 1
st.Text = ""
st.TextColor3 = Color3.fromRGB(220, 60, 60)
st.Font = Enum.Font.Gotham
st.TextSize = 12
st.TextXAlignment = Enum.TextXAlignment.Left
st.Parent = win

-- Bouton Vérifier
local bv = Instance.new("TextButton")
bv.Size = UDim2.new(0, 190, 0, 42)
bv.Position = UDim2.new(0, 10, 0, 165)
bv.BackgroundColor3 = Color3.fromRGB(80, 80, 210)
bv.TextColor3 = Color3.new(1, 1, 1)
bv.Text = "✅  Vérifier la clé"
bv.Font = Enum.Font.GothamBold
bv.TextSize = 13
bv.BorderSizePixel = 0
bv.Parent = win
Instance.new("UICorner", bv).CornerRadius = UDim.new(0, 6)

-- Bouton Obtenir clé
local bg2 = Instance.new("TextButton")
bg2.Size = UDim2.new(0, 200, 0, 42)
bg2.Position = UDim2.new(0, 210, 0, 165)
bg2.BackgroundColor3 = Color3.fromRGB(240, 240, 248)
bg2.TextColor3 = Color3.fromRGB(80, 80, 210)
bg2.Text = "🔑  Obtenir une clé"
bg2.Font = Enum.Font.GothamBold
bg2.TextSize = 13
bg2.BorderSizePixel = 0
bg2.Parent = win
Instance.new("UICorner", bg2).CornerRadius = UDim.new(0, 6)
local stroke = Instance.new("UIStroke", bg2)
stroke.Color = Color3.fromRGB(80, 80, 210)
stroke.Thickness = 1

-- Footer
local ft = Instance.new("TextLabel")
ft.Size = UDim2.new(1, -20, 0, 20)
ft.Position = UDim2.new(0, 10, 0, 250)
ft.BackgroundTransparency = 1
ft.Text = "Clé valable 24h • Liée à votre compte Roblox"
ft.TextColor3 = Color3.fromRGB(170, 170, 180)
ft.Font = Enum.Font.Gotham
ft.TextSize = 11
ft.TextXAlignment = Enum.TextXAlignment.Center
ft.Parent = win

-- Logique bouton Obtenir
bg2.MouseButton1Click:Connect(function()
    setclipboard(LINKVERTISE)
    bg2.Text = "✅  Lien copié !"
    task.wait(2)
    bg2.Text = "🔑  Obtenir une clé"
end)

-- Logique bouton Vérifier
bv.MouseButton1Click:Connect(function()
    if inp.Text == "" then
        st.TextColor3 = Color3.fromRGB(220, 60, 60)
        st.Text = "⚠  Entre une clé avant de vérifier."
        return
    end

    st.TextColor3 = Color3.fromRGB(100, 100, 210)
    st.Text = "⏳  Vérification en cours..."
    bv.Active = false
    bv.BackgroundColor3 = Color3.fromRGB(50, 50, 150)

    local ok, res = pcall(function()
        return (syn and syn.request or http_request or request)({
            Url = API .. "/check",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                key = inp.Text,
                userid = tostring(plr.UserId)
            })
        })
    end)

    if not ok then
        st.TextColor3 = Color3.fromRGB(220, 60, 60)
        st.Text = "❌  Impossible de contacter le serveur !"
        bv.Active = true
        bv.BackgroundColor3 = Color3.fromRGB(80, 80, 210)
        return
    end

    local data = HttpService:JSONDecode(res.Body)
    if data.valid then
        st.TextColor3 = Color3.fromRGB(60, 180, 100)
        st.Text = "✅  Clé valide ! Chargement..."
        task.wait(1)
        sg:Destroy()
        confirmed = true
    else
        st.TextColor3 = Color3.fromRGB(220, 60, 60)
        st.Text = "❌  " .. (data.message or "Clé invalide !")
        bv.Active = true
        bv.BackgroundColor3 = Color3.fromRGB(80, 80, 210)
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
