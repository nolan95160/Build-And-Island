-- Chargement de Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "Build An Island",
    LoadingTitle = "Build An Island",
    LoadingSubtitle = "Par nolan95160",
    ConfigurationSaving = {
        Enabled = false,
    },
    KeySystem = false,
})

-- Tabs
local BuildTab = Window:CreateTab("Construction", "hammer")
local BuyTab = Window:CreateTab("Acheter des items", "shopping-cart")
local SettingsTab = Window:CreateTab("Paramètres", "settings")

-- Variables
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local plot = game:GetService("Workspace"):WaitForChild("Plots"):WaitForChild(plr.Name)

local land = plot:FindFirstChild("Land")
local resources = plot:WaitForChild("Resources")
local expand = plot:WaitForChild("Expand")

getgenv().settings = {
    farm = false,
    expand = false,
    craft = false,
    sell = false,
    gold = false,
    collect = false,
    harvest = false,
    hive = false,
    auto_buy = false,
    afk = false
}

local expand_delay = 0.1
local craft_delay = 0.1
local BUY_ATTEMPTS = 99
local hit_count = 1

-- Threads
local farmThread = nil
local expandThread = nil
local craftThread = nil
local goldThread = nil
local collectThread = nil
local sellThread = nil
local harvestThread = nil
local hiveThread = nil
local autoBuyThread = nil
local afkThread = nil

-- Onglet Construction
BuildTab:CreateToggle({
    Name = "Farm automatique",
    CurrentValue = false,
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

BuildTab:CreateToggle({
    Name = "Expansion automatique",
    CurrentValue = false,
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
                                        local args = {
                                            exp.Name,
                                            contribute.Name,
                                            1
                                        }
                                        game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("ContributeToExpand"):FireServer(unpack(args))
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

BuildTab:CreateToggle({
    Name = "Fabrication automatique",
    CurrentValue = false,
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

BuildTab:CreateToggle({
    Name = "Mine d'or automatique",
    CurrentValue = false,
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

BuildTab:CreateToggle({
    Name = "Collecte d'or automatique",
    CurrentValue = false,
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

BuildTab:CreateToggle({
    Name = "Vente automatique",
    CurrentValue = false,
    Callback = function(Value)
        settings.sell = Value
        if Value then
            sellThread = task.spawn(function()
                while settings.sell do
                    for _, crop in pairs(plr.Backpack:GetChildren()) do
                        if not settings.sell then break end
                        if crop:GetAttribute("Sellable") then
                            local a = {
                                false,
                                {
                                    crop:GetAttribute("Hash")
                                }
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Communication"):WaitForChild("SellToMerchant"):FireServer(unpack(a))
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

BuildTab:CreateToggle({
    Name = "Récolte automatique",
    CurrentValue = false,
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

BuildTab:CreateToggle({
    Name = "Collecte de ruche automatique",
    CurrentValue = false,
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

-- Onglet Acheter des items
local allItems = {
    "Pineapple Seeds",
    "Strawberry Seeds",
    "Growth Potion",
    "Magma Bee",
    "Tomato Seeds",
    "Watermelon Seeds",
    "Autochopper Mk 1",
    "Starfruit Seeds",
    "Autominer Mk 1",
    "Multicast Potion",
    "Peach Seeds",
    "Galaxy Potion",
    "Pumpkin Seeds",
    "Corn Seeds",
    "Dragonfruit Seeds",
    "Busy Bee Potion",
    "Strength Potion",
    "Cherry Seeds",
    "Magic Durian Seeds",
    "Mango Seeds",
    "Honey Bee",
    "Blueberry Seeds",
    "Coal Crate",
    "Resource Potion",
    "Goji Berry Seeds",
    "Apple Seeds",
    "Coconut Seeds",
}

local selectedItems = {}
local timer = plr.PlayerGui.Main.Menus.Merchant.Inner.Timer
local timerLabel = nil
local hold = plr.PlayerGui.Main.Menus.Merchant.Inner.ScrollingFrame.Hold

local function buySelectedItems()
    if selectedItems and #selectedItems > 0 then
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

BuyTab:CreateLabel("                  Sélectionner les items")

for _, itemName in ipairs(allItems) do
    BuyTab:CreateToggle({
        Name = itemName,
        CurrentValue = false,
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

BuyTab:CreateLabel("             Achat des items sélectionnés")

BuyTab:CreateButton({
    Name = "Acheter les items sélectionnés",
    Callback = function()
        buySelectedItems()
    end
})

BuyTab:CreateToggle({
    Name = "Achat automatique au refresh",
    CurrentValue = false,
    Callback = function(Value)
        settings.auto_buy = Value
        if Value then
            autoBuyThread = task.spawn(function()
                buySelectedItems()

                hold.ChildAdded:Connect(function(child)
                    if not settings.auto_buy then return end
                    if child:IsA("Frame") then
                        for _, itemName in ipairs(selectedItems or {}) do
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

local function getTimerText()
    if timer then
        return timer.Text:match("%d+:%d+") or "00:00"
    end
    return "00:00"
end

timerLabel = BuyTab:CreateLabel("Nouveaux items dans " .. getTimerText())

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if timerLabel and timer then
                timerLabel:Set("Nouveaux items dans " .. getTimerText())
            end
        end)
    end
end)

-- Onglet Paramètres
SettingsTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
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

MiscTab:CreateToggle({

    Name = "Saut infini",

    CurrentValue = false,

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

SettingsTab:CreateInput({
    Name = "Nombre de coups par resource",
    PlaceholderText = "1",
    RemoveTextAfterFocusLost = false,
    Callback = function(t)
        hit_count = tonumber(t) or hit_count
    end
})

SettingsTab:CreateInput({
    Name = "Délai d'expansion",
    PlaceholderText = "0.1",
    RemoveTextAfterFocusLost = false,
    Callback = function(t)
        expand_delay = tonumber(t) or expand_delay
    end
})

SettingsTab:CreateInput({
    Name = "Délai de fabrication",
    PlaceholderText = "0.1",
    RemoveTextAfterFocusLost = false,
    Callback = function(t)
        craft_delay = tonumber(t) or craft_delay
    end
})

SettingsTab:CreateInput({
    Name = "Tentatives d'achat",
    PlaceholderText = "99",
    RemoveTextAfterFocusLost = false,
    Callback = function(t)
        BUY_ATTEMPTS = tonumber(t) or BUY_ATTEMPTS
    end
})

SettingsTab:CreateButton({
    Name = "Supprimer l'interface",
    Callback = function()
        settings.farm = false
        settings.expand = false
        settings.craft = false
        settings.sell = false
        settings.gold = false
        settings.collect = false
        settings.harvest = false
        settings.hive = false
        settings.auto_buy = false
        settings.afk = false
        Rayfield:Destroy()
    end
})
