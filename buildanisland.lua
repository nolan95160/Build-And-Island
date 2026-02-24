local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))()

local Notifier = Compkiller.newNotify()

Compkiller:Loader("rbxassetid://120245531583106", 2.5).yield()

local Window = Compkiller.new({
    Name = "Build An Island",
    Keybind = "LeftAlt",
    Logo = "rbxassetid://120245531583106",
    TextSize = 15,
})

Notifier.new({
    Title = "Build An Island",
    Content = "Bienvenue ! Script par nolan95160",
    Duration = 5,
    Icon = "rbxassetid://120245531583106"
})

local Watermark = Window:Watermark()
Watermark:AddText({ Icon = "user", Text = "nolan95160" })
local Time = Watermark:AddText({ Icon = "timer", Text = "TIME" })
task.spawn(function()
    while true do task.wait()
        Time:SetText(Compkiller:GetTimeNow())
    end
end)
Watermark:AddText({ Icon = "server", Text = Compkiller.Version })

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

local farmThread = nil
local priorityFarmThread = nil
local expandThread = nil
local craftThread = nil
local goldThread = nil
local collectThread = nil
local sellThread = nil
local harvestThread = nil
local hiveThread = nil
local autoBuyThread = nil
local afkThread = nil

-- =====================
-- CATEGORY: CONSTRUCTION
-- =====================
Window:DrawCategory({ Name = "Construction" })

local BuildTab = Window:DrawTab({
    Name = "Construction",
    Icon = "hammer",
    Type = "Single",
    EnableScrolling = true
})

local BuildLeft = BuildTab:DrawSection({ Name = "Automatisation", Position = "left" })
local BuildRight = BuildTab:DrawSection({ Name = "Récolte", Position = "right" })

BuildLeft:AddToggle({
    Name = "Expansion automatique",
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

BuildLeft:AddToggle({
    Name = "Fabrication automatique",
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

BuildLeft:AddToggle({
    Name = "Mine d'or automatique",
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

BuildLeft:AddToggle({
    Name = "Collecte d'or automatique",
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

BuildRight:AddToggle({
    Name = "Vente automatique",
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

BuildRight:AddToggle({
    Name = "Récolte automatique",
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

BuildRight:AddToggle({
    Name = "Collecte de ruche automatique",
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
-- CATEGORY: AUTO FARM
-- =====================
Window:DrawCategory({ Name = "Auto Farm" })

local FarmTab = Window:DrawTab({
    Name = "Auto Farm",
    Icon = "sword",
    Type = "Single",
    EnableScrolling = true
})

local FarmLeft = FarmTab:DrawSection({ Name = "Farm", Position = "left" })
local FarmRight = FarmTab:DrawSection({ Name = "Ressources prioritaires", Position = "right" })

FarmLeft:AddToggle({
    Name = "Farm automatique",
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

FarmLeft:AddToggle({
    Name = "Farm ressource prioritaire",
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

-- Ressources dédupliquées
local resourceNames = {}
local resourceNamesSet = {}
for _, r in ipairs(resources:GetChildren()) do
    if not resourceNamesSet[r.Name] then
        resourceNamesSet[r.Name] = true
        table.insert(resourceNames, r.Name)
    end
end

for _, resourceName in ipairs(resourceNames) do
    FarmRight:AddToggle({
        Name = resourceName,
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

-- =====================
-- CATEGORY: ACHETER
-- =====================
Window:DrawCategory({ Name = "Marchand" })

local BuyTab = Window:DrawTab({
    Name = "Acheter des items",
    Icon = "shopping-cart",
    Type = "Single",
    EnableScrolling = true
})

local BuyLeft = BuyTab:DrawSection({ Name = "Sélectionner les items", Position = "left" })
local BuyRight = BuyTab:DrawSection({ Name = "Options", Position = "right" })

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
    BuyLeft:AddToggle({
        Name = itemName,
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

BuyRight:AddButton({
    Name = "Acheter les items sélectionnés",
    Callback = function()
        buySelectedItems()
    end
})

BuyRight:AddToggle({
    Name = "Achat automatique au refresh",
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

local timerLabel = BuyRight:AddParagraph({
    Title = "Timer marchand",
    Content = "Nouveaux items dans 00:00"
})

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if timer then
                local time = timer.Text:match("%d+:%d+") or "00:00"
                timerLabel:SetContent("Nouveaux items dans " .. time)
            end
        end)
    end
end)

-- =====================
-- CATEGORY: DIVERS
-- =====================
Window:DrawCategory({ Name = "Divers" })

local MiscTab = Window:DrawTab({
    Name = "Divers",
    Icon = "zap",
    Type = "Single",
    EnableScrolling = true
})

local MiscLeft = MiscTab:DrawSection({ Name = "Joueur", Position = "left" })
local MiscRight = MiscTab:DrawSection({ Name = "Mouvement", Position = "right" })

MiscLeft:AddToggle({
    Name = "Anti AFK",
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

MiscLeft:AddToggle({
    Name = "Saut infini",
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

MiscRight:AddSlider({
    Name = "Vitesse de déplacement",
    Min = 16,
    Max = 500,
    Default = 16,
    Round = 0,
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

MiscRight:AddToggle({
    Name = "Vol",
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

MiscRight:AddSlider({
    Name = "Vitesse de vol",
    Min = 10,
    Max = 500,
    Default = 50,
    Round = 0,
    Callback = function(Value)
        flySpeed = Value
    end
})

-- =====================
-- CATEGORY: PARAMÈTRES
-- =====================
Window:DrawCategory({ Name = "Paramètres" })

local SettingsTab = Window:DrawTab({
    Name = "Paramètres",
    Icon = "settings-3",
    Type = "Single",
    EnableScrolling = true
})

local SettingsLeft = SettingsTab:DrawSection({ Name = "Délais", Position = "left" })
local SettingsRight = SettingsTab:DrawSection({ Name = "Autres", Position = "right" })

SettingsLeft:AddTextBox({
    Name = "Nombre de coups par resource",
    Placeholder = "1",
    Default = "1",
    Callback = function(t)
        hit_count = tonumber(t) or hit_count
    end
})

SettingsLeft:AddTextBox({
    Name = "Délai d'expansion",
    Placeholder = "0.1",
    Default = "0.1",
    Callback = function(t)
        expand_delay = tonumber(t) or expand_delay
    end
})

SettingsLeft:AddTextBox({
    Name = "Délai de fabrication",
    Placeholder = "0.1",
    Default = "0.1",
    Callback = function(t)
        craft_delay = tonumber(t) or craft_delay
    end
})

SettingsRight:AddTextBox({
    Name = "Tentatives d'achat",
    Placeholder = "99",
    Default = "99",
    Callback = function(t)
        BUY_ATTEMPTS = tonumber(t) or BUY_ATTEMPTS
    end
})

SettingsRight:AddButton({
    Name = "Supprimer l'interface",
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
        Compkiller:Destroy()
    end
})

SettingsRight:AddParagraph({
    Title = "Crédits",
    Content = "Script par nolan95160"
})
