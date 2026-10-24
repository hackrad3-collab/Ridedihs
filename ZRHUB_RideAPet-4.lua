local replicatedStorage = game:GetService("ReplicatedStorage")
local workspaceService = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local httpService = game:GetService("HttpService")
local virtualUser = game:GetService("VirtualUser")

pcall(function()
  if not table.find then
    function table:find(p1)
      if type(self) ~= "table" then
        return nil
      end

      for index, value in ipairs(self) do
        if value == p1 then
          return index
        end
      end

      return nil
    end
  end
end)

_G.CrownHubInstanceId = (_G.CrownHubInstanceId or 0) + 1
local crownHubInstanceId = _G.CrownHubInstanceId

if _G.CrownHubInstance and typeof(_G.CrownHubInstance) == "table" and _G.CrownHubInstance.Destroy then
  pcall(function() _G.CrownHubInstance:Destroy() end)
end

if _G.CrownHubConnections and type(_G.CrownHubConnections) == "table" then
  for index2, value2 in ipairs(_G.CrownHubConnections) do
    local v1 = value2
    pcall(function() v1:Disconnect() end)
  end
end

_G.CrownHubConnections = {}

pcall(function()
  local rayfield = coreGui:FindFirstChild("Rayfield")

  if rayfield then
    rayfield:Destroy()
  end

  if gethui and gethui():FindFirstChild("CrownHub_MobileToggle") then
    gethui().CrownHub_MobileToggle:Destroy()
  end

  if coreGui:FindFirstChild("CrownHub_MobileToggle") then
    coreGui.CrownHub_MobileToggle:Destroy()
  end

  local localPlayer = players.LocalPlayer

  if localPlayer and localPlayer:FindFirstChild("PlayerGui")
    and localPlayer.PlayerGui:FindFirstChild("CrownHub_MobileToggle") then
    localPlayer.PlayerGui.CrownHub_MobileToggle:Destroy()
  end

  if localPlayer and localPlayer.Character then
    local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = localPlayer.Character:FindFirstChild("Humanoid")

    if humanoidRootPart then
      local crownFlightStabilizer = humanoidRootPart:FindFirstChild("CrownFlightStabilizer")

      if crownFlightStabilizer then
        crownFlightStabilizer:Destroy()
      end

      humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
      humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
    end

    if humanoid then
      humanoid.PlatformStand = false
      humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
  end

  local renderedEggs = workspaceService:FindFirstChild("RenderedEggs")

  if renderedEggs then
    for index3, value3 in ipairs(renderedEggs:GetChildren()) do
      local crownEggESP = value3:FindFirstChild("CrownEggESP")

      if crownEggESP then
        pcall(function() crownEggESP:Destroy() end)
      end

      local crownEggTag = value3:FindFirstChild("CrownEggTag")

      if crownEggTag then
        pcall(function() crownEggTag:Destroy() end)
      end
    end
  end
end)

local localPlayer2 = players.LocalPlayer
local robloxGui

pcall(function()
  if gethui then
    robloxGui = gethui()
  elseif syn and syn.protect_gui then
    robloxGui = coreGui:FindFirstChild("RobloxGui") or coreGui
  else
    robloxGui = coreGui:FindFirstChild("RobloxGui") or coreGui
  end
end)

if not robloxGui then
  robloxGui = localPlayer2:WaitForChild("PlayerGui", 3)
    or localPlayer2:FindFirstChild("PlayerGui")
end

pcall(function()
  local crownHubLoadingScreen = robloxGui:FindFirstChild("CrownHub_LoadingScreen")

  if crownHubLoadingScreen then
    crownHubLoadingScreen:Destroy()
  end
end)

-- bootstrap simplified (no loading screen)
local v2 = false
local function f1(p2)
  -- no-op (loading UI removed)
end
local function f2(p3, p4)
  -- no-op
end



pcall(function()
  local connect = localPlayer2.Idled:Connect(function()
    virtualUser:Button2Down(Vector2.new(0, 0), workspaceService.CurrentCamera.CFrame)
    task.wait(0.5)
    virtualUser:Button2Up(Vector2.new(0, 0), workspaceService.CurrentCamera.CFrame)
  end)
end)

local v6 = getrenv and type(getrenv) == "function" and getrenv().require
local v7 = getgenv and type(getgenv) == "function" and getgenv().require
local crownMODULES = _G._CROWN_MODULES or {}

local function f3(p5, p6, p7)
  if crownMODULES and crownMODULES[p6] then
    return crownMODULES[p6]
  end

  if not p5 then
    return p7 or {}
  end

  if v6 then
    local v8, v9 = pcall(v6, p5)

    if v8 and v9 and (type(v9) == "table" or type(v9) == "userdata") then
      return v9
    end
  end

  if v7 and v7 ~= v6 then
    local v10, v11 = pcall(v7, p5)

    if v10 and v11 and (type(v11) == "table" or type(v11) == "userdata") then
      return v11
    end

    return p7 or {}
  end

  return p7 or {}
end

local v12 = {
  ["White Egg"] = { GrowthTime = 3, Rarity = "Common", Luck = 1 },
  ["Brown Egg"] = { GrowthTime = 3, Rarity = "Common", Luck = 5 },
  ["Cracked Egg"] = { GrowthTime = 5, Rarity = "Rare", Luck = 30 },
  ["Easter Egg"] = { GrowthTime = 6, Rarity = "Rare", Luck = 50 },
  ["Stone Egg"] = { GrowthTime = 7, Rarity = "Rare", Luck = 100 },
  ["Leaf Egg"] = { GrowthTime = 8, Rarity = "Rare", Luck = 200 },
  ["Mushroom Egg"] = { GrowthTime = 60, Rarity = "Epic", Luck = 500 },
  ["Flower Egg"] = { GrowthTime = 180, Rarity = "Epic", Luck = 750 },
  ["Slime Egg"] = { GrowthTime = 180, Rarity = "Epic", Luck = 1000 },
  ["Ice Egg"] = { GrowthTime = 180, Rarity = "Epic", Luck = 3000 },
  ["Glass Egg"] = { GrowthTime = 300, Rarity = "Legendary", Luck = 10000 },
  ["Golden Egg"] = { GrowthTime = 300, Rarity = "Legendary", Luck = 30000 },
  ["Diamond Egg"] = { GrowthTime = 600, Rarity = "Mythic", Luck = 90000 },
  ["Crystal Egg"] = { GrowthTime = 900, Rarity = "Mythic", Luck = 150000 },
  ["Skull Egg"] = { GrowthTime = 3600, Rarity = "Mythic", Luck = 250000 },
  ["Asteroid Egg"] = { GrowthTime = 7200, Rarity = "Mythic", Luck = 500000 },
  ["Dominus Egg"] = { GrowthTime = 7200, Rarity = "Mythic", Luck = 700000 },
  ["Flaming Egg"] = { GrowthTime = 7200, Rarity = "Mythic", Luck = 1000000 },
  ["Sinister Egg"] = { GrowthTime = 7200, Rarity = "Mythic", Luck = 3000000 },
  ["Soul Egg"] = { GrowthTime = 7200, Rarity = "Mythic", Luck = 7000000 },
  ["Tidal Egg"] = { GrowthTime = 7200, Rarity = "Mythic", Luck = 8000000 },
  ["Aurora Egg"] = { GrowthTime = 10800, Rarity = "Divine", Luck = 300000000 },
  ["Galaxy Egg"] = { GrowthTime = 10800, Rarity = "Divine", Luck = 1500000000 },
  ["Bloom Egg"] = { GrowthTime = 10800, Rarity = "Divine", Luck = 2000000000 },
  ["Blackhole Egg"] = { GrowthTime = 21600, Rarity = "Ethereal", Luck = 100000000000 },
  ["Solaris Egg"] = { GrowthTime = 25200, Rarity = "Ethereal", Luck = 300000000000 },
  ["Cherub Egg"] = { GrowthTime = 28800, Rarity = "Ethereal", Luck = 1000000000000 },
  ["Volcanic Egg"] = { GrowthTime = 32400, Rarity = "Ethereal", Luck = 2500000000000 },
}

local gameData = replicatedStorage:FindFirstChild("GameData")
  or replicatedStorage:WaitForChild("GameData", 1.5)

local eggs = gameData and (gameData:FindFirstChild("Eggs") or gameData:WaitForChild("Eggs", 1))
local v13 = eggs and f3(eggs, "Eggs", v12) or v12

local hatchLuck = gameData
  and (gameData:FindFirstChild("HatchLuck") or gameData:WaitForChild("HatchLuck", 1))

local v14 = hatchLuck and f3(hatchLuck, "HatchLuck")

local rebirths = gameData
  and (gameData:FindFirstChild("Rebirths") or gameData:WaitForChild("Rebirths", 1))

local v15 = rebirths and f3(rebirths, "Rebirths", {
  Cap = 6,
  RiggedCost = { 1000000, 500000000, 2500000000, 125000000000, 6250000000000, 1000000000000000 },
}) or {
  Cap = 6,
  RiggedCost = { 1000000, 500000000, 2500000000, 125000000000, 6250000000000, 1000000000000000 },
}

if gameData then
  v61 = gameData:FindFirstChild("Pets") or gameData:WaitForChild("Pets", 1)
end

local general = gameData
  and (gameData:FindFirstChild("General") or gameData:WaitForChild("General", 1))

local v16 = general and f3(general, "GeneralConfig")

local remotes = replicatedStorage:FindFirstChild("Remotes")
  or replicatedStorage:WaitForChild("Remotes", 1.5)

local v17 = remotes and (remotes:FindFirstChild("Game") or remotes:WaitForChild("Game", 1))
local eggPickup = v17 and (v17:FindFirstChild("EggPickup") or v17:WaitForChild("EggPickup", 1))

local basketDrop = v17
  and (v17:FindFirstChild("BasketDrop") or v17:WaitForChild("BasketDrop", 1))

local teleportToPlot = v17
  and (v17:FindFirstChild("TeleportToPlot") or v17:WaitForChild("TeleportToPlot", 1))

local eggPlaced = v17 and (v17:FindFirstChild("EggPlaced") or v17:WaitForChild("EggPlaced", 1))
local rebirth = v17 and (v17:FindFirstChild("Rebirth") or v17:WaitForChild("Rebirth", 1))
local hatch = v17 and (v17:FindFirstChild("Hatch") or v17:WaitForChild("Hatch", 1))
local plot = v17 and (v17:FindFirstChild("Plot") or v17:WaitForChild("Plot", 1))
local nests = plot and (plot:FindFirstChild("Nests") or plot:WaitForChild("Nests", 1))

local gameServices = replicatedStorage:FindFirstChild("GameServices")
  or replicatedStorage:WaitForChild("GameServices", 1.5)

local general2 = gameServices
  and (gameServices:FindFirstChild("General") or gameServices:WaitForChild("General", 1))

local v18 = general2 and f3(general2, "General")

local dayNight = gameServices
  and (gameServices:FindFirstChild("DayNight") or gameServices:WaitForChild("DayNight", 1))

local v19 = dayNight and f3(dayNight, "DayNight")

local v20 = {
  Ethereal = 1000,
  Divine = 900,
  Mythic = 800,
  Legendary = 700,
  Epic = 600,
  Rare = 500,
  Common = 100,
  Unknown = 0,
}

Color3.fromRGB(255, 60, 255)
Color3.fromRGB(0, 240, 255)
Color3.fromRGB(255, 50, 50)
Color3.fromRGB(255, 190, 0)
Color3.fromRGB(180, 70, 255)
Color3.fromRGB(60, 150, 255)
Color3.fromRGB(190, 190, 190)
Color3.fromRGB(255, 255, 255)

local function f4(p8)
  local v21 = v13 and v13[p8] or v12[p8]
  return v21 and v21.Rarity or "Common"
end

local function f5(p9)
  local v22 = v13 and v13[p9] or v12[p9]
  return v22 and v22.Luck or 1
end

local v23 = {
  Shocked = 2,
  Volted = 3,
  Rage = 4,
  Void = 10,
  Magma = 10,
  Eternal = 100,
}

local v24 = {
  Eternal = 100000,
  Magma = 75000,
  Void = 50000,
  Rage = 20000,
  Volted = 10000,
  Shocked = 5000,
}

local v25 = {
  Eternal = Color3.fromRGB(255, 100, 220),
  Magma = Color3.fromRGB(255, 120, 20),
  Void = Color3.fromRGB(130, 60, 255),
  Rage = Color3.fromRGB(255, 60, 60),
  Volted = Color3.fromRGB(255, 230, 40),
  Shocked = Color3.fromRGB(80, 190, 255),
}

local v26 = {
  Thunder = "Shocked",
  Volt = "Volted",
  Raging = "Rage",
  Dreadful = "Void",
  Eternal = "Eternal",
}

local vector = Vector3.new(-5102.8, 41408, -3489.1)

local cframe = CFrame.new(
  -4917.03369, 41285.5312, -3704.17505, -0.710648835, -0.151280612, 0.68708986, 1.78015469e-8,
  0.976608396, 0.215025634, -0.703546941, 0.152807727, -0.694025576
)

local cframe2 = CFrame.new(
  -4972.5, 41276.5, -3650, 0.83177793, 0, -0.555108488, 0, 1, 0, 0.555108488, 0, 0.83177793
)

local function f6()
  local serverData = replicatedStorage:FindFirstChild("ServerData")

  if not serverData then
    return nil
  end

  local activeWeathers = serverData:GetAttribute("ActiveWeathers")

  if not activeWeathers or activeWeathers == "" or activeWeathers == "[]" then
    return nil
  else
    local v27, v28 = pcall(function() return httpService:JSONDecode(activeWeathers) end)

    if not v27 or type(v28) ~= "table" then
      return nil
    else
      local getServerTimeNow = workspaceService:GetServerTimeNow()

      for index6, value6 in ipairs(v28) do
        if value6.Type == "Storm" and value6.Variant
          and (not value6.EndsAt or value6.EndsAt > getServerTimeNow) then
          return value6
        end
      end

      return nil
    end
  end
end

local function f7(p10)
  if not p10 or p10 == "" then
    return false
  else
    local minMutationTier = _G.CrownHubState and _G.CrownHubState.MinMutationTier
      or "All Mutations (Shocked+)"

    local v29 = v23[p10] or 1

    if minMutationTier == "Eternal Only (100x)" then
      return v29 >= 100
    end

    if minMutationTier == "Magma & Above (10x+)" or minMutationTier == "Void & Above (10x+)" then
      return v29 >= 10
    elseif minMutationTier == "Rage & Above (4x+)" then
      return v29 >= 4
    else
      if minMutationTier == "Volted & Above (3x+)" then
        return v29 >= 3
      end

      return v29 >= 2
    end
  end
end

local function f8()
  local cook45VolcanoPlatform = workspaceService:FindFirstChild("Crown_VolcanoPlatform")
  local cframe3 = CFrame.new(cframe.Position - Vector3.new(0, 3.2, 0))

  if not cook45VolcanoPlatform then
    cook45VolcanoPlatform = Instance.new("Part")
    cook45VolcanoPlatform.Name = "Crown_VolcanoPlatform"
    cook45VolcanoPlatform.Size = Vector3.new(14, 1, 14)
    cook45VolcanoPlatform.Anchored = true
    cook45VolcanoPlatform.CanCollide = true
    cook45VolcanoPlatform.CFrame = cframe3
    cook45VolcanoPlatform.Material = Enum.Material.SmoothPlastic
    cook45VolcanoPlatform.Transparency = 0.5
    cook45VolcanoPlatform.Parent = workspaceService
  else
    cook45VolcanoPlatform.CFrame = cframe3
  end

  return cook45VolcanoPlatform
end

local function f9(p11)
  if not p11 then
    return nil
  else
    local mutation = p11:GetAttribute("Mutation")

    if mutation and mutation ~= "" then
      return mutation
    else
      local serverData2 = replicatedStorage:FindFirstChild("ServerData")
      local activeEggs = serverData2 and serverData2:FindFirstChild("ActiveEggs")

      if activeEggs then
        local position = p11:GetPivot().Position

        for index7, value7 in ipairs(activeEggs:GetChildren()) do
          local getAttributes = value7:GetAttributes()

          if getAttributes.Mutation and getAttributes.Mutation ~= "" then
            local position2 = getAttributes.Position

            local position3 = position2

            position3 = position2
              or getAttributes.SpawnCFrame and getAttributes.SpawnCFrame.Position

            if position3 and (position3 - position).Magnitude <= 6 then
              return getAttributes.Mutation
            end
          end
        end

        if p11:FindFirstChild("MutationHitbox") then
          local v30 = f6()

          if v30 and v30.Variant and v26[v30.Variant] then
            return v26[v30.Variant]
          end

          return "Shocked"
        end

        return nil
      elseif p11:FindFirstChild("MutationHitbox") then
        local v31 = f6()

        if v31 and v31.Variant and v26[v31.Variant] then
          return v26[v31.Variant]
        end

        return "Shocked"
      else
        return nil
      end
    end
  end
end

local g = _G
g.CrownHubState = _G.CrownHubState or {}

local crownHubState = _G.CrownHubState
-- old Auto Steal is replaced by Collect Eggs
crownHubState.AutoFarm = false
crownHubState.AutoRebirth = false
crownHubState.AutoMagmaDip = false

-- Discord webhooks
if crownHubState.WebhookEnabled == nil then crownHubState.WebhookEnabled = false end
if crownHubState.WebhookURL == nil then crownHubState.WebhookURL = "" end
if crownHubState.WebhookPingHere == nil then crownHubState.WebhookPingHere = false end
if crownHubState.WebhookOnLoad == nil then crownHubState.WebhookOnLoad = false end
if crownHubState.WebhookOnEggCollect == nil then crownHubState.WebhookOnEggCollect = true end
if crownHubState.WebhookOnMutation == nil then crownHubState.WebhookOnMutation = true end
if crownHubState.WebhookOnRebirth == nil then crownHubState.WebhookOnRebirth = true end
if crownHubState.WebhookOnRebirthFail == nil then crownHubState.WebhookOnRebirthFail = true end
if crownHubState.WebhookOnNestFull == nil then crownHubState.WebhookOnNestFull = false end

-- Instant steal only (locked)
crownHubState.FarmMode = "Instant"


local WEBHOOK_ICON = "https://www.image2url.com/r2/default/images/1791412813555-72fbe978-91b1-4e78-9fa7-b947bd641bf5.png"
local WEBHOOK_NAME = "ZRHUB"
local DISCORD_SERVER_URL = "https://discord.gg/TCuMcKy9j4"

local function crownWebhook(title, description, color)
  if not crownHubState.WebhookEnabled then return end
  local url = tostring(crownHubState.WebhookURL or "")
  if url == "" or not url:find("discord", 1, true) then return end

  local content = nil
  if crownHubState.WebhookPingHere then
    content = "@here"
  end

  local embed = {
    title = tostring(title or "ZRHUB"),
    description = tostring(description or ""),
    color = color or 15442216, -- gold
    footer = { text = "ZRHUB" },
    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
  }

  local body = {
    username = WEBHOOK_NAME,
    avatar_url = WEBHOOK_ICON,
    content = content,
    embeds = { embed },
  }

  local ok, payload = pcall(function()
    return httpService:JSONEncode(body)
  end)
  if not ok or not payload then return end

  pcall(function()
    if request then
      request({
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = payload,
      })
    elseif http_request then
      http_request({
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = payload,
      })
    elseif syn and syn.request then
      syn.request({
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = payload,
      })
    end
  end)
end



-- One shared speed for flying to the egg AND carrying it back to the plot.
-- Default 1250, max 10000. Read live every frame, so changing it while
-- Auto Steal Eggs speed (legacy field, Instant mode does not tween).
if crownHubState.TweenSpeed == nil then
  crownHubState.TweenSpeed = 250
end
if crownHubState.StealMovement == nil then
  crownHubState.StealMovement = "Tween"
end

-- ReturnSpeed was merged into TweenSpeed
crownHubState.ReturnSpeed = nil

if crownHubState.StealApproach == nil then
  crownHubState.StealApproach = "Over Map"
end

if crownHubState.SyncDelay == nil then
  crownHubState.SyncDelay = 0.35
end

if crownHubState.PostPickupDelay == nil then
  crownHubState.PostPickupDelay = 0.15
end

if crownHubState.PriorityRarity == nil then
  crownHubState.PriorityRarity = true
end

if crownHubState.AutoDropUnwanted == nil then
  crownHubState.AutoDropUnwanted = false
end

if crownHubState.AutoReturnPlot == nil then
  crownHubState.AutoReturnPlot = false
end

crownHubState.AutoPlaceNest = false

crownHubState.SpawnNest = false

crownHubState.AutoHatchPlot = false

if crownHubState.AutoUnlockNests == nil then
  crownHubState.AutoUnlockNests = false
end

if crownHubState.AutoUpgradeLuck == nil then
  crownHubState.AutoUpgradeLuck = false
end

crownHubState.AutoFeedPets = false

if crownHubState.FeedTargetMode == nil then
  crownHubState.FeedTargetMode = "Smart Priority"
end

if crownHubState.SelectedPetKey == nil then
  crownHubState.SelectedPetKey = nil
end

if crownHubState.FeedPriorityMode == nil then
  crownHubState.FeedPriorityMode = "Smart Potential"
end

if crownHubState.FeedSkipMaxAge == nil then
  crownHubState.FeedSkipMaxAge = true
end

if crownHubState.FeedAllowPremiumFood == nil then
  crownHubState.FeedAllowPremiumFood = true
end

if crownHubState.FeedFoodSelection == nil then
  crownHubState.FeedFoodSelection = "All Foods"
end

if crownHubState.FeedAllPets == nil then
  crownHubState.FeedAllPets = true
end

if crownHubState.FeedPetList == nil then
  crownHubState.FeedPetList = {}
end

if crownHubState.PrioritizeRebirthPet == nil then
  crownHubState.PrioritizeRebirthPet = true
end

if crownHubState.AutoRebirthWhenReady == nil then
  crownHubState.AutoRebirthWhenReady = true
end

if crownHubState.AllowedRarities == nil then
  crownHubState.AllowedRarities = {
    Ethereal = true,
    Divine = true,
    Mythic = true,
    Legendary = true,
    Epic = true,
    Rare = false,
    Common = false,
  }
end

if crownHubState.AutoFuse == nil then
  crownHubState.AutoFuse = false
end

if crownHubState.FuseProtectFavorited == nil then
  crownHubState.FuseProtectFavorited = true
end

if crownHubState.AutoFavoriteFuse == nil then
  crownHubState.AutoFavoriteFuse = true
end

if crownHubState.AutoFavoriteFuseList == nil then
  crownHubState.AutoFavoriteFuseList = {
    "Hydra Dragon ($165M/s - Val: $99B)", "Hellhound ($140M/s - Val: $84B)",
    "Fenrir ($120M/s - Val: $72B)", "Stone Golem ($60M/s - Val: $36B)",
    "El Toro ($20M/s - Val: $12B)",
  }
end

if crownHubState.FuseRarities == nil then
  crownHubState.FuseRarities = {
    Legendary = true,
    Mythic = true,
    Divine = false,
    Ethereal = false,
  }
end

crownHubState.ESP_Enabled = false

if crownHubState.ESP_Highlights == nil then
  crownHubState.ESP_Highlights = true
end

if crownHubState.ESP_Billboards == nil then
  crownHubState.ESP_Billboards = true
end

if crownHubState.ESP_Tracers == nil then
  crownHubState.ESP_Tracers = false
end

if crownHubState.ESP_MaxDistance == nil then
  crownHubState.ESP_MaxDistance = 5000
end

if crownHubState.ESP_MinRarity == nil or crownHubState.ESP_MinRarity == "Rare" then
  crownHubState.ESP_MinRarity = "Rare & Above"
end

if type(crownHubState.ESP_MaxDistance) ~= "number" then
  crownHubState.ESP_MaxDistance = tonumber(crownHubState.ESP_MaxDistance) or 5000
end

if crownHubState.NoClip == nil then
  crownHubState.NoClip = false
end

if crownHubState.SpeedMultiplier == nil then
  crownHubState.SpeedMultiplier = 1
end

if crownHubState.SpeedModEnabled == nil then
  crownHubState.SpeedModEnabled = false
end

if crownHubState.MinFarmRarity == nil then
  crownHubState.MinFarmRarity = "Mythic & Above"
end

if crownHubState.TargetSpecificEgg == nil then
  crownHubState.TargetSpecificEgg = "Any Egg (Use Rarity Filter)"
end

if crownHubState.FarmPriority == nil then
  crownHubState.FarmPriority = "Highest Rarity First"
end

if crownHubState.PlotStrategy == nil then
  crownHubState.PlotStrategy = "Disabled"
end

crownHubState.ESP_VisualPreset = "Highlights + Floating Text"
crownHubState.ESP_Highlights = true
crownHubState.ESP_Billboards = true
crownHubState.ESP_Tracers = false

if crownHubState.SpeedPreset == nil then
  crownHubState.SpeedPreset = "Default (1x)"
end

if crownHubState.MinEggWeight == nil then
  crownHubState.MinEggWeight = 0
end

if crownHubState.PrioritizeHeaviest == nil then
  crownHubState.PrioritizeHeaviest = false
end

if crownHubState.WeatherEggWait == nil then
  crownHubState.WeatherEggWait = false
end

if crownHubState.PrioritizeMutations == nil then
  crownHubState.PrioritizeMutations = true
end

if crownHubState.MinMutationTier == nil then
  crownHubState.MinMutationTier = "All Mutations (Shocked+)"
end

if crownHubState.WeatherNotify == nil then
  crownHubState.WeatherNotify = true
end

local function f10(p12)
  crownHubState.MinFarmRarity = p12

  local v32 = ({
    ["All Eggs"] = {
      Common = true,
      Rare = true,
      Epic = true,
      Legendary = true,
      Mythic = true,
      Divine = true,
      Ethereal = true,
    },
    ["Rare & Above"] = {
      Common = false,
      Rare = true,
      Epic = true,
      Legendary = true,
      Mythic = true,
      Divine = true,
      Ethereal = true,
    },
    ["Epic & Above"] = {
      Common = false,
      Rare = false,
      Epic = true,
      Legendary = true,
      Mythic = true,
      Divine = true,
      Ethereal = true,
    },
    ["Legendary & Above"] = {
      Common = false,
      Rare = false,
      Epic = false,
      Legendary = true,
      Mythic = true,
      Divine = true,
      Ethereal = true,
    },
    ["Mythic & Above"] = {
      Common = false,
      Rare = false,
      Epic = false,
      Legendary = false,
      Mythic = true,
      Divine = true,
      Ethereal = true,
    },
    ["Divine & Above"] = {
      Common = false,
      Rare = false,
      Epic = false,
      Legendary = false,
      Mythic = false,
      Divine = true,
      Ethereal = true,
    },
    ["Ethereal Only"] = {
      Common = false,
      Rare = false,
      Epic = false,
      Legendary = false,
      Mythic = false,
      Divine = false,
      Ethereal = true,
    },
  })[p12]

  if v32 then
    for key, value8 in pairs(v32) do
      crownHubState.AllowedRarities[key] = value8
    end
  end
end

local function f11(p13)
  crownHubState.ESP_VisualPreset = p13

  if p13 == "All Visuals (Highlight + Text + Tracer)" then
    crownHubState.ESP_Highlights = true
    crownHubState.ESP_Billboards = true
    crownHubState.ESP_Tracers = true
  elseif p13 == "Highlights + Floating Text" then
    crownHubState.ESP_Highlights = true
    crownHubState.ESP_Billboards = true
    crownHubState.ESP_Tracers = false
  elseif p13 == "Floating Text Only (Clean)" then
    crownHubState.ESP_Highlights = false
    crownHubState.ESP_Billboards = true
    crownHubState.ESP_Tracers = false
  elseif p13 == "Highlights Only (Minimal)" then
    crownHubState.ESP_Highlights = true
    crownHubState.ESP_Billboards = false
    crownHubState.ESP_Tracers = false
  elseif p13 == "Tracers Only" then
    crownHubState.ESP_Highlights = false
    crownHubState.ESP_Billboards = false
    crownHubState.ESP_Tracers = true
  end
end

local v33 = false
local profile = "default"

pcall(function()
  if isfile and isfile("CrownHub_RideAPet/configs/autoload.json") then
    local jsonDecode = httpService:JSONDecode((readfile("CrownHub_RideAPet/configs/autoload.json")))

    if jsonDecode and type(jsonDecode) == "table" then
      if jsonDecode.AutoLoad == true then
        v33 = true
      end

      if jsonDecode.Profile and type(jsonDecode.Profile) == "string"
        and jsonDecode.Profile ~= "" and jsonDecode.Profile ~= "autoload" then
        profile = jsonDecode.Profile
      end
    end
  end

  if v33 and profile ~= "" then
    local v34 = "CrownHub_RideAPet/configs" .. "/" .. profile .. ".json"

    if isfile and isfile(v34) then
      local jsonDecode2 = httpService:JSONDecode((readfile(v34)))

      if jsonDecode2 and type(jsonDecode2) == "table" then
        for key2, value9 in pairs(jsonDecode2) do
          if key2 ~= "AutoFarm" and key2 ~= "AutoRebirth" then
            crownHubState[key2] = value9
          end
        end

        if crownHubState.MinFarmRarity and f10 then
          f10(crownHubState.MinFarmRarity)
        end

        if crownHubState.ESP_VisualPreset and f11 then
          f11(crownHubState.ESP_VisualPreset)
        end
      end
    end
  end
end)
-- lock steal mode
crownHubState.FarmMode = "Instant"

local values = {
  "Any Egg (Use Rarity Filter)", "Volcanic Egg [Ethereal]", "Cherub Egg [Ethereal]",
  "Solaris Egg [Ethereal]", "Blackhole Egg [Ethereal]", "Giant Egg [Ethereal]",
  "Dragon Egg [Ethereal]", "Bloom Egg [Divine]", "Galaxy Egg [Divine]", "Aurora Egg [Divine]",
  "Tidal Egg [Mythic]", "Soul Egg [Mythic]", "Sinister Egg [Mythic]", "Flaming Egg [Mythic]",
  "Dominus Egg [Mythic]", "Asteroid Egg [Mythic]", "Skull Egg [Mythic]", "Crystal Egg [Mythic]",
  "Diamond Egg [Mythic]", "Golden Egg [Legendary]", "Glass Egg [Legendary]", "Ice Egg [Epic]",
  "Slime Egg [Epic]", "Flower Egg [Epic]", "Mushroom Egg [Epic]", "Leaf Egg [Rare]",
  "Stone Egg [Rare]", "Easter Egg [Rare]", "Cracked Egg [Rare]", "Brown Egg [Common]",
  "White Egg [Common]",
}

local function f12()
  local character = localPlayer2.Character

  if not character then
    return nil
  else
    local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
    local humanoid2 = character:FindFirstChildOfClass("Humanoid")

    if humanoidRootPart2 and humanoid2 and humanoid2.Health > 0 then
      return character, humanoidRootPart2, humanoid2
    end

    return nil
  end
end

local v35 = {
  Status = "Idle",
  Target = "None",
  TargetRarity = "None",
  CollectedCount = 0,
  IsFarming = false,
  CurrentTween = nil,
  RebirthTargetPet = nil,
  RebirthEggName = nil,
  RebirthEggChance = 0,
  TargetWeight = 0,
}

local function f13()
  if v18 and v18.GetPlot then
    local getPlot = v18:GetPlot(localPlayer2)

    if getPlot then
      return getPlot
    end
  end

  local plots = workspaceService:FindFirstChild("Plots")

  if plots then
    for index8, value10 in ipairs(plots:GetChildren()) do
      local nestsOwnerLoaded = value10:GetAttribute("NestsOwnerLoaded")
        or value10:GetAttribute("OwnerUserId") or value10:GetAttribute("Owner")

      if nestsOwnerLoaded == localPlayer2.UserId
        or tostring(nestsOwnerLoaded) == tostring(localPlayer2.UserId) then
        return value10
      else
        local data = value10:FindFirstChild("Data")

        local owner = data
        owner = data and data:FindFirstChild("Owner")

        if owner
          and (owner.Value == localPlayer2 or tostring(owner.Value) == localPlayer2.Name
            or tostring(owner.Value) == tostring(localPlayer2.UserId)) then
          return value10
        end

        if value10.Name == tostring(localPlayer2.UserId) or value10.Name == localPlayer2.Name then
          return value10
        elseif value10:FindFirstChild("Pets") then
          for index9, value11 in ipairs(value10.Pets:GetChildren()) do
            if value11:IsA("Model")
              and (value11:GetAttribute("OwnerUserId") == localPlayer2.UserId
                or tostring(value11:GetAttribute("OwnerUserId"))
                  == tostring(localPlayer2.UserId)) then
              return value10
            end
          end
        end
      end
    end

    return nil
  end

  return nil
end

local function f14()
  local v36 = f13()
  local eggs2 = v36 and v36:FindFirstChild("Eggs")

  if eggs2 then
    return #eggs2:GetChildren()
  end

  return 0
end

local function f15()
  local count = 0
  local v37 = f13()
  local nests2 = v37 and v37:FindFirstChild("Nests")

  if nests2 then
    for index10, value12 in ipairs(nests2:GetChildren()) do
      if value12:GetAttribute("Occupied") == true then
        count = count + 1
      end
    end
  end

  return count
end

local function f16(p14)
  if not p14 then
    return
  end

  local waitForChild = p14:WaitForChild("Humanoid", 5)
  local waitForChild2 = p14:WaitForChild("HumanoidRootPart", 5)

  if not waitForChild then
    return
  end

  pcall(function()
    waitForChild:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    waitForChild:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    waitForChild:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    waitForChild:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
  end)

  waitForChild.StateChanged:Connect(function(p15, p16)
    if _G.CrownHubInstanceId ~= crownHubInstanceId then
      return
    end

    if p16 == Enum.HumanoidStateType.Ragdoll or p16 == Enum.HumanoidStateType.Physics
      or p16 == Enum.HumanoidStateType.FallingDown then
      pcall(function()
        waitForChild:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        waitForChild:ChangeState(Enum.HumanoidStateType.GettingUp)
      end)

      if waitForChild2 and waitForChild2:IsA("BasePart") then
        waitForChild2.AssemblyLinearVelocity = Vector3.zero
      end
    end
  end)
end

if localPlayer2.Character then
  f16(localPlayer2.Character)
end

localPlayer2.CharacterAdded:Connect(function(character2)
  pcall(function()
    local ragdoll = localPlayer2:FindFirstChild("PlayerScripts")
      and localPlayer2.PlayerScripts:FindFirstChild("Game")
      and localPlayer2.PlayerScripts.Game:FindFirstChild("Ragdoll")

    if ragdoll and ragdoll:IsA("LocalScript") then
      ragdoll.Disabled = true
    end
  end)

  f16(character2)
end)

pcall(function()
  local net = replicatedStorage:FindFirstChild("packages")
    and replicatedStorage.packages:FindFirstChild("Net")

  local reRagdoll = net and net:FindFirstChild("RE/Ragdoll")

  if reRagdoll and reRagdoll:IsA("RemoteEvent") then
    reRagdoll.OnClientEvent:Connect(function(p17, p18)
      if _G.CrownHubInstanceId ~= crownHubInstanceId then
        return
      end

      if p17 then
        task.defer(function()
          local v38, v39, v40 = f12()

          if v40 then
            pcall(function()
              v40:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
              v40:ChangeState(Enum.HumanoidStateType.GettingUp)
            end)
          end

          if v39 and v39:IsA("BasePart") then
            v39.AssemblyLinearVelocity = Vector3.zero
          end
        end)
      end
    end)
  end
end)

local function f17(p19)
  local v41 = f13()
  local nests3 = v41 and v41:FindFirstChild("Nests")

  if not nests3 then
    return
  end

  for index11, value13 in ipairs(nests3:GetChildren()) do
    local v42 = value13

    for index12, value14 in ipairs(v42:GetDescendants()) do
      local v43 = value14

      if v43:IsA("BasePart") and v43.Name ~= "Crown_NestAnchor" then
        v43.LocalTransparencyModifier = p19 and 0 or 1

        if not v43:GetAttribute("NestWatched") then
          v43:SetAttribute("NestWatched", true)

          v43:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
            if crownHubState.SpawnNest and v43.LocalTransparencyModifier ~= 0 then
              v43.LocalTransparencyModifier = 0
            end
          end)
        end
      end
    end

    local cook45NestAnchor = v42:FindFirstChild("Crown_NestAnchor")

    if p19 then
      if not cook45NestAnchor then
        cook45NestAnchor = Instance.new("Part")
        cook45NestAnchor.Name = "Crown_NestAnchor"
        cook45NestAnchor.Size = Vector3.new(2, 2, 2)
        cook45NestAnchor.CFrame = v42:GetPivot() * CFrame.new(0, 1.5, 0)
        cook45NestAnchor.Transparency = 1
        cook45NestAnchor.CanCollide = false
        cook45NestAnchor.CanTouch = false
        cook45NestAnchor.CanQuery = false
        cook45NestAnchor.Anchored = true
        cook45NestAnchor.Parent = v42
      end

      local nestPlacePrompt = cook45NestAnchor:FindFirstChildOfClass("ProximityPrompt")

      if not nestPlacePrompt then
        nestPlacePrompt = Instance.new("ProximityPrompt")
        nestPlacePrompt.Name = "NestPlacePrompt"
        nestPlacePrompt.ActionText = "Place Egg"
        nestPlacePrompt.ObjectText = "Nest " .. v42.Name
        nestPlacePrompt.HoldDuration = 0
        nestPlacePrompt.MaxActivationDistance = 25
        nestPlacePrompt.RequiresLineOfSight = false
        nestPlacePrompt.Parent = cook45NestAnchor

        nestPlacePrompt.Triggered:Connect(function(p20)
          if p20 == localPlayer2 then
            if v42:GetAttribute("Occupied") then
              if v347 then
                if crownHubState.WebhookOnNestFull then
                  task.spawn(function()
                    crownWebhook("Nest Full", "All nests are full.", 15105570)
                  end)
                end
                v347:Notify({
                  Title = "Nest Full",
                  Content = "This nest is already occupied!",
                  Duration = 2,
                  Icon = "alert-circle",
                })
              end

              return
            else
              local character3 = localPlayer2.Character
              local humanoid3 = character3 and character3:FindFirstChildOfClass("Humanoid")
              local v44 = nil

              if character3 then
                for index13, value15 in ipairs(character3:GetChildren()) do
                  if value15:IsA("Tool")
                    and (value15:HasTag("Egg") or string.find(value15.Name, "Egg")) then
                    v44 = value15
                    break
                  end
                end
              end

              if not v44 and localPlayer2:FindFirstChild("Backpack") then
                for index14, value16 in ipairs(localPlayer2.Backpack:GetChildren()) do
                  if value16:IsA("Tool")
                    and (value16:HasTag("Egg") or string.find(value16.Name, "Egg")) then
                    v44 = value16
                    break
                  end
                end
              end

              if not v44 then
                if v347 then
                  v347:Notify({
                    Title = "No Egg",
                    Content = "No egg tool in backpack or character!",
                    Duration = 2,
                    Icon = "x",
                  })
                end

                return
              end

              if humanoid3 and v44.Parent ~= character3 then
                humanoid3:EquipTool(v44)
                local v45 = os.clock()

                while v44.Parent ~= character3 and os.clock() - v45 < 0.8 do
                  task.wait(0.05)
                end
              end

              if v44.Parent == character3 and eggPlaced then
                task.wait(0.1)
                eggPlaced:FireServer({ NestId = v42.Name })

                if v347 then
                  v347:Notify({
                    Title = "Nest Placed",
                    Content = "Placed " .. v44.Name .. " in Nest " .. v42.Name .. "!",
                    Duration = 3,
                    Icon = "check",
                  })
                end
              end

              return
            end
          else
            return
          end
        end)
      end

      if not cook45NestAnchor:FindFirstChild("NestStatusESP") then
        local nestStatusESP = Instance.new("BillboardGui")
        nestStatusESP.Name = "NestStatusESP"
        nestStatusESP.Size = UDim2.new(0, 140, 0, 30)
        nestStatusESP.StudsOffset = Vector3.new(0, 2.5, 0)
        nestStatusESP.AlwaysOnTop = true
        nestStatusESP.Adornee = cook45NestAnchor
        nestStatusESP.Enabled = true
        nestStatusESP.Parent = cook45NestAnchor

        local statusLabel2 = Instance.new("TextLabel")
        statusLabel2.Name = "StatusLabel"
        statusLabel2.Size = UDim2.new(1, 0, 1, 0)
        statusLabel2.BackgroundTransparency = 0.4
        statusLabel2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        statusLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel2.Font = Enum.Font.GothamBold
        statusLabel2.TextSize = 13
        statusLabel2.BorderSizePixel = 0
        statusLabel2.Parent = nestStatusESP

        local uiCorner5 = Instance.new("UICorner")
        uiCorner5.CornerRadius = UDim.new(0, 6)
        uiCorner5.Parent = statusLabel2
      end

      local function f18()
        local v46 = v42:GetAttribute("Occupied") == true
        local v47 = cook45NestAnchor
        local v48 = v42:GetAttribute("Unlocked") ~= false

        local statusLabel3 = v47:FindFirstChild("NestStatusESP")
          and cook45NestAnchor.NestStatusESP:FindFirstChild("StatusLabel")

        if statusLabel3 then
          if not v48 then
            statusLabel3.Text = "[Locked] Nest " .. v42.Name
            statusLabel3.TextColor3 = Color3.fromRGB(220, 80, 80)
          elseif v46 then
            statusLabel3.Text = "[Incubating] Nest " .. v42.Name
            statusLabel3.TextColor3 = Color3.fromRGB(255, 200, 50)
          else
            statusLabel3.Text = "[Ready] Nest " .. v42.Name
            statusLabel3.TextColor3 = Color3.fromRGB(80, 255, 120)
          end
        end

        if nestPlacePrompt then
          local v49 = nestPlacePrompt
          v49.Enabled = v48 and not v46
        end
      end

      v42:GetAttributeChangedSignal("Occupied"):Connect(f18)
      v42:GetAttributeChangedSignal("Unlocked"):Connect(f18)

      f18()
    elseif cook45NestAnchor then
      local proximityPrompt = cook45NestAnchor:FindFirstChildOfClass("ProximityPrompt")

      if proximityPrompt then
        proximityPrompt.Enabled = false
      end

      local nestStatusESP2 = cook45NestAnchor:FindFirstChild("NestStatusESP")

      if nestStatusESP2 then
        nestStatusESP2.Enabled = false
      end
    end
  end
end

local function f19(p21)
  local v50 = tonumber(p21) or 0

  if v50 >= 1000000000000000 then
    return string.format("%.2fQa", v50 / 1000000000000000)
  elseif v50 >= 1000000000000 then
    return string.format("%.2fT", v50 / 1000000000000)
  elseif v50 >= 1000000000 then
    return string.format("%.2fB", v50 / 1000000000)
  elseif v50 >= 1000000 then
    return string.format("%.2fM", v50 / 1000000)
  else
    if v50 >= 1000 then
      return string.format("%.2fK", v50 / 1000)
    end

    return tostring(math.floor(v50))
  end
end

local v51 = {}

local function f20(p22)
  if not p22 then
    return {}
  elseif v51[p22] then
    return v51[p22]
  else
    if v14 and v14.GetOdds then
      local v52, v53 = pcall(function() return v14.GetOdds(p22) end)

      if v52 and type(v53) == "table" then
        local v54 = {}

        for index15, value17 in ipairs(v53) do
          if value17.PetName and value17.Chance then
            v54[value17.PetName] = value17.Chance
          end
        end

        v51[p22] = v54
        return v54
      end

      return {}
    end

    return {}
  end
end

local function f21(p23)
  local v55 = tonumber(p23) or 0

  if v55 >= 1000 then
    return f19(v55) .. " KG"
  end

  if v55 >= 10 then
    return string.format("%.1f KG", v55)
  end

  return string.format("%.2f KG", v55)
end

local function f22(p24, p25)
  if not p24 then
    return false
  end

  local create3

  if localPlayer2:GetAttribute("InVolcano") == true
    and localPlayer2:GetAttribute("VolcanoValidated") == true then
    return true
  else
    v35.Status = "Warping to Volcano Sky Platform..."
    f8()

    p24.AssemblyLinearVelocity = Vector3.zero
    p24.AssemblyAngularVelocity = Vector3.zero
    p24.CFrame = cframe

    task.wait(0.12)
    local volcano = workspaceService:FindFirstChild("Volcano")
    local volcanoEntrance = volcano and volcano:FindFirstChild("VolcanoEntrance")
    local volcanoValidate = volcano and volcano:FindFirstChild("VolcanoValidate")
    v35.Status = "Tweening into Cave Doors..."
    local v56 = math.clamp((cframe2.Position - p24.Position).Magnitude / 40, 0.6, 1.6)

    create3 = tweenService:Create(p24, TweenInfo.new(v56, Enum.EasingStyle.Linear), {
      CFrame = cframe2,
    })

    create3:Play()

    local v57 = os.clock()

    while os.clock() - v57 < v56 + 0.5 do
      if firetouchinterest then
        if volcanoEntrance then
          pcall(firetouchinterest, p24, volcanoEntrance, 0)
        end

        if volcanoValidate then
          pcall(firetouchinterest, p24, volcanoValidate, 0)
        end
      end

      if localPlayer2:GetAttribute("InVolcano") == true
        and localPlayer2:GetAttribute("VolcanoValidated") == true then
        break
      end

      task.wait(0.03)
    end

    pcall(function() create3:Cancel() end)

    if firetouchinterest then
      if volcanoEntrance then
        pcall(firetouchinterest, p24, volcanoEntrance, 1)
      end

      if volcanoValidate then
        pcall(firetouchinterest, p24, volcanoValidate, 1)
      end
    end

    p24.AssemblyLinearVelocity = Vector3.zero
    p24.AssemblyAngularVelocity = Vector3.zero

    task.wait(0.05)
    return localPlayer2:GetAttribute("InVolcano") == true
  end
end

local function f23(p26, p27)
  if not p26 then
    return false
  else
    local v58 = (p26.Position - vector).Magnitude < 1500
    local v59 = false
    local basket = localPlayer2:FindFirstChild("Basket")

    if basket then
      for index16, value18 in ipairs(basket:GetChildren()) do
        if value18.Name == "Volcanic Egg" or value18:GetAttribute("Egg") == "Volcanic Egg"
          or value18:GetAttribute("Escaping") == true
          or value18:GetAttribute("VolcanoUntil") ~= nil then
          v59 = true
          break
        end
      end
    end

    if v58 and (v59 or localPlayer2:GetAttribute("InVolcano") == true) then
      v35.Status = "Escaping Volcano through Lair Door..."

      p26.AssemblyLinearVelocity = Vector3.zero
      p26.AssemblyAngularVelocity = Vector3.zero
      p26.CFrame = cframe2

      task.wait(0.08)
      local volcano2 = workspaceService:FindFirstChild("Volcano")

      local volcanoEntrance2 = volcano2
      volcanoEntrance2 = volcano2 and volcano2:FindFirstChild("VolcanoEntrance")

      local volcanoValidate2 = volcano2
      volcanoValidate2 = volcano2 and volcano2:FindFirstChild("VolcanoValidate")

      if firetouchinterest then
        if volcanoValidate2 then
          pcall(firetouchinterest, p26, volcanoValidate2, 0)
        end

        if volcanoEntrance2 then
          pcall(firetouchinterest, p26, volcanoEntrance2, 0)
        end
      end

      p26.AssemblyLinearVelocity = Vector3.zero
      p26.AssemblyAngularVelocity = Vector3.zero
      p26.CFrame = cframe

      if firetouchinterest then
        if volcanoValidate2 then
          pcall(firetouchinterest, p26, volcanoValidate2, 1)
        end

        if volcanoEntrance2 then
          pcall(firetouchinterest, p26, volcanoEntrance2, 1)
        end
      end

      local v60 = os.clock()

      while os.clock() - v60 < 0.5 do
        if localPlayer2:GetAttribute("InVolcano") ~= true then
          break
        end

        task.wait(0.04)
      end

      v35.Status = "Volcano Escaped!"
      return true
    end

    return false
  end
end

local v62 = {
  Horse = {
    ["Asteroid Egg"] = true,
    ["Skull Egg"] = true,
    ["Dominus Egg"] = true,
    ["Crystal Egg"] = true,
    ["Diamond Egg"] = true,
    ["Golden Egg"] = true,
  },
  Fox = { ["Soul Egg"] = true, ["Sinister Egg"] = true, ["Flaming Egg"] = true },
  Unicorn = {
    ["Cherub Egg"] = true,
    ["Solaris Egg"] = true,
    ["Blackhole Egg"] = true,
    ["Galaxy Egg"] = true,
  },
  Phoenix = { ["Cherub Egg"] = true, ["Solaris Egg"] = true, ["Blackhole Egg"] = true },
  Kitsune = { ["Cherub Egg"] = true, ["Solaris Egg"] = true, ["Blackhole Egg"] = true },
  Dragon = { ["Cherub Egg"] = true, ["Solaris Egg"] = true, ["Blackhole Egg"] = true },
}

local function f24(p28)
  if not p28 or p28 == "" then
    return false, "No Target"
  else
    local savedData = localPlayer2:FindFirstChild("SavedData")
    local ownedPets = savedData and savedData:FindFirstChild("OwnedPets")

    if ownedPets and ownedPets.Value then
      if string.find(tostring(ownedPets.Value), p28 .. ",") then
        return true, "SavedData"
      end
    end

    local backpack = localPlayer2:FindFirstChild("Backpack")

    if backpack then
      for index17, value19 in ipairs(backpack:GetChildren()) do
        if value19:IsA("Tool") then
          local petKey = value19:GetAttribute("PetKey")
          local match = value19.Name:match("^(.-) %[") or value19.Name

          if petKey and string.find(petKey, p28) or match == p28 then
            return true, "Backpack"
          end
        end
      end
    end

    local character4 = localPlayer2.Character

    if character4 then
      for index18, value20 in ipairs(character4:GetChildren()) do
        if value20:IsA("Tool") then
          local petKey2 = value20:GetAttribute("PetKey")
          local match2 = value20.Name:match("^(.-) %[") or value20.Name

          if petKey2 and string.find(petKey2, p28) or match2 == p28 then
            return true, "Character"
          end
        end
      end
    end

    local v63 = f13()

    if v63 and v63:FindFirstChild("Pets") then
      for index19, value21 in ipairs(v63.Pets:GetChildren()) do
        if (value21.Name:match("^(.-) %[") or value21.Name) == p28 then
          return true, "Plot"
        end
      end

      return false, "Not Owned"
    end

    return false, "Not Owned"
  end
end

local function f25(p29)
  local v64 = not p29 or not p29.Parent
  local v65, placeTime, weight, v66, isReady, v67, v68

  if v64 then
    return nil
  else
    local eggKey = p29:GetAttribute("EggKey")
    local eggData = p29:FindFirstChild("EggData")

    placeTime = eggData and eggData:FindFirstChild("PlaceTime")
      and tonumber(eggData.PlaceTime.Value)

    weight = eggData and eggData:FindFirstChild("Weight") and tonumber(eggData.Weight.Value)
      or 1

    v65 = v13 and v13[p29.Name] or v12[p29.Name]

    local plotEggsTracker = localPlayer2:FindFirstChild("PlayerGui")
      and localPlayer2.PlayerGui:FindFirstChild("Main")
      and localPlayer2.PlayerGui.Main:FindFirstChild("PlotEggsTracker")

    local holder = plotEggsTracker and plotEggsTracker:FindFirstChild("Holder")
    local findFirstChild = eggKey and holder and holder:FindFirstChild(eggKey)
    local findFirstChild2 = findFirstChild and findFirstChild:FindFirstChild("Open", true)
    local findFirstChild3 = findFirstChild and findFirstChild:FindFirstChild("TimeLeft", true)

    if findFirstChild2 and findFirstChild2.Visible
      or findFirstChild3 and findFirstChild3.Text
        and string.lower(findFirstChild3.Text):find("ready") ~= nil then
      return {
        isReady = true,
        timeStr = "Ready to Hatch!",
        timeLeft = 0,
        eggKey = eggKey,
      }
    end

    v66 = nil
    isReady = false
    v67 = nil
    v68 = false

    if placeTime and v65 and v65.GrowthTime and v16 and v16.GrowthTimeFor and v19
      and v19.GrowthElapsed then
      pcall(function()
        local v69 = v16.GrowthTimeFor(v65.GrowthTime, weight)
        local v70 = v19.GrowthElapsed(placeTime)
        v66 = math.max(0, v69 - v70)

        if math.clamp(v70 / math.max(v69, 1), 0, 1) >= 1 or v66 <= 0 then
          isReady = true
          v67 = "Ready to Hatch!"
        else
          local v71 = math.floor(v66 / 3600)
          local v72 = math.floor(v66 % 3600 / 60)
          local v73 = math.floor(v66 % 60)

          v67 = v71 > 0 and string.format("%d:%02d:%02d", v71, v72, v73)
            or string.format("%d:%02d", v72, v73)
        end

        v68 = true
      end)
    end

    if not v68 and placeTime and v65 and v65.GrowthTime then
      local getServerTimeNow2 = workspace:GetServerTimeNow()
      local v74 = math.max(0, getServerTimeNow2 - placeTime)
      local v75 = v65.GrowthTime * (weight or 1)
      v66 = math.max(0, v75 - v74)

      if math.clamp(v74 / math.max(v75, 1), 0, 1) >= 1 or v66 <= 0 then
        isReady = true
        v67 = "Ready to Hatch!"
      else
        local v76 = math.floor(v66 / 3600)
        local v77 = math.floor(v66 % 3600 / 60)
        local v78 = math.floor(v66 % 60)

        v67 = v76 > 0 and string.format("%d:%02d:%02d", v76, v77, v78)
          or string.format("%d:%02d", v77, v78)
      end

      v68 = true
    end

    if not v68 then
      if findFirstChild3 and findFirstChild3.Text and findFirstChild3.Text ~= "" then
        v67 = findFirstChild3.Text

        if string.lower(v67):find("ready") then
          isReady = true
          v67 = "Ready to Hatch!"
          v66 = 0
        end

        v68 = true
      else
        local findFirstChild4 = p29:FindFirstChild("HatchingUI", true)

        local timer = findFirstChild4
        timer = findFirstChild4 and findFirstChild4:FindFirstChild("Timer")

        if timer and timer.Text and timer.Text ~= "" then
          v67 = timer.Text

          if string.find(string.lower(tostring(v67)), "ready") then
            isReady = true
            v67 = "Ready to Hatch!"
            v66 = 0
          end

          v68 = true
        else
          v67 = "Incubating..."
        end
      end
    end

    return {
      isReady = isReady,
      timeStr = v67 or "Incubating...",
      timeLeft = v66,
      eggKey = eggKey,
    }
  end
end

local function f26(p30)
  if not p30 or p30 == "" then
    return false
  else
    local v79 = f13()
    local eggs3 = v79 and v79:FindFirstChild("Eggs")

    if eggs3 then
      for index20, value22 in ipairs(eggs3:GetChildren()) do
        local name = value22.Name
        local v80 = f20((f5(name)))[p30] or 0
        local v81 = v62[p30] and v62[p30][name] == true

        if v80 and v80 > 0 or v81 then
          local v82 = f25(value22)
          return true, name, v80, v82 and v82.timeStr or "Incubating..."
        end
      end
    end

    local basket2 = localPlayer2:FindFirstChild("Basket")

    if basket2 then
      for index21, value23 in ipairs(basket2:GetChildren()) do
        local egg = value23:GetAttribute("Egg") or value23.Name
        local v83 = f20((f5(egg)))[p30] or 0
        local v84 = v62[p30] and v62[p30][egg] == true

        if v83 and v83 > 0 or v84 then
          return true, egg, v83, "In Basket"
        end
      end
    end

    local v85 = {}

    if localPlayer2:FindFirstChild("Backpack") then
      for index22, value24 in ipairs(localPlayer2.Backpack:GetChildren()) do
        table.insert(v85, value24)
      end
    end

    if localPlayer2.Character then
      for index23, value25 in ipairs(localPlayer2.Character:GetChildren()) do
        table.insert(v85, value25)
      end
    end

    for index24, value26 in ipairs(v85) do
      if value26:IsA("Tool") and (value26:HasTag("Egg") or string.find(value26.Name, "Egg")) then
        local match3 = value26.Name:match("^(.-) %[") or value26.Name
        local v86 = f20((f5(match3)))[p30] or 0
        local v87 = v62[p30] and v62[p30][match3] == true

        if v86 and v86 > 0 or v87 then
          return true, match3, v86, "In Backpack"
        end
      end
    end

    return false
  end
end

local function f27()
  local savedData2 = localPlayer2:FindFirstChild("SavedData")

  local value27 = savedData2 and savedData2:FindFirstChild("Rebirths")
    and savedData2.Rebirths.Value

  local value28 = savedData2
  local v88 = value27 or 0

  if savedData2 then
    value28 = savedData2:FindFirstChild("Cash") and savedData2.Cash.Value
  end

  local v89 = value28 or 0
  local cap = v15 and v15.Cap or 6
  local v90 = v88 >= cap
  local v91 = v88 + 1
  local v92 = 1000000

  if v15 and v15.RiggedCost and v15.RiggedCost[v91] then
    v92 = v15.RiggedCost[v91]
  end

  local text = ""

  local rebirth2 = localPlayer2:FindFirstChild("PlayerGui")
    and localPlayer2.PlayerGui:FindFirstChild("Main")
    and localPlayer2.PlayerGui.Main:FindFirstChild("Rebirth")

  if rebirth2 then
    local findFirstChild5 = rebirth2:FindFirstChild("Segment2", true)

    local findFirstChild6 = findFirstChild5
    findFirstChild6 = findFirstChild5 and findFirstChild5:FindFirstChild("pEThOLDER", true)

    local findFirstChild7 = findFirstChild6
    findFirstChild7 = findFirstChild6 and findFirstChild6:FindFirstChild("PetName", true)

    if findFirstChild7 and findFirstChild7.Text and findFirstChild7.Text ~= ""
      and findFirstChild7.Text ~= "PetName" then
      text = findFirstChild7.Text
    end
  end

  local v93 = { "Horse", "Fox", "Unicorn", "Phoenix", "Kitsune", "Dragon" }

  if text == "" and v91 <= #v93 then
    text = v93[v91]
  end

  local v94 = false
  local petLoc = "N/A"

  if text ~= "" then
    v94, petLoc = f24(text)
  end

  local isIncubating = false
  local incubatingOdds = 0
  local incubatingTime, incubatingEggName

  if text ~= "" and not v94 then
    isIncubating, incubatingEggName, incubatingOdds, incubatingTime = f26(text)
  end

  local canRebirth = not v90 and v94 and v89 >= v92

  return {
    currentRebirth = v88,
    nextTier = v91,
    maxCap = cap,
    isMaxCap = v90,
    currentCash = v89,
    reqCash = v92,
    hasCash = v89 >= v92,
    reqPet = text,
    hasPet = v94,
    petLoc = petLoc,
    isIncubating = isIncubating,
    incubatingEggName = incubatingEggName,
    incubatingOdds = incubatingOdds,
    incubatingTime = incubatingTime,
    canRebirth = canRebirth,
  }
end

local function f28()
  local v95 = f27()

  if not v95.canRebirth or v95.isMaxCap then
    return false
  end

  if rebirth then
    rebirth:FireServer()
  end

  pcall(function()
    local rebirth3 = localPlayer2.PlayerGui.Main.Rebirth.Rebirth

    if getconnections then
      for key3, value29 in pairs(getconnections(rebirth3.Activated)) do
        value29:Fire()
      end
    end
  end)

  return true
end

runService.Stepped:Connect(function()
  if crownHubState.NoClip or v35.IsFarming or v35.CurrentTween ~= nil then
    local character5 = localPlayer2.Character

    if character5 then
      for index25, value30 in ipairs(character5:GetDescendants()) do
        if value30:IsA("BasePart") then
          if value30.CanCollide then
            value30.CanCollide = false
          end

          if v35.CurrentTween ~= nil then
            value30.AssemblyLinearVelocity = Vector3.zero
            value30.AssemblyAngularVelocity = Vector3.zero
          end
        end
      end
    end
  end
end)

userInputService.JumpRequest:Connect(function()
  if crownHubState.InfiniteJump then
    local v96, v97, v98 = f12()

    if v98 then
      v98:ChangeState(Enum.HumanoidStateType.Jumping)
    end
  end
end)

runService.RenderStepped:Connect(function()
  if crownHubState.SpeedModEnabled and crownHubState.SpeedMultiplier > 1 then
    local v99, v100, v101 = f12()

    if v101 then
      v101.WalkSpeed = 92 * crownHubState.SpeedMultiplier
    end
  end
end)

local v102 = {}
local v103 = {}

local function f29(p31)
  local v104 = v102[p31]

  if v104 then
    if v104.Billboard and v104.Billboard.Parent then
      v104.Billboard:Destroy()
    end

    if v104.Highlight then
      pcall(function() v104.Highlight:Destroy() end)
    end

    if v104.Tracer then
      pcall(function()
        v104.Tracer.Visible = false
        v104.Tracer:Remove()
      end)
    end

    v102[p31] = nil
  end

  local crownEggESP2

  if p31 and p31.Parent then
    crownEggESP2 = p31:FindFirstChild("CrownEggESP")

    if crownEggESP2 then
      pcall(function() crownEggESP2:Destroy() end)
    end

    local crownEggTag2 = p31:FindFirstChild("CrownEggTag")

    if crownEggTag2 then
      pcall(function() crownEggTag2:Destroy() end)
    end
  end
end

local function f30()
  for key4, value31 in pairs(v102) do
    f29(key4)
  end

  local renderedEggs2 = workspaceService:FindFirstChild("RenderedEggs")

  if renderedEggs2 then
    for index26, value32 in ipairs(renderedEggs2:GetChildren()) do
      local crownEggESP3 = value32:FindFirstChild("CrownEggESP")

      if crownEggESP3 then
        pcall(function() crownEggESP3:Destroy() end)
      end

      local crownEggTag3 = value32:FindFirstChild("CrownEggTag")

      if crownEggTag3 then
        pcall(function() crownEggTag3:Destroy() end)
      end
    end
  end

  for index27, value33 in ipairs(v103) do
    local v105 = value33

    pcall(function()
      v105.Visible = false
      v105:Remove()
    end)
  end

  table.clear(v103)
  table.clear(v102)
end

local v106 = setmetatable({}, { __mode = "k" })

local function f31(p32)
  local v107

  if not p32 then
    return 0
  else
    local v108 = v106[p32]

    if v108 ~= nil then
      return v108
    else
      local position4 = p32:GetPivot().Position
      local activeEggs2 = (replicatedStorage:FindFirstChild("ServerData") or replicatedStorage):FindFirstChild("ActiveEggs")

      if activeEggs2 then
        for index28, value34 in ipairs(activeEggs2:GetChildren()) do
          local position5 = value34:GetAttribute("Position")

          if position5 and (position5 - position4).Magnitude < 10 then
            v107 = tonumber(value34:GetAttribute("Weight")) or 0
            local v109 = v107

            if v16 and v16.ShownEggKG then
              local v110, v111 = pcall(function() return v16.ShownEggKG(v107) end)

              if v110 and type(v111) == "number" then
                v109 = v111
              end
            end

            local v112 = math.floor(v109 * 10 + 0.5) / 10
            v106[p32] = v112
            return v112, value34
          end
        end

        v106[p32] = 0
        return 0, nil
      end

      v106[p32] = 0
      return 0, nil
    end
  end
end

-- ============================================================
-- ZRHUB ESP renderer (rewritten: highlight / floating text / tracer)
-- ============================================================
do
  local ESP_COLORS = {
    Ethereal = Color3.fromRGB(255, 60, 255),
    Divine = Color3.fromRGB(0, 240, 255),
    Mythic = Color3.fromRGB(255, 50, 50),
    Legendary = Color3.fromRGB(255, 190, 0),
    Epic = Color3.fromRGB(180, 70, 255),
    Rare = Color3.fromRGB(60, 150, 255),
    Common = Color3.fromRGB(190, 190, 190),
    Unknown = Color3.fromRGB(255, 255, 255),
  }

  -- Roblox renders at most ~31 Highlights at once, so keep a safe cap
  -- and give the slots to the rarest / closest eggs first.
  local HIGHLIGHT_LIMIT = 22

  local function espMinWeight()
    local setting = tostring(crownHubState.ESP_MinRarity or "All Eggs")
    local word = setting:match("^(%a+)")

    if not word or word == "All" then
      return 0
    end

    return v20[word] or 0
  end

  local function espAnchor(model)
    if model:IsA("BasePart") then
      return model
    end

    return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
  end

  local function espNewTracer()
    local ok, line = pcall(function()
      local drawing = Drawing.new("Line")
      drawing.Thickness = 1
      drawing.Transparency = 1
      drawing.Visible = false
      return drawing
    end)

    if ok then
      return line
    end

    return nil
  end

  local function espBuildBillboard(model)
    local anchor = espAnchor(model)

    if not anchor then
      return nil
    end

    local gui = Instance.new("BillboardGui")
    gui.Name = "CrownEggTag"
    gui.Adornee = anchor
    gui.AlwaysOnTop = true
    gui.Size = UDim2.fromOffset(300, 36)
    gui.StudsOffset = Vector3.new(0, 3.4, 0)
    gui.MaxDistance = math.huge
    gui.ResetOnSpawn = false

    -- Obsidian-style tag: dark box, grey outline, rarity colour bar on the left
    local box = Instance.new("Frame")
    box.Name = "Box"
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.Position = UDim2.fromScale(0.5, 0.5)
    box.AutomaticSize = Enum.AutomaticSize.X
    box.Size = UDim2.fromOffset(0, 26)
    box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    box.BackgroundTransparency = 0.1
    box.BorderSizePixel = 0
    box.Parent = gui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = box
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = box

    local bar = Instance.new("Frame")
    bar.Name = "Bar"
    bar.BorderSizePixel = 0
    bar.Size = UDim2.new(0, 3, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(125, 85, 255)
    bar.Parent = box

    local label = Instance.new("TextLabel")
    label.Name = "Info"
    label.BackgroundTransparency = 1
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Position = UDim2.fromOffset(9, 0)
    label.Size = UDim2.fromOffset(0, 26)
    label.RichText = true
    label.Font = Enum.Font.Code
    label.TextSize = 13
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.6
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextWrapped = false
    label.TextTruncate = Enum.TextTruncate.None
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = box

    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 9)
    pad.Parent = box

    gui.Parent = model
    return gui, label
  end

  local function espRefreshText(entry, model, rarity, color, dist)
    if not entry.Label then
      return
    end

    local now = os.clock()

    if not entry.NextInfo or now >= entry.NextInfo then
      entry.NextInfo = now + 2
      local okW, weight = pcall(f31, model)
      local okM, mutation = pcall(f9, model)
      entry.Weight = okW and tonumber(weight) or 0
      entry.Mutation = okM and mutation or nil
    end

    local extra = {}

    if entry.Weight and entry.Weight > 0 then
      table.insert(extra, string.format("%.1fkg", entry.Weight))
    end

    if entry.Mutation and entry.Mutation ~= "" then
      table.insert(extra, tostring(entry.Mutation))
    end

    table.insert(extra, string.format("%d studs", math.floor(dist)))

    entry.Label.Text = string.format(
      '<font color="#%s">%s</font> <font color="#FFFFFF">[%s]</font>  <font color="#A0A0A0" size="11">%s</font>',
      color:ToHex(), model.Name, rarity, table.concat(extra, " · ")
    )
    pcall(function()
      local box = entry.Label.Parent
      local bar = box and box:FindFirstChild("Bar")
      if bar then bar.BackgroundColor3 = color end
    end)

  end

  local function espHideAll()
    if next(v102) ~= nil then
      f30()
    end
  end

  task.spawn(function()
    local warned = false

    while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
      task.wait(0.2)

      local ok, err = pcall(function()
        local folder = workspaceService:FindFirstChild("RenderedEggs")

        if not crownHubState.ESP_Enabled or not folder then
          espHideAll()
          return
        end

        local _, root = f12()
        local camera = workspaceService.CurrentCamera
        local origin = root and root.Position or (camera and camera.CFrame.Position)

        if not origin then
          return
        end

        local maxDist = tonumber(crownHubState.ESP_MaxDistance) or 5000
        local minWeight = espMinWeight()
        local wantHighlight = crownHubState.ESP_Highlights == true
        local wantBillboard = crownHubState.ESP_Billboards == true
        local wantTracer = crownHubState.ESP_Tracers == true
        local candidates = {}

        for _, egg in ipairs(folder:GetChildren()) do
          local okPos, pos = pcall(function() return egg:GetPivot().Position end)

          if okPos and pos then
            local rarity = f4(egg.Name) or "Unknown"
            local weight = v20[rarity] or 0
            local dist = (pos - origin).Magnitude

            if dist <= maxDist and weight >= minWeight then
              table.insert(candidates, {
                Egg = egg, Rarity = rarity, Weight = weight, Dist = dist,
              })
            end
          end
        end

        table.sort(candidates, function(a, b)
          if a.Weight ~= b.Weight then
            return a.Weight > b.Weight
          end

          return a.Dist < b.Dist
        end)

        local alive = {}

        for index, c in ipairs(candidates) do
          local egg = c.Egg
          local color = ESP_COLORS[c.Rarity] or ESP_COLORS.Unknown
          local entry = v102[egg]

          if not entry then
            entry = {}
            v102[egg] = entry
          end

          alive[egg] = true
          entry.Color = color

          -- Highlight (clear fill + white outline, always on top)
          if wantHighlight and index <= HIGHLIGHT_LIMIT then
            if not (entry.Highlight and entry.Highlight.Parent) then
              local old = egg:FindFirstChild("CrownEggESP")

              if old then
                pcall(function() old:Destroy() end)
              end

              local highlight = Instance.new("Highlight")
              highlight.Name = "CrownEggESP"
              highlight.Adornee = egg
              highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
              highlight.OutlineTransparency = 0
              highlight.OutlineColor = Color3.new(1, 1, 1)
              highlight.FillTransparency = 0.6
              highlight.Parent = egg
              entry.Highlight = highlight
            end

            entry.Highlight.FillColor = color
            entry.Highlight.Enabled = true
          elseif entry.Highlight then
            pcall(function() entry.Highlight:Destroy() end)
            entry.Highlight = nil
          end

          -- Floating text
          if wantBillboard then
            if not (entry.Billboard and entry.Billboard.Parent) then
              local gui, label = espBuildBillboard(egg)
              entry.Billboard = gui
              entry.Gui = gui
              entry.Label = label
              entry.NextInfo = nil
            end

            if entry.Billboard then
              espRefreshText(entry, egg, c.Rarity, color, c.Dist)
            end
          elseif entry.Billboard then
            pcall(function() entry.Billboard:Destroy() end)
            entry.Billboard = nil
            entry.Label = nil
          end

          -- Tracer (needs Drawing API)
          if wantTracer then
            if not entry.Tracer then
              entry.Tracer = espNewTracer()
            end
          elseif entry.Tracer then
            pcall(function()
              entry.Tracer.Visible = false
              entry.Tracer:Remove()
            end)
            entry.Tracer = nil
          end
        end

        for egg in pairs(v102) do
          if not alive[egg] then
            f29(egg)
          end
        end
      end)

      if not ok and not warned then
        warned = true
        warn("[ZRHUB ESP] " .. tostring(err))
      end
    end
  end)

  -- per-frame work: tracer lines + highlight pulse
  local espFrame = runService.RenderStepped:Connect(function()
    if _G.CrownHubInstanceId ~= crownHubInstanceId or next(v102) == nil then
      return
    end

    local camera = workspaceService.CurrentCamera

    if not camera then
      return
    end

    local viewport = camera.ViewportSize
    local from = Vector2.new(viewport.X / 2, viewport.Y)
    local pulse = 0.3 + 0.18 * math.sin(os.clock() * 4)

    for egg, entry in pairs(v102) do
      if entry.Highlight and entry.Highlight.Parent then
        entry.Highlight.FillTransparency = pulse
      end

      local tracer = entry.Tracer

      if tracer then
        local shown = false

        if egg.Parent then
          local okPos, pos = pcall(function() return egg:GetPivot().Position end)

          if okPos then
            local screen, onScreen = camera:WorldToViewportPoint(pos)

            if onScreen and screen.Z > 0 then
              tracer.From = from
              tracer.To = Vector2.new(screen.X, screen.Y)
              tracer.Color = entry.Color or Color3.new(1, 1, 1)
              tracer.Visible = true
              shown = true
            end
          end
        end

        if not shown then
          tracer.Visible = false
        end
      end
    end
  end)

  table.insert(_G.CrownHubConnections, espFrame)
end

local f32

local function f33()
  local renderedEggs4 = workspaceService:FindFirstChild("RenderedEggs")
  local gsub

  if not renderedEggs4 then
    return nil
  else
    local v113, v114 = f12()

    if not v114 then
      return nil
    else
      gsub = nil

      if crownHubState.TargetSpecificEgg
        and crownHubState.TargetSpecificEgg ~= "Any Egg (Use Rarity Filter)" then
        gsub = crownHubState.TargetSpecificEgg:gsub("%s*%[.-%]", "")
      end

      local function f34(p33, p34)
        if gsub and gsub ~= "" then
          return p33 == gsub
        end

        return crownHubState.AllowedRarities and crownHubState.AllowedRarities[p34] == true
      end

      if crownHubState.AutoFarm and crownHubState.PrioritizeMutations then
        local v115 = {}

        for index30, value36 in ipairs(renderedEggs4:GetChildren()) do
          local name2 = value36.Name
          local v116 = f4(name2)

          if f34(name2, v116) then
            local v117 = f9(value36)

            if v117 and f7(v117) then
              local v118 = f32(value36)

              if v118 then
                local v119 = f31(value36)
                local v120 = true

                if crownHubState.MinEggWeight and crownHubState.MinEggWeight > 0 and v119 > 0
                  and v119 < crownHubState.MinEggWeight then
                  v120 = false
                end

                if v120 then
                  local getPivot = value36:GetPivot()

                  table.insert(v115, {
                    Model = value36,
                    Name = name2,
                    Rarity = v116,
                    Prompt = v118,
                    Position = getPivot.Position,
                    Distance = (getPivot.Position - v114.Position).Magnitude,
                    Luck = f5(name2),
                    Weight = v20[v116] or 0,
                    EggWeight = v119,
                    Mutation = v117,
                    MutationWeight = v24[v117] or 1000,
                  })
                end
              end
            end
          end
        end

        if #v115 > 0 then
          table.sort(v115, function(p35, p36)
            if p35.MutationWeight ~= p36.MutationWeight then
              return p35.MutationWeight > p36.MutationWeight
            elseif p35.Weight ~= p36.Weight then
              return p35.Weight > p36.Weight
            else
              if crownHubState.PrioritizeHeaviest
                and math.abs(p35.EggWeight - p36.EggWeight) > 0.05 then
                return p35.EggWeight > p36.EggWeight
              end

              return p35.Distance < p36.Distance
            end
          end)

          return v115[1]
        end
      end

      if crownHubState.AutoFarm and crownHubState.WeatherEggWait then
        local v121 = f6()

        if v121 and v121.Variant then
          local v122 = v26[v121.Variant]

          if not v122 or f7(v122) then
            local getServerTimeNow3 = workspaceService:GetServerTimeNow()

            local v123 = v121.EndsAt
                and math.max(0, math.floor(v121.EndsAt - getServerTimeNow3))
              or 0

            if v123 > 0 then
              local v124 = false

              for index31, value37 in ipairs(renderedEggs4:GetChildren()) do
                local name3 = value37.Name

                if f34(name3, (f4(name3))) then
                  v124 = true
                  break
                end
              end

              if v124 then
                return {
                  IsWaitingWeather = true,
                  StormVariant = v121.Variant,
                  MutationType = v122 or "Mutation",
                  TimeLeft = v123,
                }
              end
            end
          end
        end
      end

      local allowedRarities = crownHubState.AllowedRarities

      local v125 = allowedRarities
      v125 = allowedRarities and crownHubState.AllowedRarities.Ethereal == true

      local v126 = v125
      v126 = v125 or gsub and f4(gsub) == "Ethereal"

      if crownHubState.AutoFarm and v126 then
        local v127 = {}

        for index32, value38 in ipairs(renderedEggs4:GetChildren()) do
          local name4 = value38.Name
          local v128 = f4(name4)

          if v128 == "Ethereal" and f34(name4, v128) then
            local v129 = f32(value38)

            if v129 then
              local v130 = f31(value38)
              local v131 = true

              if crownHubState.MinEggWeight and crownHubState.MinEggWeight > 0 and v130 > 0
                and v130 < crownHubState.MinEggWeight then
                v131 = false
              end

              if v131 then
                local getPivot2 = value38:GetPivot()

                table.insert(v127, {
                  Model = value38,
                  Name = name4,
                  Rarity = v128,
                  Prompt = v129,
                  Position = getPivot2.Position,
                  Distance = (getPivot2.Position - v114.Position).Magnitude,
                  Luck = f5(name4),
                  Weight = v20[v128] or 1000,
                  EggWeight = v130,
                })
              end
            end
          end
        end

        if #v127 > 0 then
          if crownHubState.PrioritizeHeaviest then
            table.sort(v127, function(p37, p38)
              if math.abs(p37.EggWeight - p38.EggWeight) > 0.05 then
                return p37.EggWeight > p38.EggWeight
              end

              return p37.Distance < p38.Distance
            end)
          else
            table.sort(v127, function(p39, p40) return p39.Distance < p40.Distance end)
          end

          return v127[1]
        end
      end

      if crownHubState.AutoRebirth and crownHubState.PrioritizeRebirthPet then
        local v132 = f27()

        if v132 and not v132.isMaxCap and not v132.hasPet and v132.reqPet and v132.reqPet ~= "" then
          if not v132.isIncubating then
            local v133 = {}

            for index33, value39 in ipairs(renderedEggs4:GetChildren()) do
              local v134 = f32(value39)

              if v134 then
                local name5 = value39.Name
                local v135 = f5(name5)
                local v136 = false
                local v137 = f20(v135)[v132.reqPet] or 0

                if v62[v132.reqPet] and v62[v132.reqPet][name5] then
                  v136 = true
                end

                if v137 > 0 or v136 then
                  local getPivot3 = value39:GetPivot()
                  local v138 = f4(name5)

                  table.insert(v133, {
                    Model = value39,
                    Name = name5,
                    Rarity = v138,
                    Prompt = v134,
                    Position = getPivot3.Position,
                    Distance = (getPivot3.Position - v114.Position).Magnitude,
                    Luck = v135,
                    Weight = v20[v138] or 0,
                    PetChance = v137,
                    IsFallback = v136,
                  })
                end
              end
            end

            if #v133 > 0 then
              table.sort(v133, function(p41, p42)
                if math.abs(p41.PetChance - p42.PetChance) > 1e-7 then
                  return p41.PetChance > p42.PetChance
                end

                if p41.IsFallback ~= p42.IsFallback then
                  return p41.IsFallback == true
                end

                return p41.Distance < p42.Distance
              end)

              local v139 = v133[1]

              v35.RebirthTargetPet = v132.reqPet
              v35.RebirthEggName = v139.Name
              v35.RebirthEggChance = v139.PetChance

              return v139
            end
          end
        end
      end

      if not crownHubState.AutoFarm then
        return nil
      else
        local v140 = {}

        for index34, value40 in ipairs(renderedEggs4:GetChildren()) do
          local name6 = value40.Name
          local v141 = f4(name6)

          if f34(name6, v141) then
            local v142 = f32(value40)

            if v142 then
              local v143 = f31(value40)
              local v144 = true

              if crownHubState.MinEggWeight and crownHubState.MinEggWeight > 0 and v143 > 0
                and v143 < crownHubState.MinEggWeight then
                v144 = false
              end

              if v144 then
                local getPivot4 = value40:GetPivot()
                local luck = f5(name6)

                table.insert(v140, {
                  Model = value40,
                  Name = name6,
                  Rarity = v141,
                  Prompt = v142,
                  Position = getPivot4.Position,
                  Distance = (getPivot4.Position - v114.Position).Magnitude,
                  Luck = luck,
                  Weight = v20[v141] or 0,
                  EggWeight = v143,
                })
              end
            end
          end
        end

        if #v140 == 0 then
          return nil
        else
          local farmPriority = crownHubState.FarmPriority

          local priorityRarity = farmPriority

          priorityRarity = farmPriority
            or crownHubState.PriorityRarity and "Highest Rarity First"
            or "Closest Distance First"

          if priorityRarity == "Heaviest Weight First" then
            table.sort(v140, function(p43, p44)
              if math.abs(p43.EggWeight - p44.EggWeight) > 0.05 then
                return p43.EggWeight > p44.EggWeight
              end

              if p43.Weight ~= p44.Weight then
                return p43.Weight > p44.Weight
              end

              return p43.Distance < p44.Distance
            end)
          elseif priorityRarity == "Highest Rarity First" then
            table.sort(v140, function(p45, p46)
              if p45.Weight ~= p46.Weight then
                return p45.Weight > p46.Weight
              end

              if crownHubState.PrioritizeHeaviest
                and math.abs(p45.EggWeight - p46.EggWeight) > 0.05 then
                return p45.EggWeight > p46.EggWeight
              end

              return p45.Distance < p46.Distance
            end)
          elseif priorityRarity == "Closest Distance First" then
            table.sort(v140, function(p47, p48)
              if crownHubState.PrioritizeHeaviest
                and math.abs(p47.EggWeight - p48.EggWeight) > 0.05 then
                return p47.EggWeight > p48.EggWeight
              end

              if p47.Distance ~= p48.Distance then
                return p47.Distance < p48.Distance
              end

              return p47.Weight > p48.Weight
            end)
          elseif priorityRarity == "Highest Luck First" then
            table.sort(v140, function(p49, p50)
              if p49.Luck ~= p50.Luck then
                return p49.Luck > p50.Luck
              end

              if crownHubState.PrioritizeHeaviest
                and math.abs(p49.EggWeight - p50.EggWeight) > 0.05 then
                return p49.EggWeight > p50.EggWeight
              end

              return p49.Distance < p50.Distance
            end)
          else
            table.sort(v140, function(p51, p52) return p51.Distance < p52.Distance end)
          end

          return v140[1]
        end
      end
    end
  end
end

function f32(p53)
  return p53:FindFirstChildWhichIsA("ProximityPrompt", true)
end

local function f35(p54, p55)
  local crownFlightStabilizer2 = p54:FindFirstChild("CrownFlightStabilizer")

  if not crownFlightStabilizer2 then
    crownFlightStabilizer2 = Instance.new("BodyVelocity")
    crownFlightStabilizer2.Name = "CrownFlightStabilizer"
    crownFlightStabilizer2.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
    crownFlightStabilizer2.Velocity = Vector3.zero
    crownFlightStabilizer2.Parent = p54
  end

  if p55 then
    p55.PlatformStand = true
  end

  if p54 then
    p54.AssemblyLinearVelocity = Vector3.zero
    p54.AssemblyAngularVelocity = Vector3.zero
  end

  return crownFlightStabilizer2
end

local function f36(p56, p57)
  local v145 = p57 or p56 and f32(p56)

  pcall(function()
    if v145 and v145:IsA("ProximityPrompt") then
      v145.HoldDuration = 0

      if fireproximityprompt then
        fireproximityprompt(v145, 0)
      else
        v145:InputHoldBegin()
        task.wait(0.05)
        v145:InputHoldEnd()
      end
    end
  end)

  pcall(function()
    if eggPickup and p56 then
      local activeEggs3 = replicatedStorage:FindFirstChild("ServerData")
          and replicatedStorage.ServerData:FindFirstChild("ActiveEggs")
        or replicatedStorage:FindFirstChild("ActiveEggs")

      if activeEggs3 then
        local getPivot5 = p56:GetPivot()
        local v146 = nil
        local v147 = 25

        for index35, value41 in ipairs(activeEggs3:GetChildren()) do
          local position6 = value41:GetAttribute("Position")

          if position6 then
            local magnitude = (position6 - getPivot5.Position).Magnitude

            if magnitude < v147 then
              v147 = magnitude
              v146 = value41
            end
          end
        end

        if v146 then
          eggPickup:FireServer(v146.Name)
        end
      end
    end
  end)
end


-- =====================================================================
-- Skyhawk-style movement (ported from the Skyhawk script's Tween)
-- Instant steal: teleport, eggs staged outside plot first,
--                 re-picked, and only then carried into the plot
-- Everything lives in ONE table so it only costs one top-level local.
-- =====================================================================
local skyMove = {}

do
  local CRUISE_HEIGHT = 45
  local OVER_HEIGHT = 250
  local VOID_DEPTH = 110
  local savedCollide = {}

  -- shared flight speed (egg run + return to plot), always read live
  local function currentSpeed()
    return math.clamp(tonumber(crownHubState.TweenSpeed) or 1250, 20, 10000)
  end

  local function root()
    local character = localPlayer2.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if hrp and hrp:IsDescendantOf(workspaceService) then
      return hrp
    end
    return nil
  end

  local function setNoclip(on)
    local character = localPlayer2.Character
    if not character then
      return
    end

    for _, part in ipairs(character:GetDescendants()) do
      if part:IsA("BasePart") then
        if on then
          if savedCollide[part] == nil then
            savedCollide[part] = part.CanCollide
          end
          part.CanCollide = false
        elseif savedCollide[part] ~= nil then
          part.CanCollide = savedCollide[part]
        end
      end
    end

    if not on then
      table.clear(savedCollide)
    end
  end

  local function route(from, to, opts)
    if Vector3.new(to.X - from.X, 0, to.Z - from.Z).Magnitude < 80 and math.abs(to.Y - from.Y) < 30 then
      return { to }
    end

    if opts and opts.Void then
      local voidY = math.min(from.Y, to.Y) - VOID_DEPTH
      voidY = math.max(voidY, workspaceService.FallenPartsDestroyHeight + 60)
      return {
        Vector3.new(from.X, voidY, from.Z),
        Vector3.new(to.X, voidY, to.Z),
        to,
      }
    end

    local cruise = (opts and opts.Over) and OVER_HEIGHT or CRUISE_HEIGHT
    local y = math.max(from.Y, to.Y) + cruise
    return { Vector3.new(from.X, y, from.Z), Vector3.new(to.X, y, to.Z), to }
  end

  local function noclipConnection()
    return runService.Stepped:Connect(function()
      local character = localPlayer2.Character
      if not character then
        return
      end

      for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
          part.CanCollide = false
        end
      end
    end)
  end

  -- approach dropdown -> route options (same as Skyhawk's RouteOpts)
  function skyMove.RouteOpts()
    if crownHubState.StealApproach == "Under Map" then
      return { Void = true }
    elseif crownHubState.StealApproach == "Over Map" then
      return { Over = true }
    end
    return nil
  end

  -- Skyhawk FlyTo: waypoint flight stepped on Heartbeat
  function skyMove.FlyTo(target, cancelFn, arriveDist, opts)
    local hrp = root()
    if not hrp or typeof(target) ~= "Vector3" then
      return false
    end

    local arrive = arriveDist or 3
    if (hrp.Position - target).Magnitude <= arrive then
      return true
    end

    local startPosition = hrp.Position
    local waypoints = route(hrp.Position, target, opts)

    local total, last = 0, hrp.Position
    for _, wp in ipairs(waypoints) do
      total = total + (wp - last).Magnitude
      last = wp
    end

    -- The speed slider is read live every frame (currentSpeed), so the time
    -- budget cannot be a fixed deadline from the starting speed. Instead:
    --   * hard cap based on the slowest possible speed, and
    --   * a stall check (no progress for 3s -> give up).
    local startedAt = os.clock()
    local hardCap = total / 20 + 10
    local lastProgress = os.clock()
    local bestMag = math.huge
    local lastIndex = 1

    -- token keeps v35.CurrentTween compatible (Cancel(), NoClip loop, etc.)
    local token = { Cancelled = false }
    function token:Cancel()
      self.Cancelled = true
    end
    v35.CurrentTween = token

    setNoclip(true)
    local noclipConn = noclipConnection()

    local index = 1
    local arrived = false

    while os.clock() - startedAt < hardCap do
      if token.Cancelled or (cancelFn and cancelFn()) then
        break
      end

      local dt = runService.Heartbeat:Wait()
      hrp = root()
      if not hrp then
        break
      end

      local isLast = index == #waypoints
      local delta = waypoints[index] - hrp.Position
      local mag = delta.Magnitude

      if index ~= lastIndex then
        lastIndex = index
        bestMag = math.huge
      end
      if mag < bestMag - 0.5 then
        bestMag = mag
        lastProgress = os.clock()
      end
      if os.clock() - lastProgress > 3 then
        break
      end

      if mag <= (isLast and arrive or 2) then
        if isLast then
          arrived = true
          break
        end
        index = index + 1
      else
        local step = math.min(mag, currentSpeed() * dt)
        local flat = Vector3.new(delta.X, 0, delta.Z)
        local rotation = flat.Magnitude > 0.1 and CFrame.lookAt(Vector3.zero, flat.Unit)
          or hrp.CFrame.Rotation
        local nextPosition = hrp.Position + delta.Unit * step

        -- big hops: pre-load terrain ahead so we never fall into the void
        if step > 60 then
          pcall(function()
            if typeof(workspaceService.RequestStreamAroundAsync) == "function" then
              workspaceService:RequestStreamAroundAsync(nextPosition, 16)
            end
          end)
        end

        pcall(function()
          hrp.CFrame = CFrame.new(nextPosition) * rotation
          hrp.AssemblyLinearVelocity = Vector3.zero
          hrp.AssemblyAngularVelocity = Vector3.zero
        end)
      end
    end

    hrp = root()

    -- fall-through safety (same anchor-and-reteleport trick as Skyhawk)
    if hrp and hrp.Position.Y < math.min(target.Y, startPosition.Y) - 15 then
      local recoverTo = arrived and target or startPosition
      pcall(function()
        local wasAnchored = hrp.Anchored
        hrp.Anchored = true
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = CFrame.new(recoverTo)
        runService.Heartbeat:Wait()
        hrp.Anchored = wasAnchored
      end)
      hrp = root()
    end

    noclipConn:Disconnect()
    setNoclip(false)
    if v35.CurrentTween == token then
      v35.CurrentTween = nil
    end

    hrp = root()
    if hrp then
      pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
      end)
      if (hrp.Position - target).Magnitude <= arrive + 1 then
        return true
      end
    end

    return arrived
  end

  -- Skyhawk InstantFlyTo: teleport, stay anchored while terrain streams in
  function skyMove.InstantFlyTo(target, cancelFn, arriveDist)
    local hrp = root()
    if not hrp or typeof(target) ~= "Vector3" then
      return false
    end

    local arrive = arriveDist or 3
    if (hrp.Position - target).Magnitude <= arrive then
      return true
    end
    if cancelFn and cancelFn() then
      return false
    end

    if v35.CurrentTween then
      pcall(function() v35.CurrentTween:Cancel() end)
      v35.CurrentTween = nil
    end

    setNoclip(true)
    local noclipConn = noclipConnection()
    local wasAnchored = hrp.Anchored

    local function teleportTo(position)
      local r = root()
      if not r then
        return
      end
      pcall(function()
        r.Anchored = true
        r.AssemblyLinearVelocity = Vector3.zero
        r.AssemblyAngularVelocity = Vector3.zero
        r.CFrame = CFrame.new(position)
      end)
    end

    teleportTo(target)

    pcall(function()
      if typeof(workspaceService.RequestStreamAroundAsync) == "function" then
        workspaceService:RequestStreamAroundAsync(target, 16)
      end
    end)

    for _ = 1, 5 do
      if cancelFn and cancelFn() then
        break
      end
      runService.Heartbeat:Wait()
    end

    local r = root()
    if r and r.Position.Y < target.Y - 15 then
      teleportTo(target)
      runService.Heartbeat:Wait()
      r = root()
    end

    pcall(function()
      if r then
        r.Anchored = wasAnchored
        r.AssemblyLinearVelocity = Vector3.zero
        r.AssemblyAngularVelocity = Vector3.zero
      end
    end)

    noclipConn:Disconnect()
    setNoclip(false)

    if not r then
      return false
    end
    return (r.Position - target).Magnitude <= arrive + 1
  end

  -- tween by default; "Teleport" keeps the old instant move
  function skyMove.MoveTo(target, cancelFn, arriveDist, opts)
    if crownHubState.StealMovement == "Teleport" then
      return skyMove.InstantFlyTo(target, cancelFn, arriveDist)
    end
    return skyMove.FlyTo(target, cancelFn, arriveDist, opts or skyMove.RouteOpts())
  end

  local function basketCount()
    local basket = localPlayer2:FindFirstChild("Basket")
    return basket and #basket:GetChildren() or 0
  end

  -- point just outside the plot edge (+20 studs), 4 studs above the plot (Skyhawk fn9)
  local function stagingPoint(baseplate, fromPos)
    local topY = baseplate.Position.Y + baseplate.Size.Y / 2
    local rel = baseplate.CFrame:PointToObjectSpace(fromPos)
    local flat = Vector3.new(rel.X, 0, rel.Z)
    if flat.Magnitude < 1 then
      flat = Vector3.new(0, 0, 1)
    end

    local halfX = baseplate.Size.X / 2
    local halfZ = baseplate.Size.Z / 2
    local unit = flat.Unit
    local scaled = unit / math.max(math.abs(unit.X) / (halfX + 20), math.abs(unit.Z) / (halfZ + 20))
    local world = baseplate.CFrame:PointToWorldSpace(Vector3.new(scaled.X, 0, scaled.Z))
    return Vector3.new(world.X, topY + 4, world.Z)
  end

  -- eggs that were dipped / are volcano eggs keep their state: never drop those
  local function canRelay(basket)
    for _, egg in ipairs(basket:GetChildren()) do
      if egg.Name == "Volcanic Egg" or egg:GetAttribute("Egg") == "Volcanic Egg"
        or egg:GetAttribute("VolcanoDipped") == true
        or egg:GetAttribute("Escaping") == true
        or egg:GetAttribute("VolcanoUntil") ~= nil then
        return false
      end

      local mutation = egg:GetAttribute("Mutation")
      if mutation == "Magma" or mutation == "Eternal" then
        return false
      end
    end
    return true
  end

  -- hold at the edge, drop the eggs, re-pick them next to the base
  local function relayAtStage(stagePos, cancelFn)
    local basket = localPlayer2:FindFirstChild("Basket")
    local serverData = replicatedStorage:FindFirstChild("ServerData")
    local active = serverData and serverData:FindFirstChild("ActiveEggs")
      or replicatedStorage:FindFirstChild("ActiveEggs")

    if not basket or not active or not basketDrop or not eggPickup then
      return
    end

    v35.Status = "Re-picking eggs near base"

    local holdUntil = os.clock() + 0.3
    while os.clock() < holdUntil do
      local hrp = root()
      if hrp then
        pcall(function()
          hrp.CFrame = CFrame.new(stagePos) * hrp.CFrame.Rotation
          hrp.AssemblyLinearVelocity = Vector3.zero
        end)
      end
      runService.Heartbeat:Wait()
    end

    if cancelFn and cancelFn() then
      return
    end

    local seen = {}
    for _, child in ipairs(active:GetChildren()) do
      seen[child] = true
    end

    local names = {}
    for _, egg in ipairs(basket:GetChildren()) do
      local name = egg:GetAttribute("Egg")
      if type(name) ~= "string" then
        name = egg.Name
      end
      table.insert(names, name)
    end

    for _, name in ipairs(names) do
      basketDrop:FireServer(name)
    end

    local fresh = {}
    local waitUntil = os.clock() + 3
    while #fresh < #names and os.clock() < waitUntil do
      for _, child in ipairs(active:GetChildren()) do
        if not seen[child] and child:GetAttribute("OriginPosition") ~= nil
          and typeof(child:GetAttribute("Position")) == "Vector3" then
          seen[child] = true
          table.insert(fresh, child)
        end
      end
      runService.Heartbeat:Wait()
    end

    for _, egg in ipairs(fresh) do
      local position = egg:GetAttribute("Position")

      for _ = 1, 3 do
        if egg.Parent == nil then
          break
        end

        if typeof(position) == "Vector3" then
          skyMove.MoveTo(position + Vector3.new(0, 3, 0), nil, 5)
        end

        local before = basketCount()
        eggPickup:FireServer(egg.Name)

        local pickUntil = os.clock() + 1.5
        while basketCount() == before and os.clock() < pickUntil do
          runService.Heartbeat:Wait()
        end

        if basketCount() > before then
          break
        end
      end
    end
  end

  -- carry eggs home:
  --   always -> go to the plot edge, hold, drop + re-pick, THEN enter the plot
  --   (same for Safe Tween and Instant; no distance threshold any more)
  --   exception: "Return to Plot" trips and eggs that must keep their state
  function skyMove.DeliverHome(baseplate, target, pickupPos, reason)
    local cancelFn = function()
      return not (crownHubState.AutoFarm
        or crownHubState.AutoRebirth and crownHubState.PrioritizeRebirthPet)
    end

    local hrp = root()
    if not hrp then
      return
    end

    local basket = localPlayer2:FindFirstChild("Basket")

    local useRelay = reason ~= "Return to Plot"
      and basket and #basket:GetChildren() > 0
      and canRelay(basket)

    if useRelay then
      local stage = stagingPoint(baseplate, hrp.Position)
      v35.Status = "Moving to base edge..."
      skyMove.MoveTo(stage, cancelFn, 4)

      local now = root()
      if now and (now.Position - stage).Magnitude <= 10 and not cancelFn() then
        relayAtStage(stage, cancelFn)
      end

      if basketCount() == 0 then
        return
      end
    end

    v35.Status = "Delivering to Plot..."
    skyMove.MoveTo(target, cancelFn, 4)
  end
end

local f37

local function f38(p58, p59)
  local v148, v149, v150 = f12()

  if not v149 then
    return false, "no_hrp"
  end

  -- tween to the egg (unless Steal Movement is set to Teleport)
  if crownHubState.StealMovement ~= "Teleport" then
    local goal = p58 + Vector3.new(0, 1.8, 0)
    local ok = skyMove.FlyTo(goal, function()
      return not crownHubState.AutoFarm or (p59 ~= nil and p59.Parent == nil)
    end, 4, skyMove.RouteOpts())
    if p59 ~= nil and p59.Parent == nil then
      return false, "despawned"
    end
    return ok, ok and "ok" or "retry"
  end

  local cframe4
  local v152 = p58 - v149.Position

  if v152.Magnitude > 0.05 then
    local vector2 = Vector3.new(v152.X, 0, v152.Z)

    if vector2.Magnitude > 0.05 then
      cframe4 = CFrame.lookAt(
        p58 + Vector3.new(0, 1.8, 0), p58 + Vector3.new(0, 1.8, 0) + vector2.Unit
      )
    else
      cframe4 = CFrame.new(p58 + Vector3.new(0, 1.8, 0))
    end
  else
    cframe4 = CFrame.new(p58 + Vector3.new(0, 1.8, 0))
  end

  v149.AssemblyLinearVelocity = Vector3.zero
  v149.AssemblyAngularVelocity = Vector3.zero
  v149.CFrame = cframe4

  return true, "ok"
end

function f37(p60, p61)
  local crownFlightStabilizer3 = p60:FindFirstChild("CrownFlightStabilizer")

  if crownFlightStabilizer3 then
    crownFlightStabilizer3:Destroy()
  end

  if p61 then
    p61.PlatformStand = false
    p61:ChangeState(Enum.HumanoidStateType.GettingUp)
  end

  if p60 then
    p60.AssemblyLinearVelocity = Vector3.zero
    p60.AssemblyAngularVelocity = Vector3.zero
  end
end

local f39

local function f40(p62)
  local v155, v156, v157 = f12()
  local pickupPos = v156 and v156.Position
  local v158 = f13()
  local v159 = not v158 or not v156 or not v157
  local cframe5, v160, connect3

  if v159 then
    return
  else
    local baseplate = v158:FindFirstChild("Baseplate")

    if not baseplate then
      return
    else
      f23(v156, v157)
      local v161, v162, v163 = f12()

      if not v162 or not v163 then
        return
      else
        if crownHubState.AutoMagmaDip and not v35.IsMagmaDipping and p62 ~= "Return to Plot" then
          v35.IsMagmaDipping = true
          f39(p62)
          v35.IsMagmaDipping = false
          local v164 = { f12() }
          v162 = v164[2]
          local v165 = not v162
          v163 = v164[3]

          if v165 or not v163 then
            return
          end
        end

        v35.Status = "Delivering to Plot..."
        local v166 = baseplate.Position + Vector3.new(0, 3.5, 0)
        local magnitude4 = (v166 - v162.Position).Magnitude

        if magnitude4 > 15 then
          skyMove.DeliverHome(baseplate, v166, pickupPos, p62)

          local v167, v168, v169 = f12()

          if not v168 then
            return
          end

          v162, v163 = v168, v169
        end

        if firetouchinterest then
          pcall(firetouchinterest, v162, baseplate, 0)
          task.wait(0.04)
          pcall(firetouchinterest, v162, baseplate, 1)
        end

        local v173 = os.clock()

        while os.clock() - v173 < 1.5 do
          local basket3 = localPlayer2:FindFirstChild("Basket")

          if not basket3 or #basket3:GetChildren() == 0 then
            break
          end

          if firetouchinterest then
            pcall(firetouchinterest, v162, baseplate, 0)
            task.wait(0.03)
            pcall(firetouchinterest, v162, baseplate, 1)
          end

          task.wait(0.05)
        end

        if crownHubState.AutoHatchPlot then
          local eggs4 = v158:FindFirstChild("Eggs")

          if eggs4 then
            for index36, value42 in ipairs(eggs4:GetChildren()) do
              local findFirstChild8 = value42:FindFirstChild("Hatch", true)
                or value42:FindFirstChildWhichIsA("ProximityPrompt", true)

              if findFirstChild8 and findFirstChild8:IsA("ProximityPrompt")
                and findFirstChild8.Enabled then
                v35.Status = "Hatching " .. value42.Name .. "..."
                findFirstChild8.HoldDuration = 0

                if fireproximityprompt then
                  fireproximityprompt(findFirstChild8, 0)
                else
                  pcall(function()
                    findFirstChild8:InputHoldBegin()
                    task.wait(0.05)
                    findFirstChild8:InputHoldEnd()
                  end)
                end

                task.wait(0.15)
              end
            end
          end

          pcall(function()
            local plotEggsTracker2 = localPlayer2.PlayerGui:FindFirstChild("Main")
              and localPlayer2.PlayerGui.Main:FindFirstChild("PlotEggsTracker")

            local holder2 = plotEggsTracker2
              and (plotEggsTracker2:FindFirstChild("Holder")
                or plotEggsTracker2:FindFirstChild("Handler"))

            if holder2 then
              for index37, value43 in ipairs(holder2:GetChildren()) do
                local findFirstChild9 = value43:FindFirstChild("Open", true)

                if findFirstChild9 and findFirstChild9:IsA("GuiButton")
                  and findFirstChild9.Visible then
                  if getconnections then
                    for key5, value44 in pairs(getconnections(findFirstChild9.Activated)) do
                      value44:Fire()
                    end

                    for key6, value45 in pairs(getconnections(findFirstChild9.MouseButton1Click)) do
                      value45:Fire()
                    end
                  end
                end
              end
            end
          end)
        end

        if crownHubState.AutoPlaceNest then
          local spawnNest = crownHubState.SpawnNest and 15 or 10
          local v174 = f14()

          if v174 < spawnNest then
            local v175 = v174 - f15()
            local v176 = 0

            if crownHubState.SpawnNest then
              local nests4 = v158:FindFirstChild("Nests")

              if nests4 then
                for index38, value46 in ipairs(nests4:GetChildren()) do
                  if value46:GetAttribute("Unlocked") ~= false
                    and not value46:GetAttribute("Occupied") then
                    v176 = v176 + 1
                  end
                end
              end
            end

            if v176 > 0 or v175 < 10 then
              local v177 = {}

              for index39, value47 in ipairs(localPlayer2.Backpack:GetChildren()) do
                if value47:IsA("Tool")
                  and (value47:HasTag("Egg") or string.find(value47.Name, "Egg")) then
                  table.insert(v177, value47)
                end
              end

              local character6 = localPlayer2.Character

              if character6 then
                for index40, value48 in ipairs(character6:GetChildren()) do
                  if value48:IsA("Tool")
                    and (value48:HasTag("Egg") or string.find(value48.Name, "Egg")) then
                    table.insert(v177, value48)
                  end
                end
              end

              for index41, value49 in ipairs(v177) do
                local v178 = f14()
                local v179 = v178 - f15()

                if v178 >= spawnNest then
                  break
                else
                  local v180 = false

                  if crownHubState.SpawnNest and v176 > 0 then
                    local nests5 = v158:FindFirstChild("Nests")

                    if nests5 then
                      for index42, value50 in ipairs(nests5:GetChildren()) do
                        if value50:GetAttribute("Unlocked") ~= false
                          and not value50:GetAttribute("Occupied") then
                          v35.Status = "Placing " .. value49.Name .. " in Nest..."

                          if character6 and v163 and value49.Parent ~= character6 then
                            v163:EquipTool(value49)
                            local v181 = os.clock()

                            while value49.Parent ~= character6 and os.clock() - v181 < 0.8 do
                              task.wait(0.05)
                            end
                          end

                          if value49.Parent == character6 and eggPlaced then
                            task.wait(0.1)
                            eggPlaced:FireServer({ NestId = value50.Name })
                            local v182 = os.clock()

                            while value49.Parent == character6 and os.clock() - v182 < 1 do
                              task.wait(0.05)
                            end

                            task.wait(0.2)
                            f14()

                            v35.Status = "Placed " .. value49.Name .. " in Nest "
                              .. value50.Name .. "!"

                            v180 = true
                            v176 = math.max(0, v176 - 1)
                          end

                          break
                        end
                      end
                    end
                  end

                  if not v180 then
                    if v179 < 10 then
                      v35.Status = "Placing " .. value49.Name .. " on Plot..."
                      local v183 = math.random()
                      local v184 = math.random()

                      local vector3 = Vector3.new(
                        (v183 * 2 - 1) * 20, 0.55, (v184 * 2 - 1) * 20
                      )

                      local pointToWorldSpace = baseplate.CFrame:PointToWorldSpace(vector3)

                      if character6 and v163 and value49.Parent ~= character6 then
                        v163:EquipTool(value49)
                        local v185 = os.clock()

                        while value49.Parent ~= character6 and os.clock() - v185 < 0.8 do
                          task.wait(0.05)
                        end
                      end

                      if value49.Parent == character6 and eggPlaced then
                        task.wait(0.1)
                        eggPlaced:FireServer({ PlantPosition = pointToWorldSpace })
                        local v186 = os.clock()

                        while value49.Parent == character6 and os.clock() - v186 < 1 do
                          task.wait(0.05)
                        end

                        task.wait(0.2)
                        f14()
                        v35.Status = "Placed " .. value49.Name .. " on Plot!"
                      end
                    else
                      break
                    end
                  end
                end
              end
            end
          end
        end

        if crownHubState.AutoUnlockNests and localPlayer2:GetAttribute("NoNest") ~= true then
          local nests6 = v158:FindFirstChild("Nests")

          if nests6 then
            for index43, value51 in ipairs(nests6:GetChildren()) do
              if value51:GetAttribute("Unlocked") ~= true then
                local findFirstChildWhichIsA = value51:FindFirstChildWhichIsA(
                  "ProximityPrompt", true
                )

                if findFirstChildWhichIsA and fireproximityprompt then
                  fireproximityprompt(findFirstChildWhichIsA, 0)
                end

                local v187 = tonumber(value51.Name)

                if v187 and nests then
                  pcall(function() nests:FireServer(v187) end)
                end

                task.wait(0.05)
              end
            end
          end
        end

        v35.Status = "Delivery Complete!"
        task.wait(0.05)
        return
      end
    end
  end
end

function f39(p63)
  local v188

  if not crownHubState.AutoMagmaDip then
    return false
  else
    local basket4 = localPlayer2:FindFirstChild("Basket")

    if not basket4 or #basket4:GetChildren() == 0 then
      return false
    else
      local v189, v190, v191 = f12()

      if not v190 or not v191 then
        return false
      end

      v188 = nil

      for index44, value52 in ipairs(basket4:GetChildren()) do
        if value52:GetAttribute("VolcanoDipped") ~= true
          and value52:GetAttribute("Delivering") ~= true then
          local mutation2 = value52:GetAttribute("Mutation")

          if mutation2 ~= "Eternal" and mutation2 ~= "Magma" then
            v188 = value52
            break
          end
        end
      end

      if not v188 then
        return false
      else
        if v35.CurrentTween then
          pcall(function() v35.CurrentTween:Cancel() end)
          v35.CurrentTween = nil
        end

        f37(v190, v191)
        v35.Status = "Warping directly to Volcano Top..."

        v190.AssemblyLinearVelocity = Vector3.zero
        v190.AssemblyAngularVelocity = Vector3.zero
        v190.CFrame = CFrame.new(vector)

        task.wait(0.2)

        if (v190.Position - vector).Magnitude > 25 then
          v190.AssemblyLinearVelocity = Vector3.zero
          v190.AssemblyAngularVelocity = Vector3.zero
          v190.CFrame = CFrame.new(vector)

          task.wait(0.1)
        end

        v35.Status = "Triggering Magma Lava Dip..."

        local reVolcanoDip = replicatedStorage:FindFirstChild("packages")
          and replicatedStorage.packages:FindFirstChild("Net")
          and replicatedStorage.packages.Net:FindFirstChild("RE/VolcanoDip")

        local v192 = os.clock()

        while os.clock() - v192 < 3.5 do
          if not v188.Parent then
            break
          else
            local volcanoUntil = v188:GetAttribute("VolcanoUntil")

            if volcanoUntil and type(volcanoUntil) == "number"
                and volcanoUntil > workspace:GetServerTimeNow()
              or v188:GetAttribute("VolcanoDipped") == true then
              break
            end

            if reVolcanoDip then
              pcall(function() reVolcanoDip:FireServer() end)
            else
              pcall(function()
                local v193 = f3(replicatedStorage.packages:FindFirstChild("Net"), "Net")

                if v193 and v193.RemoteEvent then
                  local volcanoDip = v193:RemoteEvent("VolcanoDip")

                  if volcanoDip then
                    volcanoDip:FireServer()
                  end
                end
              end)
            end

            pcall(function()
              local main = localPlayer2:FindFirstChild("PlayerGui")
                and localPlayer2.PlayerGui:FindFirstChild("Main")

              local actionsHolder = main and main:FindFirstChild("ActionsHolder")

              local dropEggVolcanoButton = actionsHolder
                and actionsHolder:FindFirstChild("DropEggVolcanoButton")

              if dropEggVolcanoButton and firesignal then
                firesignal(dropEggVolcanoButton.Activated)
              end
            end)

            task.wait(0.3)
          end
        end

        local v194 = os.clock()
        local magmaDipDuration = crownHubState.MagmaDipDuration or 9.5

        while os.clock() - v194 < magmaDipDuration do
          if not v188.Parent then
            break
          else
            local v195, v196 = f12()

            if v196 and (v196.Position - vector).Magnitude > 30 then
              v196.AssemblyLinearVelocity = Vector3.zero
              v196.AssemblyAngularVelocity = Vector3.zero
              v196.CFrame = CFrame.new(vector)
            end

            local volcanoUntil2 = v188:GetAttribute("VolcanoUntil")

            if volcanoUntil2 and type(volcanoUntil2) == "number"
              and workspace:GetServerTimeNow() >= volcanoUntil2 then
              break
            else
              local v197 = os.clock()
              local v198 = math.max(0, math.ceil(magmaDipDuration - (v197 - v194)))
              v35.Status = string.format("Dipping Egg in Lava (Magma Gamble)... %ds", v198)
              task.wait(0.2)
            end
          end
        end

        pcall(function() v188:SetAttribute("VolcanoDipped", true) end)

 
        if (v188.Parent and v188:GetAttribute("Mutation")) == "Magma" then
          v35.Status = "Magma Mutation Succeeded! (10x)"

          pcall(function()
            if crownHubState.WebhookOnMutation then
              task.spawn(function()
                crownWebhook("Magma Mutation", "Magma mutation succeeded **(10x)**.", 15105570)
              end)
            end
            v347:Notify({
              Title = "Magma Mutation (10x)!",
              Content = string.format("Successfully mutated %s to Magma!", v188.Name),
              Duration = 4,
              Icon = "flame",
            })
          end)
        else
          v35.Status = "Dip Complete (No Magma)"
        end

        return true
      end
    end
  end
end

task.spawn(function()
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    task.wait(0.1)
    local autoRebirth = crownHubState.AutoRebirth and f27() or nil

    local v199 = autoRebirth and not autoRebirth.isMaxCap and not autoRebirth.hasPet
      and not autoRebirth.isIncubating and autoRebirth.reqPet ~= ""

    if crownHubState.AutoFarm or v199 then
      local v200, v201 = f12()

      if v200 and v201 then
        local basket5 = localPlayer2:FindFirstChild("Basket")

        if basket5 and #basket5:GetChildren() >= 1 then
          v35.Status = "Basket Full (1/1) - Delivering..."
          f40("Carried Egg")
          local basket6 = localPlayer2:FindFirstChild("Basket")

          if basket6 and #basket6:GetChildren() >= 1 then
            v35.Status = "Offloading egg at Baseplate..."
            task.wait(0.4)
          end
        end

        local basket7 = localPlayer2:FindFirstChild("Basket")
          and #localPlayer2.Basket:GetChildren() >= 1

        if basket7 then
          v35.Status = "Plot Full - Waiting for Hatch..."
          task.wait(1.5)
        elseif not basket7 then
          local v202 = f33()

          if v202 and v202.IsWaitingWeather then
            v35.IsFarming = true
            local timeLeft = v202.TimeLeft or 0

            v35.Status = string.format(
              "[Weather: %s] Waiting for %s eggs (%ds)...", v202.StormVariant or "Storm",
              v202.MutationType or "Mutation", timeLeft
            )

            v35.Target = "Waiting for " .. (v202.MutationType or "Mutation")
            v35.TargetRarity = v202.StormVariant or "Weather"
            v35.TargetWeight = 0

            task.wait(0.5)
          elseif v202 and v202.Model and v202.Model.Parent then
            v35.IsFarming = true

            local v203 = v202.Mutation
                and string.format(" [%s x%d]", v202.Mutation, v23[v202.Mutation] or 1)
              or ""

            v35.Status = "Targeting " .. v202.Name .. v203
            v35.Target = v202.Name .. v203

            v35.TargetRarity = v202.Mutation and v202.Mutation .. " (" .. v202.Rarity .. ")"
              or v202.Rarity

            v35.TargetWeight = v202.EggWeight or 0

            local v204 = false
            local v205 = v202.Name == "Volcanic Egg"

            if v205
              and (localPlayer2:GetAttribute("InVolcano") ~= true
                or localPlayer2:GetAttribute("VolcanoValidated") ~= true) then
              v35.Status = "Entering Volcano (Activating Scorching)..."
              f22(v201, hum)
              v1477, v201 = f12()
            end

            if v201 then
              if v205 then
                if v35.CurrentTween then
                  pcall(function() v35.CurrentTween:Cancel() end)
                  v35.CurrentTween = nil
                end

                f37(v201, hum)
                v1480, v201 = f12()

                if v201 then
                  v201.AssemblyLinearVelocity = Vector3.zero
                  v201.AssemblyAngularVelocity = Vector3.zero

                  local position7 = v202.Position
                  local parent = v202.Prompt and v202.Prompt.Parent

                  if parent and parent:IsA("BasePart") then
                    position7 = parent.Position
                  end

                  v201.CFrame = CFrame.new(position7.X, position7.Y + 2, position7.Z)
                  task.wait(0.08)

                  if (v201.Position - position7).Magnitude > 25 then
                    v201.AssemblyLinearVelocity = Vector3.zero
                    v201.AssemblyAngularVelocity = Vector3.zero
                    v201.CFrame = CFrame.new(position7.X, position7.Y + 2, position7.Z)

                    task.wait(0.05)
                  end

                  v204 = true
                end
              else
                local v206, v207 = f38(v202.Position, v202.Model)

                if not v206 then
                  if v207 == "despawned" then
                    v35.Status = v202.Name .. " despawned, retargeting..."
                  else
                    v35.Status = "Retrying move to " .. v202.Name .. "..."
                  end

                  task.wait(0.2)
                else
                  v204 = true
                end
              end
            end

            if v204 then
              local v208 = math.clamp(crownHubState.SyncDelay, 0.25, 0.6)
              task.wait(v208)

              local basket8 = localPlayer2:FindFirstChild("Basket")
                  and #localPlayer2.Basket:GetChildren()
                or 0

              v1492, v201 = f12()

              if v201 then
                v201.AssemblyLinearVelocity = Vector3.zero
                v201.AssemblyAngularVelocity = Vector3.zero

                local position8 = v202.Position
                local parent2 = v202.Prompt and v202.Prompt.Parent

                if parent2 and parent2:IsA("BasePart") then
                  position8 = parent2.Position
                end

                v201.CFrame = CFrame.new(position8.X, position8.Y + 2, position8.Z)
              end

              pcall(function()
                if workspaceService.CurrentCamera and v201 then
                  workspaceService.CurrentCamera.CFrame = CFrame.lookAt(v201.Position
                    + Vector3.new(0, 3, 4), v202.Position)
                end
              end)

              if v202.Model and v202.Model.Parent then
                v35.Status = "Collecting " .. v202.Name
                f36(v202.Model, v202.Prompt)
              end

              local v209 = math.clamp(crownHubState.PostPickupDelay + 1.8, 1.8, 3)
              local v210 = os.clock()
              local v211 = false
              local v212 = os.clock()

              while os.clock() - v210 < v209 do
                if (localPlayer2:FindFirstChild("Basket") and #localPlayer2.Basket:GetChildren()
                    or 0)
                  > basket8 then
                  v211 = true
                  break
                end

                if not v202.Model or not v202.Model.Parent then
                  v211 = true
                  break
                end

                if os.clock() - v212 >= 0.3 then
                  v212 = os.clock()
                  v1509, v201 = f12()

                  if v201 then
                    v201.AssemblyLinearVelocity = Vector3.zero
                    v201.AssemblyAngularVelocity = Vector3.zero

                    local position9 = v202.Position
                    local parent3 = v202.Prompt and v202.Prompt.Parent

                    if parent3 and parent3:IsA("BasePart") then
                      position9 = parent3.Position
                    end

                    v201.CFrame = CFrame.new(position9.X, position9.Y + 2, position9.Z)
                  end

                  f36(v202.Model, v202.Prompt)
                end

                task.wait(0.05)
              end

              if v211 then
                v35.CollectedCount = v35.CollectedCount + 1
                v35.Status = "Collected " .. v202.Name .. " (1/1) - Delivering..."
                if crownHubState.WebhookOnEggCollect then
                  task.spawn(function()
                    local mut = ""
                    pcall(function()
                      local m = f9(v202)
                      if m and m ~= "" then mut = " · " .. tostring(m) end
                    end)
                    local w = ""
                    pcall(function()
                      local kg = f31(v202)
                      if kg and tonumber(kg) and tonumber(kg) > 0 then
                        w = string.format(" · %.1fkg", tonumber(kg))
                      end
                    end)
                    crownWebhook(
                      "Egg Collected",
                      string.format("**%s** [%s]%s%s\nTotal this session: %d",
                        tostring(v202.Name), tostring(v35.TargetRarity or "?"), w, mut,
                        tonumber(v35.CollectedCount) or 0),
                      5763719
                    )
                  end)
                end
                f40(v202.Name)
              else
                v35.Status = "Missed " .. v202.Name .. ", retargeting..."
                task.wait(0.2)
              end
            end
          else
            if autoRebirth and autoRebirth.isIncubating then
              local incubatingTime2 = autoRebirth.incubatingTime
                  and " (" .. autoRebirth.incubatingTime .. ")"
                or ""

              v35.Status = string.format(
                "Waiting for Ethereal / Incubating 1 %s%s",
                autoRebirth.incubatingEggName or "Egg", incubatingTime2
              )
            else
              v35.Status = "Searching for targets..."
            end

            v35.Target = "None"
            v35.TargetWeight = 0

            if crownHubState.AutoReturnPlot then
              local v213 = f13()

              local baseplate2 = v213
              baseplate2 = v213 and v213:FindFirstChild("Baseplate")

              if baseplate2 and (baseplate2.Position - v201.Position).Magnitude > 25 then
                f40("Return to Plot")
              end
            end

            task.wait(0.5)
          end
        end
      end
    else
      v35.IsFarming = false

      if v35.CurrentTween then
        pcall(function() v35.CurrentTween:Cancel() end)
        v35.CurrentTween = nil
      end

      if crownHubState.AutoRebirth and autoRebirth and not autoRebirth.isMaxCap then
        if autoRebirth.hasPet then
          v35.Status = string.format("Pet Owned (%s) - Waiting for Cash...", autoRebirth.reqPet)
        elseif autoRebirth.isIncubating then
          local incubatingTime3 = autoRebirth.incubatingTime
              and " (" .. autoRebirth.incubatingTime .. ")"
            or ""

          v35.Status = string.format(
            "Incubating 1 %s%s - Waiting to Hatch...", autoRebirth.incubatingEggName or "Egg",
            incubatingTime3
          )
        else
          v35.Status = "Idle"
        end
      else
        v35.Status = "Idle"
      end

      v35.Target = "None"
      v35.TargetWeight = 0
    end
  end
end)

task.spawn(function()
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    task.wait(0.25)

    if crownHubState.AutoHatchPlot then
      pcall(function()
        local plotEggsTracker3 = localPlayer2:FindFirstChild("PlayerGui")
          and localPlayer2.PlayerGui:FindFirstChild("Main")
          and localPlayer2.PlayerGui.Main:FindFirstChild("PlotEggsTracker")

        local holder3 = plotEggsTracker3 and plotEggsTracker3:FindFirstChild("Holder")

        if holder3 then
          for index45, value53 in ipairs(holder3:GetChildren()) do
            if value53:IsA("GuiObject") then
              local findFirstChild10 = value53:FindFirstChild("Open", true)
              local findFirstChild11 = value53:FindFirstChild("TimeLeft", true)

              if findFirstChild10 and findFirstChild10:IsA("GuiButton")
                  and findFirstChild10.Visible
                or findFirstChild11 and findFirstChild11:IsA("TextLabel")
                  and findFirstChild11.Text
                  and string.lower(findFirstChild11.Text):find("ready") ~= nil then
                local name7 = value53.Name

                if hatch and name7 and #name7 > 10 then
                  hatch:FireServer({ EggKey = name7 })
                end

                if findFirstChild10 and findFirstChild10:IsA("GuiButton") then
                  if getconnections then
                    for key7, value54 in pairs(getconnections(findFirstChild10.Activated)) do
                    end

                    for key8, value55 in pairs(getconnections(findFirstChild10.MouseButton1Click)) do
                    end
                  elseif firesignal then
                    pcall(firesignal, findFirstChild10.Activated)
                  end
                end

                task.wait(0.06)
              end
            end
          end
        end

        local v214 = f13()

        local eggs5 = v214
        eggs5 = v214 and v214:FindFirstChild("Eggs")

        if eggs5 then
          for index46, value56 in ipairs(eggs5:GetChildren()) do
            local eggKey2 = value56:GetAttribute("EggKey")
            local v215 = f25(value56)

            if v215 and v215.isReady and eggKey2 then
              if hatch then
                hatch:FireServer({ EggKey = eggKey2 })
              end

              local findFirstChild12 = value56:FindFirstChild("Hatch", true)
                or value56:FindFirstChildWhichIsA("ProximityPrompt", true)

              if findFirstChild12 and findFirstChild12:IsA("ProximityPrompt")
                and findFirstChild12.Enabled then
                findFirstChild12.HoldDuration = 0

                if fireproximityprompt then
                  fireproximityprompt(findFirstChild12, 0)
                else
                  pcall(function()
                    findFirstChild12:InputHoldBegin()
                    task.wait(0.05)
                    findFirstChild12:InputHoldEnd()
                  end)
                end
              end

              task.wait(0.06)
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  local lastMissingNotify = 0
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    task.wait(1)

    if crownHubState.AutoRebirth and crownHubState.AutoRebirthWhenReady then
      pcall(function()
        local v216 = f27()

        if v216.canRebirth and not v216.isMaxCap then
          v35.Status = "Executing Rebirth Tier " .. v216.nextTier .. "!"

          if f28() and v347 and v347.Notify then
            v347:Notify({
              Title = "Rebirth Completed",
              Content = string.format(
                "Tier %d unlocked! Requirements fulfilled.", v216.nextTier
              ),
              Duration = 4,
              Icon = "award",
            })
            if crownHubState.WebhookOnRebirth then
              task.spawn(function()
                crownWebhook(
                  "Rebirth Completed",
                  string.format("Tier **%d** unlocked.", v216.nextTier),
                  15844367
                )
              end)
            end
          end

          task.wait(2.5)
        elseif not v216.isMaxCap and v347 and v347.Notify then
          local parts = {}
          if not v216.hasPet then
            table.insert(parts, "Missing pet: " .. tostring(v216.reqPet or "?"))
          end
          if not v216.hasCash then
            table.insert(parts, string.format(
              "Insufficient cash ($%s / $%s)",
              tostring(f19(v216.currentCash or 0)),
              tostring(f19(v216.reqCash or 0))
            ))
          end
          if #parts > 0 and (os.clock() - lastMissingNotify) > 20 then
            lastMissingNotify = os.clock()
            v347:Notify({
              Title = "Cannot Rebirth",
              Content = table.concat(parts, " · "),
              Duration = 5,
              Icon = "alert-triangle",
            })
            if crownHubState.WebhookOnRebirthFail then
              task.spawn(function()
                crownWebhook("Cannot Rebirth", table.concat(parts, "\n"), 15158332)
              end)
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    task.wait(0.5)

    if crownHubState.AutoPlaceNest and not v35.CurrentTween then
      pcall(function()
        local v217 = f13()
        local baseplate3 = v217 and v217:FindFirstChild("Baseplate")
        local v218, v219, v220 = f12()

        if not v217 or not baseplate3 or not v220 or not v219 then
          return
        elseif (v219.Position - baseplate3.Position).Magnitude > 85 then
          return
        else
          local spawnNest2 = crownHubState.SpawnNest and 15 or 10

          if f14() >= spawnNest2 then
            return
          else
            local v221 = {}

            for index47, value57 in ipairs(localPlayer2.Backpack:GetChildren()) do
              if value57:IsA("Tool")
                and (value57:HasTag("Egg") or string.find(value57.Name, "Egg")) then
                table.insert(v221, value57)
              end
            end

            if v218 then
              for index48, value58 in ipairs(v218:GetChildren()) do
                if value58:IsA("Tool")
                  and (value58:HasTag("Egg") or string.find(value58.Name, "Egg")) then
                  table.insert(v221, value58)
                end
              end
            end

            if #v221 > 0 then
              for index49, value59 in ipairs(v221) do
                local v222 = f14()

                if v222 >= spawnNest2 then
                  break
                else
                  local v223 = false

                  if crownHubState.SpawnNest then
                    local nests7 = v217:FindFirstChild("Nests")

                    if nests7 then
                      for index50, value60 in ipairs(nests7:GetChildren()) do
                        if value60:GetAttribute("Unlocked") ~= false
                          and not value60:GetAttribute("Occupied") then
                          if value59.Parent ~= v218 then
                            v220:EquipTool(value59)
                            local v224 = os.clock()

                            while value59.Parent ~= v218 and os.clock() - v224 < 0.8 do
                              task.wait(0.05)
                            end
                          end

                          if value59.Parent == v218 and eggPlaced then
                            task.wait(0.1)
                            eggPlaced:FireServer({ NestId = value60.Name })
                            local v225 = os.clock()

                            while value59.Parent == v218 and os.clock() - v225 < 1 do
                              task.wait(0.05)
                            end

                            task.wait(0.25)
                            v223 = true
                            v222 = f14()
                          end

                          break
                        end
                      end
                    end
                  end

                  if not v223 then
                    if v222 - f15() < 10 then
                      local v226 = math.random()
                      local v227 = math.random()

                      local vector4 = Vector3.new(
                        (v226 * 2 - 1) * 20, 0.55, (v227 * 2 - 1) * 20
                      )

                      local pointToWorldSpace2 = baseplate3.CFrame:PointToWorldSpace(vector4)

                      if value59.Parent ~= v218 then
                        v220:EquipTool(value59)
                        local v228 = os.clock()

                        while value59.Parent ~= v218 and os.clock() - v228 < 0.8 do
                          task.wait(0.05)
                        end
                      end

                      if value59.Parent == v218 and eggPlaced then
                        task.wait(0.1)
                        eggPlaced:FireServer({ PlantPosition = pointToWorldSpace2 })
                        local v229 = os.clock()

                        while value59.Parent == v218 and os.clock() - v229 < 1 do
                          task.wait(0.05)
                        end

                        task.wait(0.25)
                        f14()
                      end
                    else
                      break
                    end
                  end
                end
              end
            end

            return
          end
        end
      end)
    end
  end
end)

local values2 = {
  "Hydra Dragon ($165M/s - Val: $99B)", "Hellhound ($140M/s - Val: $84B)",
  "Fenrir ($120M/s - Val: $72B)", "Stone Golem ($60M/s - Val: $36B)",
  "El Toro ($20M/s - Val: $12B)", "Black Panther ($180K/s - Val: $108M)",
  "Jackalope ($125K/s - Val: $75M)", "Grizzly Bear ($75K/s - Val: $45M)",
  "Scorpion ($45K/s - Val: $27M)", "Black Stallion ($5.4K/s - Val: $3.2M)",
  "Anaconda ($4K/s - Val: $2.4M)", "White Tiger ($2.8K/s - Val: $1.7M)",
  "Okapi ($2K/s - Val: $1.2M)", "Fennec ($900/s - Val: $540K)", "Bison ($625/s - Val: $375K)",
  "Llama ($425/s - Val: $255K)",
}

local v230 = {
  ["Hydra Dragon ($165M/s - Val: $99B)"] = "Hydra Dragon",
  ["Hellhound ($140M/s - Val: $84B)"] = "Hellhound",
  ["Fenrir ($120M/s - Val: $72B)"] = "Fenrir",
  ["Stone Golem ($60M/s - Val: $36B)"] = "Stone Golem",
  ["El Toro ($20M/s - Val: $12B)"] = "El Toro",
  ["Black Panther ($180K/s - Val: $108M)"] = "Black Panther",
  ["Jackalope ($125K/s - Val: $75M)"] = "Jackalope",
  ["Grizzly Bear ($75K/s - Val: $45M)"] = "Grizzly Bear",
  ["Scorpion ($45K/s - Val: $27M)"] = "Scorpion",
  ["Black Stallion ($5.4K/s - Val: $3.2M)"] = "Black Stallion",
  ["Anaconda ($4K/s - Val: $2.4M)"] = "Anaconda",
  ["White Tiger ($2.8K/s - Val: $1.7M)"] = "White Tiger",
  ["Okapi ($2K/s - Val: $1.2M)"] = "Okapi",
  ["Fennec ($900/s - Val: $540K)"] = "Fennec",
  ["Bison ($625/s - Val: $375K)"] = "Bison",
  ["Llama ($425/s - Val: $255K)"] = "Llama",
}

local function f41(p64)
  if not p64 then
    return
  end

  pcall(function()
    local favoritePet = replicatedStorage:FindFirstChild("Remotes")
      and replicatedStorage.Remotes:FindFirstChild("Game")
      and replicatedStorage.Remotes.Game:FindFirstChild("FavoritePet")

    if favoritePet then
      favoritePet:FireServer(p64)
    end
  end)
end

local function f42(p65)
  if not crownHubState.AutoFavoriteFuse then
    return false
  end

  if not crownHubState.AutoFavoriteFuseList or type(crownHubState.AutoFavoriteFuseList) ~= "table" then
    return false
  end

  for index51, value61 in ipairs(crownHubState.AutoFavoriteFuseList) do
    if v230[value61] == p65 or string.find(value61, p65, 1, true) then
      return true
    end
  end

  return false
end

task.spawn(function()
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    task.wait(0.5)
  end
end)

task.spawn(function()
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    task.wait(1.5)

    if crownHubState.AutoFavoriteFuse then
      pcall(function()
        for index52, value62 in ipairs(localPlayer2.Backpack:GetChildren()) do
          if value62:IsA("Tool") and value62:HasTag("Pet")
            and value62:GetAttribute("Favorited") ~= true then
            local petName = value62:GetAttribute("PetName") or value62.Name

            if f42(string.match(petName, "^(.-)%s*%[") or petName) then
              value62:GetAttribute("PetKey")
            end
          end
        end
      end)
    end

    if crownHubState.AutoFuse then
      pcall(function()
        local v231, v232, v233 = f12()
        local v234 = not v231 or not v232 or not v233
        local petKey3

        if v234 then
          return
        else
          local fusionSlots = localPlayer2:FindFirstChild("FusionSlots")
          local fusionResult = localPlayer2:FindFirstChild("FusionResult")

          local v235 = replicatedStorage:FindFirstChild("Remotes")
            and replicatedStorage.Remotes:FindFirstChild("Game")

          local fusionAction = v235 and v235:FindFirstChild("FusionAction")

          local fusionPetPlace = v235
          fusionPetPlace = v235 and v235:FindFirstChild("FusionPetPlace")

          local v236 = not fusionSlots
          local v237 = fusionPetPlace

          if v236 or not fusionAction or not v237 then
            return
          else
            local vector5 = Vector3.new(387.9, 40328.8, 751.3)
            local fusionStatus = fusionSlots:GetAttribute("FusionStatus")

            local cash = localPlayer2:FindFirstChild("SavedData")
                and localPlayer2.SavedData:FindFirstChild("Cash")
                and tonumber(localPlayer2.SavedData.Cash.Value)
              or localPlayer2:FindFirstChild("leaderstats")
                and localPlayer2.leaderstats:FindFirstChild("Cash")
                and tonumber(localPlayer2.leaderstats.Cash.Value)
              or 0

            local v238 = require(replicatedStorage.GameServices.FusionRules)

            if fusionStatus == "Result" then
              if (v232.Position - vector5).Magnitude > 25 then
                v232.CFrame = CFrame.new(vector5 + Vector3.new(0, 3, 0))
                task.wait(0.4)
              end

              if fusionSlots:GetAttribute("FusionFailed") == true then
                fusionAction:FireServer("Claim", fusionSlots:GetAttribute("FusionResultKey"))
              else
                local pet = fusionResult and fusionResult:FindFirstChild("Pet")
                petKey3 = pet and pet:GetAttribute("PetKey")

                if petKey3 then
                  fusionAction:FireServer("Claim", petKey3)

                  if crownHubState.AutoFavoriteFuse then
                    task.delay(0.5, function() f41(petKey3) end)
                  end
                else
                  local fusionOutput = workspaceService:FindFirstChild("Functionals")
                    and workspaceService.Functionals:FindFirstChild("Fusion")
                    and workspaceService.Functionals.Fusion:FindFirstChild("FusionOutput")

                  local findFirstChildWhichIsA2 = fusionOutput and fusionOutput:FindFirstChildWhichIsA(
                    "ProximityPrompt", true
                  )

                  if findFirstChildWhichIsA2 and fireproximityprompt then
                    fireproximityprompt(findFirstChildWhichIsA2, 0)
                  end
                end
              end

              task.wait(1)
              return
            elseif fusionStatus == "Waiting" then
              local endsAt = fusionSlots:GetAttribute("EndsAt")

              if workspace:GetServerTimeNow() >= (endsAt or 0) then
                if (v232.Position - vector5).Magnitude > 25 then
                  v232.CFrame = CFrame.new(vector5 + Vector3.new(0, 3, 0))
                  task.wait(0.4)
                end

                fusionAction:FireServer("Fuse")
                task.wait(2)
              end

              return
            else
              local v239 = {}

              for i = 1, 4 do
                if not fusionSlots:FindFirstChild(tostring(i)) then
                  table.insert(v239, i)
                end
              end

              if #v239 == 0 or fusionSlots:GetAttribute("Ready") == true then
                local v240 = {}
                local count2 = 0

                while true do
                  count2 = 1 + count2

                  if not (count2 <= 4) then
                    break
                  end

                  local findFirstChild13 = fusionSlots:FindFirstChild(tostring(count2))

                  if findFirstChild13 then
                    table.insert(v240, findFirstChild13:GetAttributes())
                  end
                end

                local v241 = v238.Preview(v240)

                if cash < (v241 and v241.FuseCost or 0) then
                  return
                end

                if (v232.Position - vector5).Magnitude > 25 then
                  v232.CFrame = CFrame.new(vector5 + Vector3.new(0, 3, 0))
                  task.wait(0.4)
                end

                fusionAction:FireServer("Start")
                task.wait(2)
                return
              else
                local v242 = require(replicatedStorage.GameData.Pets)
                local v243 = {}

                for index53, value63 in ipairs(localPlayer2.Backpack:GetChildren()) do
                  if value63:IsA("Tool") and value63:HasTag("Pet") then
                    local petName2 = value63:GetAttribute("PetName") or value63.Name

                    local v244 = v242[string.match(petName2, "^(.-)%s*%[") or petName2]
                      or v242[petName2]

                    local rarity = v244 and v244.Rarity or value63:GetAttribute("Rarity")
                    local v245 = value63:GetAttribute("Favorited") == true

                    if rarity and crownHubState.FuseRarities
                      and crownHubState.FuseRarities[rarity] == true then
                      if not (crownHubState.FuseProtectFavorited and v245) then
                        table.insert(v243, value63)
                      end
                    end
                  end
                end

                if #v243 >= #v239 then
                  local v246 = {}
                  local count3 = 0

                  while true do
                    count3 = 1 + count3

                    if not (4 >= count3) then
                      break
                    end

                    local findFirstChild14 = fusionSlots:FindFirstChild(tostring(count3))

                    if findFirstChild14 then
                      table.insert(v246, findFirstChild14:GetAttributes())
                    end
                  end

                  for index54, value64 in ipairs(v243) do
                    if #v246 >= 4 then
                      break
                    end

                    table.insert(v246, value64:GetAttributes())
                  end

                  if #v246 == 4 then
                    local v247 = v238.Preview(v246)

                    if cash < (v247 and v247.FuseCost or 0) then
                      return
                    end
                  end

                  if (v232.Position - vector5).Magnitude > 25 then
                    v232.CFrame = CFrame.new(vector5 + Vector3.new(0, 3, 0))
                    task.wait(0.4)
                  end

                  for index55, value65 in ipairs(v239) do
                    if #v243 == 0 then
                      break
                    else
                      local v248 = table.remove(v243, 1)

                      if v248 and v248.Parent == localPlayer2.Backpack and v233 then
                        v233:UnequipTools()
                        task.wait(0.05)
                        v233:EquipTool(v248)
                        local v249 = os.clock()

                        while v248.Parent ~= v231 and os.clock() - v249 < 0.8 do
                          task.wait(0.05)
                        end

                        if v248.Parent == v231 then
                          task.wait(0.1)
                          v237:FireServer(value65)
                          task.wait(0.25)
                        end
                      end
                    end
                  end

                  task.wait(0.5)

                  if fusionSlots:GetAttribute("Ready") == true
                    or #fusionSlots:GetChildren() >= 4 then
                    fusionAction:FireServer("Start")
                    task.wait(2)
                  end

                  return
                end

                return
              end
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(0.5)

    if crownHubState.AutoUpgradeLuck then
      pcall(function()
        local upgrades = replicatedStorage:FindFirstChild("Remotes", true)
          and replicatedStorage.Remotes:FindFirstChild("Game", true)
          and replicatedStorage.Remotes.Game:FindFirstChild("Plot", true)
          and replicatedStorage.Remotes.Game.Plot:FindFirstChild("Upgrades")

        if not upgrades then
          upgrades = replicatedStorage:FindFirstChild("Upgrades", true)
        end

        if upgrades then
          upgrades:FireServer("HatchUpgrade", "BuyMax")
          upgrades:FireServer("HatchUpgrade", "BuyOne")
        end
      end)
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(1)

    if crownHubState.AutoUnlockNests then
      pcall(function()
        if localPlayer2:GetAttribute("NoNest") == true then
          return
        else
          local v250 = f13()

          if v250 and v250:FindFirstChild("Nests") then
            for index56, value66 in ipairs(v250.Nests:GetChildren()) do
              if value66:GetAttribute("Unlocked") ~= true then
                local findFirstChildWhichIsA3 = value66:FindFirstChildWhichIsA(
                  "ProximityPrompt", true
                )

                if findFirstChildWhichIsA3 and fireproximityprompt then
                  fireproximityprompt(findFirstChildWhichIsA3, 0)
                end

                local nests8 = replicatedStorage:FindFirstChild("Remotes", true)
                  and replicatedStorage.Remotes:FindFirstChild("Game", true)
                  and replicatedStorage.Remotes.Game:FindFirstChild("Plot", true)
                  and replicatedStorage.Remotes.Game.Plot:FindFirstChild("Nests")

                if nests8 then
                  local v251 = tonumber(value66.Name)

                  if v251 then
                    nests8:FireServer(v251)
                  end
                end

                task.wait(0.25)
              end
            end
          end

          return
        end
      end)
    end
  end
end)

local function f43(p66)
  local v252 = f13()
  local baseplate4 = v252 and v252:FindFirstChild("Baseplate")
  local v253, v254, v255 = f12()
  local v256 = v252 and baseplate4 and v253 and v254 and v255
  local v257, bestPetsStrategy

  if not v256 then
    return false, "Not near plot or character missing"
  elseif (v254.Position - baseplate4.Position).Magnitude > 45 then
    return false, "Too far from plot baseplate"
  else
    local petAging = replicatedStorage:FindFirstChild("GameServices")
      and replicatedStorage.GameServices:FindFirstChild("PetAging")

    local pets = replicatedStorage:FindFirstChild("GameData")
      and replicatedStorage.GameData:FindFirstChild("Pets")

    local mutations = replicatedStorage:FindFirstChild("GameData")
      and replicatedStorage.GameData:FindFirstChild("Mutations")

    local playerScripts = localPlayer2:FindFirstChild("PlayerScripts")
    local v258 = playerScripts and playerScripts:FindFirstChild("Game")
    local pets2 = v258 and v258:FindFirstChild("Pets")
    local petRenderer = pets2 and pets2:FindFirstChild("PetRenderer")
    local v259 = petAging and f3(petAging, "PetAging", {}) or {}
    local v260 = pets and f3(pets, "Pets", {}) or {}
    local v261 = mutations and f3(mutations, "Mutations", {}) or {}
    v257 = petRenderer and f3(petRenderer, "PetRenderer", {}) or {}

    local v262 = replicatedStorage:FindFirstChild("Remotes")
      and replicatedStorage.Remotes:FindFirstChild("Game")

    local placePet = v262 and v262:FindFirstChild("PlacePet")
    local pickupPet = v262 and v262:FindFirstChild("PickupPet")

    if not (placePet and pickupPet) then
      return false, "Place/Pickup remotes not found"
    else
      local v263 = {}

      if v257 and v257.GetAll then
        for key9, value67 in pairs(v257.GetAll()) do
          if value67.OwnerUserId == localPlayer2.UserId and value67.Model
            and value67.Model.Parent then
            local v264 = tonumber(value67.Model:GetAttribute("Age")) or 1
            local v265 = tonumber(value67.Model:GetAttribute("Weight")) or 1
            local petName3 = value67.Model:GetAttribute("PetName") or value67.Model.Name
            local v266 = v260 and v260[petName3] and tonumber(v260[petName3].Income) or 0
            local mutation3 = value67.Model:GetAttribute("Mutation")
            local spawnMutation = value67.Model:GetAttribute("SpawnMutation")

            local combinedFactor = v261 and v261.CombinedFactor
                and v261.CombinedFactor(mutation3, spawnMutation)
              or 1

            local multiplierFor = v259 and v259.MultiplierFor and v259.MultiplierFor(v264) or 1

            if multiplierFor <= 0 then
              multiplierFor = 1
            end

            local v267 = v265 / multiplierFor
            local maxAge = v259 and v259.MaxAge or 100

            local v268 = v267
              * (v259 and v259.MultiplierFor and v259.MultiplierFor(maxAge) or 1.99)

            local weightStandardKG = v259 and v259.WeightStandardKG or 10
            local v269 = math.floor(v266 * (v265 / weightStandardKG))
            local v270 = math.floor(v269 * combinedFactor)
            local v271 = math.floor(v266 * (v268 / weightStandardKG))
            local v272 = math.floor(v271 * combinedFactor)
            local model = value67.Model

            table.insert(v263, {
              Key = value67.PetKey,
              Name = petName3,
              Placed = true,
              Age = v264,
              CurWeight = v265,
              BaseWeight = v267,
              CurIncome = v270,
              MaxIncome = v272,
              Position = model:GetPivot().Position,
            })
          end
        end
      end

      if localPlayer2:FindFirstChild("Backpack") then
        for index57, value68 in ipairs(localPlayer2.Backpack:GetChildren()) do
          if value68:IsA("Tool") and value68:HasTag("Pet") and value68:GetAttribute("PetKey") then
            local v273 = tonumber(value68:GetAttribute("Age")) or 1
            local v274 = tonumber(value68:GetAttribute("Weight")) or 1
            local petName4 = value68:GetAttribute("PetName") or value68.Name
            local v275 = v260 and v260[petName4] and tonumber(v260[petName4].Income) or 0
            local mutation4 = value68:GetAttribute("Mutation")
            local combinedFactor2 = v261
            local spawnMutation2 = value68:GetAttribute("SpawnMutation")

            if v261 then
              combinedFactor2 = v261.CombinedFactor
                and v261.CombinedFactor(mutation4, spawnMutation2)
            end

            local v276 = combinedFactor2 or 1
            local multiplierFor2 = v259 and v259.MultiplierFor and v259.MultiplierFor(v273) or 1

            if multiplierFor2 <= 0 then
              multiplierFor2 = 1
            end

            local v277 = v274 / multiplierFor2
            local maxAge2 = v259 and v259.MaxAge or 100

            local v278 = v277
              * (v259 and v259.MultiplierFor and v259.MultiplierFor(maxAge2) or 1.99)

            local weightStandardKG2 = v259 and v259.WeightStandardKG or 10
            local v279 = math.floor(v275 * (v274 / weightStandardKG2))
            local v280 = math.floor(v279 * v276)
            local v281 = math.floor(v275 * (v278 / weightStandardKG2))
            local v282 = math.floor(v281 * v276)

            table.insert(v263, {
              Key = value68:GetAttribute("PetKey"),
              Name = petName4,
              Placed = false,
              Age = v273,
              CurWeight = v274,
              BaseWeight = v277,
              CurIncome = v280,
              MaxIncome = v282,
              Tool = value68,
            })
          end
        end
      end

      if #v263 == 0 then
        return false, "No pets found"
      else
        bestPetsStrategy = p66 or crownHubState.BestPetsStrategy
          or "Smart Potential"

        table.sort(v263, function(p67, p68)
          if bestPetsStrategy == "Current Cash/s" then
            if p67.CurIncome ~= p68.CurIncome then
              return p67.CurIncome > p68.CurIncome
            end

            return p67.MaxIncome > p68.MaxIncome
          end

          if p67.MaxIncome ~= p68.MaxIncome then
            return p67.MaxIncome > p68.MaxIncome
          end

          return p67.BaseWeight > p68.BaseWeight
        end)

        local maxPets = localPlayer2:GetAttribute("MaxPets")
        local v283 = math.min(maxPets or 5, #v263)
        local v284 = {}
        local count4 = 0

        while true do
          count4 = 1 + count4

          if not (v283 >= count4) then
            break
          end

          v284[v263[count4].Key] = true
        end

        local v285 = {}
        local count5 = 0

        for index58, value69 in ipairs(v263) do
          local v286 = value69

          if v286.Placed and not v284[v286.Key] then
            if v286.Position then
              table.insert(v285, v286.Position)
            end

            pcall(function() v257.Remove(localPlayer2.UserId, v286.Key) end)
            pickupPet:FireServer(v286.Key)
            count5 = count5 + 1
            task.wait(0.2)
          end
        end

        local count6 = 0

        local function f44(p69)
          local v287 = math.floor((p69 - 1) / 3)
          local cframe6 = CFrame.new(((p69 - 1) % 3 - 1) * 4, 0, -(v287 * 4 + 8))
          local pointToObjectSpace = baseplate4.CFrame:PointToObjectSpace((v254.CFrame * cframe6).Position)
          local v288 = baseplate4.Size.X / 2 - 3
          local v289 = baseplate4.Size.Z / 2 - 3
          local v290 = math.clamp(pointToObjectSpace.X, -v288, v288)
          local v291 = math.clamp(pointToObjectSpace.Z, -v289, v289)

          return baseplate4.CFrame:PointToWorldSpace(Vector3.new(
            v290, pointToObjectSpace.Y, v291
          ))
        end

        for j = 1, v283 do
          local v292 = v263[j]

          if not v292.Placed then
            local tool = v292.Tool

            if not tool or tool.Parent ~= localPlayer2.Backpack then
              for index59, value70 in ipairs(localPlayer2.Backpack:GetChildren()) do
                if value70:IsA("Tool") and value70:GetAttribute("PetKey") == v292.Key then
                  tool = value70
                  break
                end
              end
            end

            if tool then
              v255:EquipTool(tool)
              local v293 = os.clock()

              while tool.Parent ~= v253 and os.clock() - v293 < 1 do
                task.wait(0.05)
              end

              if tool.Parent == v253 then
                local v294 = table.remove(v285, 1) or f44(j)
                placePet:FireServer(v292.Key, v294)
                count6 = count6 + 1
                task.wait(0.25)
              end
            end
          end
        end

        if v255 and localPlayer2:GetAttribute("IsRiding") ~= true then
          pcall(function() v255:UnequipTools() end)
        end

        return true, string.format(
          "Optimized %d placed, %d picked up (%s)", count6, count5, bestPetsStrategy
        )
      end
    end
  end
end

task.spawn(function()
  while true do
    task.wait(10)

    if _G.CrownHubInstanceId ~= crownHubInstanceId then
      break
    elseif crownHubState.AutoPlaceBestPets then
      pcall(function() f43(crownHubState.BestPetsStrategy) end)
    end
  end
end)

local function f45(p70)
  local v295 = f13()
  local v296, v297, v298 = f12()
  local v299 = v295 and v296 and v297 and v298
  local v300, feedTargetMode

  if not v299 then
    return false, "Character or plot missing"
  elseif v35.IsFarming then
    return false, "Cannot feed while farming is active"
  else
    local petAging2 = replicatedStorage:FindFirstChild("GameServices")
      and replicatedStorage.GameServices:FindFirstChild("PetAging")

    local pets3 = replicatedStorage:FindFirstChild("GameData")
      and replicatedStorage.GameData:FindFirstChild("Pets")

    local mutations2 = replicatedStorage:FindFirstChild("GameData")
      and replicatedStorage.GameData:FindFirstChild("Mutations")

    local playerScripts2 = localPlayer2:FindFirstChild("PlayerScripts")
    local v301 = playerScripts2 and playerScripts2:FindFirstChild("Game")
    local pets4 = v301 and v301:FindFirstChild("Pets")
    local petRenderer2 = pets4 and pets4:FindFirstChild("PetRenderer")

    local foods = replicatedStorage:FindFirstChild("GameData")
      and replicatedStorage.GameData:FindFirstChild("Foods")

    local v302 = petAging2 and f3(petAging2, "PetAging", {}) or {}
    local v303 = pets3 and f3(pets3, "Pets", {}) or {}
    local v304 = mutations2 and f3(mutations2, "Mutations", {}) or {}
    local v305 = petRenderer2 and f3(petRenderer2, "PetRenderer", {}) or {}
    v300 = foods and f3(foods, "Foods", {}) or {}

    local v306 = replicatedStorage:FindFirstChild("Remotes")
      and replicatedStorage.Remotes:FindFirstChild("Game")

    local feedPet = v306 and v306:FindFirstChild("FeedPet")
      or replicatedStorage:FindFirstChild("FeedPet", true)

    if not feedPet then
      return false, "FeedPet remote not found"
    else
      local v307 = {}
      local maxAge3 = v302 and v302.MaxAge
      local multiplierFor3 = v302
      local v308 = maxAge3 or 100

      if v302 then
        multiplierFor3 = v302.MultiplierFor and v302.MultiplierFor(v308)
      end

      local v309 = multiplierFor3 or 1.99
      local weightStandardKG3 = v302 and v302.WeightStandardKG or 10

      if v305 and v305.GetAll then
        for key10, value71 in pairs(v305.GetAll()) do
          if value71.OwnerUserId == localPlayer2.UserId and value71.Model
            and value71.Model.Parent and value71.Model.PrimaryPart then
            local v310 = tonumber(value71.Model:GetAttribute("Age")) or 1
            local v311 = tonumber(value71.Model:GetAttribute("Weight")) or 1
            local petName5 = value71.Model:GetAttribute("PetName") or value71.Model.Name
            local v312 = v303 and v303[petName5] and tonumber(v303[petName5].Income) or 0
            local mutation5 = value71.Model:GetAttribute("Mutation")
            local model2 = value71.Model
            local combinedFactor3 = v304
            local spawnMutation3 = model2:GetAttribute("SpawnMutation")

            if v304 then
              combinedFactor3 = v304.CombinedFactor
                and v304.CombinedFactor(mutation5, spawnMutation3)
            end

            local v313 = combinedFactor3 or 1
            local multiplierFor4 = v302 and v302.MultiplierFor and v302.MultiplierFor(v310) or 1

            if multiplierFor4 <= 0 then
              multiplierFor4 = 1
            end

            local v314 = v311 / multiplierFor4
            local v315 = math.floor(math.floor(v312 * (v311 / weightStandardKG3)) * v313)
            local v316 = math.floor(math.floor(v312 * (v314 * v309 / weightStandardKG3)) * v313)

            table.insert(v307, {
              PetKey = value71.PetKey,
              Name = petName5,
              Model = value71.Model,
              PrimaryPart = value71.Model.PrimaryPart,
              Age = v310,
              CurWeight = v311,
              BaseWeight = v314,
              CurIncome = v315,
              MaxIncome = v316,
              Headroom = v316 - v315,
            })
          end
        end
      end

      if #v307 == 0 and v295:FindFirstChild("Pets") then
        for index60, value72 in ipairs(v295.Pets:GetChildren()) do
          if value72:IsA("Model") and value72.PrimaryPart then
            local ownerUserId = value72:GetAttribute("OwnerUserId")

            local owner2 = ownerUserId
            owner2 = ownerUserId or value72:GetAttribute("Owner")

            if owner2 == localPlayer2.UserId
              or tostring(owner2) == tostring(localPlayer2.UserId)
              or v295:GetAttribute("NestsOwnerLoaded") == localPlayer2.UserId
              or v295.Name == tostring(localPlayer2.UserId) then
              local petKey4 = value72:GetAttribute("PetKey") or value72.Name
              local v317 = tonumber(value72:GetAttribute("Age")) or 1
              local v318 = tonumber(value72:GetAttribute("Weight")) or 1
              local petName6 = value72:GetAttribute("PetName") or value72.Name
              local v319 = v303 and v303[petName6] and tonumber(v303[petName6].Income) or 0
              local mutation6 = value72:GetAttribute("Mutation")
              local combinedFactor4 = v304
              local spawnMutation4 = value72:GetAttribute("SpawnMutation")

              if v304 then
                combinedFactor4 = v304.CombinedFactor
                  and v304.CombinedFactor(mutation6, spawnMutation4)
              end

              local v320 = combinedFactor4 or 1

              local multiplierFor5 = v302 and v302.MultiplierFor and v302.MultiplierFor(v317)
                or 1

              if multiplierFor5 <= 0 then
                multiplierFor5 = 1
              end

              local v321 = v318 / multiplierFor5
              local v322 = math.floor(math.floor(v319 * (v318 / weightStandardKG3)) * v320)
              local v323 = math.floor(math.floor(v319 * (v321 * v309 / weightStandardKG3)) * v320)

              table.insert(v307, {
                PetKey = petKey4,
                Name = petName6,
                Model = value72,
                PrimaryPart = value72.PrimaryPart,
                Age = v317,
                CurWeight = v318,
                BaseWeight = v321,
                CurIncome = v322,
                MaxIncome = v323,
                Headroom = v323 - v322,
              })
            end
          end
        end
      end

      if #v307 == 0 then
        return false, "No placed pets found on plot"
      else
        local v324 = {}

        if (crownHubState.FeedTargetMode == "Selected Pet Only"
            or crownHubState.FeedTargetMode == nil)
          and crownHubState.SelectedPetKey then
          for index61, value73 in ipairs(v307) do
            if value73.PetKey == crownHubState.SelectedPetKey then
              if crownHubState.FeedSkipMaxAge == false or value73.Age < v308 then
                table.insert(v324, value73)
              end

              break
            end
          end
        end

        if #v324 == 0 then
          for index62, value74 in ipairs(v307) do
            local v325 = true

            if crownHubState.FeedSkipMaxAge ~= false and value74.Age >= v308 then
              v325 = false
            end

            if v325 and crownHubState.FeedAllPets == false
              and type(crownHubState.FeedPetList) == "table" then
              local v326 = false

              for key11, value75 in pairs(crownHubState.FeedPetList) do
                if type(key11) == "number"
                    and (value75 == value74.Name or value75 == value74.PetKey)
                  or type(key11) == "string"
                    and (key11 == value74.Name or key11 == value74.PetKey) and value75 == true then
                  v326 = true
                  break
                end
              end

              if not v326 then
                v325 = false
              end
            end

            if v325 then
              table.insert(v324, value74)
            end
          end

          if #v324 == 0 then
            return false, crownHubState.FeedSkipMaxAge ~= false
                and "All placed pets are already max level (Age 100)"
              or "No matching pets selected"
          end

          feedTargetMode = crownHubState.FeedTargetMode or crownHubState.FeedPriorityMode
            or "Smart Priority"

          table.sort(v324, function(p71, p72)
            if feedTargetMode == "Highest Max Income" then
              if p71.MaxIncome ~= p72.MaxIncome then
                return p71.MaxIncome > p72.MaxIncome
              end

              return p71.Headroom > p72.Headroom
            elseif feedTargetMode == "Lowest Level First" then
              if p71.Age ~= p72.Age then
                return p71.Age < p72.Age
              end

              return p71.Headroom > p72.Headroom
            elseif p71.Headroom ~= p72.Headroom then
              return p71.Headroom > p72.Headroom
            else
              if p71.MaxIncome ~= p72.MaxIncome then
                return p71.MaxIncome > p72.MaxIncome
              end

              return p71.BaseWeight > p72.BaseWeight
            end
          end)
        end

        local function f46()
          local v327 = {}

          for index63, value76 in ipairs({
            localPlayer2.Character, localPlayer2:FindFirstChild("Backpack"),
          }) do
            if value76 then
              for index64, value77 in ipairs(value76:GetChildren()) do
                if value77:IsA("Tool") and not value77:HasTag("Pet")
                  and not value77:HasTag("Egg") and not value77:HasTag("Radar") then
                  if value77:HasTag("Food") or v300 and v300[value77.Name] ~= nil then
                    local v328 = v300 and v300[value77.Name] or {}
                    local v329 = v328.NoFeedAll == true

                    local v330 = v329

                    v330 = v329 or value77.Name == "Dragonfruit"
                      or value77.Name == "Magic Apple"

                    local v331 = crownHubState.FeedAllowPremiumFood ~= false
                    local v332 = true

                    if v330 and not v331 then
                      v332 = false
                    end

                    if crownHubState.FeedFoodSelection
                      and crownHubState.FeedFoodSelection ~= "All Foods"
                      and value77.Name ~= crownHubState.FeedFoodSelection then
                      v332 = false
                    end

                    local v333 = 1
                    local data2 = value77:FindFirstChild("Data")

                    if data2 and data2:FindFirstChild("Amount") then
                      v333 = tonumber(data2.Amount.Value) or 0
                    end

                    if v332 and v333 > 0 then
                      table.insert(v327, {
                        Tool = value77,
                        Name = value77.Name,
                        XP = tonumber(v328.XP) or 0,
                        Amount = v333,
                      })
                    end
                  end
                end
              end
            end
          end

          table.sort(v327, function(p73, p74) return p73.XP > p74.XP end)
          return v327
        end

        local v334 = f46()

        if #v334 == 0 then
          return false, "No valid food items available in backpack"
        else
          local v335 = v324[1]
          local v336 = v334[1]
          local tool2 = v336.Tool

          if tool2.Parent ~= localPlayer2.Character and v298 then
            v298:EquipTool(tool2)
            local v337 = os.clock()

            while tool2.Parent ~= localPlayer2.Character and os.clock() - v337 < 0.8 do
              task.wait(0.05)
            end
          end

          if tool2.Parent ~= localPlayer2.Character then
            return false, "Failed to equip food tool " .. tostring(v336.Name)
          else
            local cframe7 = nil
            local primaryPart = v335.PrimaryPart

            local basePart = primaryPart
            basePart = primaryPart or v335.Model:FindFirstChildWhichIsA("BasePart")

            if basePart and v297 then
              if (v297.Position - basePart.Position).Magnitude > 7 and not v35.IsFarming then
                cframe7 = v297.CFrame
                v297.CFrame = basePart.CFrame * CFrame.new(0, 1, 3.5)
                task.wait(0.1)
              end
            end

            local feed = basePart
              and (basePart:FindFirstChild("Feed") or v335.Model:FindFirstChild("Feed", true))

            if feed and feed:IsA("ProximityPrompt") then
              pcall(function()
                feed.Enabled = true
                feed.HoldDuration = 0
                feed.RequiresLineOfSight = false
                feed.MaxActivationDistance = 9999
              end)

              if fireproximityprompt then
                pcall(fireproximityprompt, feed, 0)
              end
            end

            feedPet:FireServer(v335.PetKey, v336.Name)
            task.wait(0.4)
            local v338 = 1

            if p70 then
              local v339 = 1

              while true do
                v339 = 1 + v339

                if not (5 >= v339) then
                  break
                end

                local age = tonumber(v335.Model:GetAttribute("Age")) or v335.Age

                if crownHubState.FeedSkipMaxAge ~= false and age >= v308 then
                  break
                else
                  local data3 = tool2:FindFirstChild("Data")

                  if (data3 and data3:FindFirstChild("Amount") and tonumber(data3.Amount.Value)
                      or 0)
                    <= 0 then
                    break
                  end

                  feedPet:FireServer(v335.PetKey, v336.Name)
                  v338 = v338 + 1
                  task.wait(0.4)
                end
              end
            end

            if cframe7 and v297 and v297.Parent then
              v297.CFrame = cframe7
            end

            return true, string.format(
              "Fed %d %s to %s (Age %s)", v338, v336.Name, v335.Name,
              tostring(v335.Model:GetAttribute("Age") or v335.Age)
            )
          end
        end
      end
    end
  end
end

task.spawn(function()
  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    if crownHubState.AutoFeedPets and not v35.IsFarming then
      pcall(function() f45(false) end)
      task.wait(0.1)
    else
      task.wait(0.5)
    end
  end
end)

task.spawn(function()
  local function f47(p75)
    if not p75 then
      return
    end

    for index65, value78 in ipairs(p75:GetChildren()) do
      local v340 = value78

      if v340:IsA("GuiObject") and v340.Name:find("-") then
        local petHolder = v340:FindFirstChild("PetHolder") or v340

        if petHolder and not v340:GetAttribute("CrownHooked") then
          v340:SetAttribute("CrownHooked", true)

          petHolder.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
              or input.UserInputType == Enum.UserInputType.Touch then
              crownHubState.SelectedPetKey = v340.Name
              crownHubState.FeedTargetMode = "Selected Pet Only"

              local text2 = petHolder:FindFirstChild("PetName", true)
                  and petHolder:FindFirstChild("PetName", true).Text
                or "Pet"

              if UIControls.FeedTargetMode and UIControls.FeedTargetMode.Set then
                pcall(function() UIControls.FeedTargetMode:Set("Selected Pet Only") end)
              end

              if v347 and v347.Notify then
                v347:Notify({
                  Title = "Target Pet Locked",
                  Content = string.format("Locked onto %s from in-game list", text2),
                  Duration = 2,
                  Icon = "shield-check",
                })
              end
            end
          end)
        end
      end
    end
  end

  while not (_G.CrownHubInstanceId ~= crownHubInstanceId) do
    pcall(function()
      local main2 = localPlayer2:FindFirstChild("PlayerGui")
        and localPlayer2.PlayerGui:FindFirstChild("Main")

      local petsTracker = main2 and main2:FindFirstChild("PetsTracker")
      local holder4 = petsTracker and petsTracker:FindFirstChild("Holder")

      if holder4 then
        f47(holder4)
      end
    end)

    task.wait(2)
  end
end)

-- ============================================================
-- ZRHUB UI: Obsidian (same calls the script used before)
-- ============================================================
local Library, v347, window, ZR_Obs
do
  local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
  local Obsidian = loadstring(game:HttpGet(repo .. "Library.lua"))()
  ZR_Obs = Obsidian
  local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
  local Options, Toggles = Obsidian.Options, Obsidian.Toggles

  local count = 0
  local function newId() count += 1 return "zr_rap_" .. count end
  local function plain(t) return (tostring(t or ""):gsub("<[^>]->", "")) end
  local function rounding(step)
    step = tonumber(step) or 1
    if step >= 1 then return 0 end
    local dec = tostring(step):match("%.(%d+)")
    return dec and math.min(#dec, 3) or 2
  end

  local BOX_ICONS = {
    { "steal", "hand" }, { "mutation", "flask-conical" }, { "rebirth", "rotate-ccw" }, { "plot egg", "egg" },
    { "upgrade", "circle-arrow-up" }, { "feed", "utensils" }, { "visual", "eye" }, { "scanner", "radar" },
    { "webhook", "webhook" }, { "notify", "bell" }, { "interface", "monitor" }, { "config", "save" },
    { "movement", "move" },
  }
  local function boxIcon(t)
    t = tostring(t):lower()
    for _, p in ipairs(BOX_ICONS) do if t:find(p[1], 1, true) then return p[2] end end
    return "box"
  end

  local Dead
  Dead = setmetatable({}, { __index = function() return function() return Dead end end })

  local function makeGroup(getBox)
    local G = {}

    function G:Toggle(o)
      o = o or {}
      local id = newId()
      getBox():AddToggle(id, {
        Text = plain(o.Title), Default = o.Value == true, Tooltip = o.Desc,
        Callback = function(v) if o.Callback then o.Callback(v) end end,
      })
      local el = { Value = o.Value == true }
      Toggles[id]:OnChanged(function() el.Value = Toggles[id].Value end)
      function el:Set(v) Toggles[id]:SetValue(v == true) end
      return el
    end

    function G:Slider(o)
      o = o or {}
      local id = newId()
      local val = type(o.Value) == "table" and o.Value or {}
      local minV, maxV = tonumber(val.Min) or tonumber(o.Min) or 0, tonumber(val.Max) or tonumber(o.Max) or 100
      local default = math.clamp(tonumber(val.Default) or tonumber(o.Default) or minV, minV, maxV)
      getBox():AddSlider(id, {
        Text = plain(o.Title), Min = minV, Max = maxV, Default = default,
        Rounding = rounding(o.Step), Suffix = o.Suffix, Tooltip = o.Desc,
        Callback = function(v) if o.Callback then o.Callback(v) end end,
      })
      local el = {}
      function el:Set(v) if tonumber(v) then Options[id]:SetValue(math.clamp(tonumber(v), minV, maxV)) end end
      return el
    end

    function G:Dropdown(o)
      o = o or {}
      local id = newId()
      local values = type(o.Values) == "table" and o.Values or {}
      local multi = o.Multi == true
      getBox():AddDropdown(id, {
        Text = plain(o.Title), Values = values, Multi = multi, AllowNull = true,
        Searchable = #values > 8, Tooltip = o.Desc,
        Callback = function(v) if o.Callback then o.Callback(v) end end,
      })
      local cb = Options[id].Callback
      local function setQuiet(v)
        pcall(function() Options[id].Callback = function() end end)
        pcall(function() Options[id]:SetValue(v) end)
        pcall(function() Options[id].Callback = cb end)
      end
      if o.Value ~= nil and o.Value ~= "" then setQuiet(o.Value) end
      local el = {}
      function el:Set(v) pcall(function() Options[id]:SetValue(v) end) end
      el.Select = el.Set
      function el:Refresh(list) pcall(function() Options[id]:SetValues(list or {}) end) end
      el.SetValues = el.Refresh
      return el
    end

    function G:Input(o)
      o = o or {}
      local id = newId()
      getBox():AddInput(id, {
        Text = plain(o.Title), Default = tostring(o.Value or ""), Placeholder = o.Placeholder or "",
        Finished = true, ClearTextOnFocus = false, Tooltip = o.Desc,
        Callback = function(v) if o.Callback then o.Callback(v) end end,
      })
      local el = {}
      function el:Set(v) Options[id]:SetValue(tostring(v or "")) end
      return el
    end

    function G:Button(o)
      o = o or {}
      getBox():AddButton({ Text = plain(o.Title), Tooltip = o.Desc, Func = function() if o.Callback then task.spawn(o.Callback) end end })
      return Dead
    end

    function G:Paragraph(o)
      o = o or {}
      local title, desc = plain(o.Title), plain(o.Desc or o.Content)
      local label = getBox():AddLabel(desc ~= "" and (title .. "\n" .. desc) or title, true)
      local el = {}
      local function draw() pcall(function() label:SetText(desc ~= "" and (title .. "\n" .. desc) or title) end) end
      function el:SetTitle(t) title = plain(t) draw() end
      function el:SetDesc(t) desc = plain(t) draw() end
      el.Set = el.SetDesc
      return el
    end
    G.Label = G.Paragraph

    -- the "Toggle Keybind" picker becomes the Obsidian menu key
    function G:Keybind(o)
      o = o or {}
      getBox():AddLabel(plain(o.Title or "Menu key")):AddKeyPicker("MenuKeybind", {
        Default = o.Value or "RightShift", NoUI = true, Text = "Menu keybind",
      })
      Obsidian.ToggleKeybind = Options.MenuKeybind
      return Dead
    end

    return G
  end

  local Win = Obsidian:CreateWindow({
    Title = "ZRHUB",
    Footer = "Ride a Pet",
    Icon = "rbxthumb://type=Asset&id=129949624640047&w=150&h=150",
    NotifySide = "Right",
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(720, 580),
  })

  Library = {}
  function Library:Notify(o)
    o = o or {}
    Obsidian:Notify({ Title = plain(o.Title or "ZRHUB"), Description = plain(o.Content or o.Desc), Time = o.Duration or 4 })
  end
  v347 = Library

  window = { Tabs = {} }
  local TAB_ICONS = { Main = "egg", Visual = "eye", Misc = "layers", Webhooks = "bell", Settings = "settings" }
  function window:Tab(o)
    o = o or {}
    local name = o.Title or "Tab"
    if name == "Discord" then return setmetatable({}, { __index = function() return function() return Dead end end }) end
    local obsTab = Win:AddTab(name, TAB_ICONS[name] or o.Icon or "folder")
    local side, current = 0, nil
    local function newBox(title)
      side += 1
      current = (side % 2 == 1) and obsTab:AddLeftGroupbox(title, boxIcon(title)) or obsTab:AddRightGroupbox(title, boxIcon(title))
      return current
    end
    local tab = makeGroup(function() return current or newBox(name) end)
    function tab:Section(s)
      local title = type(s) == "table" and (s.Title or s.Name) or tostring(s or "Section")
      local box = newBox(plain(title))
      return makeGroup(function() return box end)
    end
    tab._obs = obsTab
    self.Tabs[#self.Tabs + 1] = tab

    if name == "Settings" then
      task.defer(function()
        local m = obsTab:AddRightGroupbox("Menu", "menu")
        if not Options.MenuKeybind then
          m:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
          Obsidian.ToggleKeybind = Options.MenuKeybind
        end
        ThemeManager:SetLibrary(Obsidian)
        ThemeManager:SetFolder("ZRHUB")
        ThemeManager:ApplyToTab(obsTab)
        ThemeManager:ApplyTheme("Jester")

        local creditsTab = Win:AddTab("Credits", "user")
        local CreditsBox = creditsTab:AddLeftGroupbox("Credits", "user")
        CreditsBox:AddLabel("Made by tung zo1os", true)
        CreditsBox:AddButton({
          Text = "Copy Discord Link",
          Func = function()
            pcall(setclipboard, "https://discord.gg/TCuMcKy9j4")
            Obsidian:Notify({ Title = "Copied!", Description = "Discord link copied.", Time = 3 })
          end,
        })
      end)
    end
    return tab
  end
  function window:Notify(o) return Library:Notify(o) end
  function window:Toggle(v) pcall(function() Obsidian:Toggle(v) end) end
  function window:Open() pcall(function() Obsidian:Toggle(true) end) end
  function window:SelectTab(t) pcall(function() if t and t._obs then t._obs:Show() end end) end
  function window:Destroy() pcall(function() Obsidian:Unload() end) end
  function window:Tag() end
end

_G.CrownHubInstance = window

-- mute spam; allow important alerts
do
  local _force = false
  local IMPORTANT = {
    ["ZRHUB"] = true,
    ["Cannot Rebirth"] = true,
    ["Rebirth Request Sent"] = true,
    ["Rebirth Completed"] = true,
    ["Magma Mutation (10x)!"] = true,
    ["Magma Mutation"] = true,
    ["Nest Full"] = true,
    ["No Egg"] = true,
    ["Error"] = true,
  }
  local function isImportant(opts)
    if _force then return true end
    if type(opts) ~= "table" then return false end
    local title = tostring(opts.Title or opts.title or "")
    if IMPORTANT[title] then return true end
    local content = tostring(opts.Content or opts.content or opts.Desc or "")
    local blob = (title .. " " .. content):lower()
    if blob:find("missing", 1, true) then return true end
    if blob:find("insufficient", 1, true) then return true end
    if blob:find("not enough", 1, true) then return true end
    if blob:find("inventory", 1, true) then return true end
    if blob:find("required", 1, true) then return true end
    if blob:find("rebirth", 1, true) and (blob:find("cannot", 1, true) or blob:find("fail", 1, true) or blob:find("cap", 1, true) or blob:find("need", 1, true)) then
      return true
    end
    if blob:find("magma", 1, true) and blob:find("mutation", 1, true) then return true end
    return false
  end
  local function gateNotify(tbl)
    if not tbl then return end
    local orig = tbl.Notify
    if type(orig) ~= "function" then return end
    tbl.Notify = function(self, opts)
      if isImportant(opts) then
        return orig(self, opts)
      end
    end
  end
  gateNotify(Library)
  gateNotify(window)
  if v347 then gateNotify(v347) end
  _G._CrownHubAllowNotify = function(v) _force = not not v end
end


local v355 = nil
pcall(function() if window.Tag then window:Tag({ Title = "Free", Color = Color3.fromHex("#D01818"), Border = true }) end end)
local autoFarmTab = window:Tab({ Title = "Main", Icon = "egg" })
local eggESPTab = window:Tab({ Title = "Visual", Icon = "eye" })
local plotPetsTab = window:Tab({ Title = "Misc", Icon = "layers" })
local movementTab = window:Tab({ Title = "Movement", Icon = "move" })
local webhooksTab = window:Tab({ Title = "Webhooks", Icon = "bell" })
local discordTab = window:Tab({ Title = "Discord", Icon = "message-circle" })
local settingsTab = window:Tab({ Title = "Settings", Icon = "settings" })

local function f50(p78, p79, p80)
  local v356 = os.clock()
  f2(0.76, "Building " .. p79 .. " tab...")

  local v357, v358 = xpcall(p80, function(p81)
    if debug and debug.traceback then
      return debug.traceback(tostring(p81), 2)
    end

    return tostring(p81)
  end)

  if not v357 then
    warn(string.format("[ZRHUB %s Error]: %s", p79, tostring(v358)))

    pcall(function()
      p78:Section({ Title = p79 .. " Status", Opened = true }):Paragraph({
        Title = "Initialization Notice",
        Desc = string.sub(tostring(v358), 1, 180),
      })

      if v347 and v347.Notify then
        v347:Notify({
          Title = p79 .. " Status",
          Content = string.sub(tostring(v358), 1, 80),
          Duration = 6,
          Icon = "alert-triangle",
        })
      end
    end)
  else
    print(string.format("[ZRHUB] %s tab built in %.2fs", p79, os.clock() - v356))
  end

  task.wait()
end

-- ============================================================
-- ZRHUB Collect Eggs engine (runs inside the Obsidian window above)
-- ============================================================
local ZR_MarioLib = {}
do
  local L = ZR_MarioLib
  L.Options = ZR_Obs.Options
  L.Toggles = ZR_Obs.Toggles
  function L:T(en) return en end
  function L:Notify(title, text, time)
    pcall(function()
      ZR_Obs:Notify({ Title = (tostring(title or "ZRHUB"):gsub("Mario Hub", "ZRHUB")), Description = tostring(text or ""), Time = tonumber(time) or 5 })
    end)
  end
  function L:Every(sec, fn)
    task.spawn(function()
      while not L._dead do
        task.wait(sec)
        pcall(fn)
      end
    end)
  end
  function L:Unload() L._dead = true end
  function L:OnUnload() end

  local function requireAsGame(module)
    local done, ok, loaded = false, false, nil
    task.spawn(function()
      if pcall(setthreadidentity, 2) then ok, loaded = pcall(require, module) end
      done = true
    end)
    local deadline = os.clock() + 10
    repeat if done then break end task.wait() until os.clock() > deadline
    return ok, loaded
  end

  L.Compat = {
    Caps = {
      Queue = (queue_on_teleport or queueonteleport) ~= nil,
      Touch = firetouchinterest ~= nil,
      Prompt = fireproximityprompt ~= nil,
      FileSystem = writefile ~= nil,
    },
    Require = function(module)
      local ok, loaded = pcall(require, module)
      if not ok and tostring(loaded):find("non-RobloxScript", 1, true) then
        ok, loaded = requireAsGame(module)
      end
      return ok, loaded
    end,
    Call = function(fn, ...) return fn(...) end,
    RestoreAll = function() end,
    Block = function() end,
    NeedCap = function() end,
  }
end

local MarioCore = (function()
do
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" and type(env.RideAPetUnload) == "function" then
        pcall(env.RideAPetUnload)
    end
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Library = ZR_MarioLib

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    GameId = 10035204815, PlaceId = 124216119978534,
    Tag = "[RideAPet]",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    LoadTimeout = 10, GameLibDeadline = 8,
    AlertTries = 8, AlertGap = 1.5, WarnGap = 5,

    PickupReach = 84,
    PickupLimit = 90,
    PickupRetryStep = 0.04,
    PickupReplyTimeout = 0.6,
    PickupAckWait = 0.12,
    PickupTotalTimeout = 1.5,
    TpSettle = 0.1, VolcanoSettle = 0.3, DismountTimeout = 10, DismountToolWindow = 2,
    DropOutside = 4,
    DropSettle = 0.2,
    DropSettleMax = 0.35,
    DropEndsSlack = 0.03,
    DropAppearTimeout = 1.0,
    DropLandMax = 8,
    StaleDropDistance = 20,
    DepositTimeout = 1.5,
    RunBudget = 4.0,
    DirectFactor = 2.5,
    DirectFactorAfterFail = 2.0,
    ReturnBackoff = { 2.0, 1.5 }, ReturnStopCount = 3, ReturnWindow = 300, ReturnDedupe = 3,
    UnmountedDirect = 90, WeightPenalty = 0.01, CherubWeightPenalty = 0.0125, WeightPenaltyMax = 0.8,
    ContainsSlack = 2, EdgeInset = 1, StandLift = 3,
    TripCost = { Plot = 0.35, Direct = 0.62, Drop = 1.25 },
    ContestWeight = 1.5, ContestWeightMax = 3, ContestHorizon = 6, UnmountedPlayerSpeed = 36,
    CycleLength = 420, CycleOffset = 418.5, WaveSurge = 12, WaveWakeEarly = 2,
    GoneBlacklistSec = 2,
    MountTimeout = 1.5, MountTries = 3, MountGap = 0.35,
    CarryDeferCap = 3,
    ReturnHopMax = 400,
    EggTick = 0.05, SlowTick = 1, EspTick = 0.25, EspTickMobile = 0.5,
    EspRange = 4000, EspRangeMobile = 1500,
    FailLimit = 5, FailWindow = 10,
    PlantSpacing = 6, PlantCapDefault = 10, HatchGap = 0.3,
    CollectMinPending = 60, SellRange = 9, SellBatch = 50, ConfirmWindow = 2,
    ShopBuyGap = 0.15, AfkRejoinSec = 1100,
    HunterHopsPerCycle = 5, HunterMinLeft = 90,
    VolcanoCenter = Vector3.new(-5103, 41406, -3489), VolcanoResultTimeout = 20, VolcanoMinBreakLeft = 3,
    PumpTick = 0.5, PlotRetry = 1, MobileViewport = 900,
    UnloadCarryTimeout = 2,
    JobTick = {
        Volcano = 0.25, Halloween = 0.1, Junk = 0.25, Hatch = 1, Plant = 2, Pets = 2,
        Feed = 1, Sell = 10, Fusion = 2, Economy = 3, Shop = 5, Rewards = 30, Boosts = 5, Server = 5,
        Webhook = 1, Settle = 1, Kaitun = 2,
    },
    JobBackoff = 40,

    HalloweenSettle = 0.55,
    CandyPickupSettle = 0.15,
    CandyCooldown = 2.1,
    CandyPrepAhead = 0.8,
    CandyPickupReach = 28,
    CandyPickupLimit = 32,
    CandyDirectFactor = 2,
    CandyDirectMax = 400,
    CandyDepositReach = 18,
    CandyRangeDefault = 1500,
    CandyCarryGoal = 6,
    CandySpoilAt = 12,
    CandyCollectTimeout = 2.5,
    CandyDepositTimeout = 2.5,
    CandySkipSec = 16,
    CandyStateCache = 3,
    CandyReturnFactor = 1,
    CandyDepositReserve = 2,
    TravelStepMax = 0.1,
    TravelStopDistance = 2,
    CandyPadLift = 3,
    CandyPadPos = Vector3.new(-45839.9, 40368.5, -20118.0),
    PortalPos = Vector3.new(-46800, 40390, -20000),
    DoorCooldown = 180,
    DoorStateCache = 3,
    DoorStand = 6,
    PumpkinCooldown = 40,
    PumpkinStateCache = 3,
    HalloweenPrio = 70,
    HalloweenPhaseBudget = 12,
    HalloweenManualTimeout = 180,
    HalloweenEggGap = 3,
    HalloweenPurchaseTimeout = 4,
    HalloweenShopRange = 20,
    HalloweenShopRetry = 8,
    HalloweenZoneTries = 5,
    HalloweenZoneGap = 2,
    RitualRetry = 20,
    RitualPrompts = 4,
    RitualPromptGap = 0.4,
    RitualStand = 8,
    EventStreamDist = 512,
    EventStreamTimeout = 5,
    GroundRayUp = 30,
    GroundRayDown = 60,

    VolcanoStreamTimeout = 5,
    VolcanoTouchEvery = 0.25,
    VolcanoStepWait = 5,
    VolcanoStandLift = 3,
    VolcanoRetry = 30,
    VolcanoDipSettle = 0.7,
    VolcanoRefire = 0.3,
    VolcanoTailEggs = 1,
    VolcanoClaimSec = 2,

    PlantReplyTimeout = 1.5,
    PlantTries = 3,
    EquipSettle = 0.1,
    HatchPending = 5,
    PlotEggsRefresh = 60, PlotFullRecheck = 10,
    PlantStandLift = 3,
    PlantLongGrow = 3600,
    PlantLongShare = 0.5,

    JunkEquipSettle = 0.1,
    JunkSpacing = 0.2,
    JunkSpacingMin = 0.1,
    JunkSpacingMax = 1,
    JunkSpacingUp = 0.05,
    JunkSpacingDown = 0.02,
    JunkSpacingEase = 20,
    JunkPlantTimeout = 0.9,
    JunkPlantFails = 8,
    JunkHatchRetry = 0.8,
    JunkHatchSlack = 0.02,
    JunkHatchSlackMax = 0.3,
    JunkHatchGapMax = 0.3,
    JunkHatchGapStep = 0.02,
    JunkSellEvery = 60,
    JunkQueueTtl = 30,
    JunkIdleCheck = 5,
    JunkResyncIdle = 8,
    JunkFullPause = 0.6,
    JunkAutoShare = 0.2,
    JunkShareSample = 200,
    JunkSessionMax = 45,
    JunkYieldGap = 3,
    JunkBackoff = 10,
    JunkRateWindow = 60,
    JunkReportGap = 0.5,
    JunkAnchorNear = 4,
    JunkPlotShare = 0.5,
    JunkYieldTo = {
        "AutoEquipBest", "AutoCollectCash", "AutoFeed", "AutoFusion", "AutoPlaceEggs",
    },

    PetReplyTimeout = 1.5,
    PetSwapGain = 1.01,
    PetSpread = 0.35,
    PetStandLift = 3,
    PetBaseKg = 10,
    PetMaxAge = 100,
    CollectGap = 0.15,
    FeedGap = 0.36, FeedBurst = 8, FeedMissLimit = 3, FeedReplyTimeout = 1,
    TopCacheSec = 1,
    AutoCollectPass = { "AutoCollect", "1940707069" },
    PetAgeRefresh = 30,
    PetWatchedAttrs = {
        PetKey = true, PetName = true, Weight = true, BaseWeight = true, Mutation = true,
        SpawnMutation = true, Age = true, BirthTime = true, Favorited = true,
    },

    SellReplyTimeout = 8,
    SellRetry = 0.45,
    SellTries = 5,
    SellNear = 3,
    SellPriceMult = 600,
    SellStand = 5,
    IncomeSettle = 1.5,
    SellSettle = 0.6,
    FuseSlots = 4,
    FuseStand = 3,
    FuseLift = 3,
    FuseSettle = 0.15,
    FuseReplyTimeout = 2,
    FuseGap = 0.3,
    FusePlaceSettle = 1,
    FuseResultTimeout = 5,
    WeekSec = 604800,
    SellKeepTopRarities = 3,

    UpgradePayback = 300,
    UpgradeBatch = 25,
    UpgradeGap = 0.1,
    UpgradeVerify = 1.5,
    UpgradeBackoff = 30,
    UpgradeMaxBuy = 1000,
    RebirthSaveWindow = 1800,
    RebirthVerify = 3,
    RebirthBackoff = 60,
    ShopReplyTimeout = 3,
    ShopRecheck = 300,
    ClaimVerify = 2,
    PromptRetry = 3600,
    GroupRewardCooldown = 86400,
    BoostAttributes = {
        "HatchLuckEventMultiplier", "HatchLuckEventUntil", "HatchMutationEventMultiplier",
        "HatchMutationEventUntil", "HatchSpeedBoostAmount", "HatchSpeedBoostUntil", "GlobalCashBoostUntil",
    },

    KaitunToggles = {
        "AutoEggs", "EggHunter", "AutoPlaceEggs", "AutoHatch", "AutoEquipBest",
        "AutoCollectCash", "AutoUpgrade", "AutoClaim", "SmartSpend",
    },
    KaitunHuntRarity = "Mythic",
    KaitunSteerEvery = 60,

    UpdateLog = {
        { "2026-10-12", "Improved Auto Candy targeting and smoother returns\nAdded Instant E and return speed controls up to 600% (default 350%)\nEvent farming now retries at a lower speed after movement rejection\nImproved Halloween egg buying and purchased egg hatching\nFixed egg delivery, hatch order, fusion claims and Kaitun target handling" },
        { "2026-10-11", "Updated Halloween candy, doors, pumpkins, event ESP and teleports\nImproved fusion eligibility and ground placement" },
    },
}

xDTaraZ.State = {
    Alive = true, Connections = {}, Halted = {}, Errors = {},
    Tune = { DropSettle = 0.2, ContestWeight = 1.5, DirectFactor = 2.5 },
    Status = {},
    PendingSet = {},
    PendingToggleOff = {},
    PendingNotify = {},
    LastFail = nil,
    Stats = { delivered = 0, lost = 0, returned = 0, plot = 0, direct = 0, drop = 0, staleDrops = 0, window = {} },
    PlotEggs = {}, PlantCap = 10, Weather = {},
    WarnedAt = {},
}

xDTaraZ.Options = {}

local Config, State = xDTaraZ.Config, xDTaraZ.State

Config.JobTick.Eggs, Config.JobTick.Hunter = Config.EggTick, Config.EggTick

State.Tune.DropSettle = Config.DropSettle
State.Tune.ContestWeight = Config.ContestWeight
State.Tune.DirectFactor = Config.DirectFactor
State.PlantCap = Config.PlantCapDefault

xDTaraZ.Util = {}

---@return boolean, any  ok, fn result or the error
function xDTaraZ.Util.Try(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if ok then return true, err end

    local now = os.clock()
    if now - (State.WarnedAt[label] or -math.huge) >= Config.WarnGap then
        State.WarnedAt[label] = now
        warn(Config.Tag .. " " .. label .. ":", err)
    end
    return false, err
end

---@return string|nil, string|nil  body, or nil and why every transport failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end

    local requester = (syn and syn.request) or (http and http.request) or http_request or request
    if not requester then return nil, "no http function" end

    local sent, response = pcall(requester, { Url = url, Method = "GET" })
    if not sent or type(response) ~= "table" then return nil, tostring(response) end
    if response.StatusCode ~= 200 or type(response.Body) ~= "string" then
        return nil, "HTTP " .. tostring(response.StatusCode)
    end
    return response.Body
end

---@param detail any  console only
function xDTaraZ.Util.Alert(text, detail)
    warn(Config.Tag, text, detail or "")
    task.spawn(function()
        for _ = 1, Config.AlertTries do
            local shown = pcall(StarterGui.SetCore, StarterGui, "SendNotification", { Title = "ZRHUB", Text = text, Duration = 10 })
            if shown then return end
            task.wait(Config.AlertGap)
        end
    end)
end

---@return table|nil  UI library, nil after an on-screen alert
function xDTaraZ.Util.LoadLibrary(url)
    local source, why = xDTaraZ.Util.HttpGet(url)
    if not source or not source:sub(-64):find("return%s+Library%s*$") then
        xDTaraZ.Util.Alert("Could not download the menu. Check your connection and run it again.", why or "truncated download")
        return nil
    end

    local chunk, compileErr = loadstring(source)
    if type(chunk) ~= "function" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor.", compileErr)
        return nil
    end

    local ok, lib = pcall(chunk)
    if not ok or type(lib) ~= "table" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor.", lib)
        return nil
    end
    return lib
end

function xDTaraZ.Util.Copy(text)
    local copier = setclipboard or toclipboard
    if not copier then return false end
    return (pcall(copier, text))
end

---@return boolean  queued for the next server
function xDTaraZ.Util.Queue(src)
    if not (Library and Library.Compat and Library.Compat.Caps.Queue) then return false end
    local queue = queue_on_teleport or queueonteleport
    if not queue then return false end
    return (pcall(queue, src))
end

function xDTaraZ.Util.ServerNow()
    return Workspace:GetServerTimeNow()
end

---@return number  XZ distance
function xDTaraZ.Util.Flat(a, b)
    local dx, dz = a.X - b.X, a.Z - b.Z
    return math.sqrt(dx * dx + dz * dz)
end

function xDTaraZ.Util.Format(n)
    n = tonumber(n) or 0
    if n ~= n or n == math.huge then return "-" end

    local suffixes = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx" }
    local step = 1
    repeat
        if math.abs(n) < 1000 then break end
        n /= 1000
        step += 1
    until step == #suffixes
    if step == 1 then return tostring(math.floor(n)) end
    return string.format("%.2f%s", n, suffixes[step])
end

---@return any  option value; the UI mirror first, then the live option
function xDTaraZ.Util.Opt(idx)
    local mirrored = xDTaraZ.Options[idx]
    if mirrored ~= nil then return mirrored end
    local option = Library and Library.Options and Library.Options[idx]
    return option and option.Value
end

---@param seconds number|nil
function xDTaraZ.Util.Notify(title, text, seconds)
    table.insert(State.PendingNotify, { title, text, seconds or 5 })
end

do
    local camera = Workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
    local touch = UserInputService.TouchEnabled
    local noKeys = not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

    xDTaraZ.Platform = {
        Touch = touch,
        Mobile = touch and (noKeys or viewport.X < Config.MobileViewport),
        Console = GuiService:IsTenFootInterface(),
        Viewport = viewport,
    }
end

---@return boolean  false when the executor has no working fps cap
function xDTaraZ.Util.SetFpsCap(fps)
    local ok = pcall(function() setfpscap(fps) end)
    return ok
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(self.State.Connections, conn)
    return conn
end

xDTaraZ.StopOrder = {
    "Kaitun", "Guard", "Eggs", "Hunter", "Volcano", "Halloween", "Prompts", "Junk", "Hatch", "Pets", "Sell", "Fusion",
    "Economy", "Shop", "Rewards", "Boosts", "Troll", "Server", "Webhook", "Visual",
}

function xDTaraZ:Unload()
    if not State.Alive or State.Unloading then return end
    State.Unloading = true
    local try = xDTaraZ.Util.Try

    try("unload carry", function() xDTaraZ.Eggs.FinishCarry(Config.UnloadCarryTimeout) end)
    State.Alive = false
    try("unload tasks", function() xDTaraZ.Tasks.ReleaseAll("unload") end)
    for _, name in ipairs(xDTaraZ.StopOrder) do
        local module = rawget(xDTaraZ, name)
        if module and module.Stop then try("unload " .. name, module.Stop) end
    end
    try("unload character", function() xDTaraZ.Player:Release() end)
    try("unload inventory", function() xDTaraZ.Eggs.QuietInventory(false, true) end)
    State.TeardownPending = true
    if not State.TeardownConn then xDTaraZ.Teardown() end
end

function xDTaraZ.Teardown()
    State.TeardownPending = false
    if State.TeardownConn then
        State.TeardownConn:Disconnect()
        State.TeardownConn = nil
    end
    local try = xDTaraZ.Util.Try

    try("unload move", function() xDTaraZ.Move.Restore() end)
    try("unload esp", function() xDTaraZ.Esp.Clear() end)
    try("unload hooks", function() Library.Compat.RestoreAll() end)

    try("unload player", function() xDTaraZ.Player:Unbind() end)
    for _, conn in ipairs(State.Connections) do
        if type(conn) == "function" then conn() else conn:Disconnect() end
    end
    table.clear(State.Connections)

    try("unload ui", function() Library:Unload() end)
end

---@param signal RBXScriptSignal  fired on a thread that never calls game code
function xDTaraZ.BindTeardown(signal)
    State.TeardownConn = signal:Connect(function()
        if State.TeardownPending then xDTaraZ.Teardown() end
    end)
end

do
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" then
        env.RideAPetUnload = function() xDTaraZ:Unload() end
    end
end

xDTaraZ.GameLib = {
    Data = {}, Svc = {}, Missing = {},
    Cache = {}, NetSearched = false,
    EggInfo = {}, PetInfo = {}, RarityOrder = {}, RarityRank = {}, FuseQuality = {},
    Foods = {}, FoodOrder = {}, ShopItems = {}, Rebirths = { Cap = 0, Costs = {} }, RebirthReq = {},
    IndexStages = {}, Mutations = {},
}

local GameLib = xDTaraZ.GameLib

GameLib.ServiceModules = { "General", "EggCycle", "DayNight", "EggDeliveryRules", "SellValue", "PetAging", "HalloweenEvent" }

GameLib.Denied = {
    Restock = true, SetOpenShop = true, RegisterSkipTarget = true, RegisterSkipAllTarget = true,
    UpdatePlayerToGift = true, CanGiftGamepass = true, CmdrFunction = true, PetMove = true,
    EggTimerPause = true, EggArrivalClaim = true,
    ["Reusable.Ban"] = true, ["Reusable.GetPlayerData"] = true, ["Reusable.InitiatePlot"] = true,
    ["Reusable.ClaimGroupReward"] = true, ["Reusable.ClaimEventReward"] = true, ["Reusable.Teleporting"] = true,
}
GameLib.DeniedPrefix = { "SkipGrowth" }
GameLib.ListenOnly = { Restock = true }

GameLib.Needs = {
    AutoEggs = { "EggPickup", "BasketDrop", "Mounting", "GameMessage", "ActiveEggs" },
    EggHunter = { "EggPickup", "BasketDrop", "ActiveEggs" },
    VolcanoDip = { "EggPickup", "BasketDrop", "VolcanoDip", "VolcanoDipResult" },
    VolcanoObby = { "EggPickup", "BasketDrop", "ActiveEggs" },
    AutoPlaceEggs = { "EggPlaced" },
    AutoHatch = { "Hatch" },
    ClearJunk = { "EggPlaced", "Hatch", "SellItems", "ConfirmRequest" },
    AutoEquipBest = { "PlacePet", "PickupPet" },
    AutoCollectCash = { "PetCollect" },
    AutoFeed = { "FeedPet" },
    AutoSell = { "SellItems", "ConfirmRequest" },
    AutoFusion = { "FusionPetPlace", "FusionAction" },
    AutoUpgrade = { "Plot.Upgrades" },
    AutoRebirth = { "Rebirth" },
    AutoShop = { "ShopStock", "BuyWithCash" },
    AutoClaim = { "ClaimIndexReward", "OfflineEarnings" },
    AutoCandy = { "CollectCandy", "GetCandyState" },
    AutoTrickOrTreat = { "KnockDoor", "GetDoorState" },
    AutoPumpkin = { "SearchPumpkin", "GetPumpkinState" },
    AutoHalloweenEgg = { "BuyHalloweenEgg" },
    Kaitun = { "EggPickup", "BasketDrop", "ActiveEggs" },
}

---@return boolean, any  ok, module or error; retried from an identity-2 thread
function GameLib.RequireAsGame(module)
    local done, ok, loaded = false, false, nil
    task.spawn(function()
        local switched = pcall(setthreadidentity, 2)
        if switched then ok, loaded = pcall(require, module) end
        done = true
    end)

    local deadline = os.clock() + xDTaraZ.Config.LoadTimeout
    repeat
        if done then break end
        task.wait()
    until os.clock() > deadline
    return ok, loaded
end

---@return table|nil
function GameLib.Require(module)
    if typeof(module) ~= "Instance" or not module:IsA("ModuleScript") then return nil end

    local ok, loaded
    if Library and Library.Compat then
        ok, loaded = Library.Compat.Require(module)
    else
        ok, loaded = pcall(require, module)
        if not ok and tostring(loaded):find("non-RobloxScript", 1, true) then
            ok, loaded = GameLib.RequireAsGame(module)
        end
    end

    if ok and type(loaded) == "table" then return loaded end
    warn(xDTaraZ.Config.Tag, "require " .. module.Name .. ":", loaded)
    return nil
end

---@return boolean, ...  ok, then the game function's results or the error
function GameLib.Call(fn, ...)
    if type(fn) ~= "function" then return false, "not a function" end
    if Library and Library.Compat then
        return pcall(Library.Compat.Call, fn, ...)
    end
    return pcall(fn, ...)
end

---@return boolean
function GameLib.IsDenied(name)
    if GameLib.Denied[name] then return true end
    for _, prefix in ipairs(GameLib.DeniedPrefix) do
        if name:sub(1, #prefix) == prefix then return true end
    end
    return false
end

---@return Instance|nil  the packages Net folder, found once whatever the _Index version
function GameLib.NetFolder()
    if GameLib.NetSearched then return GameLib.NetFolderRef end
    GameLib.NetSearched = true

    local packages = ReplicatedStorage:FindFirstChild("packages")
    if not packages then return nil end
    local direct = packages:FindFirstChild("Net")
    if direct then
        GameLib.NetFolderRef = direct
        return direct
    end

    for _, node in ipairs(packages:GetDescendants()) do
        if node.Name ~= "Net" then continue end
        for _, child in ipairs(node:GetChildren()) do
            if child.Name:sub(1, 3) == "RE/" then
                GameLib.NetFolderRef = node
                return node
            end
        end
    end
    return nil
end

---@param name string  "EggPickup", "Plot.Upgrades" or a packages Net name without "RE/"
---@return Instance|nil
function GameLib.Remote(name)
    if GameLib.IsDenied(name) then return nil end
    local cached = GameLib.Cache[name]
    if cached and cached.Parent then return cached end

    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameFolder = remotes and remotes:FindFirstChild("Game")
    local reusable = remotes and remotes:FindFirstChild("Reusable")
    local found

    local folder, leaf = name:match("^(%w+)%.(.+)$")
    if folder then
        local parent = gameFolder and gameFolder:FindFirstChild(folder)
        found = parent and parent:FindFirstChild(leaf)
    else
        found = gameFolder and gameFolder:FindFirstChild(name)
        if not found and reusable and not GameLib.IsDenied("Reusable." .. name) then
            found = reusable:FindFirstChild(name)
        end
        if not found then
            local net = GameLib.NetFolder()
            found = net and net:FindFirstChild("RE/" .. name)
        end
    end

    GameLib.Cache[name] = found
    return found
end

---@return Instance|nil  a denied remote that is only ever listened to, never fired
function GameLib.Listen(name)
    if not GameLib.ListenOnly[name] then return GameLib.Remote(name) end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameFolder = remotes and remotes:FindFirstChild("Game")
    return gameFolder and gameFolder:FindFirstChild(name)
end

xDTaraZ.Net = setmetatable({}, {
    __index = function(self, name)
        local remote = GameLib.Remote(name)
        if remote then rawset(self, name, remote) end
        return remote
    end,
})

---@return Instance|nil
function GameLib.ActiveEggs()
    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    return serverData and serverData:FindFirstChild("ActiveEggs")
end

---@return Model|nil
function GameLib.Plot()
    local general = GameLib.Svc.General
    if general and general.GetPlot then
        local ok, plot = GameLib.Call(general.GetPlot, general, LocalPlayer)
        if ok and typeof(plot) == "Instance" then return plot end
    end

    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in ipairs(plots:GetChildren()) do
        local data = plot:FindFirstChild("Data")
        local owner = data and data:FindFirstChild("Owner")
        if owner and owner.Value == LocalPlayer then return plot end
    end
    return nil
end

---@return boolean  same rule as the game's delivery check, Y ignored
function GameLib.Contains(bp, pos)
    local rel = bp.CFrame:PointToObjectSpace(pos)
    local slack = xDTaraZ.Config.ContainsSlack
    return math.abs(rel.X) <= bp.Size.X / 2 + slack and math.abs(rel.Z) <= bp.Size.Z / 2 + slack
end

function GameLib.CycleIndex()
    local cycle = GameLib.Svc.EggCycle
    if cycle then
        local ok, index = GameLib.Call(cycle.Index)
        if ok and type(index) == "number" then return index end
    end
    return math.floor((xDTaraZ.Util.ServerNow() - xDTaraZ.Config.CycleOffset) / xDTaraZ.Config.CycleLength)
end

---@return number  seconds until the next egg wave
function GameLib.CycleLeft()
    local cycle = GameLib.Svc.EggCycle
    if cycle then
        local ok, left = GameLib.Call(cycle.SecondsRemaining)
        if ok and type(left) == "number" then return left end
    end
    local length = xDTaraZ.Config.CycleLength
    return length - (xDTaraZ.Util.ServerNow() - xDTaraZ.Config.CycleOffset) % length
end

---@param mult number  hatch luck multiplier, event included
---@return table|nil   { {pet, chance} }
function GameLib.Odds(egg, mult)
    local hatchLuck, eggs = GameLib.Data.HatchLuck, GameLib.Data.Eggs
    local info = GameLib.EggInfo[egg]
    if not (hatchLuck and hatchLuck.GetOdds and eggs and eggs[egg] and info) then return nil end

    local ok, odds = GameLib.Call(hatchLuck.GetOdds, info.luck * (mult or 1), eggs[egg])
    if not ok or type(odds) ~= "table" then return nil end

    local out = {}
    for _, row in ipairs(odds) do
        if type(row) == "table" and row.PetName then
            out[#out + 1] = { row.PetName, tonumber(row.Chance) or 0 }
        end
    end
    return out
end

---@return number|nil  growth seconds an egg of this weight needs, nil when the game module is missing
function GameLib.GrowthSeconds(base, weight)
    local general = GameLib.Data.General
    if not (general and general.GrowthTimeFor) then return nil end

    local ok, total = GameLib.Call(general.GrowthTimeFor, base, weight)
    return ok and tonumber(total) or nil
end

---@return number|nil  growth seconds still needed, nil when the game modules are missing
function GameLib.GrowthLeft(placeTime, base, weight)
    local dayNight = GameLib.Svc.DayNight
    local total = GameLib.GrowthSeconds(base, weight)
    if not (total and dayNight and dayNight.GrowthElapsed) then return nil end

    local ok, elapsed = GameLib.Call(dayNight.GrowthElapsed, placeTime)
    if not ok then return nil end
    return total - (tonumber(elapsed) or 0)
end

---@return number|nil  real seconds until a placed egg is grown, night counts faster; nil when unknown
function GameLib.GrowthRealLeft(placeTime, base, weight)
    local dayNight = GameLib.Svc.DayNight
    local total = GameLib.GrowthSeconds(base, weight)
    if not (total and dayNight and dayNight.GrowthRealRemaining) then return nil end

    local ok, left = GameLib.Call(dayNight.GrowthRealRemaining, placeTime, total)
    return ok and tonumber(left) or nil
end

---@param into   table   GameLib.Data or GameLib.Svc
---@param stopAt number  shared deadline for every require
function GameLib.LoadFolder(folder, names, into, label, stopAt)
    for _, name in ipairs(names) do
        local module = folder and folder:FindFirstChild(name)
        if module and os.clock() < stopAt then into[name] = GameLib.Require(module) end
        if not into[name] then GameLib.Missing[label .. "." .. name] = module and "load timeout" or "module not found" end
    end
end

---@param folder  Instance  GameData or a folder nested inside it
---@param prefix  string    "" or a path like "Halloween."
function GameLib.LoadDataTree(folder, prefix, stopAt)
    for _, child in ipairs(folder:GetChildren()) do
        if os.clock() >= stopAt then return end
        local key = prefix .. child.Name
        if child:IsA("ModuleScript") then
            if GameLib.Data[key] == nil then
                GameLib.Data[key] = GameLib.Require(child)
                if not GameLib.Data[key] then GameLib.Missing["GameData." .. key] = "require failed" end
            end
        elseif child:IsA("Folder") then
            GameLib.LoadDataTree(child, key .. ".", stopAt)
        end
    end
end

function GameLib.LoadModules()
    local deadline = xDTaraZ.Config.GameLibDeadline
    local dataFolder = ReplicatedStorage:WaitForChild("GameData", deadline)
    local svcFolder = ReplicatedStorage:FindFirstChild("GameServices") or ReplicatedStorage:WaitForChild("GameServices", 1)
    local stopAt = os.clock() + deadline

    if dataFolder then
        GameLib.LoadDataTree(dataFolder, "", stopAt)
        local halloween = dataFolder:FindFirstChild("Halloween")
        local debuffs = halloween and halloween:FindFirstChild("Debuffs")
        if debuffs and GameLib.Data["Halloween.Debuffs"] == nil then
            GameLib.Data["Halloween.Debuffs"] = GameLib.Require(debuffs)
        end
    end
    GameLib.LoadFolder(svcFolder, GameLib.ServiceModules, GameLib.Svc, "GameServices", stopAt)
end

local function BuildRarities()
    local order, rank = GameLib.RarityOrder, GameLib.RarityRank
    table.clear(order)
    table.clear(rank)

    local general = GameLib.Data.General or {}
    local levels = general.RarityLevelRequirementMultiplier or {}
    local weight = {}
    for rarity, level in pairs(levels) do
        weight[rarity] = tonumber(level) or 0
    end

    local floor = {}
    for _, pet in pairs(GameLib.PetInfo) do
        floor[pet.rarity] = math.min(floor[pet.rarity] or math.huge, pet.income)
    end
    for _, egg in pairs(GameLib.EggInfo) do
        floor[egg.rarity] = floor[egg.rarity] or math.huge
    end
    for rarity, income in pairs(floor) do
        if not weight[rarity] then weight[rarity] = 1e9 + math.min(income, 1e12) end
    end

    for rarity in pairs(weight) do
        order[#order + 1] = rarity
    end
    table.sort(order, function(a, b) return weight[a] < weight[b] end)
    for index, rarity in ipairs(order) do
        rank[rarity] = index
    end
end

local function BuildEggsAndPets()
    table.clear(GameLib.EggInfo)
    table.clear(GameLib.PetInfo)
    local breakTimer = (GameLib.Data.General or {}).EggBreakTimer or {}

    for name, egg in pairs(GameLib.Data.Eggs or {}) do
        if type(egg) ~= "table" then continue end
        local rarity = egg.Rarity or "Common"
        GameLib.EggInfo[name] = {
            rarity = rarity,
            luck = tonumber(egg.Luck) or 0,
            growth = tonumber(egg.GrowthTime) or 0,
            breakSec = tonumber(breakTimer[rarity]) or 0,
            ethereal = rarity == "Ethereal",
            volcanic = egg.RequiresVolcano == true,
        }
    end

    for name, pet in pairs(GameLib.Data.Pets or {}) do
        if type(pet) ~= "table" or not pet.Rarity then continue end
        GameLib.PetInfo[name] = {
            rarity = pet.Rarity,
            speed = tonumber(pet.Speed) or 0,
            income = tonumber(pet.Income) or 0,
            fusionOnly = pet.FusionOnly == true,
            moveSpeed = tonumber(pet.MovementSpeed) or 0,
        }
    end
end

local function BuildEconomy()
    local data = GameLib.Data

    table.clear(GameLib.Foods)
    table.clear(GameLib.FoodOrder)
    for name, food in pairs(data.Foods or {}) do
        if type(food) ~= "table" then continue end
        GameLib.Foods[name] = { cost = tonumber(food.Cost) or 0, xp = tonumber(food.XP) or 0, rarity = food.Rarity, noFeedAll = food.NoFeedAll == true }
        table.insert(GameLib.FoodOrder, name)
    end
    table.sort(GameLib.FoodOrder, function(a, b) return GameLib.Foods[a].cost < GameLib.Foods[b].cost end)

    table.clear(GameLib.ShopItems)
    local categories = data.Shop and data.Shop.Categories or {}
    for category, items in pairs(categories) do
        for item, entry in pairs(items) do
            if type(entry) ~= "table" or entry.Source == "Lanterns" then continue end
            local price = tonumber(entry.Price) or (GameLib.Foods[item] and GameLib.Foods[item].cost) or 0
            GameLib.ShopItems[#GameLib.ShopItems + 1] = { cat = category, item = item, price = price, rarity = entry.Rarity }
        end
    end
    table.sort(GameLib.ShopItems, function(a, b) return a.price < b.price end)

    local rebirths = data.Rebirths
    GameLib.Rebirths.Cap = rebirths and tonumber(rebirths.Cap) or 0
    table.clear(GameLib.Rebirths.Costs)
    for n = 1, GameLib.Rebirths.Cap do
        local ok, cost = GameLib.Call(rebirths.GetCost, n - 1)
        GameLib.Rebirths.Costs[n] = ok and tonumber(cost) or math.huge
    end

    table.clear(GameLib.RebirthReq)
    for index, pet in ipairs((data.General or {}).RebirthRequirements or {}) do
        GameLib.RebirthReq[index] = pet
    end

    table.clear(GameLib.IndexStages)
    for _, stage in ipairs(data.IndexRewards and data.IndexRewards.Stages or {}) do
        table.insert(GameLib.IndexStages, { goal = tonumber(stage.Goal) or 0, reward = tonumber(stage.Reward) or 0 })
    end

    table.clear(GameLib.Mutations)
    for name, mutation in pairs(data.Mutations or {}) do
        if type(mutation) == "table" and mutation.StatMultiplier then
            GameLib.Mutations[name] = 1 + (tonumber(mutation.StatMultiplier) or 0) / 100
        end
    end
end

local function BuildFuseQuality()
    table.clear(GameLib.FuseQuality)
    local raw = GameLib.Data.WeightedFuseData
    if type(raw) ~= "table" then return end

    local holders = { raw.Pets, raw.Inputs, raw }
    for _, holder in ipairs(holders) do
        if type(holder) == "table" then
            for key, value in pairs(holder) do
                local name = key
                local quality = value
                if type(value) == "table" then
                    name = value.Name or value.PetName or value.Pet
                    quality = value.Quality or value.Value or value.Score
                end
                if type(name) == "string" and tonumber(quality) and GameLib.PetInfo[name] then
                    GameLib.FuseQuality[name] = tonumber(quality)
                end
            end
        end
        if next(GameLib.FuseQuality) then return end
    end
end

function GameLib.Build()
    BuildEggsAndPets()
    BuildRarities()
    BuildEconomy()
    BuildFuseQuality()
end

---@return number  pet sell price multiplier straight from the game's SellValue module
function GameLib.SellMultiplier()
    local sellValue = GameLib.Svc.SellValue
    local mult = type(sellValue) == "table" and tonumber(sellValue.SellIncomeMultiplier)
    return mult or xDTaraZ.Config.SellPriceMult
end

---@return number  the game's income multiplier for a rebirth count
function GameLib.RebirthMultiplier(done)
    local rebirths = GameLib.Data.Rebirths
    if type(rebirths) == "table" and type(rebirths.GetMultiplier) == "function" then
        local ok, mult = GameLib.Call(rebirths.GetMultiplier, done)
        if ok and tonumber(mult) then return tonumber(mult) end
    end
    return 1 + done
end

---@return number  hatch luck multiplier: bought upgrades times the live event multiplier
function GameLib.LuckMult()
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local upgrades = saved and saved:FindFirstChild("HatchUpgrades")
    local bought = upgrades and tonumber(upgrades.Value) or 0
    local event = tonumber(ReplicatedStorage:GetAttribute("HatchLuckEventMultiplier")) or 1
    return (1 + bought + 4 * math.floor(bought / 5)) * event
end

---@return string|nil  why the option cannot run
function GameLib.Blocked(idx)
    for _, name in ipairs(GameLib.Needs[idx] or {}) do
        local reason = GameLib.Missing[name]
        if reason then return reason end
    end
    return nil
end

function GameLib.Check()
    local started = os.clock()
    local deadline = xDTaraZ.Config.GameLibDeadline
    local seen = {}

    for _, names in pairs(GameLib.Needs) do
        for _, name in ipairs(names) do
            if seen[name] then continue end
            seen[name] = true
            if os.clock() - started > deadline then
                GameLib.Missing[name] = "check timed out"
                continue
            end

            local found
            if name == "ActiveEggs" then
                found = GameLib.ActiveEggs()
            else
                found = GameLib.Remote(name)
            end
            if not found then GameLib.Missing[name] = "not found after a game update" end
        end
    end

    if not GameLib.Data.Eggs or not GameLib.Data.Pets then
        GameLib.Missing.ActiveEggs = GameLib.Missing.ActiveEggs or "egg data not readable"
    end
end

xDTaraZ.Player = {
    Client = LocalPlayer,
    Char = nil, Humanoid = nil, Root = nil,
    Epoch = 0,
    BindVersion = 0,
    CharConns = {},
    PlotModel = nil, Baseplate = nil, PlotConn = nil, PlotRetryAt = 0,
}

function xDTaraZ.Player:Lose(char)
    if self.Char ~= char then return end
    if self.LostChar == char then return end
    self.LostChar = char
    self.BindVersion += 1
    self.Humanoid, self.Root = nil, nil
    self.Epoch += 1
    xDTaraZ.Util.Try("abort on death", function() xDTaraZ.Tasks.Abort("death") end)
    xDTaraZ.Util.Try("forget mount", function() xDTaraZ.Mount.Forget() end)
end

function xDTaraZ.Player:Unbind()
    self.BindVersion += 1
    self.Epoch += 1
    self.Char, self.Humanoid, self.Root = nil, nil, nil
    for _, conn in ipairs(self.CharConns) do
        conn:Disconnect()
    end
    table.clear(self.CharConns)
    if self.PlotConn then
        self.PlotConn:Disconnect()
        self.PlotConn = nil
    end
end

function xDTaraZ.Player:Bind(char)
    if not State.Alive or State.Unloading then return end
    if self.Char and self.Char ~= char then self:Lose(self.Char) end
    self.BindVersion += 1
    local version = self.BindVersion
    for _, conn in ipairs(self.CharConns) do
        conn:Disconnect()
    end
    table.clear(self.CharConns)
    self.Char, self.Humanoid, self.Root = char, nil, nil

    task.spawn(function()
        local hum = char:WaitForChild("Humanoid", Config.LoadTimeout)
        local hrp = char:WaitForChild("HumanoidRootPart", Config.LoadTimeout)
        if not State.Alive or State.Unloading or self.Char ~= char or self.BindVersion ~= version then return end
        if not hum or not hrp then
            warn(Config.Tag, "character parts missing after", Config.LoadTimeout, "s")
            return
        end

        self.Humanoid, self.Root = hum, hrp
        table.insert(self.CharConns, hum.Died:Connect(function() self:Lose(char) end))
    end)
end

function xDTaraZ.Player:IsAlive()
    local hum, hrp = self.Humanoid, self.Root
    return hum ~= nil and hum.Health > 0 and hrp ~= nil and hrp.Parent ~= nil
end

---@return Model|nil, BasePart|nil  plot and its baseplate
function xDTaraZ.Player:Plot()
    local plot, bp = self.PlotModel, self.Baseplate
    if plot and bp and plot.Parent and bp.Parent then return plot, bp end

    local now = os.clock()
    if now < self.PlotRetryAt then return nil, nil end
    self.PlotRetryAt = now + Config.PlotRetry

    plot = xDTaraZ.GameLib.Plot()
    bp = plot and plot:FindFirstChild("Baseplate")
    if not bp then return nil, nil end
    self.PlotModel, self.Baseplate = plot, bp

    if self.PlotConn then self.PlotConn:Disconnect() end
    local owner = plot:FindFirstChild("Data") and plot.Data:FindFirstChild("Owner")
    if owner then
        self.PlotConn = owner.Changed:Connect(function()
            self.PlotModel, self.Baseplate, self.PlotRetryAt = nil, nil, 0
        end)
    end
    return plot, bp
end

---@return Instance[]
function xDTaraZ.Player:BasketItems()
    local basket = LocalPlayer:FindFirstChild("Basket")
    return basket and basket:GetChildren() or {}
end

function xDTaraZ.Player:BasketCount()
    local basket = LocalPlayer:FindFirstChild("Basket")
    return basket and #basket:GetChildren() or 0
end

function xDTaraZ.Player:Riding()
    return LocalPlayer:GetAttribute("IsRiding") == true
end

---@async
---@return boolean  off the mount with empty hands, yields until the landing tool is put away
function xDTaraZ.Player:Release()
    local hum = self.Humanoid
    local remote = self:Riding() and xDTaraZ.GameLib.Remote("PetDismount")
    if remote and hum and hum.Parent then
        local landed = false
        local conn = hum.Parent.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then landed = true end
        end)
        remote:FireServer()

        local deadline = os.clock() + Config.DismountTimeout
        while self:Riding() and os.clock() < deadline do task.wait() end
        local toolBy = os.clock() + Config.DismountToolWindow
        while not landed and os.clock() < toolBy and hum.Parent do task.wait() end
        conn:Disconnect()
    end

    if self:BasketCount() > 0 or not hum then return not self:Riding() end
    hum:UnequipTools()
    return not self:Riding()
end

---@return number  server delivery-failure counter
function xDTaraZ.Player:Flags()
    return tonumber(LocalPlayer:GetAttribute("TeleportFlags")) or 0
end

xDTaraZ.Geo = {}

---@return number  root clearance for the current character and mount
function xDTaraZ.Geo.Lift(minimum)
    local hum, root = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Root
    return math.max(minimum or Config.StandLift, (hum and hum.HipHeight or 0) + (root and root.Size.Y / 2 or 0))
end

---@return Vector3  nearest point inside the baseplate edge, standing height
function xDTaraZ.Geo.EdgeInside(bp, target)
    local rel = bp.CFrame:PointToObjectSpace(target)
    local hx, hz = bp.Size.X / 2 - Config.EdgeInset, bp.Size.Z / 2 - Config.EdgeInset
    local clamped = Vector3.new(math.clamp(rel.X, -hx, hx), bp.Size.Y / 2 + xDTaraZ.Geo.Lift(), math.clamp(rel.Z, -hz, hz))
    return bp.CFrame:PointToWorldSpace(clamped)
end

---@param dist number  studs past the edge
---@return Vector3     point outside the baseplate on the side facing target
function xDTaraZ.Geo.Outside(bp, target, dist)
    local rel = bp.CFrame:PointToObjectSpace(target)
    local hx, hz = bp.Size.X / 2, bp.Size.Z / 2
    local cx, cz = math.clamp(rel.X, -hx, hx), math.clamp(rel.Z, -hz, hz)
    local dx, dz = rel.X - cx, rel.Z - cz
    local len = math.sqrt(dx * dx + dz * dz)
    if len < 1e-3 then dx, dz, len = 1, 0, 1 end

    return bp.CFrame:PointToWorldSpace(Vector3.new(cx + dx / len * dist, bp.Size.Y / 2 + xDTaraZ.Geo.Lift(), cz + dz / len * dist))
end

---@return Vector3  pickup spot on the egg-to-plot line, within reach of the egg
function xDTaraZ.Geo.StandPoint(bp, eggPos)
    local edge = xDTaraZ.Geo.EdgeInside(bp, eggPos)
    local dir = (edge - eggPos) * Vector3.new(1, 0, 1)
    local span = dir.Magnitude
    if span < 1e-3 then return Vector3.new(eggPos.X, eggPos.Y + xDTaraZ.Geo.Lift(), eggPos.Z) end

    local spot = eggPos + dir.Unit * math.min(Config.PickupReach, span)
    return Vector3.new(spot.X, eggPos.Y + xDTaraZ.Geo.Lift(), spot.Z)
end

---@return number  spatial distance to the plot entry, including elevated spawns
function xDTaraZ.Geo.Trip(bp, from)
    return (from - xDTaraZ.Geo.EdgeInside(bp, from)).Magnitude
end

function xDTaraZ.Geo.InPlot(pos)
    local _, bp = xDTaraZ.Player:Plot()
    return bp ~= nil and xDTaraZ.GameLib.Contains(bp, pos)
end

if LocalPlayer.Character then xDTaraZ.Player:Bind(LocalPlayer.Character) end
xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(char) xDTaraZ.Player:Bind(char) end)
xDTaraZ:Connect(LocalPlayer.CharacterRemoving, function(char) xDTaraZ.Player:Lose(char) end)

xDTaraZ.Tasks = { Current = nil, Prio = { Recover = 100, Volcano = 80, Hunter = 70, Mount = 65, Eggs = 60, Plot = 40, Travel = 30, Manual = 20 } }

function xDTaraZ.Tasks.Carrying()
    if xDTaraZ.Player:BasketCount() > 0 then return true end
    return xDTaraZ.Halloween ~= nil and xDTaraZ.Halloween.Carried() > 0
end

function xDTaraZ.Tasks.EggsBusy()
    local eggs = xDTaraZ.Eggs
    if not eggs or not eggs.Waiting then return false end
    return not eggs.Waiting()
end

---@return table|nil  token { owner, prio, epoch, dead, preempt }
function xDTaraZ.Tasks.Request(owner, prio)
    if not xDTaraZ.State.Alive then return nil end
    if xDTaraZ.State.Unloading and owner ~= "Recover" then return nil end
    if not xDTaraZ.Player:IsAlive() then return nil end

    if prio <= xDTaraZ.Tasks.Prio.Manual and xDTaraZ.Tasks.Carrying() then
        table.insert(xDTaraZ.State.PendingNotify, { "ZRHUB", "Finish the egg delivery first" })
        return nil
    end
    if prio <= xDTaraZ.Tasks.Prio.Plot and prio > xDTaraZ.Tasks.Prio.Manual and xDTaraZ.Tasks.EggsBusy() then return nil end

    local cur = xDTaraZ.Tasks.Current
    if cur and (cur.dead or cur.epoch ~= xDTaraZ.Player.Epoch) then
        cur.dead = true
        cur = nil
        xDTaraZ.Tasks.Current = nil
    end

    if cur then
        if prio > cur.prio then cur.preempt = true end
        return nil
    end

    local token = { owner = owner, prio = prio, epoch = xDTaraZ.Player.Epoch, thread = coroutine.running(), dead = false, preempt = false }
    local hrp = xDTaraZ.Player.Root
    if prio <= xDTaraZ.Tasks.Prio.Plot and hrp then token.home = hrp.CFrame end
    xDTaraZ.Tasks.Current = token
    return token
end

function xDTaraZ.Tasks.Release(token)
    if not token or token.dead then return end
    token.dead = true
    if xDTaraZ.Tasks.Current ~= token then return end
    xDTaraZ.Tasks.Current = nil

    local opts = xDTaraZ.Options
    local back = opts and opts.ReturnAfter
    if not token.home or not back or not xDTaraZ.State.Alive or xDTaraZ.State.Unloading or xDTaraZ.Tasks.Carrying() then return end
    local hrp = xDTaraZ.Player.Root
    if hrp and xDTaraZ.Player:IsAlive() and token.epoch == xDTaraZ.Player.Epoch then
        hrp.CFrame = token.home
        hrp.AssemblyLinearVelocity = Vector3.zero
    end
end

---@return boolean  false after preempt, death or unload
function xDTaraZ.Tasks.Holds(token)
    if not token or token.dead or not xDTaraZ.State.Alive then return false end
    if xDTaraZ.Tasks.Current ~= token or token.epoch ~= xDTaraZ.Player.Epoch then return false end
    if not token.preempt or token.critical then return true end
    local delivering = token.owner == "Eggs" or token.owner == "Hunter" or token.owner == "Recover" or token.owner == "Volcano" or token.owner == "Halloween"
    if delivering and ((xDTaraZ.Eggs and xDTaraZ.Eggs.CarryCritical) or xDTaraZ.Tasks.Carrying()) then return true end

    xDTaraZ.Tasks.Release(token)
    return false
end

---@param cond     function|nil  nil waits the full timeout
---@return boolean, string        "ok"|"timeout"|"preempted"|"death"|"unload"
function xDTaraZ.Tasks.Await(token, cond, timeout)
    local deadline = os.clock() + timeout
    repeat
        if not xDTaraZ.State.Alive then return false, "unload" end
        if not token or token.epoch ~= xDTaraZ.Player.Epoch then return false, "death" end
        if not xDTaraZ.Tasks.Holds(token) then return false, "preempted" end
        if cond and cond() then return true, "ok" end
        task.wait()
    until os.clock() >= deadline
    return false, "timeout"
end

---@return boolean  refuses dead tokens
function xDTaraZ.Tasks.Teleport(token, cf)
    if not xDTaraZ.Tasks.Holds(token) then return false end
    if token.epoch ~= xDTaraZ.Player.Epoch or not xDTaraZ.Player:IsAlive() then return false end
    local hrp = xDTaraZ.Player.Root
    if not hrp then return false end

    hrp.CFrame = cf
    hrp.AssemblyLinearVelocity = Vector3.zero
    return true
end

function xDTaraZ.Tasks.Abort(why)
    local cur = xDTaraZ.Tasks.Current
    if not cur then return end
    cur.dead, cur.why = true, why
    xDTaraZ.Tasks.Current = nil
end

---@async
---@return boolean  reached the destination with bounded movement per frame
function xDTaraZ.Tasks.Travel(token, cf, speed, timeout, opts)
    local deadline = os.clock() + timeout
    local collisions, originalCollisions, clipConnections = {}, {}, {}
    local root = xDTaraZ.Player.Root
    local rotation = root and root.CFrame.Rotation
    local hum = xDTaraZ.Player.Humanoid
    local autoRotate = hum and hum.AutoRotate
    local ok, reached = pcall(function()
        if hum then hum.AutoRotate = false end
        if opts and opts.noClip and xDTaraZ.Player.Char then
            local function addPart(part)
                if not part:IsA("BasePart") or originalCollisions[part] ~= nil then return end
                originalCollisions[part] = part.CanCollide
                collisions[#collisions + 1] = part
                part.CanCollide = false
            end
            local function addModel(model)
                for _, part in ipairs(model:GetDescendants()) do addPart(part) end
                if model.DescendantAdded then
                    clipConnections[#clipConnections + 1] = model.DescendantAdded:Connect(function(part)
                        if xDTaraZ.Tasks.Holds(token) then addPart(part) end
                    end)
                end
            end
            addModel(xDTaraZ.Player.Char)
            local joint = root and root.FindFirstChild and root:FindFirstChild("PetMountJoint")
            local mount = joint and joint.Part1 and joint.Part1:FindFirstAncestorOfClass("Model")
            if mount and mount ~= xDTaraZ.Player.Char then addModel(mount) end
            clipConnections[#clipConnections + 1] = RunService.Stepped:Connect(function()
                if not xDTaraZ.Tasks.Holds(token) then return end
                for _, part in ipairs(collisions) do
                    if part.Parent and part.CanCollide then part.CanCollide = false end
                end
            end)
        end
        while xDTaraZ.Tasks.Holds(token) and os.clock() < deadline do
            if opts and opts.maxFlags ~= nil and xDTaraZ.Player:Flags() > opts.maxFlags then return false end
            if opts and opts.done and opts.done() then return true end
            local hrp = xDTaraZ.Player.Root
            if not hrp or not xDTaraZ.Player:IsAlive() then return false end
            local delta = cf.Position - hrp.Position
            local reach = opts and opts.reach or Config.TravelStopDistance
            if delta.Magnitude <= reach then return true end
            if hum then hum:Move(Vector3.zero) end
            local elapsed = task.wait()
            if not xDTaraZ.Tasks.Holds(token) then return false end
            if opts and opts.maxFlags ~= nil and xDTaraZ.Player:Flags() > opts.maxFlags then return false end
            if opts and opts.done and opts.done() then return true end
            for _, part in ipairs(collisions) do
                if part.Parent and part.CanCollide then part.CanCollide = false end
            end
            delta = cf.Position - hrp.Position
            if delta.Magnitude <= reach then return true end
            local currentSpeed = type(speed) == "function" and speed() or speed
            if type(currentSpeed) ~= "number" or currentSpeed ~= currentSpeed or currentSpeed <= 0 or currentSpeed == math.huge then return false end
            local step = math.min(delta.Magnitude, currentSpeed * math.min(elapsed, Config.TravelStepMax))
            local pos = hrp.Position + delta.Unit * step
            local nextCF = CFrame.new(pos) * rotation
            if not xDTaraZ.Tasks.Teleport(token, nextCF) then return false end
        end
        return false
    end)

    for _, connection in ipairs(clipConnections) do connection:Disconnect() end
    for _, part in ipairs(collisions) do
        if part.Parent then part.CanCollide = originalCollisions[part] end
    end
    if hum and hum.Parent then hum.AutoRotate = autoRotate end
    if not ok then error(reached, 0) end
    return reached
end

function xDTaraZ.Tasks.ReleaseAll(why)
    xDTaraZ.Tasks.Abort(why or "release")
end

function xDTaraZ.Tasks.Owner()
    local cur = xDTaraZ.Tasks.Current
    return cur and not cur.dead and cur.owner or nil
end

xDTaraZ.Scheduler = { Jobs = {}, Order = {}, Booted = false }

xDTaraZ.Scheduler.Defaults = {
    { "Eggs", "Eggs", "Step", { "AutoEggs" } },
    { "Hunter", "Hunter", "Step", { "EggHunter" } },
    { "Volcano", "Volcano", "Step", { "VolcanoDip", "VolcanoObby" } },
    { "Halloween", "Halloween", "Step", { "AutoCandy", "AutoTrickOrTreat", "AutoPumpkin", "AutoHalloweenEgg", "AutoRitual" }, function() return xDTaraZ.Halloween.AnyActive() end },
    { "Junk", "Junk", "Step", { "ClearJunk" } },
    { "Hatch", "Hatch", "Step", { "AutoHatch" }, function()
        return xDTaraZ.Util.Opt("AutoHatch") == true or (xDTaraZ.Util.Opt("HalloweenAutoHatch") ~= false and next(xDTaraZ.Hatch.Purchased) ~= nil)
    end },
    { "Plant", "Hatch", "PlantStep", { "AutoPlaceEggs" } },
    { "Pets", "Pets", "Step", { "AutoEquipBest", "AutoCollectCash" } },
    { "Feed", "Pets", "FeedStep", { "AutoFeed" } },
    { "Sell", "Sell", "Step", { "AutoSell" } },
    { "Fusion", "Fusion", "Step", { "AutoFusion" } },
    { "Economy", "Economy", "Step", { "AutoUpgrade", "AutoRebirth", "SmartSpend" } },
    { "Shop", "Shop", "Step", { "AutoShop" } },
    { "Rewards", "Rewards", "Step", { "AutoClaim" } },
    { "Boosts", "Boosts", "Step", nil },
    { "Server", "Server", "Step", nil },
    { "Esp", "Esp", "Step", { "EggEsp" } },
    { "HalloweenEsp", "Halloween", "EspStep", { "HalloweenEsp" } },
    { "Webhook", "Webhook", "Step", nil },
    { "Settle", "Eggs", "SettleStep", nil },
    { "Kaitun", "Kaitun", "Step", { "Kaitun" } },
}

---@param enabledFn function|nil  nil = any of toggles is on, or always when toggles is nil too
---@param toggles string[]|nil    switched off when the job halts
function xDTaraZ.Scheduler.Add(name, interval, fn, enabledFn, toggles)
    local job = xDTaraZ.Scheduler.Jobs[name]
    if not job then
        job = { name = name, due = 0, busy = false }
        job.runner = function()
            job.thread = coroutine.running()
            local ok, err = pcall(function()
                if not State.Alive or State.Unloading then return end
                job.fn()
            end)
            job.busy = false
            if not ok then xDTaraZ.Scheduler.Fail(job, err) end
            job.thread = nil
        end
        xDTaraZ.Scheduler.Jobs[name] = job
        table.insert(xDTaraZ.Scheduler.Order, job)
    end
    job.interval, job.fn, job.enabledFn, job.toggles = interval, fn, enabledFn, toggles or {}
    return job
end

---@return boolean
function xDTaraZ.Scheduler.Enabled(job)
    if State.Halted[job.name] then return false end
    if job.enabledFn then return job.enabledFn() == true end
    if #job.toggles == 0 then return true end

    for _, idx in ipairs(job.toggles) do
        if xDTaraZ.Util.Opt(idx) == true then return true end
    end
    return false
end

function xDTaraZ.Scheduler.Fail(job, err)
    local token = xDTaraZ.Tasks.Current
    if token and job.thread and token.thread == job.thread then xDTaraZ.Tasks.Abort("job error: " .. job.name) end
    local now = os.clock()
    local log = State.Errors[job.name] or {}
    State.Errors[job.name] = log

    local kept = {}
    for _, at in ipairs(log) do
        if now - at <= Config.FailWindow then kept[#kept + 1] = at end
    end
    kept[#kept + 1] = now
    State.Errors[job.name] = kept

    if #kept == 1 then warn(Config.Tag, job.name .. " failing:", err) end
    if #kept < Config.FailLimit then return end

    if #job.toggles == 0 then
        State.Errors[job.name] = nil
        job.due = now + Config.JobBackoff
        warn(Config.Tag, job.name .. " backing off:", err)
        return
    end

    State.Halted[job.name] = true
    for _, idx in ipairs(job.toggles) do
        table.insert(State.PendingToggleOff, idx)
    end
    local line = tostring(err):match("^[^\n]*") or "unknown error"
    xDTaraZ.Util.Notify("ZRHUB", job.name .. " stopped: " .. line, 8)
end

function xDTaraZ.Scheduler.Run(job)
    if job.busy or not State.Alive or State.Unloading then return end
    job.busy = true
    task.spawn(job.runner)
end

function xDTaraZ.Scheduler.Tick()
    if not State.Alive or State.Unloading then return end
    local now = os.clock()
    for _, job in ipairs(xDTaraZ.Scheduler.Order) do
        if job.busy or now < job.due then continue end
        job.due = now + job.interval
        local ok, enabled = pcall(xDTaraZ.Scheduler.Enabled, job)
        if not ok then
            xDTaraZ.Scheduler.Fail(job, enabled)
            continue
        end
        if not enabled then continue end
        xDTaraZ.Scheduler.Run(job)
    end
end

---@param key string  job name or toggle idx
function xDTaraZ.Scheduler.Resume(key)
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if name == key or table.find(job.toggles, key) then
            State.Halted[name] = nil
            State.Errors[name] = nil
            job.due = 0
        end
    end
end

function xDTaraZ.Scheduler.Pump()
    if not Library then return end
    if #State.PendingToggleOff == 0 and #State.PendingNotify == 0 then return end

    local offList = State.PendingToggleOff
    State.PendingToggleOff = {}
    for _, idx in ipairs(offList) do
        local option = Library.Options and Library.Options[idx]
        if option and option.Value then option:SetValue(false) end
        xDTaraZ.Options[idx] = false
    end

    local notes = State.PendingNotify
    State.PendingNotify = {}
    for _, note in ipairs(notes) do
        Library:Notify(note[1], note[2], note[3] or 5)
    end
end

function xDTaraZ.Scheduler.AddDefaults()
    local espTick = xDTaraZ.Platform.Mobile and Config.EspTickMobile or Config.EspTick
    for _, row in ipairs(xDTaraZ.Scheduler.Defaults) do
	local name, owner, method, toggles, enabledFn = row[1], row[2], row[3], row[4], row[5]
	local interval = Config.JobTick[name] or espTick
	if xDTaraZ.Scheduler.Jobs[name] then continue end

	local module = rawget(xDTaraZ, owner)
	local fn = module and module[method]
	if type(fn) ~= "function" then
		warn(Config.Tag, "no job function " .. owner .. "." .. method)
		continue
	end
	xDTaraZ.Scheduler.Add(name, interval, fn, enabledFn, toggles)
end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true

    xDTaraZ.Scheduler.AddDefaults()
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Tick)
end

xDTaraZ.Signal = {}
xDTaraZ.Signal.__index = xDTaraZ.Signal

function xDTaraZ.Signal.new()
    return setmetatable({ handlers = {} }, xDTaraZ.Signal)
end

---@return function  call to disconnect
function xDTaraZ.Signal:Connect(fn)
    local handlers = self.handlers
    handlers[#handlers + 1] = fn
    return function()
        local at = table.find(handlers, fn)
        if at then table.remove(handlers, at) end
    end
end

function xDTaraZ.Signal:Fire(...)
    for _, fn in ipairs(table.clone(self.handlers)) do
        xDTaraZ.Util.Try("signal", fn, ...)
    end
end

xDTaraZ.EggIndex = {
    Entries = {}, Conns = {}, Waiters = {},
    Claimed = {}, LocalClaims = {}, Blacklist = {}, Failed = {}, FailCap = 2,
    Memo = {}, Mult = nil, Median = nil, ValueEpoch = 0,
    Cycle = nil, RolledAt = 0, Started = false,
    OnAdded = xDTaraZ.Signal.new(),
    OnRemoved = xDTaraZ.Signal.new(),
    OnReply = xDTaraZ.Signal.new(),
    OnRoll = xDTaraZ.Signal.new(),
}

---@return number  hatch luck multiplier: upgrades x live event
function xDTaraZ.EggIndex.LuckMult()
    return GameLib.LuckMult()
end

---@return number  expected income of one hatch, luck-based fallback when odds are unreadable
function xDTaraZ.EggIndex.Expected(egg, mult)
    local key = egg .. "|" .. mult
    local memo = xDTaraZ.EggIndex.Memo
    if memo[key] then return memo[key] end

    local total = 0
    for _, pair in ipairs(GameLib.Odds(egg, mult) or {}) do
        local pet = GameLib.PetInfo[pair[1]]
        total += (tonumber(pair[2]) or 0) * (pet and pet.income or 0)
    end
    if total <= 0 then
        local info = GameLib.EggInfo[egg]
        total = (info and info.luck or 0) * mult
    end

    memo[key] = total
    return total
end

function xDTaraZ.EggIndex.Value(entry)
    if not entry.egg then return 0 end
    local index = xDTaraZ.EggIndex
    index.Mult = index.Mult or index.LuckMult()
    local factor = entry.mutation and GameLib.Mutations[entry.mutation] or 1
    return index.Expected(entry.egg, index.Mult) * (entry.weight or 1) * factor
end

function xDTaraZ.EggIndex.Revalue()
    local index = xDTaraZ.EggIndex
    table.clear(index.Memo)
    index.Mult = nil
    for _, entry in pairs(index.Entries) do
        entry.value = index.Value(entry)
    end
    index.Median = nil
    index.ValueEpoch += 1
end

---@param entry table?  refreshed in place when given
function xDTaraZ.EggIndex.Read(inst, entry)
    entry = entry or { guid = inst.Name, inst = inst }
    entry.egg = inst:GetAttribute("Egg")
    entry.pos = inst:GetAttribute("Position")
    entry.weight = tonumber(inst:GetAttribute("Weight")) or 1
    entry.mutation = inst:GetAttribute("Mutation")
    entry.cycle = tonumber(inst:GetAttribute("Cycle"))
    entry.privateTo = inst:GetAttribute("PrivateTo")
    entry.area = inst:GetAttribute("Area") == true
    entry.dropEndsAt = tonumber(inst:GetAttribute("DropEndsAt"))
    entry.origin = inst:GetAttribute("OriginPosition")
    entry.value = xDTaraZ.EggIndex.Value(entry)
    return entry
end

function xDTaraZ.EggIndex.Add(inst)
    local index = xDTaraZ.EggIndex
    if index.Entries[inst.Name] then return end
    local entry = index.Read(inst)
    index.Entries[inst.Name] = entry
    index.Median = nil

    index.Conns[inst.Name] = inst.AttributeChanged:Connect(function(attr)
        if attr ~= "Position" and attr ~= "DropEndsAt" and attr ~= "PrivateTo" then return end
        local wasDropped = entry.dropEndsAt ~= nil
        index.Read(inst, entry)
        if attr == "DropEndsAt" and not wasDropped and entry.dropEndsAt then index.OnAdded:Fire(entry) end
    end)

    index.OnAdded:Fire(entry)
end

function xDTaraZ.EggIndex.Remove(inst)
    local index = xDTaraZ.EggIndex
    local entry = index.Entries[inst.Name]
    if not entry then return end
    index.Entries[inst.Name] = nil
    entry.removed = true

    local conn = index.Conns[inst.Name]
    if conn then conn:Disconnect() end
    index.Conns[inst.Name] = nil
    index.Median = nil
    index.OnRemoved:Fire(entry)
end

---@param key string  egg guid, or "*carry" for Deposited/BasketFull
function xDTaraZ.EggIndex.Expect(key)
    local waiter = {}
    xDTaraZ.EggIndex.Waiters[key] = waiter
    return waiter
end

function xDTaraZ.EggIndex.Deliver(key, kind, text)
    local waiter = key and xDTaraZ.EggIndex.Waiters[key]
    if not waiter or waiter.kind then return end
    waiter.kind, waiter.text = kind, text
end

---@return string, string?  PickedUp|Refused|Gone|BasketFull|Deposited|Timeout, server text
function xDTaraZ.EggIndex.WaitReply(key, timeout)
    local index = xDTaraZ.EggIndex
    local waiter = index.Waiters[key] or index.Expect(key)
    local deadline = os.clock() + timeout
    while not waiter.kind and os.clock() < deadline and State.Alive do
        task.wait()
    end
    if index.Waiters[key] == waiter then index.Waiters[key] = nil end
    if not waiter.kind then return "Timeout" end
    return waiter.kind, waiter.text
end

function xDTaraZ.EggIndex.Route(kind, first, second)
    local index = xDTaraZ.EggIndex
    if kind == "PickedUp" then
        index.Deliver(second, "PickedUp", first)
        index.OnReply:Fire("PickedUp", second, first)
    elseif kind == "Refused" then
        local text = tostring(first)
        local verdict = text:find("already gone", 1, true) and "Gone" or "Refused"
        if verdict == "Gone" and second then index.Blacklist[second] = os.clock() + Config.GoneBlacklistSec end
        index.Deliver(second, verdict, text)
        index.OnReply:Fire(verdict, second, text)
    elseif kind == "Deposited" then
        index.Deliver("*carry", "Deposited", tostring(first))
        index.OnReply:Fire("Deposited", nil, first)
    elseif kind == "BasketFull" then
        for key in pairs(index.Waiters) do index.Deliver(key, "BasketFull") end
        index.OnReply:Fire("BasketFull")
    end
end

function xDTaraZ.EggIndex.OnMessage(text)
    if type(text) ~= "string" then return end
    if text:find("Egg Delivery Failed", 1, true) or text:find("Was Returned", 1, true) then
        xDTaraZ.Guard.Trip("message")
    end
end

function xDTaraZ.EggIndex.ReadClaims()
    local index = xDTaraZ.EggIndex
    local raw = LocalPlayer:GetAttribute("CollectedEggCycles")
    if type(raw) ~= "string" or raw == "" then return end

    local http = game:GetService("HttpService")
    local ok, decoded = pcall(http.JSONDecode, http, raw)
    if not ok or type(decoded) ~= "table" then
        index.ClaimsBroken = true
        return
    end

    table.clear(index.Claimed)
    for egg, cycle in pairs(decoded) do
        index.Claimed[egg] = tonumber(cycle)
    end
    index.ClaimsBroken = false
end

---@return number  last cycle this egg was claimed in, -1 if never
function xDTaraZ.EggIndex.ClaimedCycle(egg)
    local index = xDTaraZ.EggIndex
    return math.max(index.Claimed[egg] or -1, index.LocalClaims[egg] or -1)
end

function xDTaraZ.EggIndex.MarkClaimed(egg, cycle)
    if not egg or not cycle then return end
    local claims = xDTaraZ.EggIndex.LocalClaims
    claims[egg] = math.max(claims[egg] or -1, cycle)
end

function xDTaraZ.EggIndex.MarkGone(guid)
    if guid then xDTaraZ.EggIndex.Blacklist[guid] = os.clock() + Config.GoneBlacklistSec end
end

function xDTaraZ.EggIndex.Fail(guid)
    local failed = xDTaraZ.EggIndex.Failed
    failed[guid] = (failed[guid] or 0) + 1
end

---@return boolean  true on the tick the egg cycle rolled over
function xDTaraZ.EggIndex.CheckRoll()
    local index = xDTaraZ.EggIndex
    local cycle = GameLib.CycleIndex()
    if cycle == index.Cycle then return false end

    local rolled = index.Cycle ~= nil
    index.Cycle = cycle
    if not rolled then return false end

    table.clear(index.Blacklist)
    table.clear(index.Failed)
    index.RolledAt = os.clock()
    index.OnRoll:Fire(cycle)
    return true
end

---@return number  median value of the eggs on the map now
function xDTaraZ.EggIndex.MedianValue()
    local index = xDTaraZ.EggIndex
    if index.Median then return index.Median end

    local values = {}
    for _, entry in pairs(index.Entries) do
        local info = entry.egg and GameLib.EggInfo[entry.egg]
        if info and not info.volcanic then values[#values + 1] = entry.value or 0 end
    end
    table.sort(values)

    index.Median = values[math.max(1, math.ceil(#values / 2))] or 0
    return index.Median
end

---@return string?  reason the egg cannot be taken right now
function xDTaraZ.EggIndex.Blocked(entry, info)
    local index = xDTaraZ.EggIndex
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return "private" end
    if info.volcanic then return "volcanic" end
    if entry.dropEndsAt and xDTaraZ.Util.ServerNow() < entry.dropEndsAt then return "falling" end
    if info.ethereal and entry.cycle and entry.cycle <= index.ClaimedCycle(entry.egg) then return "claimed" end
    if (index.Blacklist[entry.guid] or 0) > os.clock() then return "taken" end
    if (index.Failed[entry.guid] or 0) >= index.FailCap then return "failed" end
    return nil
end

---@return boolean  passes the user's egg filters
function xDTaraZ.EggIndex.Allowed(entry, info)
    local opts = xDTaraZ.Options
    local rarities, names = opts.EggRarities, opts.EggNames
    local floor = GameLib.RarityRank[opts.MinEggRarity or ""]
    if floor and (GameLib.RarityRank[info.rarity] or 0) < floor then return false end
    if type(rarities) == "table" and next(rarities) and not rarities[info.rarity] then return false end
    if type(names) == "table" and next(names) and not names[entry.egg] then return false end
    if (info.luck or 0) < (tonumber(opts.MinLuck) or 0) then return false end
    return entry.weight >= (tonumber(opts.MinWeight) or 0)
end

---@param ignoreFilters boolean?  hunter-only mode skips the user filters
---@return boolean, string?       wanted, reason when not
function xDTaraZ.EggIndex.Wanted(entry, ignoreFilters)
    if entry.removed or not entry.pos or not entry.egg then return false, "gone" end
    local info = GameLib.EggInfo[entry.egg]
    if not info then return false, "unknown" end

    local reason = xDTaraZ.EggIndex.Blocked(entry, info)
    if reason then return false, reason end
    if ignoreFilters then return true end

    if not xDTaraZ.EggIndex.Allowed(entry, info) then return false, "filtered" end
    if xDTaraZ.Options.SmartEggs and (entry.value or 0) < xDTaraZ.EggIndex.MedianValue() then return false, "low value" end
    return true
end

function xDTaraZ.EggIndex.WatchValues()
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local upgrades = saved and saved:FindFirstChild("HatchUpgrades")
    if upgrades then xDTaraZ:Connect(upgrades.Changed, xDTaraZ.EggIndex.Revalue) end
    xDTaraZ:Connect(ReplicatedStorage:GetAttributeChangedSignal("HatchLuckEventMultiplier"), xDTaraZ.EggIndex.Revalue)
    xDTaraZ:Connect(LocalPlayer:GetAttributeChangedSignal("CollectedEggCycles"), xDTaraZ.EggIndex.ReadClaims)
end

---@return boolean  index is live
function xDTaraZ.EggIndex.Start()
    local index = xDTaraZ.EggIndex
    if index.Started then return true end
    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    local folder = serverData and serverData:FindFirstChild("ActiveEggs")
    if not folder then return false end
    index.Started = true

    xDTaraZ:Connect(folder.ChildAdded, xDTaraZ.EggIndex.Add)
    xDTaraZ:Connect(folder.ChildRemoved, xDTaraZ.EggIndex.Remove)
    for _, inst in ipairs(folder:GetChildren()) do
        index.Add(inst)
    end

    local pickup = GameLib.Remote("EggPickup")
    if pickup then xDTaraZ:Connect(pickup.OnClientEvent, xDTaraZ.EggIndex.Route) end
    local message = GameLib.Remote("GameMessage")
    if message then xDTaraZ:Connect(message.OnClientEvent, xDTaraZ.EggIndex.OnMessage) end

    index.WatchValues()
    index.ReadClaims()
    index.Cycle = GameLib.CycleIndex()
    return true
end

function xDTaraZ.EggIndex.Stop()
    local index = xDTaraZ.EggIndex
    for guid, conn in pairs(index.Conns) do
        conn:Disconnect()
        index.Conns[guid] = nil
    end
    table.clear(index.Waiters)
end

local CollectionService = game:GetService("CollectionService")

xDTaraZ.Halloween = {
    Enabled = false,
    Phase = "Idle",
    PhaseAt = 0,
    Note = nil,
    Token = nil,
    Target = nil,
    CarriedBefore = 0,
    CarriedWas = 0,
    FirstPickAt = 0,
    NextCollectAt = 0,
    LastCollectAt = 0,
    GroundRay = nil,
    ManualCandy = false,
    ManualPass = nil,
    ManualUntil = nil,
    BuyOnce = false,
    BuyTravel = false,
    Purchase = nil,
    LastBuyAt = 0,
    PriceSeen = nil,
    PriceFound = nil,
    EggsBought = 0,
    TokensEarned = 0,
    Cycles = 0,
    Spoiled = 0,
    StartedAt = 0,
    Bound = false,
    AwaitCarried = false,
    Conns = {},
    Boards = {},
    DoorAt = {},
    PumpkinAt = {},
    SkipUntil = {},
    CandyState = nil,
    CandyStateAt = 0,
    DoorState = nil,
    DoorStateAt = 0,
    PumpkinState = nil,
    PumpkinStateAt = 0,
    RitualAt = 0,
    RitualSeenOpen = false,
    ZoneTries = 0,
    ZoneRetryAt = 0,
    PadCache = nil,
    DepositCarried = 0,
    DepositBankBefore = 0,
    DepositRetried = false,
    Busy = false,
    FlagsBaseline = nil,
    Finishing = false,
    Stats = { candy = 0, knocks = 0, treats = 0 },
}

function xDTaraZ.Halloween.SetPhase(phase, note)
    local halloween = xDTaraZ.Halloween
    halloween.Phase, halloween.PhaseAt, halloween.Note = phase, os.clock(), note
    xDTaraZ.Halloween.UpdateStatus()
end

function xDTaraZ.Halloween.UpdateStatus()
    local halloween = xDTaraZ.Halloween
    if not halloween.Enabled and not halloween.ManualCandy and not halloween.ManualPass then
        State.Status.Halloween = "Off"
        return
    end

    local mins = halloween.StartedAt > 0 and math.floor((os.clock() - halloween.StartedAt) / 60) or 0
    local note = halloween.Note and (halloween.Note .. " | ") or ""
    State.Status.Halloween = string.format("%s%s | Carried %d | Bank %s | %dm",
        note, halloween.Phase, xDTaraZ.Halloween.Carried(), xDTaraZ.Util.Format(xDTaraZ.Halloween.Tokens()), mins)
end

---@return number  candy held while walking, from the player's replicated data
function xDTaraZ.Halloween.Carried()
    local noSave = LocalPlayer:FindFirstChild("NoSaveData")
    local node = noSave and noSave:FindFirstChild("CarriedCandy")
    return node and tonumber(node.Value) or 0
end

---@return number  event tokens banked
function xDTaraZ.Halloween.Tokens()
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local node = saved and saved:FindFirstChild("HalloweenCandy")
    return node and tonumber(node.Value) or 0
end

---@return boolean|nil  false when the game says we are off the event island
function xDTaraZ.Halloween.InZone()
    local value = LocalPlayer:GetAttribute("InHalloweenZone")
    if value == nil then
        local char = xDTaraZ.Player.Char
        value = char and char:GetAttribute("InHalloweenZone")
    end
    if value == nil then
        value = Workspace:GetAttribute("InHalloweenZone")
    end
    return value
end

---@return boolean  the event island is in this server
function xDTaraZ.Halloween.EventLive()
    if #CollectionService:GetTagged("HalloweenCandyDeposit") > 0 then return true end
    if #CollectionService:GetTagged("HalloweenCandySpawn") > 0 then return true end
    return Workspace:FindFirstChild("HeadlessRitual") ~= nil
end

---@return Vector3  a world point for a tagged spawn, prompt or model
function xDTaraZ.Halloween.PointOf(inst)
    if inst:IsA("BasePart") then return inst.Position end
    if inst:IsA("Model") then return inst:GetPivot().Position end
    if inst:IsA("Attachment") then return inst.WorldPosition end

    local holder = inst:FindFirstAncestorOfClass("BasePart") or inst:FindFirstAncestorOfClass("Model")
    if holder then
        return holder:IsA("BasePart") and holder.Position or holder:GetPivot().Position
    end
    return nil
end

---@return Vector3  candy pad position, tag first then the measured fallback
function xDTaraZ.Halloween.PadPos()
    local halloween = xDTaraZ.Halloween
    if halloween.PadCache and halloween.PadCache.Parent then
        return halloween.PadCache.Position
    end

    for _, inst in ipairs(CollectionService:GetTagged("HalloweenCandyDeposit")) do
        local pos = xDTaraZ.Halloween.PointOf(inst)
        if pos then
            halloween.PadCache = inst
            return pos
        end
    end
    return Config.CandyPadPos
end

---@return CFrame  standing spot on the candy pad
function xDTaraZ.Halloween.PadCF()
    return CFrame.new(xDTaraZ.Halloween.PadPos() + Vector3.new(0, xDTaraZ.Halloween.StandLift(), 0))
end

---@return number  root height for the current character and mount
function xDTaraZ.Halloween.StandLift()
    local hum, hrp = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Root
    return math.max(Config.CandyPadLift, (hum and hum.HipHeight or 0) + (hrp and hrp.Size.Y / 2 or 0))
end

---@return CFrame  ground-relative pickup position on the pad-facing side
function xDTaraZ.Halloween.PickupCF(pos, inst)
    local lift = xDTaraZ.Halloween.StandLift()
    local pad = xDTaraZ.Halloween.PadPos()
    local dir = (pad - pos) * Vector3.new(1, 0, 1)
    local reach = math.sqrt(math.max(0, Config.CandyPickupReach * Config.CandyPickupReach - lift * lift))
    local spot = pos
    if dir.Magnitude > Config.TravelStopDistance then spot += dir.Unit * math.min(reach, dir.Magnitude) end

    local ray = xDTaraZ.Halloween.GroundRay
    if not ray then
        ray = RaycastParams.new()
        ray.FilterType = Enum.RaycastFilterType.Exclude
        ray.RespectCanCollide = true
        xDTaraZ.Halloween.GroundRay = ray
    end
    ray.FilterDescendantsInstances = { xDTaraZ.Player.Char or Workspace, inst }
    local hit = Workspace:Raycast(spot + Vector3.new(0, Config.GroundRayUp, 0), Vector3.new(0, -(Config.GroundRayUp + Config.GroundRayDown), 0), ray)
    local stand = (hit and hit.Position or spot) + Vector3.new(0, lift, 0)
    local facing = Vector3.new(pad.X, stand.Y, pad.Z)
    return (facing - stand).Magnitude > Config.TravelStopDistance and CFrame.lookAt(stand, facing) or CFrame.new(stand)
end

---@return number  a single verified short-hop budget, not repeated teleports
function xDTaraZ.Halloween.DirectLimit(ignoreStyle)
    if not ignoreStyle and xDTaraZ.Halloween.ReturnHopDisabled then return 0 end
    if not ignoreStyle and xDTaraZ.Util.Opt("CandyReturnStyle") == "Smooth ride" then return 0 end
    local speed = xDTaraZ.Mount.Speed()
    return math.min(Config.CandyDirectMax, speed > 0 and speed * Config.CandyDirectFactor or Config.UnmountedDirect)
end

---@return CFrame  the event portal entrance
function xDTaraZ.Halloween.PortalCF()
    local map = Workspace:FindFirstChild("Map")
    local portal = map and map:FindFirstChild("Portal")
    local outer = portal and portal:FindFirstChild("Model")
    local inner = outer and outer:FindFirstChild("Model")
    local part = inner and inner:FindFirstChild("Part")
    if part and part:IsA("BasePart") then
        return CFrame.new(part.Position + Vector3.new(0, Config.StandLift, 0))
    end
    if portal and portal:IsA("Model") then
        return CFrame.new(portal:GetPivot().Position + Vector3.new(0, Config.StandLift, 0))
    end
    return CFrame.new(Config.PortalPos)
end

---@return Instance[]  tagged trick-or-treat houses
function xDTaraZ.Halloween.Houses()
    return CollectionService:GetTagged("TrickOrTreatHouseModel")
end

---@return string  door id the remotes use for this house
function xDTaraZ.Halloween.DoorId(house, pivot)
    local attr = house:GetAttribute("Id") or house:GetAttribute("DoorId")
    if attr then return attr end
    return "Door_" .. math.round(pivot.Position.X) .. "_" .. math.round(pivot.Position.Z)
end

---@return table|nil  cached GetCandyState answer
function xDTaraZ.Halloween.AskCandy()
    local halloween = xDTaraZ.Halloween
    local now = os.clock()
    if halloween.CandyStateAt > 0 and now - halloween.CandyStateAt < Config.CandyStateCache then
        return halloween.CandyState
    end

    local remote = xDTaraZ.Net.GetCandyState
    if not remote then return halloween.CandyState end
    local ok, state = GameLib.Call(remote.InvokeServer, remote)
    halloween.CandyStateAt = now
    if ok and type(state) == "table" then halloween.CandyState = state end
    return halloween.CandyState
end

---@return table  id -> { respawnAt, amount, respawning }
function xDTaraZ.Halloween.SpawnState()
    local parsed = {}
    local state = xDTaraZ.Halloween.AskCandy()
    if type(state) ~= "table" then return parsed end

    local raw = state
    for _, key in ipairs({ "Spawns", "Candy", "CandySpawns" }) do
        if type(state[key]) == "table" then
            raw = state[key]
            break
        end
    end
    if raw == state and type(state.RespawnAt) == "table" then
        local now = workspace:GetServerTimeNow()
        for id, at in pairs(state.RespawnAt) do
            if type(id) == "string" and tonumber(at) and at > now then
                parsed[id] = { respawnAt = tonumber(at), amount = 0, respawning = true }
            end
        end
        for id, amount in pairs(state.Amounts or {}) do
            if type(id) == "string" then
                local at = tonumber(state.RespawnAt[id])
                parsed[id] = {
                    respawnAt = at and at > now and at or nil,
                    amount = tonumber(amount) or 0,
                    tier = tonumber(state.Types and state.Types[id]),
                    respawning = at ~= nil and (at > now),
                }
            end
        end
        return parsed
    end
    for id, entry in pairs(raw) do
        if type(id) == "string" and type(entry) == "table" then
            parsed[id] = {
                respawnAt = tonumber(entry.RespawnAt),
                amount = tonumber(entry.Amounts) or tonumber(entry.Amount),
                tier = tonumber(entry.Tier) or tonumber(entry.Type),
                respawning = entry.Respawning == true,
            }
        end
    end
    return parsed
end

---@return table|nil  the game's shared Halloween config module
function xDTaraZ.Halloween.CandyLib()
    return GameLib.Data.Halloween
end

---@param entry { amount, tier }  parsed spawn state
---@param dist number  distance from the candy pad
---@return number  bankable pieces per pickup cycle; unreachable spawns score zero
function xDTaraZ.Halloween.CandyValue(entry, dist)
    local count = tonumber(entry.amount) or 1
    if count ~= count or count <= 0 or count == math.huge then return 0 end
    local returning = math.max(0, dist - Config.CandyPickupReach - Config.CandyDepositReach)
    local direct = xDTaraZ.Halloween.DirectLimit()
    local mode = xDTaraZ.Util.Opt("CandyMode") or "Most pieces"
    if mode == "Fast returns" and returning > xDTaraZ.Halloween.DirectLimit(true) then return 0 end
    local speed = xDTaraZ.Halloween.ReturnSpeed() / xDTaraZ.Halloween.ReturnFactor()
    local types = xDTaraZ.Halloween.CandyLib()
    local kind = types and types.CandyTypes and types.CandyTypes[tonumber(entry.tier)]
    local debuffs = GameLib.Data["Halloween.Debuffs"]
    local heavy = debuffs and debuffs.HeavyGravity
    if xDTaraZ.Util.Opt("CandyAvoidSpoil") ~= false and kind and debuffs and debuffs.Enabled
        and debuffs.AffectedModels and debuffs.AffectedModels[kind.Model] and heavy and heavy.Enabled then
        speed /= math.max(tonumber(heavy.SpeedDivisor) or 1, 1)
    end
    local seconds = math.max(0, returning - direct) / math.max(speed, 1)
    if seconds + Config.CandyDepositReserve >= Config.CandySpoilAt then return 0 end
    if mode == "Most pieces" then return count end
    return count / math.max(Config.CandyCooldown, seconds + Config.CandyDepositReserve)
end

---@return number  movement budget from the active mount and actual humanoid speed
function xDTaraZ.Halloween.ReturnFactor()
    local percent = tonumber(xDTaraZ.Util.Opt("CandyReturnSpeed"))
    local factor = percent and percent / 100 or Config.CandyReturnFactor
    if type(factor) ~= "number" or factor ~= factor then return 1 end
    factor = math.clamp(factor, 1, 6)
    local cap = xDTaraZ.Halloween.ReturnCapPercent
    return cap and math.min(factor, cap / 100) or factor
end

---@return number  selected return speed, following the current humanoid slowdown
function xDTaraZ.Halloween.ReturnSpeed()
    local hum = xDTaraZ.Player.Humanoid
    local speed = xDTaraZ.Mount.TravelSpeed()
    if speed <= 0 then speed = Config.UnmountedPlayerSpeed end
    return math.min(speed, hum and hum.WalkSpeed or 0) * xDTaraZ.Halloween.ReturnFactor()
end

---@return boolean  the spawn is on its respawn timer
function xDTaraZ.Halloween.Respawning(inst, entry)
    if entry and entry.respawning then return true end
    local at = tonumber(inst:GetAttribute("RespawnAt")) or entry and entry.respawnAt
    if not at then return false end
    if at > 1e6 then return xDTaraZ.Util.ServerNow() < at end
    return os.clock() < at
end

---@param dropsOnly boolean?  only door and pumpkin drops
---@return table|nil  { id, pos, value } the highest value spawn
function xDTaraZ.Halloween.NextCandy(dropsOnly)
    local halloween = xDTaraZ.Halloween
    if os.clock() + Config.CandyPrepAhead < halloween.NextCollectAt then return nil end

    local pad = xDTaraZ.Halloween.PadPos()
    local states = xDTaraZ.Halloween.SpawnState()
    local known = next(states) ~= nil
    local now = os.clock()

    local best, bestScore, bestDistance = nil, 0, math.huge
    for _, inst in ipairs(CollectionService:GetTagged("HalloweenCandySpawn")) do
        local id = inst:GetAttribute("Id") or inst.Name
        local pos = xDTaraZ.Halloween.PointOf(inst)
        if not (id and pos) then continue end
        if dropsOnly and not (id:sub(1, 9) == "DoorCandy" or id:sub(1, 11) == "PumpkinDrop") then continue end
        if (halloween.SkipUntil[id] or 0) > now then continue end

        local entry = states[id]
        if xDTaraZ.Halloween.Respawning(inst, entry) then continue end
        if known and not entry then continue end
        if entry and (entry.amount or 0) <= 0 then continue end
        if (entry and entry.amount or 1) < (tonumber(xDTaraZ.Util.Opt("CandyMinAmount")) or 1) then continue end

        local dist = (pos - pad).Magnitude
        if dist > (tonumber(xDTaraZ.Util.Opt("CandyMaxRange")) or Config.CandyRangeDefault) then continue end
        local score = xDTaraZ.Halloween.CandyValue(entry or {}, dist)
        if score > bestScore or (score > 0 and score == bestScore and dist < bestDistance) then
            bestScore = score
            bestDistance = dist
            best = { id = id, pos = pos, value = score, instance = inst }
        end
    end
    if best then best.cf = xDTaraZ.Halloween.PickupCF(best.pos, best.instance) end
    return best
end

---@return number|nil  seconds until the next candy respawn, nil when unknown
function xDTaraZ.Halloween.NextRespawnIn()
    local states = xDTaraZ.Halloween.SpawnState()
    local soonest = nil
    for _, entry in pairs(states) do
        if entry.respawning and entry.respawnAt then
            local left = entry.respawnAt - workspace:GetServerTimeNow()
            if left > 0 and (not soonest or left < soonest) then
                soonest = left
            end
        end
    end
    return soonest
end

---@return table|nil  cached GetDoorState answer
function xDTaraZ.Halloween.AskDoors()
    local halloween = xDTaraZ.Halloween
    local now = os.clock()
    if halloween.DoorStateAt > 0 and now - halloween.DoorStateAt < Config.DoorStateCache then
        return halloween.DoorState
    end

    local remote = xDTaraZ.Net.GetDoorState
    if not remote then return halloween.DoorState end
    local ok, state = GameLib.Call(remote.InvokeServer, remote)
    halloween.DoorStateAt = now
    if ok and type(state) == "table" then halloween.DoorState = state end
    return halloween.DoorState
end

---@return boolean|nil  lit state of a door, nil when unknown
function xDTaraZ.Halloween.DoorLit(id)
    local state = xDTaraZ.Halloween.AskDoors()
    if type(state) ~= "table" then return nil end

    local raw = type(state.Doors) == "table" and state.Doors or state
    local entry = raw[id]
    if type(entry) == "table" then return entry.Lit == true end
    if type(entry) == "boolean" then return entry end
    return nil
end

---@return table|nil  { id, cf } a lit door that is off cooldown
function xDTaraZ.Halloween.NextDoor()
    local halloween = xDTaraZ.Halloween
    local now = os.clock()
    for _, house in ipairs(xDTaraZ.Halloween.Houses()) do
        if not house:IsA("Model") then continue end
        local pivot = house:GetPivot()
        local id = xDTaraZ.Halloween.DoorId(house, pivot)
        if (halloween.DoorAt[id] or 0) > now then continue end
        if xDTaraZ.Halloween.DoorLit(id) ~= true then continue end

        return {
            id = id,
            cf = CFrame.new(pivot.Position + Vector3.new(Config.DoorStand, Config.StandLift, Config.DoorStand)),
        }
    end
    return nil
end

---@return boolean  this pumpkin was searched recently
function xDTaraZ.Halloween.PumpkinLooted(state, id)
    if type(state) ~= "table" then return false end
    local raw = state.Pumpkins or state
    local entry = raw[id]
    if type(entry) ~= "table" then return false end

    local searched = tonumber(entry.SearchedAt)
    if not searched then return entry.Looted == true end
    local age = searched > 1e6 and (xDTaraZ.Util.ServerNow() - searched) or (os.clock() - searched)
    return entry.Looted == true or age < Config.PumpkinCooldown
end

---@return table|nil  { id, pos } a pumpkin that can be searched
function xDTaraZ.Halloween.NextPumpkin()
    local halloween = xDTaraZ.Halloween
    local remote = xDTaraZ.Net.GetPumpkinState
    local now = os.clock()
    if remote and now - halloween.PumpkinStateAt >= Config.PumpkinStateCache then
        local ok, state = GameLib.Call(remote.InvokeServer, remote)
        halloween.PumpkinStateAt = now
        if ok and type(state) == "table" then halloween.PumpkinState = state end
    end

    for _, inst in ipairs(CollectionService:GetTagged("PumpkinPrompt")) do
        local id = inst:GetAttribute("Id") or (inst.Parent and inst.Parent:GetAttribute("Id")) or inst.Name
        local pos = xDTaraZ.Halloween.PointOf(inst)
        if not (id and pos) then continue end
        if (halloween.PumpkinAt[id] or 0) > now then continue end
        if xDTaraZ.Halloween.PumpkinLooted(halloween.PumpkinState, id) then continue end
        return { id = id, pos = pos }
    end
    return nil
end

---@return table|nil  { model, phase, open }
function xDTaraZ.Halloween.RitualInfo()
    local ritual = Workspace:FindFirstChild("HeadlessRitual")
    if not ritual then return nil end

    local phase = ritual:GetAttribute("Phase")
    local cooldownUntil = tonumber(ritual:GetAttribute("CooldownUntil")) or 0
    return {
        model = ritual,
        phase = phase,
        open = phase == "Open" and xDTaraZ.Util.ServerNow() >= cooldownUntil,
    }
end

---@return CFrame|nil  altar stand point while the ritual is open
function xDTaraZ.Halloween.RitualReady()
    local halloween = xDTaraZ.Halloween
    local info = xDTaraZ.Halloween.RitualInfo()
    if not info then
        State.Status.Ritual = "Ritual not found"
        return nil
    end
    if not info.open then
        State.Status.Ritual = "Ritual: " .. tostring(info.phase)
        halloween.RitualSeenOpen = false
        return nil
    end

    if not halloween.RitualSeenOpen then
        halloween.RitualSeenOpen = true
        xDTaraZ.Util.Notify("Halloween", "The ritual is open", 8)
    end
    if os.clock() < halloween.RitualAt then return nil end

    local pivot = info.model:GetPivot()
    return CFrame.new(pivot.Position + pivot.LookVector * Config.RitualStand + Vector3.new(0, Config.StandLift, 0))
end

---@return integer  prompts triggered at the altar
function xDTaraZ.Halloween.RitualInteract()
    local info = xDTaraZ.Halloween.RitualInfo()
    if not info then return 0 end

    local fired = 0
    for _, node in ipairs(info.model:GetDescendants()) do
        if fired >= Config.RitualPrompts then break end
        if not (node:IsA("ProximityPrompt") and node.Enabled) then continue end
        if xDTaraZ.Rewards.TriggerPrompt(node) then fired += 1 end
        task.wait(Config.RitualPromptGap)
    end
    return fired
end

---@return boolean  any event feature wants the character right now
function xDTaraZ.Halloween.WantsMove()
	local opt = xDTaraZ.Util.Opt
	return xDTaraZ.Halloween.Finishing or xDTaraZ.Halloween.BuyTravel or xDTaraZ.Halloween.Purchase ~= nil or opt("AutoCandy") == true or opt("AutoTrickOrTreat") == true or opt("AutoPumpkin") == true
		or opt("AutoRitual") == true or xDTaraZ.Halloween.ManualCandy == true or xDTaraZ.Halloween.ManualPass ~= nil
end

---@return boolean  the scheduler job should run (toggles or a manual pass)
function xDTaraZ.Halloween.AnyActive()
	local opt = xDTaraZ.Util.Opt
	return xDTaraZ.Halloween.WantsMove() or opt("AutoHalloweenEgg") == true or xDTaraZ.Halloween.BuyOnce == true
end

---@return boolean  we hold the character token
function xDTaraZ.Halloween.Claim()
    local halloween = xDTaraZ.Halloween
    if halloween.Token and xDTaraZ.Tasks.Holds(halloween.Token) then return true end
    halloween.Token = xDTaraZ.Tasks.Request("Halloween", Config.HalloweenPrio)
    return halloween.Token ~= nil
end

function xDTaraZ.Halloween.Release()
    local halloween = xDTaraZ.Halloween
    local token = halloween.Token
    halloween.Token = nil
    if token then xDTaraZ.Tasks.Release(token) end
end

function xDTaraZ.Halloween.Reset(note)
    local halloween = xDTaraZ.Halloween
    halloween.Target = nil
    halloween.DepositRetried = false
    if halloween.CollectBankBefore ~= nil and xDTaraZ.Halloween.Carried() == 0 then halloween.CollectBankBefore = nil end
    xDTaraZ.Halloween.Release()
    xDTaraZ.Halloween.SetPhase("Idle", note)
end

function xDTaraZ.Halloween.BeginDeposit()
    local halloween = xDTaraZ.Halloween
    halloween.DepositCarried = xDTaraZ.Halloween.Carried()
    halloween.DepositBankBefore = halloween.CollectBankBefore or xDTaraZ.Halloween.Tokens()
    halloween.Target = { kind = "deposit", cf = xDTaraZ.Halloween.PadCF() }
    xDTaraZ.Halloween.SetPhase("Travel")
end

---@param kind string  "candy" | "door" | "pumpkin" | "ritual"
---@param id string
---@param cf CFrame
function xDTaraZ.Halloween.BeginTarget(kind, id, cf, source)
    xDTaraZ.Halloween.Target = { kind = kind, id = id, cf = cf, source = source }
    xDTaraZ.Halloween.SetPhase("Travel")
end

function xDTaraZ.Halloween.StepTravel()
    local halloween = xDTaraZ.Halloween
    local target = halloween.Target
    if not target or not target.cf then return xDTaraZ.Halloween.Reset() end
    if not xDTaraZ.Halloween.Claim() then return end

    if target.kind == "deposit" and xDTaraZ.Halloween.Carried() > 0 then
        halloween.Token.critical = true
        local hrp = xDTaraZ.Player.Root
        local delta = target.cf.Position - hrp.Position
        local hop = math.min(xDTaraZ.Halloween.DirectLimit(), delta.Magnitude)
        if hop > 0 and not target.hopped then
            target.hopped = true
            if not xDTaraZ.Tasks.Teleport(halloween.Token, hrp.CFrame + delta.Unit * hop) then
                return xDTaraZ.Halloween.Reset("Candy return interrupted")
            end
        end
        local expires = tonumber(LocalPlayer:GetAttribute("CandyExpiresAt"))
        local remaining = expires and expires == expires and expires < math.huge
            and expires - xDTaraZ.Util.ServerNow() or Config.CandySpoilAt - (os.clock() - halloween.FirstPickAt)
        local reached = xDTaraZ.Tasks.Travel(halloween.Token, target.cf, xDTaraZ.Halloween.ReturnSpeed, math.max(0, remaining), {
            noClip = true,
            maxFlags = halloween.FlagsBaseline or xDTaraZ.Player:Flags(),
            reach = Config.CandyDepositReach,
            done = function() return xDTaraZ.Halloween.Carried() == 0 end,
        })
        if not reached then return xDTaraZ.Halloween.Reset("Candy return interrupted") end
        return xDTaraZ.Halloween.SetPhase("Deposit")
    end

    local hrp = xDTaraZ.Player.Root
    local loaded = target.source and target.source.instance and target.source.instance.Parent
    if not loaded and hrp and (hrp.Position - target.cf.Position).Magnitude > Config.EventStreamDist then
        pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, target.cf.Position, Config.EventStreamTimeout)
    end
    if not xDTaraZ.Tasks.Teleport(halloween.Token, target.cf) then
        return xDTaraZ.Halloween.Reset("Could not move")
    end
    xDTaraZ.Halloween.SetPhase("Settle")
end

function xDTaraZ.Halloween.StepSettle()
    local halloween = xDTaraZ.Halloween
    local target = halloween.Target
    if not target then return xDTaraZ.Halloween.Reset() end
    local settle = target.kind == "candy" and Config.CandyPickupSettle or Config.HalloweenSettle
    if os.clock() - halloween.PhaseAt < settle then return end
    if not xDTaraZ.Halloween.Claim() then return end

    if target.kind == "candy" then
        if os.clock() < halloween.NextCollectAt then return end
        local source = target.source
        if source and source.instance and not source.instance.Parent then
            return xDTaraZ.Halloween.Reset("Candy disappeared; selecting another spawn")
        end
        halloween.CandyStateAt = 0
        local entry = xDTaraZ.Halloween.SpawnState()[target.id]
        if entry and ((entry.amount or 0) <= 0 or entry.respawning) then
            return xDTaraZ.Halloween.Reset("Candy is respawning; selecting another spawn")
        end
        if not xDTaraZ.Tasks.Holds(halloween.Token) then return xDTaraZ.Halloween.Reset("Waiting for a turn") end
        local hrp = xDTaraZ.Player.Root
        if source and hrp and (hrp.Position - source.pos).Magnitude > Config.CandyPickupLimit then
            if target.repositioned then return xDTaraZ.Halloween.Reset("Could not reach the candy") end
            target.repositioned = true
            target.cf = CFrame.new(source.pos + Vector3.new(0, xDTaraZ.Halloween.StandLift(), 0))
            return xDTaraZ.Halloween.SetPhase("Travel")
        end
        local remote = xDTaraZ.Net.CollectCandy
        if not remote then return xDTaraZ.Halloween.Reset("Candy collecting is unavailable") end
        halloween.CarriedBefore = xDTaraZ.Halloween.Carried()
        halloween.CollectBankBefore = xDTaraZ.Halloween.Tokens()
        halloween.LastCollectAt = os.clock()
        remote:FireServer(target.id)
        return xDTaraZ.Halloween.SetPhase("Collect")
    end

    if target.kind == "door" then
        local remote = xDTaraZ.Net.KnockDoor
        if remote then
            remote:FireServer(target.id)
            halloween.DoorAt[target.id] = os.clock() + Config.DoorCooldown
            halloween.Stats.knocks += 1
        end
        return xDTaraZ.Halloween.Reset("Knocked")
    end

    if target.kind == "pumpkin" then
        local remote = xDTaraZ.Net.SearchPumpkin
        if remote then
            remote:FireServer(target.id)
            halloween.PumpkinAt[target.id] = os.clock() + Config.PumpkinCooldown
        end
        return xDTaraZ.Halloween.Reset("Searched")
    end

    if target.kind == "ritual" then
        local fired = xDTaraZ.Halloween.RitualInteract()
        halloween.RitualAt = os.clock() + Config.RitualRetry
        return xDTaraZ.Halloween.Reset(fired > 0 and "Ritual visited" or "Ritual is not ready")
    end

    if target.kind == "deposit" then
        return xDTaraZ.Halloween.SetPhase("Deposit")
    end

    if target.kind == "shop" then return xDTaraZ.Halloween.BuyAtShop() end

    if target.kind == "portal" then
        xDTaraZ.Halloween.PortalTries = (xDTaraZ.Halloween.PortalTries or 0) + 1
        task.spawn(function()
            local tries = xDTaraZ.Halloween.PortalTries
            local epoch = xDTaraZ.Player.Epoch
            for attempt = 1, 6 do
                if not State.Alive or State.Unloading or epoch ~= xDTaraZ.Player.Epoch then return end
                if not xDTaraZ.Halloween.WantsMove() then return end
                local portal = Workspace:FindFirstChild("Map")
                portal = portal and portal:FindFirstChild("Portal")
                if not (portal and xDTaraZ.Player:IsAlive()) then break end
                if xDTaraZ.Halloween.PortalTries ~= tries then return end

                local fired = false
                for _, prompt in ipairs(portal:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        fired = pcall(fireproximityprompt, prompt) or fired
                    end
                end
                if LocalPlayer:GetAttribute("InHalloweenZone") == true then return end
                task.wait(0.4)
            end
        end)
        return xDTaraZ.Halloween.Reset("Entering the event")
    end

    xDTaraZ.Halloween.Reset("Entering the event")
end

function xDTaraZ.Halloween.StepCollect()
    local halloween = xDTaraZ.Halloween
    local target = halloween.Target
    if not target then return xDTaraZ.Halloween.Reset() end

    local carried = xDTaraZ.Halloween.Carried()
    local banked = halloween.CollectBankBefore and xDTaraZ.Halloween.Tokens() - halloween.CollectBankBefore or 0
    if carried == 0 and banked > 0 then
        halloween.Stats.candy += banked
        halloween.NextCollectAt = halloween.LastCollectAt + Config.CandyCooldown
        halloween.CandyStateAt = 0
        halloween.DepositBankBefore = halloween.CollectBankBefore
        return xDTaraZ.Halloween.SetPhase("Deposit")
    end
    if carried > halloween.CarriedBefore then
        if halloween.FirstPickAt == 0 then halloween.FirstPickAt = os.clock() end
        halloween.Stats.candy += carried - halloween.CarriedBefore
        halloween.NextCollectAt = halloween.LastCollectAt + Config.CandyCooldown
        halloween.CandyStateAt = 0
        return xDTaraZ.Halloween.BeginDeposit()
    end

    if halloween.FirstPickAt > 0 and carried > 0 and os.clock() - halloween.FirstPickAt >= Config.CandySpoilAt then
        return xDTaraZ.Halloween.BeginDeposit()
    end

    if os.clock() - halloween.PhaseAt > Config.CandyCollectTimeout then
        halloween.SkipUntil[target.id] = os.clock() + Config.CandySkipSec
        halloween.CandyStateAt = 0
        return xDTaraZ.Halloween.Reset("Candy did not answer")
    end
end

function xDTaraZ.Halloween.StepDeposit()
    local halloween = xDTaraZ.Halloween

    if xDTaraZ.Halloween.Carried() == 0 then
        local banked = xDTaraZ.Halloween.Tokens() - halloween.DepositBankBefore
        if banked <= 0 then
            if os.clock() - halloween.PhaseAt < Config.CandyDepositTimeout then return end
            halloween.Spoiled += 1
            halloween.FirstPickAt = 0
            return xDTaraZ.Halloween.Reset("Candy cleared without a confirmed deposit")
        end
        halloween.TokensEarned += banked
        halloween.Cycles += 1
        halloween.FirstPickAt = 0
        halloween.DepositDoneAt = os.clock()
        if halloween.ManualCandy then halloween.ManualCandy = false end
        return xDTaraZ.Halloween.Reset("Cashed in " .. banked)
    end

    if os.clock() - halloween.PhaseAt <= Config.CandyDepositTimeout then return end
    if not halloween.DepositRetried then
        halloween.DepositRetried = true
        if xDTaraZ.Halloween.Claim() and xDTaraZ.Tasks.Teleport(halloween.Token, xDTaraZ.Halloween.PadCF()) then
            return xDTaraZ.Halloween.SetPhase("Deposit")
        end
    end
    xDTaraZ.Halloween.Reset("Could not reach the candy pad")
end

function xDTaraZ.Halloween.StepIdle()
    local halloween = xDTaraZ.Halloween
    local opt = xDTaraZ.Util.Opt
    local carried = xDTaraZ.Halloween.Carried()

    local spoiling = carried > 0 and halloween.FirstPickAt > 0 and os.clock() - halloween.FirstPickAt >= Config.CandySpoilAt
    if carried > 0 and (carried >= Config.CandyCarryGoal or spoiling) then
        return xDTaraZ.Halloween.BeginDeposit()
    end

    local fullCandy = opt("AutoCandy") == true or halloween.ManualCandy
    local dropsOnly = not fullCandy and (opt("AutoTrickOrTreat") == true or opt("AutoPumpkin") == true or halloween.ManualPass ~= nil)
    if fullCandy or dropsOnly then
        if os.clock() + Config.CandyPrepAhead >= halloween.NextCollectAt then
            if not xDTaraZ.Halloween.Claim() then return end
            if xDTaraZ.Util.Opt("CandyAutoMount") ~= false then xDTaraZ.Mount.Ensure(halloween.Token) end
        end
        local candy = xDTaraZ.Halloween.NextCandy(dropsOnly)
        if candy then
            return xDTaraZ.Halloween.BeginTarget("candy", candy.id,
                candy.cf, candy)
        end
        if carried > 0 then
            local waitLeft = xDTaraZ.Halloween.NextRespawnIn()
            local spoilLeft = halloween.FirstPickAt > 0 and Config.CandySpoilAt - (os.clock() - halloween.FirstPickAt) or Config.CandySpoilAt
            if not (waitLeft and waitLeft < spoilLeft - 2) then
                return xDTaraZ.Halloween.BeginDeposit()
            end
        end
        if halloween.ManualCandy then
            if carried == 0 then
                halloween.ManualCandy = false
            else
                return xDTaraZ.Halloween.BeginDeposit()
            end
        end
    end

    if opt("AutoTrickOrTreat") == true or halloween.ManualPass == "doors" then
        local door = xDTaraZ.Halloween.NextDoor()
        if door then return xDTaraZ.Halloween.BeginTarget("door", door.id, door.cf) end
    end

    if opt("AutoPumpkin") == true or halloween.ManualPass == "pumpkins" then
        local pumpkin = xDTaraZ.Halloween.NextPumpkin()
        if pumpkin then
            return xDTaraZ.Halloween.BeginTarget("pumpkin", pumpkin.id,
                CFrame.new(pumpkin.pos + Vector3.new(0, Config.StandLift, 0)))
        end
    end

    if opt("AutoRitual") == true then
        local altar = xDTaraZ.Halloween.RitualReady()
        if altar then return xDTaraZ.Halloween.BeginTarget("ritual", "ritual", altar) end
    end

    if halloween.ManualPass then halloween.ManualPass = nil end
    xDTaraZ.Halloween.Release()
    local cooldownLeft = halloween.NextCollectAt - os.clock()
    if cooldownLeft > 0 then
        return xDTaraZ.Halloween.SetPhase("Idle", string.format("Pickup cooldown %.0fs", cooldownLeft))
    end
    xDTaraZ.Halloween.SetPhase("Idle", "Waiting for candy to respawn")
end

function xDTaraZ.Halloween.StepZone()
    local halloween = xDTaraZ.Halloween
    local now = os.clock()
    if now < halloween.ZoneRetryAt then return end

    halloween.ZoneTries += 1
    if halloween.ZoneTries > Config.HalloweenZoneTries then
        return xDTaraZ.Halloween.LeaveZone()
    end

    halloween.ZoneRetryAt = now + Config.HalloweenZoneGap
    halloween.Target = { kind = "portal", cf = xDTaraZ.Halloween.PortalCF() }
    xDTaraZ.Halloween.SetPhase("Travel")
end

function xDTaraZ.Halloween.LeaveZone()
    xDTaraZ.Halloween.StopMovement("Left the event island, event farming stopped")
end

function xDTaraZ.Halloween.StopMovement(note)
    local halloween = xDTaraZ.Halloween
    halloween.ManualCandy, halloween.ManualPass, halloween.ManualUntil = false, nil, nil
    xDTaraZ.Halloween.Reset(note)

    for _, idx in ipairs({ "AutoCandy", "AutoTrickOrTreat", "AutoPumpkin", "AutoRitual" }) do
        table.insert(State.PendingToggleOff, idx)
    end
    table.insert(State.PendingNotify, { "Halloween", note })
end

function xDTaraZ.Halloween.RecoverMovement()
    local halloween = xDTaraZ.Halloween
    local percent = xDTaraZ.Halloween.ReturnFactor() * 100
    halloween.ReturnCapPercent = math.max(100, math.min(200, percent * 0.75))
    halloween.ReturnHopDisabled = true
    halloween.FlagsBaseline = xDTaraZ.Player:Flags()
    halloween.RecoveryUntil = os.clock() + (xDTaraZ.Halloween.Carried() > 0 and 0.15 or 1)
    halloween.CandyStateAt = 0
    xDTaraZ.Halloween.Reset("Retrying at " .. math.floor(halloween.ReturnCapPercent) .. "%")
    if xDTaraZ.Halloween.Carried() > 0 then xDTaraZ.Halloween.BeginDeposit() end
end

---@return number|nil  egg token price read from the game data, nil when not found
function xDTaraZ.Halloween.KnownPrice()
    local halloween = xDTaraZ.Halloween
    if halloween.PriceSeen then return halloween.PriceSeen end
    local lib = xDTaraZ.Halloween.CandyLib()
    local eggs = lib and lib.Eggs
    local egg = eggs and eggs["Halloween Egg"]
    halloween.PriceFound = egg and tonumber(egg.Price) or nil
    return halloween.PriceFound
end

---@return Instance|nil, Vector3|nil  a real shop anchor from the game's own tags
function xDTaraZ.Halloween.ShopAnchor()
    for _, tag in ipairs({ "HalloweenShopGuy", "HalloweenShopPrompt" }) do
        for _, inst in ipairs(CollectionService:GetTagged(tag)) do
            local pos = xDTaraZ.Halloween.PointOf(inst)
            if pos then return inst, pos end
        end
    end
    return nil, nil
end

function xDTaraZ.Halloween.BuyBlocked(reason)
    xDTaraZ.Halloween.BuyOnce, xDTaraZ.Halloween.BuyTravel = false, false
    State.Status.HalloweenEgg = reason
end

---@return boolean  enough unreserved tokens, a known price and an active event
function xDTaraZ.Halloween.CanBuy()
    local price = xDTaraZ.Halloween.KnownPrice()
    if not price or price <= 0 then
        xDTaraZ.Halloween.BuyBlocked("Egg price is unavailable")
        return false
    end
    local keep = math.max(0, tonumber(xDTaraZ.Util.Opt("HalloweenKeepTokens")) or 0)
    local tokens = xDTaraZ.Halloween.Tokens()
    if tokens < price + keep then
        xDTaraZ.Halloween.BuyBlocked("Saving " .. xDTaraZ.Util.Format(tokens) .. " / " .. xDTaraZ.Util.Format(price + keep) .. " tokens")
        return false
    end
    local event = GameLib.Svc and GameLib.Svc.HalloweenEvent
    if event and type(event.IsLive) == "function" then
        local ok, live = GameLib.Call(event.IsLive)
        if not ok or live ~= true then
            xDTaraZ.Halloween.BuyBlocked("Halloween egg shop is closed")
            return false
        end
    end
    local limit = tonumber(xDTaraZ.Util.Opt("HalloweenBuyLimit")) or 0
    if not xDTaraZ.Halloween.BuyOnce and limit > 0 and xDTaraZ.Halloween.EggsBought >= limit then
        xDTaraZ.Halloween.BuyBlocked("Egg purchase limit reached")
        return false
    end
    return true
end

function xDTaraZ.Halloween.BuyStep()
    local halloween = xDTaraZ.Halloween
    local opt = xDTaraZ.Util.Opt
    if not (opt("AutoHalloweenEgg") == true or halloween.BuyOnce) then return end
    if halloween.Purchase or halloween.Phase ~= "Idle" or xDTaraZ.Tasks.Carrying() then return end
    if os.clock() - halloween.LastBuyAt < Config.HalloweenEggGap then return end

    local remote = xDTaraZ.Net.BuyHalloweenEgg
    if not remote then
        State.Status.HalloweenEgg = "Egg shop is unavailable"
        return
    end

    if not xDTaraZ.Halloween.CanBuy() then return end
    halloween.BuyTravel = true
    if xDTaraZ.Halloween.InZone() ~= true then return end
    local inst, pos = xDTaraZ.Halloween.ShopAnchor()
    if not pos or not xDTaraZ.Halloween.Claim() then return end
    local hrp = xDTaraZ.Player.Root
    halloween.ShopHome = { hrp.CFrame, xDTaraZ.Player.Epoch }
    State.Status.HalloweenEgg = "Going to the egg shop"
    local cf = xDTaraZ.Halloween.PickupCF(pos, inst)
    xDTaraZ.Halloween.BeginTarget("shop", nil, cf, { instance = inst, pos = pos })
end

function xDTaraZ.Halloween.BuyAtShop()
    local halloween = xDTaraZ.Halloween
    if not xDTaraZ.Halloween.CanBuy() then return xDTaraZ.Halloween.FinishShop() end
    local target = halloween.Target
    local hrp = xDTaraZ.Player.Root
    if not target or not target.source or not hrp then return xDTaraZ.Halloween.FinishShop("Could not reach the egg shop") end
    local distance = xDTaraZ.Util.Flat(hrp.Position, target.source.pos)
    if distance > Config.HalloweenShopRange then
        target.cf = CFrame.new(target.source.pos + Vector3.new(0, xDTaraZ.Halloween.StandLift(), 0))
        return xDTaraZ.Halloween.SetPhase("Travel")
    end
    local before = {}
    for _, row in ipairs(xDTaraZ.Hatch.EggTools()) do before[row[1]] = true end
    local tokens = xDTaraZ.Halloween.Tokens()
    local price = xDTaraZ.Halloween.KnownPrice()
    local remote = xDTaraZ.Net.BuyHalloweenEgg
    halloween.LastBuyAt = os.clock()
    local ok, bought = GameLib.Call(remote.InvokeServer, remote, "Halloween Egg")
    halloween.BuyOnce = false
    if not ok or bought ~= true then
        halloween.LastBuyAt = os.clock() + Config.HalloweenShopRetry
        return xDTaraZ.Halloween.FinishShop(ok and "Egg shop refused the purchase; retrying later" or "Egg shop did not answer")
    end
    halloween.Purchase = { before = before, tokens = tokens, price = price, at = os.clock(), epoch = xDTaraZ.Player.Epoch }
    State.Status.HalloweenEgg = "Confirming the egg purchase"
    xDTaraZ.Halloween.SetPhase("Purchase")
end

function xDTaraZ.Halloween.StepPurchase()
    local halloween = xDTaraZ.Halloween
    local purchase = halloween.Purchase
    if not purchase then return xDTaraZ.Halloween.FinishShop() end
    local tool
    for _, row in ipairs(xDTaraZ.Hatch.EggTools()) do
        if row[2] == "Halloween Egg" and not purchase.before[row[1]] then tool = row[1]; break end
    end
    local spent = purchase.tokens - xDTaraZ.Halloween.Tokens()
    if spent < purchase.price or not tool then
        if os.clock() - purchase.at < Config.HalloweenPurchaseTimeout then return end
        return xDTaraZ.Halloween.FinishShop("Purchase not confirmed; check the egg inventory")
    end
    halloween.EggsBought += 1
    local note = "Bought " .. halloween.EggsBought .. " eggs"
    if xDTaraZ.Util.Opt("HalloweenAutoHatch") ~= false and purchase.epoch == xDTaraZ.Player.Epoch and xDTaraZ.Halloween.Claim() then
        halloween.Token.critical = true
        local key = xDTaraZ.Hatch.PlantTool(halloween.Token, tool)
        if key then
            xDTaraZ.Hatch.Purchased[key] = true
            local hatched = xDTaraZ.Tasks.Await(halloween.Token, function()
                if xDTaraZ.Hatch.Confirmed[key] then return true end
                local egg = State.PlotEggs[key]
                local left = egg and xDTaraZ.Hatch.Left(egg)
                if left and left <= 0 then xDTaraZ.Hatch.HatchNow(key) end
                return false
            end, Config.HalloweenPurchaseTimeout)
            note = hatched and "Bought and hatched the Halloween egg" or "Egg placed; waiting to hatch"
        else
            note = "Bought egg; no free plot space, kept in inventory"
        end
    end
    xDTaraZ.Halloween.FinishShop(note)
end

function xDTaraZ.Halloween.FinishShop(note)
    local halloween = xDTaraZ.Halloween
    local home, token = halloween.ShopHome, halloween.Token
    if home and token and home[2] == xDTaraZ.Player.Epoch and not xDTaraZ.Tasks.Carrying() then
        xDTaraZ.Tasks.Teleport(token, home[1])
    end
    halloween.ShopHome, halloween.Purchase, halloween.BuyTravel = nil, nil, false
    if note then State.Status.HalloweenEgg = note end
    xDTaraZ.Halloween.Reset()
end

function xDTaraZ.Halloween.StepOnce()
    local halloween = xDTaraZ.Halloween
    xDTaraZ.Halloween.Bind()
    if halloween.FlagsBaseline and xDTaraZ.Player:Flags() > halloween.FlagsBaseline then
        return xDTaraZ.Halloween.RecoverMovement()
    end
    if os.clock() < (halloween.RecoveryUntil or 0) then return end
    if not xDTaraZ.Player:IsAlive() then return xDTaraZ.Halloween.Reset("Waiting for respawn") end
    if halloween.Finishing and halloween.Phase == "Idle" and xDTaraZ.Halloween.Carried() == 0 then
        return xDTaraZ.Halloween.Stop()
    end
    if halloween.Token and not xDTaraZ.Tasks.Holds(halloween.Token) then
        return xDTaraZ.Halloween.Reset("Waiting for a turn")
    end

    xDTaraZ.Halloween.BuyStep()

    if halloween.ManualUntil and os.clock() > halloween.ManualUntil then
        halloween.ManualCandy, halloween.ManualPass, halloween.ManualUntil = false, nil, nil
    end
    if not xDTaraZ.Halloween.WantsMove() then
        if halloween.Phase ~= "Idle" then xDTaraZ.Halloween.Reset() end
        return
    end

    if halloween.Phase ~= "Idle" and os.clock() - halloween.PhaseAt > Config.HalloweenPhaseBudget then
        xDTaraZ.Halloween.Reset("Restarting")
    end

    local phase = halloween.Phase
    if phase == "Purchase" then return xDTaraZ.Halloween.StepPurchase() end
    if phase == "Travel" then return xDTaraZ.Halloween.StepTravel() end
    if phase == "Settle" then return xDTaraZ.Halloween.StepSettle() end
    if phase == "Collect" then return xDTaraZ.Halloween.StepCollect() end
    if phase == "Deposit" then return xDTaraZ.Halloween.StepDeposit() end

    if xDTaraZ.Halloween.InZone() ~= true then return xDTaraZ.Halloween.StepZone() end
    halloween.ZoneTries = 0
    return xDTaraZ.Halloween.StepIdle()
end

function xDTaraZ.Halloween.Step()
    local halloween = xDTaraZ.Halloween
    if halloween.Busy then return end
    halloween.Busy = true
    local ok, err = pcall(xDTaraZ.Halloween.StepOnce)
    halloween.Busy = false
    if not ok then
        xDTaraZ.Halloween.Reset("Restarting after an error")
        error(err, 0)
    end
end

function xDTaraZ.Halloween.OnCarried(value)
    local halloween = xDTaraZ.Halloween
    if value > 0 and halloween.CarriedWas == 0 then
        halloween.FirstPickAt = os.clock()
    elseif value == 0 and halloween.CarriedWas > 0 and not (halloween.Target and halloween.Target.kind == "deposit") then
        if os.clock() - (halloween.DepositDoneAt or 0) > 2 then
            halloween.FirstPickAt = 0
            halloween.Spoiled += 1
        end
    end
    halloween.CarriedWas = value
    xDTaraZ.Halloween.UpdateStatus()
end

function xDTaraZ.Halloween.Bind()
    local halloween = xDTaraZ.Halloween
    if halloween.Bound or halloween.AwaitCarried then return end
    local noSave = LocalPlayer:FindFirstChild("NoSaveData")
    if not noSave then return end

    local carried = noSave:FindFirstChild("CarriedCandy")
    if not carried then
        halloween.AwaitCarried = true
        table.insert(halloween.Conns, noSave.ChildAdded:Connect(function(child)
            if child.Name == "CarriedCandy" then
                halloween.Bound, halloween.AwaitCarried = false, false
            end
        end))
        return
    end

    halloween.Bound = true
    halloween.CarriedWas = tonumber(carried.Value) or 0
    table.insert(halloween.Conns, carried.Changed:Connect(xDTaraZ.Halloween.OnCarried))

    local reply = GameLib.Remote("DoorKnocked")
    if reply then
        table.insert(halloween.Conns, reply.OnClientEvent:Connect(function(id, isTreat, amount)
            if isTreat then
                halloween.Stats.treats += 1
                table.insert(State.PendingNotify, { "Trick-or-Treat", "Treat: " .. tostring(amount) .. " candy dropped" })
            end
        end))
    end

    local ritual = Workspace:FindFirstChild("HeadlessRitual")
    if ritual then
        table.insert(halloween.Conns, ritual:GetAttributeChangedSignal("Phase"):Connect(function()
            if ritual:GetAttribute("Phase") ~= "Open" then halloween.RitualSeenOpen = false end
        end))
    end
end

function xDTaraZ.Halloween.CandyNow()
    xDTaraZ.Halloween.Start()
    xDTaraZ.Halloween.ManualCandy = true
    xDTaraZ.Halloween.ManualUntil = os.clock() + Config.HalloweenManualTimeout
end

function xDTaraZ.Halloween.KnockNow()
    xDTaraZ.Halloween.Start()
    xDTaraZ.Halloween.ManualPass = "doors"
    xDTaraZ.Halloween.ManualUntil = os.clock() + Config.HalloweenManualTimeout
end

function xDTaraZ.Halloween.SearchNow()
    xDTaraZ.Halloween.Start()
    xDTaraZ.Halloween.ManualPass = "pumpkins"
    xDTaraZ.Halloween.ManualUntil = os.clock() + Config.HalloweenManualTimeout
end

function xDTaraZ.Halloween.BuyNow()
    xDTaraZ.Halloween.Start()
    xDTaraZ.Halloween.BuyOnce = true
end

function xDTaraZ.Halloween.ExitNow()
    local halloween = xDTaraZ.Halloween
    halloween.ManualCandy, halloween.ManualPass, halloween.ManualUntil, halloween.BuyOnce = false, nil, nil, false
    xDTaraZ.Halloween.Reset("Stopped")
end

---@return string, Color3  short label and colour for a candy spawn id
function xDTaraZ.Halloween.TierOf(id)
    if id:sub(1, 9) == "DoorCandy" then return "Door Candy", Config.RarityColors.Legendary end
    if id:sub(1, 11) == "PumpkinDrop" then return "Pumpkin Drop", Config.RarityColors.Legendary end
    local tier = id:match("^Candy(%d)_")
    if tier == "1" then return "Candy", Config.RarityColors.Common end
    if tier == "2" then return "Rare Candy", Config.RarityColors.Rare end
    if tier == "3" then return "Epic Candy", Config.RarityColors.Epic end
    return "Candy", Color3.new(1, 1, 1)
end

function xDTaraZ.Halloween.EspStep()
    if not State.Alive or not xDTaraZ.Util.Opt("HalloweenEsp") then return end
    xDTaraZ.Halloween.Bind()

    local halloween = xDTaraZ.Halloween
    local esp = xDTaraZ.Esp
    local hrp = xDTaraZ.Player.Root
    local range = xDTaraZ.Platform.Mobile and Config.EspRangeMobile or Config.EspRange
    local kinds = xDTaraZ.Util.Opt("HalloweenEspTypes")
    if type(kinds) ~= "table" or not next(kinds) then
        kinds = { Candy = true, Doors = true, Pumpkins = true, Altar = true }
    end

    local seen = {}
    local function Show(key, pos, text, color)
        local dist = hrp and (pos - hrp.Position).Magnitude or 0
        if dist > range then return end
        seen[key] = true

        local slot = halloween.Boards[key]
        if not slot or not slot.board.Parent then
            slot = esp.Take()
            halloween.Boards[key] = slot
        end
        slot.anchor.WorldPosition = pos
        slot.board.MaxDistance = range
        slot.board.Enabled = true
        slot.label.TextColor3 = color
        slot.label.Text = type(text) == "function" and text(math.floor(dist)) or text
    end

    if kinds.Candy then
        local states = xDTaraZ.Halloween.SpawnState()
        for _, inst in ipairs(CollectionService:GetTagged("HalloweenCandySpawn")) do
            local id = inst:GetAttribute("Id") or inst.Name
            local pos = xDTaraZ.Halloween.PointOf(inst)
            if id and pos and not xDTaraZ.Halloween.Respawning(inst, states[id]) then
                local label, color = xDTaraZ.Halloween.TierOf(id)
                local amount = states[id] and states[id].amount
                Show("candy:" .. id, pos, function(dist)
                    return string.format("%s%s | %dm", label, amount and (" " .. amount) or "", dist)
                end, color)
            end
        end
    end

    if kinds.Doors then
        for _, house in ipairs(xDTaraZ.Halloween.Houses()) do
            if not house:IsA("Model") then continue end
            local pivot = house:GetPivot()
            local id = xDTaraZ.Halloween.DoorId(house, pivot)
            local lit = xDTaraZ.Halloween.DoorLit(id)
            Show("door:" .. id, pivot.Position,
                lit == true and "Door Lit" or lit == false and "Door Dark" or "Door",
                lit == true and Color3.fromRGB(120, 255, 120) or Color3.fromRGB(170, 170, 170))
        end
    end

    if kinds.Pumpkins then
        for _, inst in ipairs(CollectionService:GetTagged("PumpkinPrompt")) do
            local pos = xDTaraZ.Halloween.PointOf(inst)
            if pos then Show("pumpkin:" .. tostring(inst), pos, "Pumpkin", Color3.fromRGB(255, 140, 40)) end
        end
    end

    if kinds.Altar then
        local info = xDTaraZ.Halloween.RitualInfo()
        if info then
            Show("altar", info.model:GetPivot().Position,
                "Ritual Altar" .. (info.phase and (" (" .. tostring(info.phase) .. ")") or ""),
                Color3.fromRGB(190, 80, 255))
        end
        Show("pad", xDTaraZ.Halloween.PadPos(), "Candy Pad", Config.RarityColors.Legendary)
    end

    for key in pairs(halloween.Boards) do
        if not seen[key] then esp.Disown(halloween.Boards, key) end
    end
end

function xDTaraZ.Halloween.ClearEsp()
    local halloween = xDTaraZ.Halloween
    for key in pairs(halloween.Boards) do
        xDTaraZ.Esp.Disown(halloween.Boards, key)
    end
end

---@return table<string, function>  label -> CFrame getter for the teleport tab
function xDTaraZ.Halloween.Places()
    local places = {}
    if not xDTaraZ.Halloween.EventLive() then return places end

    places["Event: Candy Pad"] = function()
        return CFrame.new(xDTaraZ.Halloween.PadPos() + Vector3.new(0, Config.CandyPadLift, 0))
    end
    places["Event: Portal"] = xDTaraZ.Halloween.PortalCF

    for index, house in ipairs(xDTaraZ.Halloween.Houses()) do
        if house:IsA("Model") then
            local pivot = house:GetPivot()
            places["Event: House " .. index] = function()
                return CFrame.new(pivot.Position + Vector3.new(Config.DoorStand, Config.StandLift, Config.DoorStand))
            end
        end
    end

    local ritual = Workspace:FindFirstChild("HeadlessRitual")
    if ritual then
        places["Event: Ritual Altar"] = function()
            local pivot = ritual:GetPivot()
            return CFrame.new(pivot.Position + Vector3.new(0, Config.StandLift, 0))
        end
    end
    return places
end

function xDTaraZ.Halloween.Start()
    local halloween = xDTaraZ.Halloween
    halloween.Finishing = false
    if halloween.Enabled then return end
    halloween.FlagsBaseline = xDTaraZ.Player:Flags()
    halloween.Enabled = true
    halloween.ZoneTries = 0
    halloween.ZoneRetryAt = 0
    if halloween.StartedAt == 0 then halloween.StartedAt = os.clock() end
    xDTaraZ.Halloween.Bind()
    xDTaraZ.Halloween.SetPhase("Idle")
end

function xDTaraZ.Halloween.Stop()
    local halloween = xDTaraZ.Halloween
    halloween.Enabled = false
    halloween.ManualCandy, halloween.ManualPass, halloween.ManualUntil, halloween.BuyOnce = false, nil, nil, false
    if State.Alive and not State.Unloading and halloween.Purchase then return end
    halloween.Purchase, halloween.BuyTravel, halloween.ShopHome = nil, false, nil
    if State.Alive and not State.Unloading and xDTaraZ.Halloween.Carried() > 0 then
        halloween.Finishing = true
        if not (halloween.Target and halloween.Target.kind == "deposit") then xDTaraZ.Halloween.BeginDeposit() end
        return
    end
    halloween.Finishing = false
    xDTaraZ.Halloween.Reset("Off")

    for _, conn in ipairs(halloween.Conns) do
        conn:Disconnect()
    end
    table.clear(halloween.Conns)
    halloween.Bound = false
    halloween.AwaitCarried = false
end

xDTaraZ.Delivery = {}

---@return "Plot"|"Direct"|"Drop", number  mode, trip studs
function xDTaraZ.Delivery.Mode(entry)
    local _, bp = xDTaraZ.Player:Plot()
    if not bp or not entry or not entry.pos then return "Drop", math.huge end

    local inside = xDTaraZ.Geo.EdgeInside(bp, entry.pos)
    if (inside - entry.pos).Magnitude <= xDTaraZ.Config.PickupReach then return "Plot", 0 end

    local trip = xDTaraZ.Geo.Trip(bp, xDTaraZ.Geo.StandPoint(bp, entry.pos))
    local opts = xDTaraZ.Options
    if opts and opts.DeliveryMode == "Safe" then return "Drop", trip end

    if xDTaraZ.Delivery.Fits(trip, entry.weight, entry.egg) then return "Direct", trip end
    return "Drop", trip
end

---@return number  carry speed left after the egg weight slowdown
function xDTaraZ.Delivery.WeightFactor(weight, eggName)
    local cfg = xDTaraZ.Config
    local over = math.max(0, (tonumber(weight) or 1) - 1)
    local per = eggName == "Cherub" and cfg.CherubWeightPenalty or cfg.WeightPenalty
    return 1 - math.min(cfg.WeightPenaltyMax, over * 10 * per)
end

---@param weight number|nil  carried egg weight, nil = light
---@return boolean           straight trip home passes with the pet ridden right now
function xDTaraZ.Delivery.Fits(trip, weight, eggName)
    local factor = xDTaraZ.Delivery.WeightFactor(weight, eggName)
    local speed = xDTaraZ.Mount.Speed()
    if speed > 0 then return trip <= xDTaraZ.State.Tune.DirectFactor * speed * factor end
    return trip <= xDTaraZ.Config.UnmountedDirect * factor
end

---@return boolean  true when the full time passed
function xDTaraZ.Delivery.Sleep(token, sec)
    if sec <= 0 then return true end
    local _, why = xDTaraZ.Tasks.Await(token, nil, sec)
    return why == "timeout"
end

---@return boolean, string
function xDTaraZ.Delivery.Pickup(token, guid, standPos)
    local cfg = xDTaraZ.Config
    local remote = xDTaraZ.GameLib.Remote("EggPickup")
    local hrp = xDTaraZ.Player.Root
    if not remote or not hrp then return false, "missing" end
    local flags = xDTaraZ.Player:Flags()

    if (hrp.Position - standPos).Magnitude > 1 then
        if not xDTaraZ.Tasks.Teleport(token, CFrame.new(standPos)) then return false, "aborted" end
        if not xDTaraZ.Delivery.Sleep(token, cfg.TpSettle) then return false, "aborted" end
    end

    local deadline = os.clock() + cfg.PickupTotalTimeout
    local retried = false
    repeat
        if not xDTaraZ.Tasks.Holds(token) or xDTaraZ.Guard.Tripped or xDTaraZ.Player:Flags() > flags then return false, "aborted" end
        xDTaraZ.EggIndex.Expect(guid)
        remote:FireServer(guid)
        local kind, text = xDTaraZ.EggIndex.WaitReply(guid, cfg.PickupReplyTimeout)

        if kind == "PickedUp" then return true, "ok" end
        if xDTaraZ.Player:BasketCount() > 0 then return true, "ok" end
        if kind == "BasketFull" then return false, "full" end
        if kind == "Gone" then
            xDTaraZ.EggIndex.MarkGone(guid)
            return false, "gone"
        end
        if kind == "Refused" then
            local distanceLag = tostring(text or ""):find("studs", 1, true) ~= nil
            if retried or not distanceLag or xDTaraZ.Player:Flags() > flags then return false, "refused" end
            retried = true
            if not xDTaraZ.Delivery.Sleep(token, cfg.PickupAckWait) then return false, "aborted" end
        end
    until os.clock() >= deadline
    return false, "timeout"
end

---@return boolean  only true on the server's Deposited reply
function xDTaraZ.Delivery.AwaitDeposit(token, timeout)
    local kind = xDTaraZ.EggIndex.WaitReply("*carry", timeout)
    return kind == "Deposited" and not xDTaraZ.Guard.Tripped
end

function xDTaraZ.Delivery.StepHome(token, bp)
    local hrp = xDTaraZ.Player.Root
    if not hrp then return false end
    xDTaraZ.EggIndex.Expect("*carry")
    return xDTaraZ.Tasks.Teleport(token, CFrame.new(xDTaraZ.Geo.EdgeInside(bp, hrp.Position)))
end

---@return table|nil  newest dropped entry for the carried egg
---@param before table  guids that existed before our drop
function xDTaraZ.Delivery.FindDrop(eggName, origin, since, before)
    local hrp = xDTaraZ.Player.Root
    local here = hrp and hrp.Position
    local byOrigin, nearest, nearestDist = nil, nil, math.huge

    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if not entry.dropEndsAt or entry.dropEndsAt < since then continue end
        if before[entry.guid or ""] then continue end
        if origin and entry.origin and xDTaraZ.Util.Flat(entry.origin, origin) < 1 then
            byOrigin = entry
            break
        end
        if entry.egg == eggName and here then
            local dist = xDTaraZ.Util.Flat(entry.pos, here)
            if dist < nearestDist then nearest, nearestDist = entry, dist end
        end
    end
    return byOrigin or nearest
end

---@return table|nil
function xDTaraZ.Delivery.Drop(token, eggName, origin)
    local cfg = xDTaraZ.Config
    local remote = xDTaraZ.GameLib.Remote("BasketDrop")
    if not remote then return nil end

    local before = {}
    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if entry.guid then before[entry.guid] = true end
    end
    local since = xDTaraZ.Util.ServerNow() - 0.5
    remote:FireServer()

    local drop
    xDTaraZ.Tasks.Await(token, function()
        drop = xDTaraZ.Delivery.FindDrop(eggName, origin, since, before)
        return drop ~= nil
    end, cfg.DropAppearTimeout)
    return drop
end

function xDTaraZ.Delivery.WaitLanded(token, drop)
    local landAt = drop.dropEndsAt + xDTaraZ.Config.DropEndsSlack
    local remaining = landAt - xDTaraZ.Util.ServerNow()
    if remaining ~= remaining or remaining > xDTaraZ.Config.DropLandMax then return false end
    local timeout = math.max(xDTaraZ.Config.DropAppearTimeout, remaining + 0.5)
    local ok = xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Util.ServerNow() >= landAt end, timeout)
    return ok
end

function xDTaraZ.Delivery.RaiseSettle()
    local tune = xDTaraZ.State.Tune
    tune.DropSettle = math.min(tune.DropSettle + 0.05, xDTaraZ.Config.DropSettleMax)
    xDTaraZ.State.Stats.staleDrops += 1
end

function xDTaraZ.Delivery.LowerSettle()
    local tune = xDTaraZ.State.Tune
    local floor = math.max(xDTaraZ.Config.DropSettle, tonumber(xDTaraZ.Util.Opt("DropSettle")) or 0)
    tune.DropSettle = math.max(floor, tune.DropSettle - 0.01)
end

---@return number|nil  replicated break timer for the carried egg
function xDTaraZ.Delivery.BreakLeft()
    local left
    for _, egg in ipairs(xDTaraZ.Player:BasketItems()) do
        if egg:GetAttribute("Delivering") then continue end
        local at = tonumber(egg:GetAttribute("BreakAt"))
        if at then left = math.min(left or math.huge, at - xDTaraZ.Util.ServerNow()) end
    end
    return left
end

---@return boolean  one bounded hop followed by movement at the actual ride speed
function xDTaraZ.Delivery.TravelCarry(token, cf, eggName)
    local cfg = xDTaraZ.Config
    local root, speed = xDTaraZ.Player.Root, xDTaraZ.Mount.TravelSpeed()
    if not root or speed <= 0 or xDTaraZ.Player:BasketCount() == 0 then return false end
    if not token.returnHop then
        token.returnHop = true
        local delta = cf.Position - root.Position
        local hopLimit = math.min(cfg.ReturnHopMax, math.max(xDTaraZ.Mount.Speed(), cfg.UnmountedPlayerSpeed) * State.Tune.DirectFactor)
        local hop = math.min(hopLimit, math.max(0, delta.Magnitude - cfg.TravelStopDistance))
        if hop > 0 then
            if not xDTaraZ.Tasks.Teleport(token, CFrame.new(root.Position + delta.Unit * hop) * root.CFrame.Rotation) then return false end
            if not xDTaraZ.Delivery.Sleep(token, cfg.TpSettle) then return false end
        end
    end
    local timeout = (cf.Position - root.Position).Magnitude / speed + cfg.RunBudget
    token.budget = math.max(token.budget or 0, os.clock() + timeout)
    local expired = false
    local reached = xDTaraZ.Tasks.Travel(token, cf, xDTaraZ.Mount.TravelSpeed, timeout, {
        noClip = true, reach = cfg.TravelStopDistance,
        done = function()
            local left = xDTaraZ.Delivery.BreakLeft()
            expired = left ~= nil and left <= 0
            return expired or xDTaraZ.Player:BasketCount() == 0
        end,
    })
    return reached and not expired and xDTaraZ.Player:BasketCount() > 0
end

---@return "Deposited"|"Gone"|"Refused"|"Aborted"
function xDTaraZ.Delivery.DropCycle(token, bp, eggName, origin)
    local cfg = xDTaraZ.Config

    for _ = 0, 2 do
        local hrp = xDTaraZ.Player.Root
        if not hrp or os.clock() > token.budget then return "Aborted" end

        local out = xDTaraZ.Geo.Outside(bp, hrp.Position, cfg.DropOutside)
        if not xDTaraZ.Delivery.Fits(xDTaraZ.Geo.Trip(bp, hrp.Position), nil, eggName) then
            if not xDTaraZ.Delivery.TravelCarry(token, CFrame.new(out), eggName) then return "Aborted" end
        elseif not xDTaraZ.Tasks.Teleport(token, CFrame.new(out)) then
            return "Aborted"
        end
        if not xDTaraZ.Delivery.Sleep(token, xDTaraZ.State.Tune.DropSettle) then return "Aborted" end

        local drop = xDTaraZ.Delivery.Drop(token, eggName, origin)
        if not drop then return xDTaraZ.Player:BasketCount() == 0 and "Gone" or "Aborted" end
        origin = drop.origin or origin

        local fresh = xDTaraZ.Util.Flat(drop.pos, out) <= cfg.StaleDropDistance
        local stand = fresh and out or drop.pos + Vector3.new(0, xDTaraZ.Geo.Lift(), 0)
        if fresh then xDTaraZ.Delivery.LowerSettle() end
        if not fresh then
            xDTaraZ.Delivery.RaiseSettle()
            if not xDTaraZ.Tasks.Teleport(token, CFrame.new(stand)) then return "Aborted" end
        end
        if not xDTaraZ.Delivery.WaitLanded(token, drop) then return "Aborted" end

        local got, why = xDTaraZ.Delivery.Pickup(token, drop.guid, stand)
        if not got then return why == "gone" and "Gone" or "Aborted" end

        if fresh or xDTaraZ.Delivery.Fits(xDTaraZ.Geo.Trip(bp, stand), drop.weight, eggName) then
            if not xDTaraZ.Delivery.StepHome(token, bp) then return "Aborted" end
            return xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout) and "Deposited" or "Aborted"
        end
    end
    return "Aborted"
end

---@return "Deposited"|"Aborted"
function xDTaraZ.Delivery.DirectHome(token, bp)
    local cfg = xDTaraZ.Config
    if not xDTaraZ.Delivery.StepHome(token, bp) then return "Aborted" end
    if xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout) then return "Deposited" end
    if xDTaraZ.Player:BasketCount() > 0 and xDTaraZ.Player:Flags() <= token.flags0 then
        if xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout) then return "Deposited" end
    end
    return "Aborted"
end

---@return "Deposited"|"Gone"|"Refused"|"Aborted", number  outcome, seconds
function xDTaraZ.Delivery.Run(token, entry)
    local _, bp = xDTaraZ.Player:Plot()
    if not bp or not entry then return "Aborted", 0 end

    local t0 = os.clock()
    token.flags0 = xDTaraZ.Player:Flags()
    token.budget = t0 + xDTaraZ.Config.RunBudget

    local mode, trip = xDTaraZ.Delivery.Mode(entry)
    xDTaraZ.Delivery.LastPlan = { mode = mode, trip = math.floor(trip), speed = xDTaraZ.Mount.Speed(), settle = xDTaraZ.State.Tune.DirectFactor }
    local stand = mode == "Plot" and xDTaraZ.Geo.EdgeInside(bp, entry.pos) or xDTaraZ.Geo.StandPoint(bp, entry.pos)

    xDTaraZ.EggIndex.Expect("*carry")
    local got, why = xDTaraZ.Delivery.Pickup(token, entry.guid, stand)
    if not got then
        if why == "full" then xDTaraZ.Delivery.Recover(token) end
        return why == "gone" and "Gone" or (why == "refused" and "Refused" or "Aborted"), os.clock() - t0
    end

    xDTaraZ.Eggs.CarryCritical = true
    local outcome
    if mode == "Plot" then
        outcome = xDTaraZ.Delivery.AwaitDeposit(token, xDTaraZ.Config.DepositTimeout) and "Deposited" or "Aborted"
    elseif mode == "Direct" then
        outcome = xDTaraZ.Delivery.DirectHome(token, bp)
    else
        outcome = xDTaraZ.Delivery.DropCycle(token, bp, entry.egg, entry.origin or entry.pos)
    end

    if outcome ~= "Deposited" and xDTaraZ.Player:BasketCount() > 0 then xDTaraZ.Delivery.Recover(token) end
    xDTaraZ.Eggs.CarryCritical = false
    xDTaraZ.Guard.Check(token.flags0)

    local seconds = os.clock() - t0
    local stats = xDTaraZ.State.Stats
    if outcome == "Deposited" then
        local key = string.lower(mode)
        stats[key] = (stats[key] or 0) + 1
    end
    stats.lastRun, stats.lastMode = seconds, mode
    return outcome, seconds
end

---@return string|nil, string|nil  egg name, "Delivering"|"Carry"|"Unknown"
function xDTaraZ.Delivery.Carried()
    local items = xDTaraZ.Player:BasketItems()
    local first = items[1]
    if not first then return nil, nil end
    if first:GetAttribute("Delivering") == true then return first:GetAttribute("Egg"), "Delivering" end
    if first:GetAttribute("BreakAt") then return first:GetAttribute("Egg"), "Carry" end
    return first:GetAttribute("Egg"), "Unknown"
end

---@return boolean  deposited after stepping out of the plot and back in
function xDTaraZ.Delivery.Reenter(token, bp, hrp)
    local cfg = xDTaraZ.Config
    local out = xDTaraZ.Geo.Outside(bp, hrp.Position, cfg.DropOutside)
    if not xDTaraZ.Tasks.Teleport(token, CFrame.new(out)) then return false end
    if not xDTaraZ.Delivery.Sleep(token, cfg.TpSettle) then return false end
    if not xDTaraZ.Delivery.StepHome(token, bp) then return false end
    return xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout)
end

---@return boolean  basket empty afterwards
function xDTaraZ.Delivery.Recover(token)
    local eggName, phase = xDTaraZ.Delivery.Carried()
    if not phase then return true, "Empty" end

    local cfg = xDTaraZ.Config
    token.flags0 = token.flags0 or xDTaraZ.Player:Flags()
    token.budget = math.max(token.budget or 0, os.clock() + cfg.RunBudget)

    if phase ~= "Carry" then
        xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Player:BasketCount() == 0 end, cfg.DepositTimeout)
        return xDTaraZ.Player:BasketCount() == 0, "Settled"
    end

    local _, bp = xDTaraZ.Player:Plot()
    local hrp = xDTaraZ.Player.Root
    if not bp or not hrp then return false end

    local wasCritical = xDTaraZ.Eggs.CarryCritical
    xDTaraZ.Eggs.CarryCritical = true
    local outcome = "Deposited"
    if not (xDTaraZ.Geo.InPlot(hrp.Position) and xDTaraZ.Delivery.Reenter(token, bp, hrp)) then
        outcome = xDTaraZ.Delivery.DropCycle(token, bp, eggName, nil)
    end
    xDTaraZ.Eggs.CarryCritical = wasCritical
    return xDTaraZ.Player:BasketCount() == 0, outcome
end

xDTaraZ.Mount = { Name = nil, Dirty = true, AutoLabel = "Auto (fastest)" }

function xDTaraZ.Mount.PetName(inst)
    local name = inst:GetAttribute("PetName") or inst.Name
    if xDTaraZ.GameLib.PetInfo[name] then return name end
    return nil
end

function xDTaraZ.Mount.Moving(name)
    local pets = xDTaraZ.GameLib.Data and xDTaraZ.GameLib.Data.Pets
    local row = pets and pets[name]
    return type(row) == "table" and tonumber(row.MovementSpeed) or 0
end

---@return table  pet name -> Tool, Backpack and hand
function xDTaraZ.Mount.Tools()
    return xDTaraZ.Pets.ToolsByName()
end

---@return string|nil  ridden pet name from the mount joint
function xDTaraZ.Mount.Detect()
    local hrp = xDTaraZ.Player.Root
    local joint = hrp and hrp:FindFirstChild("PetMountJoint")
    local part = joint and joint.Part1
    local model = part and part:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    return xDTaraZ.Mount.PetName(model)
end

function xDTaraZ.Mount.Choice()
    local opts = xDTaraZ.Options
    local pick = opts and opts.RidePet
    if type(pick) ~= "string" or pick == "" or pick == xDTaraZ.Mount.AutoLabel then return nil end
    return pick
end

---@return string|nil, number  name, ride speed
function xDTaraZ.Mount.Best()
    local info = xDTaraZ.GameLib.PetInfo
    local forced = xDTaraZ.Mount.Choice()
    if forced then return forced, info[forced] and info[forced].speed or 0 end

    local names = {}
    for name in pairs(xDTaraZ.Mount.Tools()) do names[#names + 1] = name end
    if xDTaraZ.Player:Riding() and xDTaraZ.Mount.Name then table.insert(names, xDTaraZ.Mount.Name) end

    local best, bestSpeed, bestMove = nil, 0, 0
    for _, name in ipairs(names) do
        local speed = info[name] and info[name].speed or 0
        local move = xDTaraZ.Mount.Moving(name)
        if speed > bestSpeed or (speed == bestSpeed and speed > 0 and move > bestMove) then
            best, bestSpeed, bestMove = name, speed, move
        end
    end
    return best, bestSpeed
end

function xDTaraZ.Mount.Speed()
    if not xDTaraZ.Player:Riding() then return 0 end
    local name = xDTaraZ.Mount.Name or xDTaraZ.Mount.Detect()
    if not name then return 0 end
    xDTaraZ.Mount.Name = name
    local info = xDTaraZ.GameLib.PetInfo[name]
    return info and info.speed or 0
end

---@return number  actual aged/mutated ride speed, capped by current slowdown
function xDTaraZ.Mount.TravelSpeed()
    local hum = xDTaraZ.Player.Humanoid
    local cap = xDTaraZ.Config.UnmountedPlayerSpeed
    if xDTaraZ.Player:Riding() then
        cap = xDTaraZ.Mount.Speed()
        local root = xDTaraZ.Player.Root
        local joint = root and root:FindFirstChild("PetMountJoint")
        local model = joint and joint.Part1 and joint.Part1:FindFirstAncestorOfClass("Model")
        local aging = xDTaraZ.GameLib.Svc.PetAging
        if model and aging and type(aging.RealSpeedFor) == "function" then
            local mutations = xDTaraZ.GameLib.Mutations
            local factor = (mutations[model:GetAttribute("Mutation") or ""] or 1) * (mutations[model:GetAttribute("SpawnMutation") or ""] or 1)
            local ok, actual = xDTaraZ.GameLib.Call(aging.RealSpeedFor, cap, model:GetAttribute("Weight"), factor)
            if ok and type(actual) == "number" and actual > 0 and actual < math.huge then cap = actual end
        end
    end
    return math.min(cap, hum and hum.WalkSpeed or 0)
end

function xDTaraZ.Mount.Forget()
    xDTaraZ.Mount.Name = nil
    xDTaraZ.Mount.Dirty = true
end

---@return Tool|nil  tool of a pet placed on the plot, only when the user named it
function xDTaraZ.Mount.Unplace(token, name)
    local remote = xDTaraZ.GameLib.Remote("PickupPet")
    if not remote then return nil end
    for _, pet in ipairs(xDTaraZ.Pets.Owned()) do
        if pet.name == name and pet.placed then
            remote:FireServer(pet.key)
            break
        end
    end

    local tool
    xDTaraZ.Tasks.Await(token, function()
        tool = xDTaraZ.Pets.ToolNamed(name)
        return tool ~= nil
    end, xDTaraZ.Config.MountTimeout)
    return tool
end

function xDTaraZ.Mount.Dismount(token)
    local remote = xDTaraZ.GameLib.Remote("PetDismount")
    if not remote then return false end
    remote:FireServer()
    xDTaraZ.Mount.Name = nil
    return (xDTaraZ.Tasks.Await(token, function() return not xDTaraZ.Player:Riding() end, xDTaraZ.Config.MountTimeout))
end

---@return boolean  riding the chosen pet
function xDTaraZ.Mount.Ensure(token)
    local cfg = xDTaraZ.Config
    if xDTaraZ.Player:BasketCount() > 0 or not xDTaraZ.Player:IsAlive() then return false end

    local name = xDTaraZ.Mount.Best()
    if not name then return false end
    if xDTaraZ.Player:Riding() then
        if (xDTaraZ.Mount.Name or xDTaraZ.Mount.Detect()) == name then
            xDTaraZ.Mount.Name, xDTaraZ.Mount.Dirty = name, false
            return true
        end
        if not xDTaraZ.Mount.Dismount(token) then return false end
    end

    local tool = xDTaraZ.Pets.ToolNamed(name)
    if not tool and xDTaraZ.Mount.Choice() == name then tool = xDTaraZ.Mount.Unplace(token, name) end
    local remote = xDTaraZ.GameLib.Remote("Mounting")
    local hum = xDTaraZ.Player.Humanoid
    if not tool or not remote or not hum then return false end

    hum:EquipTool(tool)
    for _ = 1, cfg.MountTries do
        remote:FireServer()
        local ok, why = xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Player:Riding() end, cfg.MountGap)
        if ok then break end
        if why ~= "timeout" then return false end
    end
    xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Player:Riding() end, cfg.MountTimeout)

    if not xDTaraZ.Player:Riding() then return false end
    xDTaraZ.Mount.Name, xDTaraZ.Mount.Dirty = name, false
    return true
end

function xDTaraZ.Mount.Watch(backpack)
    if not backpack then return end
    xDTaraZ:Connect(backpack.ChildAdded, function(child)
        if child:IsA("Tool") and xDTaraZ.Mount.PetName(child) then xDTaraZ.Mount.Dirty = true end
    end)
end

task.spawn(function()
    xDTaraZ.Mount.Watch(LocalPlayer:WaitForChild("Backpack", xDTaraZ.Config.LoadTimeout))
end)
xDTaraZ:Connect(LocalPlayer.CharacterAdded, function()
    task.defer(function()
        xDTaraZ.Mount.Watch(LocalPlayer:WaitForChild("Backpack", xDTaraZ.Config.LoadTimeout))
    end)
end)

xDTaraZ.Planner = {
    Ranked = {}, Contested = {},
    Dirty = true, BuiltAt = 0, Epoch = -1, MountName = nil,
    RebuildGap = 0.5, MaxAge = 2, ContestStep = 0.25,
    Started = false,
}

---@return number  studs per second this player can close on an egg
function xDTaraZ.Planner.PlayerSpeed(player, char)
    if player:GetAttribute("IsRiding") ~= true then return Config.UnmountedPlayerSpeed end
    for _, child in ipairs(char:GetChildren()) do
        local pet = GameLib.PetInfo[child.Name]
        if pet and pet.speed then return pet.speed end
    end
    return Config.UnmountedPlayerSpeed
end

---@return table  { {pos, speed} } of every other player with a body
function xDTaraZ.Planner.Riders()
    local riders = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        riders[#riders + 1] = { hrp.Position, xDTaraZ.Planner.PlayerSpeed(player, char) }
    end
    return riders
end

---@param riders table?  from Planner.Riders, built when nil
---@return number        0..1, 1 = someone is on it now
function xDTaraZ.Planner.Contest(entry, riders)
    if not entry.pos then return 0 end
    local best = 0
    for _, rider in ipairs(riders or xDTaraZ.Planner.Riders()) do
        local eta = xDTaraZ.Util.Flat(rider[1], entry.pos) / math.max(rider[2], 1)
        best = math.max(best, math.clamp(1 - eta / Config.ContestHorizon, 0, 1))
    end
    return best
end

---@return number, string, number  score, delivery mode, contest
---@return boolean  the user picked specific rarities / eggs (then far eggs are worth the trip)
function xDTaraZ.Planner.Narrowed()
    local o = xDTaraZ.Options
    if (GameLib.RarityRank[o.MinEggRarity or ""] or 1) > 1 then return true end
    if type(o.EggRarities) == "table" and next(o.EggRarities) ~= nil then return true end
    if type(o.EggNames) == "table" and next(o.EggNames) ~= nil then return true end
    return false
end

function xDTaraZ.Planner.Score(entry, riders)
    local mode, trip = xDTaraZ.Delivery.Mode(entry)
    local contest = xDTaraZ.Planner.Contest(entry, riders)
    local cost = Config.TripCost[mode] or Config.TripCost.Drop
    if mode == "Drop" then
        local hum = xDTaraZ.Player.Humanoid
        local speed = math.min(math.max(xDTaraZ.Mount.Speed(), Config.UnmountedPlayerSpeed), hum and hum.WalkSpeed or 0) * 0.9
        cost += trip / math.max(speed, 1)
    end
    local score = (entry.value or 0) * (1 + contest * State.Tune.ContestWeight) / cost
    return score, mode, contest
end

function xDTaraZ.Planner.Rebuild()
    local planner = xDTaraZ.Planner
    local riders = planner.Riders()
    local ranked = planner.Ranked
    table.clear(ranked)

    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if not entry.pos or not entry.egg then continue end
        if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then continue end
        local score, mode, contest = planner.Score(entry, riders)
        table.insert(ranked, { entry, mode, contest, score })
    end
    table.sort(ranked, function(a, b) return a[4] > b[4] end)

    planner.Dirty, planner.BuiltAt = false, os.clock()
    planner.Epoch = xDTaraZ.EggIndex.ValueEpoch
    planner.MountName = xDTaraZ.Mount.Name
end

---@return boolean  ranking is stale
function xDTaraZ.Planner.Stale()
    local planner = xDTaraZ.Planner
    local age = os.clock() - planner.BuiltAt
    if planner.Epoch ~= xDTaraZ.EggIndex.ValueEpoch or planner.MountName ~= xDTaraZ.Mount.Name then return true end
    if age > planner.MaxAge then return true end
    if not planner.Dirty then return false end

    local surging = os.clock() - xDTaraZ.EggIndex.RolledAt <= Config.WaveSurge
    return surging or age >= planner.RebuildGap
end

---@param minRank number?  hunter-only: rarity rank floor, user filters skipped
---@return table?, string?  entry, planned mode
function xDTaraZ.Planner.Next(minRank)
    local planner = xDTaraZ.Planner
    if planner.Stale() then planner.Rebuild() end

    for _, pick in ipairs(planner.Ranked) do
        local entry = pick[1]
        if not minRank and xDTaraZ.Util.Opt("EggRoute") == "Fast nearby" and pick[2] == "Drop" and not xDTaraZ.Planner.Narrowed() then continue end
        if minRank then
            local info = GameLib.EggInfo[entry.egg]
            if not info or (GameLib.RarityRank[info.rarity] or 0) < minRank then continue end
        end
        if xDTaraZ.EggIndex.Wanted(entry, minRank ~= nil) then
            planner.Contested[entry.guid] = pick[3]
            return entry, pick[2]
        end
    end
    return nil
end

function xDTaraZ.Planner.OnReply(kind, guid)
    local planner = xDTaraZ.Planner
    if kind ~= "Gone" or not guid then return end
    local contest = planner.Contested[guid]
    planner.Contested[guid] = nil
    if not contest or contest <= 0 then return end

    local tune = State.Tune
    local before = tune.ContestWeight
    tune.ContestWeight = math.min(Config.ContestWeightMax, before + planner.ContestStep)
    if tune.ContestWeight == before then return end

    State.TuneLog = State.TuneLog or {}
    table.insert(State.TuneLog, { "ContestWeight", before, tune.ContestWeight, os.time() })
end

function xDTaraZ.Planner.MarkDirty()
    xDTaraZ.Planner.Dirty = true
end

function xDTaraZ.Planner.Start()
    local planner = xDTaraZ.Planner
    if planner.Started then return end
    planner.Started = true

    local index = xDTaraZ.EggIndex
    index.OnAdded:Connect(xDTaraZ.Planner.MarkDirty)
    index.OnRemoved:Connect(xDTaraZ.Planner.MarkDirty)
    index.OnRoll:Connect(function()
        table.clear(planner.Contested)
        planner.Dirty = true
    end)
    index.OnReply:Connect(xDTaraZ.Planner.OnReply)
end

xDTaraZ.Eggs = {
    Enabled = false, Manual = false, Phase = "Idle", Note = nil,
    Token = nil, CarryCritical = false,
    MountRetryAt = 0, RecoverAt = 0,
    Prio = { Eggs = 60, Hunter = 70, Recover = 100 },
    RateWindow = 60,
}

xDTaraZ.Hunter = { Enabled = false, Hops = 0, HopCycle = nil, HopAt = 0, Seen = {}, Started = false }

xDTaraZ.Guard = {
    Baseline = nil, Tripped = false, Watching = false,
    Toggles = { "AutoEggs", "EggHunter", "VolcanoDip", "VolcanoObby" },
}

---@return number  eggs delivered in the last minute
function xDTaraZ.Eggs.PerMinute()
    local window = State.Stats.window
    local cutoff = os.clock() - xDTaraZ.Eggs.RateWindow
    while window[1] and window[1] < cutoff do
        table.remove(window, 1)
    end
    return #window
end

function xDTaraZ.Eggs.Status()
    local eggs = xDTaraZ.Eggs
    if not eggs.Enabled and not eggs.Manual and not xDTaraZ.Hunter.Enabled then return "Egg farm is off" end
    return eggs.Note or eggs.Phase or "Idle"
end

---@return boolean  always false, so callers can return it
function xDTaraZ.Eggs.SetPhase(phase, note)
    local eggs = xDTaraZ.Eggs
    eggs.Phase, eggs.Note = phase, note
    State.Status.Eggs = eggs.Status()
    if not eggs.Enabled and not eggs.Manual and not xDTaraZ.Hunter.Enabled then
        State.Status.EggRate, State.Status.WaveAt = nil, nil
        return false
    end
    State.Status.EggRate = eggs.PerMinute() .. "/min"
    State.Status.WaveAt = os.clock() + GameLib.CycleLeft()
    return false
end

---@return boolean  Plot and Travel tasks may use the character now
function xDTaraZ.Eggs.Waiting()
    local eggs = xDTaraZ.Eggs
    local active = eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled
    return not active or eggs.Phase == "WaveWait"
end

function xDTaraZ.Eggs.ReleaseToken()
    local eggs = xDTaraZ.Eggs
    if not eggs.Token then return end
    xDTaraZ.Tasks.Release(eggs.Token)
    eggs.Token = nil
end

---@return boolean  we hold a token at this priority
function xDTaraZ.Eggs.Claim(prio)
    local eggs = xDTaraZ.Eggs
    local token = eggs.Token
    if token and token.prio == prio and xDTaraZ.Tasks.Holds(token) then return true end

    eggs.ReleaseToken()
    local owner = prio >= eggs.Prio.Hunter and "Hunter" or "Eggs"
    eggs.Token = xDTaraZ.Tasks.Request(owner, prio)
    return eggs.Token ~= nil
end

function xDTaraZ.Eggs.EnsureMount()
    local eggs, mount = xDTaraZ.Eggs, xDTaraZ.Mount
    if os.clock() < eggs.MountRetryAt then return end
    if xDTaraZ.Player:Riding() and not mount.Dirty and mount.Best() == mount.Name then return end

    eggs.SetPhase("Mount", "Mounting")
    local ok, mounted = xDTaraZ.Util.Try("Mount.Ensure", mount.Ensure, eggs.Token)
    if ok and mounted then
        mount.Dirty = false
        return
    end
    eggs.MountRetryAt = os.clock() + Config.FailWindow
end

---@return boolean  basket is empty afterwards
function xDTaraZ.Eggs.Recover()
    local eggs = xDTaraZ.Eggs
    if eggs.CarryCritical or os.clock() < eggs.RecoverAt then return false end
    eggs.RecoverAt = os.clock() + Config.SlowTick
    eggs.ReleaseToken()

    local token = xDTaraZ.Tasks.Request("Recover", eggs.Prio.Recover)
    if not token then return eggs.SetPhase("Recover", "Waiting to finish the egg") end

    eggs.SetPhase("Recover", "Finishing the egg")
    xDTaraZ.Util.Try("Delivery.Recover", xDTaraZ.Delivery.Recover, token)
    xDTaraZ.Tasks.Release(token)
    return xDTaraZ.Player:BasketCount() == 0
end

function xDTaraZ.Eggs.Park()
    if not xDTaraZ.Options.ReturnAfter then return end
    local _, bp = xDTaraZ.Player:Plot()
    local hrp = xDTaraZ.Player.Root
    if not bp or not hrp or xDTaraZ.Geo.InPlot(hrp.Position) then return end

    local token = xDTaraZ.Tasks.Request("Eggs", xDTaraZ.Eggs.Prio.Eggs)
    if not token then return end
    xDTaraZ.Tasks.Teleport(token, CFrame.new(xDTaraZ.Geo.EdgeInside(bp, hrp.Position)))
    xDTaraZ.Tasks.Release(token)
end

function xDTaraZ.Eggs.WaveWait()
    local eggs = xDTaraZ.Eggs
    if eggs.Phase ~= "WaveWait" then
        eggs.ReleaseToken()
        eggs.Park()
    end
    local left = GameLib.CycleLeft()
    return eggs.SetPhase("WaveWait", left <= Config.WaveWakeEarly and "New wave" or nil)
end

function xDTaraZ.Eggs.Record(entry, outcome)
    local stats = State.Stats
    if outcome == "Gone" then
        stats.lost += 1
        return
    end
    if outcome == "Refused" then
        xDTaraZ.EggIndex.Fail(entry.guid)
        return
    end
    if outcome ~= "Deposited" then return end

    stats.delivered += 1
    table.insert(stats.window, os.clock())

    local info = GameLib.EggInfo[entry.egg]
    if info and info.ethereal then xDTaraZ.EggIndex.MarkClaimed(entry.egg, entry.cycle) end
end

---@return boolean  the egg reached the plot
function xDTaraZ.Eggs.Trip(entry)
    local eggs = xDTaraZ.Eggs
    eggs.SetPhase("Run", entry.egg)
    local ok, outcome = xDTaraZ.Util.Try("Delivery.Run", xDTaraZ.Delivery.Run, eggs.Token, entry)
    eggs.CarryCritical = false
    if not ok then outcome = "Aborted" end

    eggs.Record(entry, outcome)
    xDTaraZ.Planner.Dirty = true
    eggs.SetPhase("Settle")
    task.wait(Config.EggTick)
    return outcome == "Deposited"
end

---@param minRank number?  hunter-only: rarity floor, user filters skipped
---@return boolean          an egg was delivered
function xDTaraZ.Eggs.Tick(minRank)
    local eggs = xDTaraZ.Eggs
    if eggs.Ticking then return end
    eggs.Ticking = true
    local ok, err = pcall(eggs.TickOnce, minRank)
    eggs.Ticking = false
    if not ok then
        eggs.CarryCritical = false
        eggs.ReleaseToken()
        error(err, 0)
    end
end

function xDTaraZ.Eggs.TickOnce(minRank)
    local eggs = xDTaraZ.Eggs
    if xDTaraZ.Halloween.InZone() == true then
        eggs.ReleaseToken()
        return eggs.SetPhase("Idle", "Leave the Halloween island to farm world eggs")
    end
    xDTaraZ.EggIndex.CheckRoll()

    local _, bp = xDTaraZ.Player:Plot()
    if not bp then return eggs.SetPhase("Idle", "Waiting for plot") end
    if not xDTaraZ.Player:IsAlive() then return eggs.SetPhase("Idle", "Waiting for respawn") end
    if xDTaraZ.Player:BasketCount() > 0 then return eggs.Recover() end
    if eggs.Token and not xDTaraZ.Tasks.Holds(eggs.Token) then eggs.ReleaseToken() end
    if xDTaraZ.Volcano.Pending() then
        eggs.ReleaseToken()
        return eggs.SetPhase("Pick", "Volcano dip")
    end

    local entry = xDTaraZ.Planner.Next(minRank)
    if not entry then return eggs.WaveWait() end
    if not eggs.Claim(xDTaraZ.Hunter.Priority(entry)) then return eggs.SetPhase("Pick", "Waiting for a turn") end

    eggs.EnsureMount()
    return eggs.Trip(entry)
end

function xDTaraZ.Eggs.Step()
    if not xDTaraZ.Eggs.Enabled or xDTaraZ.Guard.Tripped then return end
    xDTaraZ.Eggs.Tick(nil)
end

---@return boolean  index is live
function xDTaraZ.Eggs.Prepare()
    xDTaraZ.Guard.Arm()
    xDTaraZ.Planner.Start()
    return xDTaraZ.EggIndex.Start()
end

---@param quiet boolean  pause the game's inventory bar while farming; the game rebuilds it once when it comes back
---@param force boolean? restore even while a farming toggle is on
function xDTaraZ.Eggs.QuietInventory(quiet, force)
    local eggs = xDTaraZ.Eggs
    if quiet then
        if eggs.InventoryPaused then return end
        eggs.InventoryPaused = true
        eggs.InventoryWas = LocalPlayer:GetAttribute("SatchelEnabled")
        LocalPlayer:SetAttribute("SatchelEnabled", false)
        return
    end
    if not eggs.InventoryPaused then return end
    if not force and (eggs.Enabled or xDTaraZ.Hunter.Enabled or xDTaraZ.Util.Opt("ClearJunk")) then return end
    eggs.InventoryPaused = false
    LocalPlayer:SetAttribute("SatchelEnabled", eggs.InventoryWas)
end

function xDTaraZ.Eggs.Start()
    local eggs = xDTaraZ.Eggs
    eggs.QuietInventory(true)
    if State.LastFail then State.Tune.DirectFactor = math.min(State.Tune.DirectFactor, Config.DirectFactorAfterFail) end
    eggs.Prepare()
    eggs.Enabled, eggs.MountRetryAt = true, 0
    eggs.SetPhase("Idle")
end

function xDTaraZ.Eggs.Stop()
    local eggs = xDTaraZ.Eggs
    eggs.Enabled = false
    if xDTaraZ.Hunter.Enabled then return end
    if eggs.InFlight() then
        task.spawn(xDTaraZ.Eggs.FinishCarry, Config.RunBudget * 2)
        return
    end
    eggs.ReleaseToken()
    eggs.SetPhase("Idle")
    task.spawn(xDTaraZ.Eggs.Settle)
end

---@async
---@return boolean  dismounted and the inventory bar is back
function xDTaraZ.Eggs.Settle()
    local eggs = xDTaraZ.Eggs
    eggs.SettlePending = true
    if not eggs.LetGo() then return false end
    eggs.SettlePending = false
    eggs.QuietInventory(false)
    return true
end

function xDTaraZ.Eggs.SettleStep()
    local eggs = xDTaraZ.Eggs
    if not eggs.SettlePending then return end
    if eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled or xDTaraZ.Util.Opt("ClearJunk") then
        eggs.SettlePending = false
        return
    end
    eggs.Settle()
end

---@return boolean  a trip is running or an egg is carried
function xDTaraZ.Eggs.InFlight()
    local eggs = xDTaraZ.Eggs
    return eggs.Phase == "Run" or eggs.CarryCritical or xDTaraZ.Player:BasketCount() > 0
end

---@param timeout number  seconds to wait for a running delivery
---@return boolean        basket is empty
function xDTaraZ.Eggs.FinishCarry(timeout)
    local eggs = xDTaraZ.Eggs
    local deadline = os.clock() + (timeout or Config.RunBudget)
    while (eggs.CarryCritical or eggs.Phase == "Run") and os.clock() < deadline do
        task.wait(Config.EggTick)
    end

    if xDTaraZ.Player:BasketCount() > 0 then
        eggs.RecoverAt = 0
        eggs.Recover()
    end
    eggs.ReleaseToken()
    if not eggs.Enabled and not xDTaraZ.Hunter.Enabled then eggs.Settle() end
    return xDTaraZ.Player:BasketCount() == 0
end

---@async
---@return boolean  off the mount with empty hands; false while a task or a carried egg still needs the mount
function xDTaraZ.Eggs.LetGo()
    if xDTaraZ.Tasks.Owner() or xDTaraZ.Player:BasketCount() > 0 then return false end
    return xDTaraZ.Player:Release()
end

function xDTaraZ.Eggs.ExitNow()
    local eggs = xDTaraZ.Eggs
    eggs.Enabled = false
    table.insert(State.PendingToggleOff, "AutoEggs")
    eggs.FinishCarry(Config.RunBudget)
    eggs.SetPhase("Idle", "Stopped")
end

---@async
---@return integer  eggs delivered in this pass, yields until the pass ends
function xDTaraZ.Eggs.CollectNow()
    local eggs = xDTaraZ.Eggs
    if eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled then return 0 end
    if not eggs.Prepare() then return 0 end

    eggs.Manual = true
    local before = State.Stats.delivered
    local limit = 0
    for _ in pairs(xDTaraZ.EggIndex.Entries) do limit += 1 end

    for _ = 1, limit do
        if xDTaraZ.Guard.Tripped or not State.Alive then break end
        eggs.Tick(nil)
        if eggs.Phase == "WaveWait" or eggs.Phase == "Idle" or eggs.Phase == "Pick" then break end
    end

    eggs.ReleaseToken()
    eggs.Manual = false
    eggs.Settle()
    local got = State.Stats.delivered - before
    table.insert(State.PendingNotify, { "Collect Eggs", "Delivered " .. got .. " eggs" })
    return got
end

---@return number  rarity rank the hunter cares about, huge when unset
function xDTaraZ.Hunter.MinRank()
    return GameLib.RarityRank[xDTaraZ.Options.HuntMinRarity] or math.huge
end

---@return number  task priority for this egg
function xDTaraZ.Hunter.Priority(entry)
    local prio = xDTaraZ.Eggs.Prio
    if not xDTaraZ.Hunter.Enabled then return prio.Eggs end
    local info = GameLib.EggInfo[entry.egg]
    local rank = info and GameLib.RarityRank[info.rarity] or 0
    return rank >= xDTaraZ.Hunter.MinRank() and prio.Hunter or prio.Eggs
end

function xDTaraZ.Hunter.Spotted(entry)
    local hunter = xDTaraZ.Hunter
    if not hunter.Enabled or not entry.egg or hunter.Seen[entry.guid] then return end
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return end
    local info = GameLib.EggInfo[entry.egg]
    if not info or info.volcanic then return end
    if (GameLib.RarityRank[info.rarity] or 0) < hunter.MinRank() then return end

    hunter.Seen[entry.guid] = true
    table.insert(State.PendingNotify, { "Rare Egg", entry.egg .. " (" .. tostring(info.rarity) .. ") spawned" })
    local webhook = xDTaraZ.Webhook
    if webhook and webhook.EggSpawned and entry.inst then task.defer(webhook.EggSpawned, entry.inst) end
end

function xDTaraZ.Hunter.TryHop()
    local hunter = xDTaraZ.Hunter
    if not xDTaraZ.Options.HunterHop or os.clock() < hunter.HopAt then return end
    if GameLib.CycleLeft() <= Config.HunterMinLeft or xDTaraZ.Player:BasketCount() > 0 then return end

    local cycle = GameLib.CycleIndex()
    if hunter.HopCycle ~= cycle then hunter.HopCycle, hunter.Hops = cycle, 0 end
    if hunter.Hops >= Config.HunterHopsPerCycle then return end
    if xDTaraZ.Planner.Next(hunter.MinRank()) then return end

    hunter.Hops += 1
    hunter.HopAt = os.clock() + Config.LoadTimeout
    xDTaraZ.Util.Try("Server.Hop", xDTaraZ.Server.Hop)
end

function xDTaraZ.Hunter.Step()
    local hunter, eggs = xDTaraZ.Hunter, xDTaraZ.Eggs
    if not hunter.Enabled or eggs.Manual or xDTaraZ.Guard.Tripped then return end
    if not eggs.Enabled then eggs.Tick(hunter.MinRank()) end
    if eggs.Phase == "WaveWait" then hunter.TryHop() end
end

function xDTaraZ.Hunter.Start()
    local hunter = xDTaraZ.Hunter
    if State.LastFail then State.Tune.DirectFactor = math.min(State.Tune.DirectFactor, Config.DirectFactorAfterFail) end
    xDTaraZ.Eggs.Prepare()
    xDTaraZ.Eggs.QuietInventory(true)
    hunter.Enabled = true
    if hunter.Started then return end

    hunter.Started = true
    xDTaraZ.EggIndex.OnAdded:Connect(xDTaraZ.Hunter.Spotted)
    xDTaraZ.EggIndex.OnRoll:Connect(function() table.clear(hunter.Seen) end)
end

function xDTaraZ.Hunter.Stop()
    xDTaraZ.Hunter.Enabled = false
    if xDTaraZ.Eggs.Enabled then return end
    if xDTaraZ.Eggs.InFlight() then
        task.spawn(xDTaraZ.Eggs.FinishCarry, Config.RunBudget * 2)
        return
    end
    xDTaraZ.Eggs.ReleaseToken()
    xDTaraZ.Eggs.SetPhase("Idle")
    task.spawn(xDTaraZ.Eggs.Settle)
end

function xDTaraZ.Guard.Arm()
    local guard = xDTaraZ.Guard
    guard.Tripped = false
    guard.Baseline = xDTaraZ.Player:Flags()
    if guard.Watching then return end
    guard.Watching = true
    xDTaraZ:Connect(LocalPlayer:GetAttributeChangedSignal("TeleportFlags"), xDTaraZ.Guard.OnFlags)
end

function xDTaraZ.Guard.OnFlags()
    local guard = xDTaraZ.Guard
    local flags = xDTaraZ.Player:Flags()
    if guard.Baseline and flags > guard.Baseline then guard.Trip("flags") end
    guard.Baseline = flags
end

function xDTaraZ.Guard.Check(flags0)
    if xDTaraZ.Player:Flags() > (flags0 or 0) then xDTaraZ.Guard.Trip("flags") end
end

---@return table  State.LastFail
function xDTaraZ.Guard.Snapshot(why)
    local plan = type(xDTaraZ.Delivery.LastPlan) == "table" and xDTaraZ.Delivery.LastPlan or {}
    return {
        why = why, at = os.time(),
        mode = plan.mode, trip = plan.trip, speed = plan.speed, settle = plan.settle, timings = plan.timings,
        flagsBefore = xDTaraZ.Guard.Baseline, flagsAfter = xDTaraZ.Player:Flags(),
    }
end

---@return boolean  true when the farm keeps going on a slower delivery pace
function xDTaraZ.Guard.Soften()
    local guard = xDTaraZ.Guard
    local now = os.clock()
    guard.Recent = guard.Recent or {}
    while guard.Recent[1] and now - guard.Recent[1] > Config.ReturnWindow do
        table.remove(guard.Recent, 1)
    end
    guard.Recent[#guard.Recent + 1] = now
    if #guard.Recent >= Config.ReturnStopCount then return false end

    local pace = Config.ReturnBackoff[#guard.Recent] or Config.ReturnBackoff[#Config.ReturnBackoff]
    State.Tune.DirectFactor = math.min(State.Tune.DirectFactor, pace)
    table.insert(State.PendingNotify, { "Egg Farm", "An egg was returned. Delivering slower and carrying on." })
    return true
end

function xDTaraZ.Guard.Trip(why)
    local guard = xDTaraZ.Guard
    if guard.Tripped or os.clock() - (guard.LastTrip or -math.huge) < Config.ReturnDedupe then return end
    guard.LastTrip = os.clock()
    State.Stats.returned += 1

    State.LastFail = guard.Snapshot(why)
    local webhook = xDTaraZ.Webhook
    if webhook and webhook.DeliveryFailed then task.defer(webhook.DeliveryFailed, State.LastFail) end
    if guard.Soften() then return end

    guard.Tripped = true
    xDTaraZ.Eggs.Enabled = false
    xDTaraZ.Hunter.Enabled = false
    local volcano = xDTaraZ.Volcano
    if volcano and volcano.Stop then xDTaraZ.Util.Try("Volcano.Stop", volcano.Stop) end
    for _, idx in ipairs(guard.Toggles) do
        table.insert(State.PendingToggleOff, idx)
    end
    table.insert(State.PendingNotify, { "Egg Farm", "Eggs keep getting returned. Egg farming stopped, switch Delivery to Safe and turn it back on." })
end

xDTaraZ.Volcano = {
    Token = nil,
    Reply = nil,
    Bound = false,
    Skip = {},
    ObbyAfter = 0,
    Dipped = 0,
    Magma = 0,
}

local function Never() return false end

function xDTaraZ.Volcano.Options()
    return xDTaraZ.Options or {}
end

function xDTaraZ.Volcano.SetStatus(text)
    xDTaraZ.State.Status.Volcano = text
end

---@return boolean  false when the token died while waiting
function xDTaraZ.Volcano.Sleep(token, sec)
    local _, why = xDTaraZ.Tasks.Await(token, Never, sec)
    return why == "timeout"
end

local function IsOurs(owner)
    return owner == LocalPlayer or owner == LocalPlayer.UserId
end

function xDTaraZ.Volcano.Bind()
    if xDTaraZ.Volcano.Bound then return end
    xDTaraZ.Volcano.Bound = true

    local result = xDTaraZ.GameLib.Remote("VolcanoDipResult")
    if result then
        xDTaraZ:Connect(result.OnClientEvent, function(reply)
            if type(reply) ~= "table" or not IsOurs(reply.Owner) then return end
            xDTaraZ.Volcano.Reply = reply
        end)
    end

    local cancelled = xDTaraZ.GameLib.Remote("VolcanoDipCancelled")
    if cancelled then
        xDTaraZ:Connect(cancelled.OnClientEvent, function(reply)
            if type(reply) == "table" and not IsOurs(reply.Owner) then return end
            xDTaraZ.Volcano.Reply = { Cancelled = true }
        end)
    end
end

---@return boolean  VolcanoTop is streamed in, not just the empty Volcano shell
function xDTaraZ.Volcano.Stream(token)
    if xDTaraZ.Volcano.Part("VolcanoTop") then return true end
    local ok, err = pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, xDTaraZ.Config.VolcanoCenter, xDTaraZ.Config.VolcanoStreamTimeout)
    if not ok then warn("[RideAPet] volcano stream:", err) end
    return xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Volcano.Part("VolcanoTop") ~= nil end, xDTaraZ.Config.VolcanoStreamTimeout) == true
end

---@return BasePart?
function xDTaraZ.Volcano.Part(name)
    local volcano = workspace:FindFirstChild("Volcano")
    local part = volcano and volcano:FindFirstChild(name, true)
    if part and part:IsA("BasePart") then return part end

    for _, tagged in ipairs(game:GetService("CollectionService"):GetTagged(name)) do
        if tagged:IsA("BasePart") then return tagged end
    end
    return nil
end

---@return boolean  same footprint rule the game uses before it lets a dip fire
function xDTaraZ.Volcano.IsOver(top)
    local hrp = xDTaraZ.Player.Root
    local info = xDTaraZ.GameLib.Data.Volcano
    if not hrp or not top or not info then return false end

    local slack = tonumber(info.ServerRangeSlack) or 0
    local localPos = top.CFrame:PointToObjectSpace(hrp.Position)
    if localPos.Y < 0 then return false end
    return math.abs(localPos.X) <= top.Size.X / 2 + slack and math.abs(localPos.Z) <= top.Size.Z / 2 + slack
end

---@return boolean  ethereal, volcanic or already magma/eternal
local function SkipsDip(entry, info)
    if not info or info.ethereal or info.volcanic then return true end
    return entry.mutation == "Magma" or entry.mutation == "Eternal"
end

---@return number  minimum remaining break time for the dip and trip back
function xDTaraZ.Volcano.MinimumBreak()
    local speed = xDTaraZ.Mount.TravelSpeed()
    if speed <= 0 then local _, bestSpeed = xDTaraZ.Mount.Best(); speed = bestSpeed end
    speed = math.max(speed, xDTaraZ.Config.UnmountedPlayerSpeed)
    local _, bp = xDTaraZ.Player:Plot()
    local returning = bp and math.max(0, (xDTaraZ.Config.VolcanoCenter - bp.Position).Magnitude - xDTaraZ.Config.ReturnHopMax) / speed or math.huge
    return returning + xDTaraZ.Config.VolcanoMinBreakLeft
end

---@return boolean  egg run is idle or waiting, or the wave is down to its last free eggs
function xDTaraZ.Volcano.WaveTail()
    if xDTaraZ.Eggs.Waiting() then return true end
    local free = 0
    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if xDTaraZ.EggIndex.Wanted(entry) and xDTaraZ.Planner.Contest(entry) == 0 then free += 1 end
        if free > xDTaraZ.Config.VolcanoTailEggs then return false end
    end
    return true
end

---@return table?  index entry worth a dip, best score first
function xDTaraZ.Volcano.PickDip()
    local rarities = xDTaraZ.Volcano.Options().DipRarities or {}
    local minBreak = xDTaraZ.Volcano.MinimumBreak()
    local best, bestScore = nil, -math.huge

    for guid, entry in pairs(xDTaraZ.EggIndex.Entries) do
        local egg = xDTaraZ.GameLib.EggInfo[entry.egg]
        if SkipsDip(entry, egg) or (xDTaraZ.Volcano.Skip[guid] or 0) > os.clock() then continue end
        if next(rarities) and not rarities[egg.rarity] then continue end
        if (egg.breakSec or 0) <= minBreak or not xDTaraZ.EggIndex.Wanted(entry) then continue end
        if xDTaraZ.Delivery.Mode(entry) == "Plot" then continue end

        local score = xDTaraZ.Planner.Score(entry)
        if score > bestScore then best, bestScore = entry, score end
    end
    return best
end

---@return Instance?  carried egg that can still be dipped
function xDTaraZ.Volcano.Carried()
    local now = xDTaraZ.Util.ServerNow()
    local minBreak = (tonumber(xDTaraZ.GameLib.Data.Volcano.BonusSeconds) or math.huge) + xDTaraZ.Config.VolcanoMinBreakLeft
    for _, egg in ipairs(xDTaraZ.Player:BasketItems()) do
        if egg:GetAttribute("VolcanoDipped") or egg:GetAttribute("Delivering") then continue end
        if (tonumber(egg:GetAttribute("VolcanoUntil")) or 0) > now then continue end
        local breakAt = tonumber(egg:GetAttribute("BreakAt"))
        if breakAt and breakAt - now > minBreak then return egg end
    end
    return nil
end

---@return table?  dip reply, re-fired while the server position still lags the teleport
function xDTaraZ.Volcano.FireUntilReply(token, remote)
    xDTaraZ.Volcano.Reply = nil
    local deadline = os.clock() + xDTaraZ.Config.VolcanoResultTimeout
    repeat
        remote:FireServer()
        if xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Volcano.Reply ~= nil end, xDTaraZ.Config.VolcanoRefire) then
            return xDTaraZ.Volcano.Reply
        end
        if not xDTaraZ.Tasks.Holds(token) then return nil end
    until os.clock() >= deadline
    return nil
end

---@return boolean  the dip reply came back and the egg is home in the basket again
function xDTaraZ.Volcano.Dip(token)
    local remote = xDTaraZ.GameLib.Remote("VolcanoDip")
    local info = xDTaraZ.GameLib.Data.Volcano
    if not remote or not info or not xDTaraZ.Volcano.Carried() then return false end
    if not xDTaraZ.Volcano.Stream(token) then return false end

    local top = xDTaraZ.Volcano.Part("VolcanoTop")
    if not top then return false end
    xDTaraZ.Tasks.Teleport(token, CFrame.new(top.Position + Vector3.yAxis * (tonumber(info.HoverHeight) or 0)))
    if not xDTaraZ.Volcano.Sleep(token, xDTaraZ.Config.VolcanoDipSettle) then return false end
    if not xDTaraZ.Volcano.IsOver(top) then return false end

    xDTaraZ.Volcano.SetStatus("Dipping egg")
    local reply = xDTaraZ.Volcano.FireUntilReply(token, remote)
    if not reply or reply.Cancelled then return false end

    local landAt = tonumber(reply.ArriveAt) or 0
    local arrived = xDTaraZ.Tasks.Await(token, function()
        return (xDTaraZ.Volcano.Reply and xDTaraZ.Volcano.Reply.Cancelled) or xDTaraZ.Util.ServerNow() >= landAt
    end, xDTaraZ.Config.VolcanoResultTimeout)
    if not arrived or (xDTaraZ.Volcano.Reply and xDTaraZ.Volcano.Reply.Cancelled) then return false end
    xDTaraZ.Volcano.Dipped += 1
    if reply.Success then xDTaraZ.Volcano.Magma += 1 end
    return true
end

---@return string  short outcome for the status line
function xDTaraZ.Volcano.DipRun(token, entry)
    local _, bp = xDTaraZ.Player:Plot()
    if not bp then return "no plot" end
    if not xDTaraZ.Mount.Ensure(token) then return "A fast ride pet is needed for the return" end

    local ok, why = xDTaraZ.Delivery.Pickup(token, entry.guid, xDTaraZ.Geo.StandPoint(bp, entry.pos))
    if not ok then
        xDTaraZ.Volcano.Skip[entry.guid] = os.clock() + xDTaraZ.Config.GoneBlacklistSec
        return "pickup " .. tostring(why)
    end

    xDTaraZ.Eggs.CarryCritical = true
    local dipped = xDTaraZ.Volcano.Dip(token)
    xDTaraZ.Volcano.SetStatus("Returning the dipped egg")
    local _, outcome = xDTaraZ.Delivery.Recover(token)
    xDTaraZ.Eggs.CarryCritical = false
    if outcome ~= "Deposited" then return "Dip finished; egg delivery not confirmed" end
    return dipped and "dipped and delivered" or "dip skipped; egg delivered"
end

---@param canTouch boolean  executor touch works
function xDTaraZ.Volcano.Hold(token, part, canTouch)
    local hrp = xDTaraZ.Player.Root
    if not hrp or not part.Parent then return end
    hrp.AssemblyLinearVelocity = Vector3.zero
    if (hrp.Position - part.Position).Magnitude > part.Size.Magnitude / 2 then xDTaraZ.Tasks.Teleport(token, part.CFrame) end
    if not canTouch or os.clock() < (xDTaraZ.Volcano.TouchAt or 0) then return end
    xDTaraZ.Volcano.TouchAt = os.clock() + xDTaraZ.Config.VolcanoTouchEvery
    firetouchinterest(hrp, part, 0)
    task.defer(firetouchinterest, hrp, part, 1)
end

function xDTaraZ.Volcano.Climb(token)
    if xDTaraZ.Volcano.Done() then return true end
    if not xDTaraZ.Volcano.Stream(token) then return false end
    local canTouch = Library and Library.Compat and Library.Compat.Caps.Touch == true

    for _, step in ipairs({ { "VolcanoEntrance" }, { "VolcanoValidate", "InVolcano" }, { "VolcanoTop", "VolcanoValidated" } }) do
        local part = xDTaraZ.Volcano.Part(step[1])
        if not part or not xDTaraZ.Tasks.Teleport(token, part.CFrame) then return false end
        if not xDTaraZ.Volcano.Sleep(token, xDTaraZ.Config.VolcanoSettle) then return false end

        xDTaraZ.Volcano.Hold(token, part, canTouch)
        local attr = step[2]
        if attr and not xDTaraZ.Tasks.Await(token, function()
            if LocalPlayer:GetAttribute(attr) == true then return true end
            xDTaraZ.Volcano.Hold(token, part, canTouch)
            return false
        end, xDTaraZ.Config.VolcanoStepWait) then
            return false
        end
    end
    return xDTaraZ.Volcano.Done()
end

function xDTaraZ.Volcano.Done()
    return LocalPlayer:GetAttribute("VolcanoValidated") == true
end

---@return table?  Volcanic egg in the index we may pick up
function xDTaraZ.Volcano.VolcanicEgg()
    for guid, entry in pairs(xDTaraZ.EggIndex.Entries) do
        local info = xDTaraZ.GameLib.EggInfo[entry.egg]
        if not info or not info.volcanic then continue end
        if entry.privateTo and not IsOurs(entry.privateTo) then continue end
        if (xDTaraZ.Volcano.Skip[guid] or 0) > os.clock() then continue end
        return entry
    end
    return nil
end

---@return string
function xDTaraZ.Volcano.ObbyRun(token, entry)
    if not xDTaraZ.Volcano.Climb(token) then
        xDTaraZ.Volcano.ObbyAfter = os.clock() + xDTaraZ.Config.VolcanoRetry
        return "climb failed"
    end

    if not xDTaraZ.Mount.Ensure(token) then return "A fast ride pet is needed for the return" end

    local stand = entry.pos + Vector3.yAxis * xDTaraZ.Geo.Lift(xDTaraZ.Config.VolcanoStandLift)
    local ok, why = xDTaraZ.Delivery.Pickup(token, entry.guid, stand)
    if not ok then
        xDTaraZ.Volcano.Skip[entry.guid] = os.clock() + xDTaraZ.Config.GoneBlacklistSec
        return "pickup " .. tostring(why)
    end

    xDTaraZ.Eggs.CarryCritical = true
    xDTaraZ.Volcano.SetStatus("Returning the volcanic egg")
    local _, outcome = xDTaraZ.Delivery.Recover(token)
    xDTaraZ.Eggs.CarryCritical = false
    return outcome == "Deposited" and "volcanic egg delivered" or "Volcanic egg delivery not confirmed"
end

---@return table?, function?  target and runner for this tick
function xDTaraZ.Volcano.Plan()
    local opts = xDTaraZ.Volcano.Options()
    if opts.VolcanoObby and os.clock() >= xDTaraZ.Volcano.ObbyAfter then
        local egg = xDTaraZ.Volcano.VolcanicEgg()
        if egg then return egg, xDTaraZ.Volcano.ObbyRun end
    end
    if opts.VolcanoDip and xDTaraZ.GameLib.Data.Volcano and xDTaraZ.Volcano.WaveTail() then
        local egg = xDTaraZ.Volcano.PickDip()
        if egg then return egg, xDTaraZ.Volcano.DipRun end
    end
    return nil
end

---@return boolean  the egg run must leave the character to the volcano for now
function xDTaraZ.Volcano.Pending()
    local hold = xDTaraZ.Volcano.Claimed
    if not hold then return false end
    if os.clock() < hold[2] and xDTaraZ.EggIndex.Entries[hold[1]] then return true end
    xDTaraZ.Volcano.Claimed = nil
    return false
end

---@return boolean  an egg nobody delivers is still in the basket
local function Orphaned()
    local eggs = xDTaraZ.Eggs
    if xDTaraZ.Player:BasketCount() == 0 or eggs.CarryCritical then return false end
    return not (eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled)
end

function xDTaraZ.Volcano.Step()
    if not xDTaraZ.State.Alive or not xDTaraZ.Player:IsAlive() or xDTaraZ.Guard.Tripped then return end
    if xDTaraZ.Halloween.InZone() == true then
        xDTaraZ.Volcano.SetStatus("Leave the Halloween island to farm the volcano")
        return
    end
    if Orphaned() then
        xDTaraZ.Volcano.SetStatus("Finishing the egg")
        xDTaraZ.Eggs.Recover()
        return
    end
    if not xDTaraZ.Player:Riding() then
        local mountToken = xDTaraZ.Tasks.Request("Volcano", xDTaraZ.Tasks.Prio.Volcano)
        if not mountToken then return end
        xDTaraZ.Volcano.Token = mountToken
        local mounted = xDTaraZ.Mount.Ensure(mountToken)
        xDTaraZ.Volcano.Token = nil
        xDTaraZ.Tasks.Release(mountToken)
        if not mounted then
            xDTaraZ.Volcano.SetStatus("A fast ride pet is needed for the return")
            return
        end
    end
    xDTaraZ.Volcano.Bind()

    local entry, runner = xDTaraZ.Volcano.Plan()
    if not entry then
        xDTaraZ.Volcano.Claimed = nil
        xDTaraZ.Volcano.SetStatus("Waiting")
        return
    end

    xDTaraZ.Volcano.Claimed = { entry.guid, os.clock() + xDTaraZ.Config.VolcanoClaimSec }
    if xDTaraZ.Player:BasketCount() > 0 then return end
    local token = xDTaraZ.Tasks.Request("Volcano", xDTaraZ.Tasks.Prio.Volcano)
    if not token then return end
    xDTaraZ.Volcano.Claimed = nil
    xDTaraZ.Volcano.Token = token

    local flags0 = xDTaraZ.Player:Flags()
    local ok, outcome = xDTaraZ.Util.Try("volcano", runner, token, entry)
    xDTaraZ.Eggs.CarryCritical = false
    xDTaraZ.Guard.Check(flags0)

    xDTaraZ.Volcano.Token = nil
    xDTaraZ.Tasks.Release(token)
    xDTaraZ.Volcano.SetStatus(ok and outcome or "error")
end

function xDTaraZ.Volcano.Start()
    xDTaraZ.Eggs.Prepare()
    xDTaraZ.Volcano.Bind()
    xDTaraZ.Volcano.ObbyAfter = 0
end

function xDTaraZ.Volcano.Stop()
    xDTaraZ.Volcano.Claimed = nil
    local token = xDTaraZ.Volcano.Token
    if token and xDTaraZ.Player:BasketCount() == 0 then
        xDTaraZ.Volcano.Token = nil
        xDTaraZ.Tasks.Release(token)
    end
end

function xDTaraZ.Volcano.Status()
    return xDTaraZ.State.Status.Volcano or "Off"
end

xDTaraZ.Hatch = {
    Bound = false,
    Pending = {},
    LastPlaced = 0,
    LastRequest = 0,
    CapHit = false,
    Hatched = 0,
    Purchased = {},
    Confirmed = {},
    Planted = 0,
    GrowCache = {},
    Signal = xDTaraZ.Signal.new(),
}

local function IsOurs(owner)
    return owner == nil or owner == LocalPlayer or owner == LocalPlayer.UserId
end

function xDTaraZ.Hatch.Options()
    return xDTaraZ.Options or {}
end

function xDTaraZ.Hatch.SetStatus(text)
    xDTaraZ.State.Status.Hatch = text
end

function xDTaraZ.Hatch.Store(placement)
    if type(placement) ~= "table" or type(placement.EggKey) ~= "string" then return end
    xDTaraZ.State.PlotEggs[placement.EggKey] = {
        key = placement.EggKey,
        egg = placement.EggName,
        placeTime = tonumber(placement.PlaceTime),
        weight = tonumber(placement.Weight) or 1,
        pos = typeof(placement.UpCFrame) == "CFrame" and placement.UpCFrame.Position or placement.Coordinate,
    }
    xDTaraZ.Hatch.LastPlaced = os.clock()
end

---@param msg table  EggPlaced reply, snapshot or one placement
function xDTaraZ.Hatch.OnPlaced(msg)
    if type(msg) ~= "table" or not IsOurs(msg.Owner) then return end
    if not msg.Snapshot then
        xDTaraZ.Hatch.Store(msg)
        return
    end

    table.clear(xDTaraZ.State.PlotEggs)
    for _, placement in pairs(type(msg.Placements) == "table" and msg.Placements or {}) do
        xDTaraZ.Hatch.Store(placement)
    end
end

function xDTaraZ.Hatch.OnHatched(msg)
    if type(msg) ~= "table" or not IsOurs(msg.Owner) or not msg.EggKey then return end
    xDTaraZ.State.PlotEggs[msg.EggKey] = nil
    xDTaraZ.Hatch.Pending[msg.EggKey] = nil
    xDTaraZ.Hatch.Hatched += 1
    xDTaraZ.Hatch.Confirmed[msg.EggKey] = os.clock()
    xDTaraZ.Hatch.Purchased[msg.EggKey] = nil
    xDTaraZ.Hatch.Signal:Fire(msg)
end

function xDTaraZ.Hatch.OnMessage(text)
    if type(text) ~= "string" then return end
    local used, cap = text:match("Max (%d+)/(%d+)")
    if not cap then return end
    xDTaraZ.State.PlantCap = math.max(tonumber(used), tonumber(cap))
    xDTaraZ.Hatch.CapHit = true
    xDTaraZ.Hatch.RequestSnapshot()
end

function xDTaraZ.Hatch.Bind()
    if xDTaraZ.Hatch.Bound then return end
    xDTaraZ.Hatch.Bound = true

    local placed = xDTaraZ.GameLib.Remote("EggPlaced")
    if placed then xDTaraZ:Connect(placed.OnClientEvent, xDTaraZ.Hatch.OnPlaced) end

    local hatch = xDTaraZ.GameLib.Remote("Hatch")
    if hatch then xDTaraZ:Connect(hatch.OnClientEvent, xDTaraZ.Hatch.OnHatched) end

    local message = xDTaraZ.GameLib.Remote("GameMessage")
    if message then xDTaraZ:Connect(message.OnClientEvent, xDTaraZ.Hatch.OnMessage) end

    xDTaraZ.Hatch.RequestSnapshot()
end

function xDTaraZ.Hatch.RequestSnapshot()
    local remote = xDTaraZ.GameLib.Remote("RequestPlotEggs")
    if not remote then return end
    xDTaraZ.Hatch.LastRequest = os.clock()
    remote:FireServer(true)
end

---@return boolean  a hatch luck event is running
function xDTaraZ.Hatch.BoostActive()
    local rs = game:GetService("ReplicatedStorage")
    local mult = tonumber(rs:GetAttribute("HatchLuckEventMultiplier")) or 1
    local untilAt = tonumber(rs:GetAttribute("HatchLuckEventUntil"))
    if untilAt and untilAt <= xDTaraZ.Util.ServerNow() then return false end
    return mult > 1
end

---@return number?  seconds of growth left, nil when unknown
function xDTaraZ.Hatch.Left(plotEgg)
    local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
    if not info or not plotEgg.placeTime then return nil end
    return xDTaraZ.GameLib.GrowthLeft(plotEgg.placeTime, info.growth, plotEgg.weight)
end

---@return number|nil  os.clock() moment the egg is grown, night growth included; nil when unknown
function xDTaraZ.Hatch.ReadyAt(plotEgg)
    if plotEgg.readyAt then return plotEgg.readyAt end
    local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
    if not info or not plotEgg.placeTime then return nil end

    local left = xDTaraZ.GameLib.GrowthRealLeft(plotEgg.placeTime, info.growth, plotEgg.weight)
    if not left then return nil end
    plotEgg.readyAt = os.clock() + left
    return plotEgg.readyAt
end

---@return integer  hatch fires sent this pass
function xDTaraZ.Hatch.HatchNow(onlyKey)
    local remote = xDTaraZ.GameLib.Remote("Hatch")
    if not remote then return 0 end
    xDTaraZ.Hatch.Bind()

    local fired, now = 0, os.clock()
    for key, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        if onlyKey and key ~= onlyKey then continue end
        if (xDTaraZ.Hatch.Pending[key] or 0) > now then continue end
        local left = xDTaraZ.Hatch.Left(plotEgg)
        if not left or left > 0 then continue end

        if fired > 0 then task.wait(xDTaraZ.Config.HatchGap) end
        xDTaraZ.Hatch.Pending[key] = os.clock() + xDTaraZ.Config.HatchPending
        remote:FireServer({ EggKey = key })
        fired += 1
    end
    return fired
end

function xDTaraZ.Hatch.Step()
    local opts = xDTaraZ.Hatch.Options()
    local purchased = opts.HalloweenAutoHatch ~= false and next(xDTaraZ.Hatch.Purchased) ~= nil
    if not opts.AutoHatch and not purchased then return end
    xDTaraZ.Hatch.Bind()

    if os.clock() - xDTaraZ.Hatch.LastRequest > xDTaraZ.Config.PlotEggsRefresh then
        xDTaraZ.Hatch.RequestSnapshot()
    end
    if opts.HoldHatchBoost and not xDTaraZ.Hatch.BoostActive() then
        xDTaraZ.Hatch.SetStatus("Holding for luck boost")
        return
    end

    if not opts.AutoHatch then
        for key in pairs(xDTaraZ.Hatch.Purchased) do
            xDTaraZ.Hatch.HatchNow(key)
        end
        return
    end

    local fired = xDTaraZ.Hatch.HatchNow()
    if fired > 0 then xDTaraZ.Hatch.SetStatus("Hatching " .. fired) end
end

---@return string?  egg name the tool plants
function xDTaraZ.Hatch.ToolEgg(tool)
    local name = tool:GetAttribute("Egg") or tool.Name:match("^(.-Egg)")
    return xDTaraZ.GameLib.EggInfo[name or ""] and name or nil
end

---@return { {Tool, string, number, string?} }  egg tools with name, weight and mutation
function xDTaraZ.Hatch.EggTools()
    local tools = {}
    for _, holder in ipairs({ LocalPlayer:FindFirstChild("Backpack"), xDTaraZ.Player.Char }) do
        if not holder then continue end
        for _, tool in ipairs(holder:GetChildren()) do
            if not tool:IsA("Tool") or not tool:GetAttribute("EggInventoryId") then continue end
            local name = xDTaraZ.Hatch.ToolEgg(tool)
            if not name then continue end
            table.insert(tools, { tool, name, tonumber(tool:GetAttribute("Weight")) or 1, tool:GetAttribute("Mutation") })
        end
    end
    return tools
end

---@return number  higher plants first
function xDTaraZ.Hatch.Rank(name, weight, order, mutation)
    local info = xDTaraZ.GameLib.EggInfo[name]
    local key = name .. "|" .. tostring(weight)
    local growth = xDTaraZ.Hatch.GrowCache[key]
    if growth == nil then
        growth = xDTaraZ.GameLib.GrowthSeconds(info.growth or 1, weight) or info.growth or 1
        xDTaraZ.Hatch.GrowCache[key] = growth
    end
    growth = math.max(growth, 0.001)
    if order == "Fastest growth" then return -growth end
    local value = xDTaraZ.EggIndex.Value({ egg = name, weight = weight, mutation = mutation })
    if order == "Value per hour" then return value / growth end
    return value
end

---@return { {Tool, string, number} }  tools to plant in order, PlantKeep per egg name held back
function xDTaraZ.Hatch.Queue()
    local opts = xDTaraZ.Hatch.Options()
    local order = opts.PlantOrder or "Best value"
    local tools = xDTaraZ.Hatch.EggTools()
    for _, entry in ipairs(tools) do
        entry[5] = xDTaraZ.Hatch.Rank(entry[2], entry[3], order, entry[4])
    end
    local function Better(a, b) return a[5] > b[5] end
    table.sort(tools, Better)

    local keep = tonumber(opts.PlantKeep) or 0
    if keep <= 0 then return tools end
    local seen, queue = {}, {}
    for i = #tools, 1, -1 do
        local name = tools[i][2]
        seen[name] = (seen[name] or 0) + 1
        if seen[name] > keep then queue[#queue + 1] = tools[i] end
    end
    table.sort(queue, Better)
    return queue
end

function xDTaraZ.Hatch.Count()
    local count = 0
    for _ in pairs(xDTaraZ.State.PlotEggs) do count += 1 end
    return count
end

function xDTaraZ.Hatch.Room()
    return math.max(0, (xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault) - xDTaraZ.Hatch.Count())
end

---@return integer  plot slots Auto Place Eggs owns while Clear Junk shares the plot
function xDTaraZ.Hatch.ValueCap()
    local cap = xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault
    return math.floor(cap * (1 - xDTaraZ.Config.JunkPlotShare))
end

---@return integer  slots the value planter may fill, Clear Junk keeps its share free
function xDTaraZ.Hatch.ValueRoom()
    local room = xDTaraZ.Hatch.Room()
    if not xDTaraZ.Util.Opt("ClearJunk") then return room end
    local held = xDTaraZ.Hatch.Count() - xDTaraZ.Junk.PlotJunk()
    return math.max(0, math.min(room, xDTaraZ.Hatch.ValueCap() - held))
end

---@return integer  slots Clear Junk may fill, the value share stays free while Auto Place Eggs runs
function xDTaraZ.Hatch.JunkRoom()
    local room = xDTaraZ.Hatch.Room()
    if not xDTaraZ.Util.Opt("AutoPlaceEggs") then return room end
    local held = xDTaraZ.Hatch.Count() - xDTaraZ.Junk.PlotJunk()
    return math.max(0, room - math.max(0, xDTaraZ.Hatch.ValueCap() - held))
end

---@return Vector3[]  free grid points on the baseplate top, PlantSpacing apart from planted eggs
function xDTaraZ.Hatch.Spots(bp, count)
    local spacing = xDTaraZ.Config.PlantSpacing
    local taken = {}
    for _, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        if typeof(plotEgg.pos) == "Vector3" then taken[#taken + 1] = plotEgg.pos end
    end

    local top = bp.Size.Y / 2
    local halfX = bp.Size.X / 2 - xDTaraZ.Config.EdgeInset - spacing / 2
    local halfZ = bp.Size.Z / 2 - xDTaraZ.Config.EdgeInset - spacing / 2
    local spots = {}
    for x = -halfX, halfX, spacing do
        for z = -halfZ, halfZ, spacing do
            local pos = (bp.CFrame * CFrame.new(x, top, z)).Position
            local clear = true
            for _, other in ipairs(taken) do
                if xDTaraZ.Util.Flat(other, pos) < spacing then
                    clear = false
                    break
                end
            end
            if not clear then continue end
            spots[#spots + 1] = pos
            taken[#taken + 1] = pos
            if #spots >= count then return spots end
        end
    end
    return spots
end

---@return { string }  nest ids that are unlocked and empty
function xDTaraZ.Hatch.FreeNests(plot)
    local nests = plot:FindFirstChild("Nests")
    local free = {}
    for _, nest in ipairs(nests and nests:GetChildren() or {}) do
        if nest:GetAttribute("Unlocked") and not nest:GetAttribute("Occupied") then table.insert(free, nest.Name) end
    end
    return free
end

---@return boolean  the server answered with a new placement
function xDTaraZ.Hatch.PlantOne(token, tool, args)
    local hum = xDTaraZ.Player.Humanoid
    if not hum or tool.Parent == nil then return false end
    hum:EquipTool(tool)
    local _, why = xDTaraZ.Tasks.Await(token, function() return false end, xDTaraZ.Config.EquipSettle)
    if why ~= "timeout" then return false end

    local before = xDTaraZ.Hatch.LastPlaced
    xDTaraZ.Hatch.CapHit = false
    local replied = function() return xDTaraZ.Hatch.LastPlaced ~= before or xDTaraZ.Hatch.CapHit end
    for _ = 1, xDTaraZ.Config.PlantTries do
        if tool.Parent ~= hum.Parent then hum:EquipTool(tool) end
        xDTaraZ.GameLib.Remote("EggPlaced"):FireServer(args)
        local ok, why = xDTaraZ.Tasks.Await(token, replied, xDTaraZ.Config.PlantReplyTimeout)
        if ok then return not xDTaraZ.Hatch.CapHit end
        if why ~= "timeout" or tool.Parent == nil then return false end
    end
    return false
end

---@return string|nil  the new placement key for this one tool
function xDTaraZ.Hatch.PlantTool(token, tool)
    xDTaraZ.Hatch.Bind()
    local plot, bp = xDTaraZ.Player:Plot()
    if not plot or not bp or xDTaraZ.Hatch.Room() <= 0 then return nil end
    local egg = xDTaraZ.Hatch.ToolEgg(tool)
    if not egg then return nil end
    local noNest = LocalPlayer:GetAttribute("NoNest") == true
    local slots = noNest and xDTaraZ.Hatch.Spots(bp, 1) or xDTaraZ.Hatch.FreeNests(plot)
    if not slots[1] then return nil end

    local before = {}
    for key in pairs(xDTaraZ.State.PlotEggs) do before[key] = true end
    local stand = CFrame.new(bp.Position + Vector3.yAxis * (bp.Size.Y / 2 + xDTaraZ.Geo.Lift(Config.PlantStandLift)))
    if not xDTaraZ.Tasks.Teleport(token, stand) then return nil end
    local args = noNest and { PlantPosition = slots[1] } or { NestId = slots[1] }
    if not xDTaraZ.Hatch.PlantOne(token, tool, args) then return nil end
    for key, placement in pairs(xDTaraZ.State.PlotEggs) do
        if not before[key] and placement.egg == egg then return key end
    end
    return nil
end

---@return boolean  takes longer than PlantLongGrow seconds to grow
function xDTaraZ.Hatch.IsLong(name, weight)
    local cache = xDTaraZ.Hatch.GrowCache
    local key = name .. "|" .. weight
    if cache[key] == nil then
        local info = xDTaraZ.GameLib.EggInfo[name]
        local total = info and (xDTaraZ.GameLib.GrowthSeconds(info.growth, weight) or info.growth) or 0
        cache[key] = total > xDTaraZ.Config.PlantLongGrow
    end
    return cache[key]
end

---@return integer  slow growers we may still plant so the rest of the plot keeps hatching
function xDTaraZ.Hatch.LongRoom()
    local cap = xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault
    local held = 0
    for _, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        local left = xDTaraZ.Hatch.Left(plotEgg)
        if left and left > xDTaraZ.Config.PlantLongGrow then held += 1 end
    end
    return math.max(0, math.floor(cap * xDTaraZ.Config.PlantLongShare) - held)
end

---@return { {Tool, string, number} }  Queue trimmed to room, slow growers capped by LongRoom
function xDTaraZ.Hatch.Pick(room)
    local longRoom = xDTaraZ.Hatch.LongRoom()
    local picked, spare = {}, {}
    for _, entry in ipairs(xDTaraZ.Hatch.Queue()) do
        if #picked >= room then break end
        if xDTaraZ.Hatch.IsLong(entry[2], entry[3]) then
            if longRoom <= 0 then
                spare[#spare + 1] = entry
                continue
            end
            longRoom -= 1
        end
        picked[#picked + 1] = entry
    end
    for _, entry in ipairs(spare) do
        if #picked >= room then break end
        picked[#picked + 1] = entry
    end
    return picked
end

---@return integer  eggs planted
function xDTaraZ.Hatch.Plant(token, plot, bp)
    local noNest = LocalPlayer:GetAttribute("NoNest") == true
    local room = xDTaraZ.Hatch.ValueRoom()
    local queue = xDTaraZ.Hatch.Pick(room)
    local slots = noNest and xDTaraZ.Hatch.Spots(bp, math.min(room, #queue)) or xDTaraZ.Hatch.FreeNests(plot)
    if #slots == 0 or #queue == 0 or room == 0 then return 0 end

    xDTaraZ.Tasks.Teleport(token, CFrame.new(bp.Position + Vector3.yAxis * (bp.Size.Y / 2 + xDTaraZ.Geo.Lift(Config.PlantStandLift))))
    local planted = 0
    for i, slot in ipairs(slots) do
        local entry = queue[i]
        if i > room or not entry or not xDTaraZ.Tasks.Holds(token) then break end
        xDTaraZ.Hatch.SetStatus("Placing " .. entry[2])
        local args = noNest and { PlantPosition = slot } or { NestId = slot }
        if not xDTaraZ.Hatch.PlantOne(token, entry[1], args) then break end
        planted += 1
    end

    return planted
end

---@return boolean  planting may take the character now
function xDTaraZ.Hatch.CanPlant()
    if xDTaraZ.Player:BasketCount() > 0 or not xDTaraZ.Player:IsAlive() then return false end
    if not xDTaraZ.GameLib.Remote("EggPlaced") or xDTaraZ.Junk.Running then return false end
    return not xDTaraZ.Hatch.Options().AutoEggs or xDTaraZ.Eggs.Phase == "WaveWait"
end

---@return integer  eggs planted
function xDTaraZ.Hatch.PlaceNow()
    xDTaraZ.Hatch.Bind()
    if not xDTaraZ.Hatch.CanPlant() then return 0 end
    local plot, bp = xDTaraZ.Player:Plot()
    if not plot or not bp then return 0 end
    if xDTaraZ.Hatch.ValueRoom() == 0 then
        if os.clock() - xDTaraZ.Hatch.LastRequest > xDTaraZ.Config.PlotFullRecheck then xDTaraZ.Hatch.RequestSnapshot() end
        xDTaraZ.Hatch.SetStatus(string.format("Plot full (%d/%d)", xDTaraZ.Hatch.Count(), xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault))
        return 0
    end

    local token = xDTaraZ.Tasks.Request("Plant", 40)
    if not token then return 0 end
    local ok, planted = xDTaraZ.Util.Try("plant", xDTaraZ.Hatch.Plant, token, plot, bp)
    local hum = xDTaraZ.Player.Humanoid
    if hum and xDTaraZ.Player:BasketCount() == 0 then hum:UnequipTools() end
    xDTaraZ.Tasks.Release(token)

    planted = ok and planted or 0
    xDTaraZ.Hatch.Planted += planted
    xDTaraZ.Hatch.SetStatus(planted > 0 and ("Placed " .. planted .. " eggs") or (#xDTaraZ.Hatch.EggTools() == 0 and "No eggs to place" or string.format("Plot %d/%d", xDTaraZ.Hatch.Count(), xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault)))
    return planted
end

function xDTaraZ.Hatch.PlantStep()
    local opts = xDTaraZ.Hatch.Options()
    if not opts.AutoPlaceEggs then return end
    xDTaraZ.Hatch.PlaceNow()
end

function xDTaraZ.Hatch.Start()
    xDTaraZ.Hatch.Bind()
end

function xDTaraZ.Hatch.Stop()
    table.clear(xDTaraZ.Hatch.Pending)
end

function xDTaraZ.Hatch.Status()
    return xDTaraZ.State.Status.Hatch or "Idle"
end

xDTaraZ.Junk = {
    Bound = false,
    Running = false,
    Queue = {},
    Cursor = 1,
    BuiltAt = -math.huge,
    EmptyUntil = 0,
    Growth = {},
    Share = {},
    Held = nil,
    EquippedAt = 0,
    Spacing = xDTaraZ.Config.JunkSpacing,
    LastFire = -math.huge,
    Calm = 0,
    Slack = xDTaraZ.Config.JunkHatchSlack,
    HatchGap = 0,
    Retries = 0,
    Anchor = "seller",
    PlantFails = 0,
    FullUntil = 0,
    BackoffUntil = 0,
    YieldUntil = 0,
    ActiveAt = 0,
    ReportAt = 0,
    Fresh = 0,
    Selling = false,
    Planted = 0,
    Hatched = 0,
    Sold = 0,
    Window = {},
}

function xDTaraZ.Junk.SetStatus(text)
    xDTaraZ.State.Status.Junk = text
end

---@return integer  hatches in the last JunkRateWindow seconds
function xDTaraZ.Junk.PerMinute()
    local window = xDTaraZ.Junk.Window
    local cutoff = os.clock() - xDTaraZ.Config.JunkRateWindow
    while window[1] and window[1] < cutoff do
        table.remove(window, 1)
    end
    return #window
end

function xDTaraZ.Junk.Report(note)
    local junk = xDTaraZ.Junk
    junk.ReportAt = os.clock()
    local line = string.format("Hatched %d | Sold %d | %d/min", junk.Hatched, junk.Sold, junk.PerMinute())
    junk.SetStatus(note and (line .. " | " .. note) or line)
end

---@return table  { [rarity] = true } egg rarities to clear, Common and Rare when none are picked
function xDTaraZ.Junk.Set()
    local picked = xDTaraZ.Util.Opt("JunkRarities")
    if type(picked) == "table" and next(picked) then return picked end
    return { Common = true, Rare = true }
end

---@return number  seconds this egg takes to grow, huge when the game does not say
function xDTaraZ.Junk.GrowthOf(name, weight)
    local cache = xDTaraZ.Junk.Growth
    local key = name .. "|" .. string.format("%.2f", weight)
    local known = cache[key]
    if known then return known end

    local info = xDTaraZ.GameLib.EggInfo[name]
    known = info and xDTaraZ.GameLib.GrowthSeconds(info.growth, weight) or math.huge
    cache[key] = known
    return known
end

---@return integer  eggs queued, fastest growing first
function xDTaraZ.Junk.Build()
    local junk = xDTaraZ.Junk
    local set, queue = junk.Set(), {}
    for _, entry in ipairs(xDTaraZ.Hatch.EggTools()) do
        local info = xDTaraZ.GameLib.EggInfo[entry[2]]
        if info and set[info.rarity] then
            queue[#queue + 1] = { entry[1], entry[2], entry[3], junk.GrowthOf(entry[2], entry[3]), info.luck }
        end
    end
    table.sort(queue, function(a, b)
        if a[4] ~= b[4] then return a[4] < b[4] end
        return a[5] < b[5]
    end)

    junk.Queue, junk.Cursor, junk.BuiltAt = queue, 1, os.clock()
    junk.EmptyUntil = #queue == 0 and os.clock() + xDTaraZ.Config.JunkIdleCheck or 0
    if #queue > 0 then junk.Share = junk.Measure(queue) end
    return #queue
end

---@return Tool|nil  next egg tool still in the bag
function xDTaraZ.Junk.NextTool()
    local junk = xDTaraZ.Junk
    local stale = os.clock() - junk.BuiltAt > xDTaraZ.Config.JunkQueueTtl
    if junk.Cursor > #junk.Queue or stale then
        if os.clock() < junk.EmptyUntil then return nil end
        junk.Build()
    end

    while junk.Cursor <= #junk.Queue do
        local tool = junk.Queue[junk.Cursor][1]
        junk.Cursor += 1
        if tool.Parent ~= nil and tool ~= junk.Held then return tool end
    end
    return nil
end

---@return table<string, number>  share of hatches per pet rarity from the eggs at the head of the queue
function xDTaraZ.Junk.Measure(queue)
    local counts, total = {}, math.min(#queue, xDTaraZ.Config.JunkShareSample)
    for index = 1, total do
        local name = queue[index][2]
        counts[name] = (counts[name] or 0) + 1
    end

    local mult, share = xDTaraZ.EggIndex.LuckMult(), {}
    for name, count in pairs(counts) do
        for _, pair in ipairs(xDTaraZ.GameLib.Odds(name, mult) or {}) do
            local pet = xDTaraZ.GameLib.PetInfo[pair[1]]
            if pet then share[pet.rarity] = (share[pet.rarity] or 0) + pair[2] * count / total end
        end
    end
    return share
end

---@return table<string, number>  last measured share per pet rarity, built on first use
function xDTaraZ.Junk.Distribution()
    local junk = xDTaraZ.Junk
    if junk.BuiltAt == -math.huge then junk.Build() end
    return junk.Share
end

---@return table  { [rarity] = true } pet rarities Clear Junk Eggs sells
function xDTaraZ.Junk.SellSet()
    local picked = xDTaraZ.Util.Opt("JunkSellPets")
    if type(picked) == "table" and next(picked) then return picked end

    local rank, ceiling = xDTaraZ.GameLib.RarityRank, 0
    for rarity, share in pairs(xDTaraZ.Junk.Distribution()) do
        if share >= xDTaraZ.Config.JunkAutoShare then ceiling = math.max(ceiling, rank[rarity] or 0) end
    end
    if ceiling == 0 then return xDTaraZ.Junk.Set() end

    local set = {}
    for _, rarity in ipairs(xDTaraZ.GameLib.RarityOrder) do
        if (rank[rarity] or math.huge) <= ceiling then set[rarity] = true end
    end
    return set
end

function xDTaraZ.Junk.WarnMismatch()
    local picked = xDTaraZ.Util.Opt("JunkSellPets")
    if type(picked) ~= "table" or not next(picked) then return end

    local share = xDTaraZ.Junk.Distribution()
    if not next(share) then return end
    for rarity, chance in pairs(share) do
        if picked[rarity] and chance >= 0.01 then return end
    end
    xDTaraZ.Util.Notify("Clear Junk Eggs", "Your junk eggs do not give the pet rarities you picked to sell", 8)
end

---@return integer  junk eggs growing on the plot
function xDTaraZ.Junk.PlotJunk()
    local set, count = xDTaraZ.Junk.Set(), 0
    for _, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
        if info and set[info.rarity] then count += 1 end
    end
    return count
end

---@return boolean  a junk hatch was sent and its answer has not come back
function xDTaraZ.Junk.HatchInFlight()
    local now = os.clock()
    for key in pairs(xDTaraZ.State.PlotEggs) do
        if (xDTaraZ.Hatch.Pending[key] or 0) > now then return true end
    end
    return false
end

---@return boolean  there is something to plant, hatch or sell
function xDTaraZ.Junk.HasWork()
    local junk = xDTaraZ.Junk
    if junk.PlotJunk() > 0 or junk.Fresh >= xDTaraZ.Config.JunkSellEvery then return true end
    if xDTaraZ.Hatch.JunkRoom() == 0 then return false end
    if junk.Cursor <= #junk.Queue then return true end
    if os.clock() < junk.EmptyUntil then return false end
    return junk.Build() > 0
end

---@return boolean  value eggs may hatch now, unless the player holds them for a luck boost
local function ValueHatchOpen()
    if not xDTaraZ.Util.Opt("HoldHatchBoost") then return true end
    return xDTaraZ.Hatch.BoostActive()
end

---@return boolean  growth has finished on a junk egg, or on any egg while value hatching is open
function xDTaraZ.Junk.Due(key, plotEgg, set, now)
    local junk = xDTaraZ.Junk
    local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
    if not info then return false end
    if not set[info.rarity] and not ValueHatchOpen() then return false end
    if (xDTaraZ.Hatch.Pending[key] or 0) > now then return false end

    local readyAt = xDTaraZ.Hatch.ReadyAt(plotEgg)
    return readyAt ~= nil and now >= readyAt + junk.Slack
end

function xDTaraZ.Junk.Fire(remote, key, now)
    local junk, plotEgg = xDTaraZ.Junk, xDTaraZ.State.PlotEggs[key]
    if not plotEgg then return end

    if plotEgg.fired then
        junk.Retries += 1
        junk.Slack = math.min(junk.Slack + 0.01, xDTaraZ.Config.JunkHatchSlackMax)
        junk.HatchGap = math.min(junk.HatchGap * 2 + xDTaraZ.Config.JunkHatchGapStep, xDTaraZ.Config.JunkHatchGapMax)
    end
    plotEgg.fired = true
    xDTaraZ.Hatch.Pending[key] = now + xDTaraZ.Config.JunkHatchRetry
    remote:FireServer({ EggKey = key })
end

---@return integer  hatch fires sent
function xDTaraZ.Junk.HatchReady()
    local junk, remote = xDTaraZ.Junk, xDTaraZ.GameLib.Remote("Hatch")
    if not remote then return 0 end

    local set, now, keys = junk.Set(), os.clock(), {}
    for key, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        if junk.Due(key, plotEgg, set, now) then keys[#keys + 1] = key end
    end
    for index, key in ipairs(keys) do
        if index > 1 and junk.HatchGap > 0 then task.wait(junk.HatchGap) end
        junk.Fire(remote, key, os.clock())
    end
    return #keys
end

function xDTaraZ.Junk.OnHatched()
    local junk = xDTaraZ.Junk
    junk.Hatched += 1
    junk.Fresh += 1
    table.insert(junk.Window, os.clock())
end

---@return Tool|nil  egg tool now in hand
function xDTaraZ.Junk.Prime()
    local junk, hum = xDTaraZ.Junk, xDTaraZ.Player.Humanoid
    local tool = junk.NextTool()
    if not tool or not hum then return nil end

    hum:EquipTool(tool)
    junk.Held, junk.EquippedAt = tool, os.clock()
    return tool
end

---@return boolean  the egg is the only tool in hand
function xDTaraZ.Junk.HandHolds(tool)
    local char = xDTaraZ.Player.Char
    if not char or tool.Parent ~= char then return false end
    for _, child in ipairs(char:GetChildren()) do
        if child ~= tool and child:IsA("Tool") then return false end
    end
    return true
end

---@return Tool|nil  egg tool in hand and settled; a pet that landed in the hand is swapped back out
function xDTaraZ.Junk.Ready(token)
    local junk, hum = xDTaraZ.Junk, xDTaraZ.Player.Humanoid
    local held = junk.Held
    if held and held.Parent == nil then
        held = nil
        junk.Held = nil
    end
    if held and hum and not junk.HandHolds(held) then
        hum:UnequipTools()
        hum:EquipTool(held)
        junk.EquippedAt = os.clock()
    end
    held = held or junk.Prime()
    if not held then return nil end

    local fireAt = math.max(junk.EquippedAt + xDTaraZ.Config.JunkEquipSettle, junk.LastFire + junk.Spacing)
    return junk.Pause(token, fireAt, held) and held or nil
end

---@return boolean  reached the moment with a clean hand, the token, and no hatch sent
function xDTaraZ.Junk.Pause(token, untilAt, held)
    local junk = xDTaraZ.Junk
    while os.clock() < untilAt do
        if junk.HatchReady() > 0 or not junk.HandHolds(held) then return false end
        if not junk.Frame(token) then return false end
    end
    return junk.HandHolds(held)
end

function xDTaraZ.Junk.Ease()
    local junk, cfg = xDTaraZ.Junk, xDTaraZ.Config
    junk.Calm += 1
    if junk.Calm < cfg.JunkSpacingEase then return end
    junk.Calm = 0
    junk.Spacing = math.max(cfg.JunkSpacingMin, junk.Spacing - cfg.JunkSpacingDown)
end

function xDTaraZ.Junk.Harden()
    local junk, cfg = xDTaraZ.Junk, xDTaraZ.Config
    junk.Calm = 0
    junk.PlantFails += 1
    junk.Spacing = math.min(cfg.JunkSpacingMax, junk.Spacing + cfg.JunkSpacingUp)
end

function xDTaraZ.Junk.OnFull()
    local junk, hatch = xDTaraZ.Junk, xDTaraZ.Hatch
    junk.FullUntil = os.clock() + xDTaraZ.Config.JunkFullPause
    hatch.RequestSnapshot()
end

---@return boolean  the server placed the egg
function xDTaraZ.Junk.Settled(replied, before, tool)
    local junk, hatch = xDTaraZ.Junk, xDTaraZ.Hatch
    if replied and hatch.LastPlaced ~= before then
        junk.PlantFails = 0
        junk.Planted += 1
        junk.ActiveAt = os.clock()
        junk.Ease()
        junk.Held = nil
        junk.Prime()
        return true
    end
    if replied then
        junk.OnFull()
        return false
    end
    if tool.Parent == nil then
        hatch.RequestSnapshot()
    elseif not junk.HandHolds(tool) then
        junk.Held = tool
    else
        junk.Harden()
    end
    return false
end

---@return boolean  the server placed an egg
function xDTaraZ.Junk.PlantOne(token, bp)
    local junk, hatch = xDTaraZ.Junk, xDTaraZ.Hatch
    local tool, remote = junk.Ready(token), xDTaraZ.GameLib.Remote("EggPlaced")
    local spot = hatch.Spots(bp, 1)[1]
    if not tool or not remote or not spot then return false end
    if not junk.HandHolds(tool) then return false end

    local before = hatch.LastPlaced
    hatch.CapHit = false
    junk.LastFire = os.clock()
    remote:FireServer({ PlantPosition = spot })
    local replied = function() return hatch.LastPlaced ~= before or hatch.CapHit end
    local ok = xDTaraZ.Tasks.Await(token, replied, xDTaraZ.Config.JunkPlantTimeout)
    return junk.Settled(ok, before, tool)
end

---@return boolean  token still held after one frame
function xDTaraZ.Junk.Frame(token)
    local _, why = xDTaraZ.Tasks.Await(token, nil, 0)
    return why == "timeout"
end

---@return boolean  the run may go on
function xDTaraZ.Junk.Alive(token)
    if not xDTaraZ.Util.Opt("ClearJunk") then return false end
    if xDTaraZ.Tasks.Carrying() or not xDTaraZ.Player:IsAlive() then return false end
    return xDTaraZ.Tasks.Holds(token)
end

---@return integer  eggs planted this pass
function xDTaraZ.Junk.PlantFree(token, bp)
    local junk, planted = xDTaraZ.Junk, 0
    while xDTaraZ.Hatch.JunkRoom() > 0 and os.clock() >= junk.FullUntil and not junk.HatchInFlight() and junk.Alive(token) do
        if not junk.PlantOne(token, bp) then break end
        planted += 1
    end
    return planted
end

---@return boolean  standing at the anchor
function xDTaraZ.Junk.Goto(token, where)
    local junk, hrp = xDTaraZ.Junk, xDTaraZ.Player.Root
    local stand
    if where == "seller" then
        stand = xDTaraZ.Sell.Stand()
    else
        stand = xDTaraZ.Pets.PlotStand()
    end
    if not stand or not hrp then return false end
    if (hrp.Position - stand.Position).Magnitude <= xDTaraZ.Config.JunkAnchorNear then return true end
    if not xDTaraZ.Tasks.Teleport(token, stand) then return false end

    local _, why = xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.SellSettle)
    return why == "timeout"
end

---@return boolean  ready to plant
function xDTaraZ.Junk.Enter(token)
    local junk = xDTaraZ.Junk
    junk.Spacing = xDTaraZ.Config.JunkSpacing
    xDTaraZ.Eggs.QuietInventory(true)
    if xDTaraZ.Player:Riding() then
        xDTaraZ.Player:Release()
        xDTaraZ.Tasks.Await(token, function() return not xDTaraZ.Player:Riding() end, xDTaraZ.Config.MountTimeout)
    end
    if junk.Anchor == "seller" and not xDTaraZ.Sell.Stand() then junk.Anchor = "plot" end

    if not junk.Goto(token, junk.Anchor) then return false end
    junk.ActiveAt = os.clock()
    junk.WarnMismatch()
    return true
end

---@return integer  pets sold
function xDTaraZ.Junk.Sell(token)
    local junk = xDTaraZ.Junk
    junk.Selling, junk.Fresh = true, 0
    local ok, sold = pcall(xDTaraZ.Sell.Run, token, true)
    junk.Selling = false
    if not ok then error(sold, 0) end

    junk.Sold += sold
    return sold
end

function xDTaraZ.Junk.Dispatch(token)
    local junk = xDTaraZ.Junk
    if junk.Anchor == "seller" then
        task.spawn(xDTaraZ.Util.Try, "junk sell", junk.Sell, token)
        return
    end
    xDTaraZ.Util.Try("junk sell", junk.Sell, token)
    junk.Goto(token, "plot")
end

function xDTaraZ.Junk.Resync()
    local junk = xDTaraZ.Junk
    if os.clock() - junk.ActiveAt < xDTaraZ.Config.JunkResyncIdle then return end
    junk.ActiveAt = os.clock()
    xDTaraZ.Hatch.RequestSnapshot()
end

function xDTaraZ.Junk.Progress(token)
    local junk = xDTaraZ.Junk
    if not junk.Selling and junk.Fresh >= xDTaraZ.Config.JunkSellEvery then junk.Dispatch(token) end
    junk.Resync()
    if os.clock() - junk.ReportAt >= xDTaraZ.Config.JunkReportGap then junk.Report() end
end

---@return boolean  planting keeps failing and the run should end
function xDTaraZ.Junk.Stuck(token)
    local junk = xDTaraZ.Junk
    if junk.PlantFails < xDTaraZ.Config.JunkPlantFails then return false end
    junk.PlantFails = 0
    if junk.Anchor == "seller" then
        junk.Anchor = "plot"
        return not junk.Goto(token, "plot")
    end
    junk.BackoffUntil = os.clock() + xDTaraZ.Config.JunkBackoff
    junk.Report("Server is not taking eggs, retrying soon")
    return true
end

---@return boolean  other jobs are waiting for the character
function xDTaraZ.Junk.Yielding()
    for _, idx in ipairs(xDTaraZ.Config.JunkYieldTo) do
        if xDTaraZ.Util.Opt(idx) == true then return true end
    end
    return false
end

---@return boolean  the run should end
function xDTaraZ.Junk.Finished(token, started)
    local junk, now = xDTaraZ.Junk, os.clock()
    if junk.Stuck(token) then return true end
    if now - started > xDTaraZ.Config.JunkSessionMax and junk.Yielding() then
        junk.YieldUntil = now + xDTaraZ.Config.JunkYieldGap
        return true
    end
    return not junk.HasWork()
end

---@return boolean  something was hatched or planted
function xDTaraZ.Junk.Pulse(token, bp)
    local junk = xDTaraZ.Junk
    local hatched = junk.HatchReady()
    local planted = junk.PlantFree(token, bp)
    if hatched + planted > 0 then junk.ActiveAt = os.clock() end
    junk.Progress(token)
    return hatched + planted > 0
end

function xDTaraZ.Junk.Leave(token)
    local junk, hum = xDTaraZ.Junk, xDTaraZ.Player.Humanoid
    xDTaraZ.Tasks.Await(token, function() return not junk.Selling end, xDTaraZ.Config.SellReplyTimeout)
    if junk.Alive(token) and junk.Fresh > 0 and not junk.HasWork() then
        xDTaraZ.Util.Try("junk sell", junk.Sell, token)
    end

    junk.Held = nil
    if hum and hum.Parent and xDTaraZ.Player:BasketCount() == 0 then hum:UnequipTools() end
    xDTaraZ.Mount.Dirty = true
    junk.Report()
end

function xDTaraZ.Junk.Run(token)
    local junk = xDTaraZ.Junk
    local _, bp = xDTaraZ.Player:Plot()
    if not bp or not junk.Enter(token) then return end

    local started = os.clock()
    while junk.Alive(token) do
        junk.Pulse(token, bp)
        if junk.Finished(token, started) or not junk.Frame(token) then break end
    end
    junk.Leave(token)
end

function xDTaraZ.Junk.Bind()
    local junk = xDTaraZ.Junk
    if junk.Bound then return end
    junk.Bound = true
    xDTaraZ.Hatch.Bind()
    xDTaraZ.Sell.Bind()
    xDTaraZ.Hatch.Signal:Connect(junk.OnHatched)
end

---@return boolean  a run may start now
function xDTaraZ.Junk.CanRun()
    local junk, now = xDTaraZ.Junk, os.clock()
    if now < junk.BackoffUntil or now < junk.YieldUntil then return false end
    if xDTaraZ.Tasks.Carrying() or not xDTaraZ.Player:IsAlive() then return false end
    return junk.HasWork()
end

function xDTaraZ.Junk.Step()
    if not xDTaraZ.Util.Opt("ClearJunk") then return end
    local junk = xDTaraZ.Junk
    junk.Bind()
    junk.HatchReady()
    if not junk.CanRun() then
        if junk.PlotJunk() > 0 then return end
        junk.Report(xDTaraZ.Hatch.Room() == 0 and "Plot is full" or "Nothing to clear right now")
        return
    end

    local token = xDTaraZ.Tasks.Request("Junk", xDTaraZ.Tasks.Prio.Plot)
    if not token then
        junk.Report("Waiting for the egg run")
        return
    end

    junk.Running = true
    local ok, err = pcall(junk.Run, token)
    junk.Running = false
    xDTaraZ.Tasks.Release(token)
    if not ok then error(err, 0) end
end

function xDTaraZ.Junk.SellNow()
    xDTaraZ.Junk.Bind()
    local sold = xDTaraZ.Pets.WithToken("Sell", xDTaraZ.Tasks.Prio.Travel, function(token)
        return xDTaraZ.Sell.Run(token, true)
    end) or 0
    xDTaraZ.Util.Notify("Clear Junk Eggs", sold > 0 and ("Sold " .. sold .. " pets") or "No junk pets to sell", 4)
    return sold
end

function xDTaraZ.Junk.Start()
    xDTaraZ.Junk.Bind()
end

function xDTaraZ.Junk.Stop()
    local junk = xDTaraZ.Junk
    junk.Report("Off")
end

function xDTaraZ.Junk.Status()
    return xDTaraZ.State.Status.Junk or "Off"
end

xDTaraZ.Pets = {
    Bound = false,
    Index = {},
    Holders = {},
    Placed = {},
    Top = {},
    TopAt = 0,
    Collected = 0,
    Swaps = 0,
    Fed = 0,
    Kept = {},
}

function xDTaraZ.Pets.IsOurs(owner)
    return owner == nil or owner == LocalPlayer or owner == LocalPlayer.UserId or owner == LocalPlayer.Name
end

function xDTaraZ.Pets.SetStatus(text)
    xDTaraZ.State.Status.Pets = text
end

---@return any  SavedData value, nil when missing
function xDTaraZ.Pets.Saved(name)
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local value = saved and saved:FindFirstChild(name)
    return value and value.Value
end

---@return number  leaderstats Income/s
function xDTaraZ.Pets.IncomeRate()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    local value = stats and stats:FindFirstChild("Income/s")
    return value and tonumber(value.Value) or 0
end

function xDTaraZ.Pets.MaxSlots()
    local fromAttr = tonumber(LocalPlayer:GetAttribute("MaxPets"))
    return fromAttr or tonumber(xDTaraZ.Pets.Saved("MaxPets")) or 5
end

---@return number  weight after the game's age bonus
function xDTaraZ.Pets.AgedWeight(kg, age)
    local aging = xDTaraZ.GameLib.Svc.PetAging
    if not age or type(aging) ~= "table" then return kg end
    local ok, aged = xDTaraZ.GameLib.Call(aging.WeightFor, kg, age)
    return ok and tonumber(aged) or kg
end

---@param row table  PetName, BaseWeight, Weight, BirthTime
---@return number|nil  age the game shows for this BirthTime
function xDTaraZ.Pets.AgeFrom(row)
    local aging = xDTaraZ.GameLib.Svc.PetAging
    if not tonumber(row.BirthTime) or type(aging) ~= "table" then return nil end
    local ok, age = xDTaraZ.GameLib.Call(aging.StateFrom, row.BirthTime, xDTaraZ.Util.ServerNow(), row)
    return ok and tonumber(age) or nil
end

---@return number  display income per second, before rebirth and friend bonus
function xDTaraZ.Pets.Income(pet)
    local info = xDTaraZ.GameLib.PetInfo[pet.name or ""]
    if not info then return 0 end

    local mutations = xDTaraZ.GameLib.Mutations
    local factor = (mutations[pet.mutation or ""] or 1) * (mutations[pet.spawnMutation or ""] or 1)
    local kg = pet.baseWeight and pet.age and xDTaraZ.Pets.AgedWeight(pet.baseWeight, pet.age)
        or xDTaraZ.Pets.AgedWeight(pet.weight or xDTaraZ.Config.PetBaseKg, pet.age)
    return math.floor(math.floor((info.income or 0) * kg / 10) * factor)
end

---@param src  Instance|table  pet Tool or a PlacePet reply
---@return table  pet record
function xDTaraZ.Pets.Record(src, placed)
    local isTool = typeof(src) == "Instance"
    local attrs = isTool and src:GetAttributes() or src

    local name = attrs.PetName or (isTool and src.Name) or nil
    local pet = {
        key = attrs.PetKey,
        name = name,
        weight = tonumber(attrs.Weight) or tonumber(attrs.BaseWeight),
        mutation = attrs.Mutation,
        spawnMutation = attrs.SpawnMutation,
        baseWeight = tonumber(attrs.BaseWeight),
        birthTime = tonumber(attrs.BirthTime),
        age = tonumber(attrs.Age),
        favorite = attrs.Favorited == true,
        placed = placed,
        tool = isTool and src or nil,
        pos = placed and attrs.Position or nil,
        collectTime = tonumber(attrs.CollectTime),
        at = os.clock(),
    }
    if not pet.age and pet.birthTime then
        pet.age = xDTaraZ.Pets.AgeFrom({ PetName = name, BaseWeight = pet.baseWeight, Weight = pet.weight, BirthTime = pet.birthTime })
    end
    pet.ageKnown = pet.age ~= nil
    pet.mutated = (pet.mutation ~= nil and pet.mutation ~= "") or (pet.spawnMutation ~= nil and pet.spawnMutation ~= "")
    pet.income = xDTaraZ.Pets.Income(pet)
    local info = xDTaraZ.GameLib.PetInfo[name or ""]
    pet.speed = info and info.speed or 0
    pet.rarity = info and info.rarity
    return pet
end

---@param reply table  PlacePet.OnClientEvent payload
function xDTaraZ.Pets.OnPlace(reply)
    if type(reply) ~= "table" or not xDTaraZ.Pets.IsOurs(reply.Owner) then return end
    if reply.Action == "Remove" then
        if type(reply.PetKey) == "string" then
            xDTaraZ.Pets.Placed[reply.PetKey] = nil
        else
            table.clear(xDTaraZ.Pets.Placed)
        end
    elseif reply.Action == "Place" and reply.PetKey then
        xDTaraZ.Pets.Placed[reply.PetKey] = xDTaraZ.Pets.Record(reply, true)
    end
    xDTaraZ.Pets.TopAt = 0
end

function xDTaraZ.Pets.OnCollect(reply)
    if type(reply) ~= "table" or not xDTaraZ.Pets.IsOurs(reply.Owner) then return end
    local keys = type(reply.PetKeys) == "table" and reply.PetKeys or { reply.PetKey }
    for _, key in pairs(keys) do
        local pet = xDTaraZ.Pets.Placed[key]
        if pet then pet.collectTime = tonumber(reply.CollectTime) or xDTaraZ.Util.ServerNow() end
    end
end

function xDTaraZ.Pets.OnFed(reply)
    if type(reply) ~= "table" or not xDTaraZ.Pets.IsOurs(reply.Owner) then return end
    xDTaraZ.Pets.FedAt = os.clock()
    local pet = xDTaraZ.Pets.Placed[reply.PetKey or ""]
    if not pet then return end
    pet.weight = tonumber(reply.Weight) or pet.weight
    if tonumber(reply.BirthTime) then
        pet.birthTime = tonumber(reply.BirthTime)
        pet.age = xDTaraZ.Pets.AgeFrom({ PetName = pet.name, BaseWeight = pet.baseWeight, Weight = pet.weight, BirthTime = pet.birthTime }) or pet.age
    end
    pet.income = xDTaraZ.Pets.Income(pet)
end

function xDTaraZ.Pets.SeedFromRenderer()
    local scripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local module = scripts and scripts:FindFirstChild("PetRenderer", true)
    local renderer = module and xDTaraZ.GameLib.Require(module)
    if type(renderer) ~= "table" or type(renderer.GetAll) ~= "function" then return end

    local ok, all = xDTaraZ.GameLib.Call(renderer.GetAll)
    if not ok or type(all) ~= "table" then return end
    for _, entry in pairs(all) do
        if type(entry) ~= "table" or not entry.PetKey then continue end
        if entry.OwnerUserId ~= LocalPlayer.UserId then continue end

        local model = typeof(entry.Model) == "Instance" and entry.Model or nil
        local pos = entry.Position
        if typeof(pos) ~= "Vector3" and model and model:IsA("Model") then pos = model:GetPivot().Position end
        local row = setmetatable({ PetName = entry.PetName or (model and model.Name), Position = pos }, {
            __index = function(_, key)
                local value = entry[key]
                if value == nil and model then value = model:GetAttribute(key) end
                return value
            end,
        })
        xDTaraZ.Pets.Placed[entry.PetKey] = xDTaraZ.Pets.Record(row, true)
    end
end

function xDTaraZ.Pets.Bind()
    if xDTaraZ.Pets.Bound then return end
    xDTaraZ.Pets.Bound = true

    local place = xDTaraZ.GameLib.Remote("PlacePet")
    if place then xDTaraZ:Connect(place.OnClientEvent, xDTaraZ.Pets.OnPlace) end
    local collect = xDTaraZ.GameLib.Remote("PetCollect")
    if collect then xDTaraZ:Connect(collect.OnClientEvent, xDTaraZ.Pets.OnCollect) end
    local fed = xDTaraZ.GameLib.Remote("PetFed")
    if fed then xDTaraZ:Connect(fed.OnClientEvent, xDTaraZ.Pets.OnFed) end

    xDTaraZ.Util.Try("pets seed", xDTaraZ.Pets.SeedFromRenderer)
    table.insert(xDTaraZ.State.Connections, xDTaraZ.Pets.Unbind)
    xDTaraZ.Pets.WatchHolders(LocalPlayer.Character)
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(char)
        task.defer(xDTaraZ.Util.Try, "pets rebind", xDTaraZ.Pets.WatchHolders, char)
    end)
end

function xDTaraZ.Pets.Unbind()
    for _, entry in pairs(xDTaraZ.Pets.Index) do entry.conn:Disconnect() end
    table.clear(xDTaraZ.Pets.Index)
    table.clear(xDTaraZ.Pets.Holders)
end

function xDTaraZ.Pets.Held(inst)
    local parent = inst.Parent
    return parent ~= nil and xDTaraZ.Pets.Holders[parent] ~= nil
end

function xDTaraZ.Pets.Track(tool)
    local index = xDTaraZ.Pets.Index
    if index[tool] or not tool:IsA("Tool") or not tool:GetAttribute("PetKey") then return end

    local entry = { name = tool:GetAttribute("PetName") or tool.Name }
    entry.conn = tool.AttributeChanged:Connect(function(attr)
        if xDTaraZ.Config.PetWatchedAttrs[attr] then entry.rec = nil end
    end)
    index[tool] = entry
end

function xDTaraZ.Pets.Untrack(tool)
    local entry = xDTaraZ.Pets.Index[tool]
    if not entry or xDTaraZ.Pets.Held(tool) then return end
    entry.conn:Disconnect()
    xDTaraZ.Pets.Index[tool] = nil
end

function xDTaraZ.Pets.Watch(holder)
    if not holder or xDTaraZ.Pets.Holders[holder] then return end
    xDTaraZ.Pets.Holders[holder] = {
        xDTaraZ:Connect(holder.ChildAdded, xDTaraZ.Pets.Track),
        xDTaraZ:Connect(holder.ChildRemoved, function(child) task.defer(xDTaraZ.Pets.Untrack, child) end),
    }
    for _, child in ipairs(holder:GetChildren()) do xDTaraZ.Pets.Track(child) end
end

---@param char Model|nil  current character; the old character and Backpack stop being watched
function xDTaraZ.Pets.WatchHolders(char)
    local bag = LocalPlayer:FindFirstChildOfClass("Backpack") or LocalPlayer:WaitForChild("Backpack", xDTaraZ.Config.LoadTimeout)
    for holder, conns in pairs(xDTaraZ.Pets.Holders) do
        if holder == bag or holder == char then continue end
        for _, conn in ipairs(conns) do conn:Disconnect() end
        xDTaraZ.Pets.Holders[holder] = nil
    end

    xDTaraZ.Pets.Watch(bag)
    xDTaraZ.Pets.Watch(char)
    for tool in pairs(xDTaraZ.Pets.Index) do xDTaraZ.Pets.Untrack(tool) end
end

---@return table  cached record, rebuilt after a watched attribute changed or the age went stale
function xDTaraZ.Pets.ToolRecord(tool, entry)
    local rec = entry.rec
    if rec and not (rec.birthTime and os.clock() - rec.at > xDTaraZ.Config.PetAgeRefresh) then return rec end
    rec = xDTaraZ.Pets.Record(tool, false)
    entry.rec = rec
    return rec
end

---@return table<string, Tool>  pet name -> one held tool of that pet
function xDTaraZ.Pets.ToolsByName()
    xDTaraZ.Pets.Bind()
    local found = {}
    for tool, entry in pairs(xDTaraZ.Pets.Index) do
        local name = entry.name
        if name and not found[name] and xDTaraZ.GameLib.PetInfo[name] then found[name] = tool end
    end
    return found
end

---@return Tool|nil  one held tool of that pet
function xDTaraZ.Pets.ToolNamed(name)
    xDTaraZ.Pets.Bind()
    for tool, entry in pairs(xDTaraZ.Pets.Index) do
        if entry.name == name then return tool end
    end
    return nil
end

---@return table[]  fresh list, safe to sort; records are shared, do not edit them
function xDTaraZ.Pets.Owned()
    xDTaraZ.Pets.Bind()
    local list = {}
    for tool, entry in pairs(xDTaraZ.Pets.Index) do
        list[#list + 1] = xDTaraZ.Pets.ToolRecord(tool, entry)
    end
    for _, pet in pairs(xDTaraZ.Pets.Placed) do
        table.insert(list, pet)
    end
    return list
end

---@return string|nil  key of the pet we ride right now
function xDTaraZ.Pets.RideKey()
    if not xDTaraZ.Player:Riding() then return nil end
    local char = xDTaraZ.Player.Char
    local tool = char and char:FindFirstChildOfClass("Tool")
    return tool and tool:GetAttribute("PetKey") or nil
end

function xDTaraZ.Pets.IsRide(pet)
    if pet.tool and pet.tool.Parent == xDTaraZ.Player.Char and xDTaraZ.Player:Riding() then return true end
    local rideKey = xDTaraZ.Pets.RideKey()
    return rideKey ~= nil and rideKey == pet.key
end

---@return table<string, true>  pet names some unfinished rebirth still needs
function xDTaraZ.Pets.RebirthNeeds()
    local done = tonumber(xDTaraZ.Pets.Saved("Rebirths")) or 0
    local needs = {}
    for step, req in pairs(xDTaraZ.GameLib.RebirthReq or {}) do
        local index = tonumber(step)
        if type(step) == "string" and not index then
            if (tonumber(req) or math.huge) > done then needs[step] = true end
            continue
        end
        if not index or index <= done then continue end
        if type(req) == "string" then needs[req] = true end
        if type(req) == "table" then
            for _, name in pairs(req) do
                if type(name) == "string" then needs[name] = true end
            end
        end
    end
    return needs
end

---@return table<string, true>  keys of the placed pets that earn the most
function xDTaraZ.Pets.TopPlaced()
    local now = os.clock()
    if now - xDTaraZ.Pets.TopAt < xDTaraZ.Config.TopCacheSec then return xDTaraZ.Pets.Top end

    local placed = {}
    for _, pet in pairs(xDTaraZ.Pets.Placed) do placed[#placed + 1] = pet end
    table.sort(placed, function(a, b) return a.income > b.income end)

    local top = {}
    for i = 1, math.min(#placed, xDTaraZ.Pets.MaxSlots()) do top[placed[i].key] = true end
    xDTaraZ.Pets.Top, xDTaraZ.Pets.TopAt = top, now
    return top
end

---@return boolean, string|nil  protected, why
function xDTaraZ.Pets.Protected(pet, needs)
    if pet.favorite then return true, "favorite" end

    local list = xDTaraZ.Util.Opt("ProtectList")
    if type(list) == "table" and (list[pet.name or ""] or list[pet.key or ""]) then return true, "protect list" end

    needs = needs or xDTaraZ.Pets.RebirthNeeds()
    if needs[pet.name or ""] then return true, "rebirth" end
    if xDTaraZ.Pets.IsRide(pet) then return true, "ride pet" end
    if pet.name and (xDTaraZ.Mount.Choice() == pet.name or xDTaraZ.Mount.Name == pet.name) then return true, "ride pet" end

    local fusion = xDTaraZ.Fusion
    if fusion and fusion.Inputs and fusion.Inputs[pet.key or ""] then return true, "fusion" end
    if pet.placed and xDTaraZ.Pets.TopPlaced()[pet.key or ""] then return true, "placed" end
    return false
end

---@return CFrame|nil, BasePart|nil  a point on our baseplate, the baseplate
function xDTaraZ.Pets.PlotStand()
    local _, bp = xDTaraZ.Player:Plot()
    if not bp then return nil end
    return CFrame.new(bp.Position + Vector3.new(0, bp.Size.Y / 2 + xDTaraZ.Geo.Lift(Config.PetStandLift), 0)), bp
end

---@return Vector3  random spot on the baseplate surface
function xDTaraZ.Pets.Spot(bp)
    local spread = xDTaraZ.Config.PetSpread
    local offset = Vector3.new((math.random() * 2 - 1) * bp.Size.X * spread, bp.Size.Y / 2 + 1, (math.random() * 2 - 1) * bp.Size.Z * spread)
    return (bp.CFrame * CFrame.new(offset)).Position
end

---@param fn fun(token: table): any
---@return any  fn result, nil when no token was granted
function xDTaraZ.Pets.WithToken(owner, prio, fn)
    local token = xDTaraZ.Tasks.Request(owner, prio)
    if not token then return nil end
    local ok, out = pcall(fn, token)
    xDTaraZ.Tasks.Release(token)
    if not ok then error(out, 0) end
    return out
end

---@return table[], table[]  unplaced candidates best first, placed pets worst first
function xDTaraZ.Pets.SwapPlan()
    local unplaced, placed = {}, {}
    local mount = xDTaraZ.Mount.Best()
    local rideKept = false
    for _, pet in ipairs(xDTaraZ.Pets.Owned()) do
        if pet.placed then
            if pet.ageKnown then placed[#placed + 1] = pet end
        elseif xDTaraZ.Pets.IsRide(pet) then
            rideKept = true
        elseif pet.key and pet.income > 0 then
            table.insert(unplaced, pet)
        elseif pet.name == mount then
            rideKept = true
        end
    end
    table.sort(unplaced, function(a, b) return a.income > b.income end)
    table.sort(placed, function(a, b) return a.income < b.income end)

    if mount and not rideKept then
        for i = #unplaced, 1, -1 do
            if unplaced[i].name == mount then
                table.remove(unplaced, i)
                break
            end
        end
    end
    return unplaced, placed
end

---@return boolean  the server confirmed the change
function xDTaraZ.Pets.AwaitPlaced(token, key, present)
    return (xDTaraZ.Tasks.Await(token, function()
        return (xDTaraZ.Pets.Placed[key] ~= nil) == present
    end, xDTaraZ.Config.PetReplyTimeout))
end

---@param worst table|nil  placed pet to pick up first
---@return boolean  pet is placed; a failed place puts worst back
function xDTaraZ.Pets.Swap(token, pet, worst, bp)
    local placeRemote, pickRemote = xDTaraZ.GameLib.Remote("PlacePet"), xDTaraZ.GameLib.Remote("PickupPet")
    token.critical = true

    if worst then
        pickRemote:FireServer(worst.key)
        if not xDTaraZ.Pets.AwaitPlaced(token, worst.key, false) then
            token.critical = false
            return false
        end
    end

    placeRemote:FireServer(pet.key, xDTaraZ.Pets.Spot(bp))
    local ok = xDTaraZ.Pets.AwaitPlaced(token, pet.key, true)
    if not ok and worst then
        placeRemote:FireServer(worst.key, worst.pos or xDTaraZ.Pets.Spot(bp))
        xDTaraZ.Pets.AwaitPlaced(token, worst.key, true)
    end
    token.critical = false
    return ok
end

---@return integer  pets placed or swapped
function xDTaraZ.Pets.PlaceBest(token)
    local placeRemote, pickRemote = xDTaraZ.GameLib.Remote("PlacePet"), xDTaraZ.GameLib.Remote("PickupPet")
    local stand, bp = xDTaraZ.Pets.PlotStand()
    if not placeRemote or not pickRemote or not stand then return 0 end

    local unplaced, placed = xDTaraZ.Pets.SwapPlan()
    local free = xDTaraZ.Pets.MaxSlots() - #placed
    for i = #placed, 1, -1 do
        if xDTaraZ.Pets.Kept[placed[i].key or ""] then table.remove(placed, i) end
    end
    if not unplaced[1] then return 0 end
    if free <= 0 and (not placed[1] or unplaced[1].income <= placed[1].income * xDTaraZ.Config.PetSwapGain) then return 0 end
    if not xDTaraZ.Tasks.Teleport(token, stand) then return 0 end

    local changed, swapped = 0, {}
    local before = xDTaraZ.Pets.IncomeRate()
    for _, pet in ipairs(unplaced) do
        if not xDTaraZ.Tasks.Holds(token) then break end
        local worst
        if free <= 0 then
            worst = placed[1]
            if not worst or pet.income <= worst.income * xDTaraZ.Config.PetSwapGain then break end
        end
        local ok = xDTaraZ.Pets.Swap(token, pet, worst, bp)
        if not ok then break end
        if worst then
            table.remove(placed, 1)
            table.insert(swapped, { pet, worst })
        else
            free -= 1
        end
        changed += 1
    end
    if #swapped > 0 then changed -= xDTaraZ.Pets.GuardIncome(token, before, swapped, bp) end

    xDTaraZ.Pets.Swaps += changed
    if changed > 0 then xDTaraZ.Mount.Dirty = true end
    return changed
end

---@param swapped table[]  { placed, pickedUp } pairs, undone newest first
---@return integer           swaps undone because Income/s went down
function xDTaraZ.Pets.GuardIncome(token, before, swapped, bp)
    xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.IncomeSettle)
    local after = xDTaraZ.Pets.IncomeRate()
    if after >= before then return 0 end

    local undone = 0
    for i = #swapped, 1, -1 do
        local pair = swapped[i]
        xDTaraZ.Pets.Kept[pair[2].key] = true
        if not xDTaraZ.Tasks.Holds(token) then break end
        if xDTaraZ.Pets.Swap(token, pair[2], xDTaraZ.Pets.Placed[pair[1].key] or pair[1], bp) then undone += 1 end
    end
    warn(xDTaraZ.Config.Tag, "place best: income " .. before .. " -> " .. after .. ", undid " .. undone)
    return undone
end

---@return boolean  the game collects on its own (pass owned)
function xDTaraZ.Pets.GameCollects()
    if LocalPlayer:GetAttribute("AutoCollectCash") == true then return true end
    local passes = tostring(xDTaraZ.Pets.Saved("OwnedPasses") or "")
    for _, mark in ipairs(xDTaraZ.Config.AutoCollectPass) do
        if passes:find(mark, 1, true) then return true end
    end
    return false
end

---@return number  seconds of income waiting on this pet
function xDTaraZ.Pets.PendingSec(pet)
    if not pet.collectTime then return math.huge end
    return xDTaraZ.Util.ServerNow() - pet.collectTime
end

---@param force boolean  ignore the pending threshold
---@return integer  collect fires sent
function xDTaraZ.Pets.Collect(token, force)
    local remote = xDTaraZ.GameLib.Remote("PetCollect")
    if not remote then return 0 end

    local fired = 0
    for key, pet in pairs(xDTaraZ.Pets.Placed) do
        if not xDTaraZ.Tasks.Holds(token) then break end
        if not force and xDTaraZ.Pets.PendingSec(pet) < xDTaraZ.Config.CollectMinPending then continue end
        if typeof(pet.pos) ~= "Vector3" then continue end
        if not xDTaraZ.Tasks.Teleport(token, CFrame.new(pet.pos + Vector3.new(0, xDTaraZ.Config.PetStandLift, 0))) then break end

        local ok, why = xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.CollectGap)
        if not ok and why ~= "timeout" then break end
        remote:FireServer(key)
        fired += 1
    end

    xDTaraZ.Pets.Collected += fired
    if fired > 0 then
        local stand = xDTaraZ.Pets.PlotStand()
        if stand then xDTaraZ.Tasks.Teleport(token, stand) end
    end
    return fired
end

---@return Tool[]  food tools the user allows, cheapest first
function xDTaraZ.Pets.FoodTools()
    local allowed = xDTaraZ.Util.Opt("FoodTypes")
    local foods = xDTaraZ.GameLib.Foods or {}
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    local tools = {}
    for _, tool in ipairs(backpack and backpack:GetChildren() or {}) do
        local row = tool:IsA("Tool") and foods[tool.Name]
        if not row then continue end
        if type(allowed) == "table" and next(allowed) and not allowed[tool.Name] then continue end
        tools[#tools + 1] = { tool, type(row) == "table" and tonumber(row.Price or row.Cost) or 0 }
    end
    table.sort(tools, function(a, b) return a[2] < b[2] end)
    for i, pair in ipairs(tools) do tools[i] = pair[1] end
    return tools
end

---@return table[]  { key, ridden } pets to feed for the current FeedTarget
function xDTaraZ.Pets.FeedTargets()
    local mode = xDTaraZ.Util.Opt("FeedTarget") or "Placed"
    local targets = {}
    if mode ~= "Ride pet" then
        for key, pet in pairs(xDTaraZ.Pets.Placed) do
            if (pet.age or 0) < xDTaraZ.Config.PetMaxAge then targets[#targets + 1] = { key, false } end
        end
    end

    local rideKey = mode ~= "Placed" and xDTaraZ.Pets.RideKey()
    if rideKey then
        local tool = xDTaraZ.Player.Char and xDTaraZ.Player.Char:FindFirstChildOfClass("Tool")
        local age = tool and tonumber(tool:GetAttribute("Age")) or 0
        if age < xDTaraZ.Config.PetMaxAge then table.insert(targets, { rideKey, true }) end
    end
    return targets
end

---@return boolean  standing on our plot
function xDTaraZ.Pets.GoHome(token)
    local hrp = xDTaraZ.Player.Root
    if hrp and xDTaraZ.Geo.InPlot(hrp.Position) then return true end
    local stand = xDTaraZ.Pets.PlotStand()
    return stand ~= nil and xDTaraZ.Tasks.Teleport(token, stand)
end

---@return integer  foods used
function xDTaraZ.Pets.Feed()
    local remote = xDTaraZ.GameLib.Remote("FeedPet")
    if not remote then return 0 end
    xDTaraZ.Pets.Bind()
    if not xDTaraZ.Pets.FoodTools()[1] or not xDTaraZ.Pets.FeedTargets()[1] then
        xDTaraZ.State.Status.Feed = "No food or nothing to feed"
        return 0
    end
    return xDTaraZ.Pets.WithToken("Feed", xDTaraZ.Tasks.Prio.Plot, function(token)
        if not xDTaraZ.Pets.GoHome(token) then
            xDTaraZ.State.Status.Feed = "Could not reach the ranch"
            return 0
        end
        return xDTaraZ.Pets.FeedAll(remote, token)
    end) or 0
end

---@return integer  food left in a stacked food tool
local function FoodLeft(tool)
    local data = tool and tool.Parent and tool:FindFirstChild("Data")
    local amount = data and data:FindFirstChild("Amount")
    return amount and tonumber(amount.Value) or 1
end

---@return integer  feeds the server took, one at a time at its own pace, until food, pets or the burst run out
function xDTaraZ.Pets.FeedAll(remote, token)
    local cfg = xDTaraZ.Config
    local used, misses, turn = 0, 0, 0
    local deadline = os.clock() + cfg.FeedBurst
    while os.clock() < deadline and misses < cfg.FeedMissLimit and xDTaraZ.Tasks.Holds(token) do
        local targets = xDTaraZ.Pets.FeedTargets()
        local food
        for _, tool in ipairs(xDTaraZ.Pets.FoodTools()) do
            if FoodLeft(tool) > 0 then
                food = tool
                break
            end
        end
        if not food or #targets == 0 then break end

        turn = turn % #targets + 1
        local target = targets[turn]
        local before, firedAt = xDTaraZ.Pets.FedAt, os.clock()
        remote:FireServer(target[1], food.Name, target[2] or nil)
        local ok = xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Pets.FedAt ~= before end, cfg.FeedReplyTimeout)
        if ok then
            used += 1
            misses = 0
        else
            misses += 1
        end
        local wait = firedAt + cfg.FeedGap - os.clock()
        if wait > 0 then xDTaraZ.Tasks.Await(token, function() return false end, wait) end
    end

    xDTaraZ.Pets.Fed += used
    xDTaraZ.State.Status.Feed = used > 0 and ("Fed " .. xDTaraZ.Pets.Fed .. " times") or "No food or nothing to feed"
    return used
end

function xDTaraZ.Pets.PlaceNow()
    return xDTaraZ.Pets.WithToken("Pets", xDTaraZ.Tasks.Prio.Plot, function(token)
        xDTaraZ.Pets.Bind()
        local changed = xDTaraZ.Pets.PlaceBest(token)
        xDTaraZ.Pets.SetStatus(changed > 0 and ("Placed " .. changed .. " pets") or "Best pets placed")
        return changed
    end) or 0
end

function xDTaraZ.Pets.CollectNow()
    return xDTaraZ.Pets.WithToken("Pets", xDTaraZ.Tasks.Prio.Plot, function(token)
        xDTaraZ.Pets.Bind()
        return xDTaraZ.Pets.Collect(token, true)
    end) or 0
end

function xDTaraZ.Pets.Step()
    local equip, collect = xDTaraZ.Util.Opt("AutoEquipBest"), xDTaraZ.Util.Opt("AutoCollectCash")
    if not equip and not collect then return end
    xDTaraZ.Pets.Bind()

    local gameCollects = collect and xDTaraZ.Pets.GameCollects()
    xDTaraZ.Pets.WithToken("Pets", xDTaraZ.Tasks.Prio.Plot, function(token)
        if equip then xDTaraZ.Pets.PlaceBest(token) end
        if collect and not gameCollects then xDTaraZ.Pets.Collect(token, false) end
    end)
    xDTaraZ.Pets.SetStatus(xDTaraZ.Pets.Status())
end

function xDTaraZ.Pets.FeedStep()
    if not xDTaraZ.Util.Opt("AutoFeed") then return end
    xDTaraZ.Pets.Feed()
end

function xDTaraZ.Pets.Status()
    return string.format("Placed %d/%d | Swaps %d | Collects %d", #xDTaraZ.Pets.PlacedList(), xDTaraZ.Pets.MaxSlots(), xDTaraZ.Pets.Swaps, xDTaraZ.Pets.Collected)
end

function xDTaraZ.Pets.PlacedList()
    local list = {}
    for _, pet in pairs(xDTaraZ.Pets.Placed) do list[#list + 1] = pet end
    return list
end

function xDTaraZ.Pets.Start()
    xDTaraZ.Pets.Bind()
end

function xDTaraZ.Pets.Stop()
    local hum = xDTaraZ.Player.Humanoid
    if hum and not xDTaraZ.Player:Riding() then hum:UnequipTools() end
end

xDTaraZ.Sell = {
    Bound = false,
    ConfirmUntil = 0,
    Reply = nil,
    Sold = 0,
    Earned = 0,
}

function xDTaraZ.Sell.SetStatus(text)
    xDTaraZ.State.Status.Sell = text
end

function xDTaraZ.Sell.OnConfirm(id, question)
    if os.clock() > xDTaraZ.Sell.ConfirmUntil then return end
    if not tostring(question or ""):lower():find("sell", 1, true) then return end
    xDTaraZ.Sell.ConfirmUntil = 0
    local remote = xDTaraZ.GameLib.Remote("ConfirmRequest")
    if remote then remote:FireServer(id, true) end
end

function xDTaraZ.Sell.Bind()
    if xDTaraZ.Sell.Bound then return end
    xDTaraZ.Sell.Bound = true

    local sell = xDTaraZ.GameLib.Remote("SellItems")
    if sell then
        xDTaraZ:Connect(sell.OnClientEvent, function(reply) xDTaraZ.Sell.Reply = reply end)
    end
    local confirm = xDTaraZ.GameLib.Remote("ConfirmRequest")
    if confirm then xDTaraZ:Connect(confirm.OnClientEvent, xDTaraZ.Sell.OnConfirm) end
end

---@return boolean  this pet passes the sell filters
function xDTaraZ.Sell.Allowed(pet, keep, under)
    if pet.placed or not pet.key or not pet.rarity then return false end
    if keep[pet.rarity] then return false end
    if pet.mutated and xDTaraZ.Util.Opt("SellKeepMutated") then return false end
    if under > 0 and pet.income >= under then return false end
    return true
end

---@return table  { [rarity] = true } for the top rarities when the player picked none
function xDTaraZ.Sell.DefaultKeep()
    local order = xDTaraZ.GameLib.RarityOrder
    local keep = {}
    for i = math.max(1, #order - xDTaraZ.Config.SellKeepTopRarities + 1), #order do
        keep[order[i]] = true
    end
    return keep
end

---@return table  { [rarity] = true } every rarity except the junk pets Clear Junk Eggs sells
function xDTaraZ.Sell.JunkKeep()
    local sell = xDTaraZ.Junk.SellSet()
    local keep = {}
    for _, rarity in ipairs(xDTaraZ.GameLib.RarityOrder) do
        if not sell[rarity] then keep[rarity] = true end
    end
    return keep
end

---@param junkOnly boolean?  sell only the Clear Junk Eggs pet rarities, never the best pets that fill the plot
---@return table[], number    pets to sell, cash expected
function xDTaraZ.Sell.Plan(junkOnly)
    local keep = xDTaraZ.Util.Opt("SellRarities")
    if type(keep) ~= "table" or next(keep) == nil then keep = xDTaraZ.Sell.DefaultKeep() end
    if junkOnly then keep = xDTaraZ.Sell.JunkKeep() end

    local under = not junkOnly and tonumber(xDTaraZ.Util.Opt("SellUnderIncome")) or 0
    local keepBest = junkOnly and xDTaraZ.Pets.MaxSlots() or tonumber(xDTaraZ.Util.Opt("SellKeepBest")) or 0
    local owned = xDTaraZ.Pets.Owned()
    table.sort(owned, function(a, b) return a.income > b.income end)

    local needs = xDTaraZ.Pets.RebirthNeeds()
    local plan, cash = {}, 0
    for rank, pet in ipairs(owned) do
        if rank <= keepBest then continue end
        if not xDTaraZ.Sell.Allowed(pet, keep, under) then continue end
        if xDTaraZ.Pets.Protected(pet, needs) then continue end
        plan[#plan + 1] = pet
        cash += pet.income * GameLib.SellMultiplier()
    end
    return plan, cash
end

function xDTaraZ.Sell.Preview()
    local plan, cash = xDTaraZ.Sell.Plan()
    local text = "Will sell " .. #plan .. " for $" .. xDTaraZ.Util.Format(cash)
    xDTaraZ.State.Status.SellPreview = text
    return text
end

---@return CFrame|nil  a spot next to the seller
function xDTaraZ.Sell.Stand()
    local stalls = Workspace:FindFirstChild("Stalls")
    local stall = stalls and stalls:FindFirstChild("Sell")
    local richie = stall and stall:FindFirstChild("Richie")
    if not richie then return nil end

    local pivot = richie:IsA("Model") and richie:GetPivot() or (richie:IsA("BasePart") and richie.CFrame)
    if not pivot then return nil end
    return CFrame.new(pivot.Position + pivot.LookVector * xDTaraZ.Config.SellStand)
end

---@return number|nil  pets sold in this batch, nil when the seller refused
---@return string|nil  refusal reason
function xDTaraZ.Sell.Batch(token, remote, keys)
    xDTaraZ.Sell.Reply = nil
    xDTaraZ.Sell.ConfirmUntil = os.clock() + xDTaraZ.Config.ConfirmWindow
    remote:FireServer({ Pets = keys, Eggs = {} })

    xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Sell.Reply ~= nil end, xDTaraZ.Config.SellReplyTimeout)
    local reply = xDTaraZ.Sell.Reply
    if type(reply) ~= "table" then return nil end
    if reply.Reason and reply.Reason ~= "Sold" then return nil, reply.Reason end
    return tonumber(reply.Sold) or 0
end

---@return number|nil  pets sold, nil when the seller refused for good
function xDTaraZ.Sell.Send(token, remote, keys)
    local cfg = xDTaraZ.Config
    for _ = 1, cfg.SellTries do
        local got, why = xDTaraZ.Sell.Batch(token, remote, keys)
        if got then return got end
        if why ~= "TooFar" and why ~= "Busy" then
            xDTaraZ.Sell.SetStatus("Seller says: " .. tostring(why or "no answer"))
            return nil
        end

        local _, waited = xDTaraZ.Tasks.Await(token, nil, why == "Busy" and cfg.SellRetry or cfg.SellSettle)
        if waited ~= "timeout" then return nil end
    end
    xDTaraZ.Sell.SetStatus("Seller is busy")
    return nil
end

---@param toggle string  switched off when income drops after the sale
function xDTaraZ.Sell.GuardIncome(before, toggle)
    task.wait(xDTaraZ.Config.IncomeSettle)
    local after = xDTaraZ.Pets.IncomeRate()
    if after >= before then return end

    table.insert(xDTaraZ.State.PendingToggleOff, toggle)
    xDTaraZ.Util.Notify("ZRHUB", "Income went down after selling, the sale option was stopped", 8)
    warn(xDTaraZ.Config.Tag .. " sell: income " .. before .. " -> " .. after)
end

---@return boolean  next to the seller and settled
function xDTaraZ.Sell.Arrive(token, stand)
    local hrp = xDTaraZ.Player.Root
    if hrp and (hrp.Position - stand.Position).Magnitude <= xDTaraZ.Config.SellNear then return true end
    if not xDTaraZ.Tasks.Teleport(token, stand) then return false end

    local _, settled = xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.SellSettle)
    return settled == "timeout"
end

---@param junkOnly boolean?  sell only the Clear Junk Eggs pet rarities
---@return integer            pets sold
function xDTaraZ.Sell.Run(token, junkOnly)
    local remote = xDTaraZ.GameLib.Remote("SellItems")
    local stand = xDTaraZ.Sell.Stand()
    if not remote or not xDTaraZ.GameLib.Remote("ConfirmRequest") or not stand then
        xDTaraZ.Sell.SetStatus("Seller not found")
        return 0
    end

    local plan, cash = xDTaraZ.Sell.Plan(junkOnly)
    if #plan == 0 then
        xDTaraZ.Sell.SetStatus("Nothing to sell")
        return 0
    end
    if not xDTaraZ.Sell.Arrive(token, stand) then return 0 end

    local before, sold = xDTaraZ.Pets.IncomeRate(), 0
    for first = 1, #plan, xDTaraZ.Config.SellBatch do
        local keys = {}
        for i = first, math.min(first + xDTaraZ.Config.SellBatch - 1, #plan) do
            table.insert(keys, plan[i].key)
        end
        local got = xDTaraZ.Sell.Send(token, remote, keys)
        if not got then break end
        sold += got
    end

    xDTaraZ.Sell.Sold += sold
    if sold > 0 then xDTaraZ.Sell.Earned += cash * sold / #plan end
    xDTaraZ.Sell.SetStatus("Sold " .. sold .. " pets")
    xDTaraZ.Sell.GuardIncome(before, junkOnly and "ClearJunk" or "AutoSell")
    return sold
end

function xDTaraZ.Sell.Now()
    xDTaraZ.Sell.Bind()
    return xDTaraZ.Pets.WithToken("Sell", xDTaraZ.Tasks.Prio.Travel, xDTaraZ.Sell.Run) or 0
end

function xDTaraZ.Sell.Step()
    xDTaraZ.Sell.Preview()
    if xDTaraZ.Util.Opt("AutoSell") then xDTaraZ.Sell.Now() end
end

function xDTaraZ.Sell.Status()
    return xDTaraZ.State.Status.Sell or ""
end

function xDTaraZ.Sell.Start()
    xDTaraZ.Sell.Bind()
end

function xDTaraZ.Sell.Stop()
    xDTaraZ.Sell.ConfirmUntil = 0
end

xDTaraZ.Fusion = {
    Inputs = {},
    Fused = 0,
    FiredAt = 0,
}

---@return string[]  rarities the machine takes, lowest first
function xDTaraZ.Fusion.Rarities()
    local rank = xDTaraZ.GameLib.RarityRank
    local list, seen = {}, {}

    if next(xDTaraZ.GameLib.FuseQuality) then
        for name in pairs(xDTaraZ.GameLib.FuseQuality) do
            local info = xDTaraZ.GameLib.PetInfo[name]
            if info and not seen[info.rarity] then
                seen[info.rarity] = true
                list[#list + 1] = info.rarity
            end
        end
    else
        local cfg = xDTaraZ.GameLib.Data.Fusion
        local floor = type(cfg) == "table" and rank[cfg.MinimumInputRarity] or 0
        for _, rarity in ipairs(xDTaraZ.GameLib.RarityOrder) do
            if (rank[rarity] or 0) >= floor then list[#list + 1] = rarity end
        end
        return list
    end

    table.sort(list, function(a, b) return (rank[a] or 0) < (rank[b] or 0) end)
    return list
end

---@return boolean  waited out the server request cooldown
function xDTaraZ.Fusion.Pace(token)
    local cfg = xDTaraZ.GameLib.Data.Fusion
    local gap = type(cfg) == "table" and tonumber(cfg.RequestCooldown) or xDTaraZ.Config.FuseGap
    local readyAt = xDTaraZ.Fusion.FiredAt + gap
    if os.clock() >= readyAt then return true end
    return (xDTaraZ.Tasks.Await(token, function() return os.clock() >= readyAt end, gap))
end

function xDTaraZ.Fusion.SetStatus(text)
    xDTaraZ.State.Status.Fusion = text
end

---@return boolean  the fusion event is running now
function xDTaraZ.Fusion.Active()
    local cfg = xDTaraZ.GameLib.Data and xDTaraZ.GameLib.Data.Fusion
    if type(cfg) ~= "table" then return false end

    local start = tonumber(cfg.StartTime)
    local on, off = tonumber(cfg.ActiveWeeks), tonumber(cfg.InactiveWeeks)
    if not (start and on and off) then return xDTaraZ.Fusion.Machine() ~= nil end

    local now = xDTaraZ.Util.ServerNow()
    if now < start then return false end
    local period = (on + off) * xDTaraZ.Config.WeekSec
    return (now - start) % period < on * xDTaraZ.Config.WeekSec
end

---@return Vector3|nil, table<number, Attachment>  console stand point, slot attachments
function xDTaraZ.Fusion.Machine()
    local functionals = Workspace:FindFirstChild("Functionals")
    local machine = functionals and functionals:FindFirstChild("Fusion")
    if not machine then return nil, {} end

    local slots, console = {}, nil
    for _, node in ipairs(machine:GetDescendants()) do
        local slot = node:IsA("Attachment") and tonumber(node:GetAttribute("FusionSlot"))
        if slot then slots[slot] = node end
        if node:IsA("ProximityPrompt") and node.Name == "OpenConsole" and node.Parent:IsA("Attachment") then
            console = node.Parent.WorldPosition
        end
    end
    return console, slots
end

---@return CFrame  stand point next to a world position
function xDTaraZ.Fusion.Near(pos)
    return CFrame.new(pos + Vector3.new(0, xDTaraZ.Config.FuseLift, xDTaraZ.Config.FuseStand))
end

---@return table[]  lowest income eligible backpack pets, up to count
function xDTaraZ.Fusion.Candidates(count)
    local allowed = xDTaraZ.Util.Opt("FuseRarities")
    if type(allowed) ~= "table" or not next(allowed) then return {} end

    local floor = xDTaraZ.GameLib.RarityRank[(xDTaraZ.Fusion.Rarities())[1] or ""] or 0
    local owned = xDTaraZ.Pets.Owned()
    table.sort(owned, function(a, b) return a.income > b.income end)
    local keepBest = tonumber(xDTaraZ.Util.Opt("FuseKeepBest")) or 0
    local needs = xDTaraZ.Pets.RebirthNeeds()

    local picked = {}
    for rank = #owned, keepBest + 1, -1 do
        if #picked >= count then break end
        local pet = owned[rank]
        if pet.placed or not pet.tool or not allowed[pet.rarity or ""] then continue end
        if (xDTaraZ.GameLib.RarityRank[pet.rarity] or 0) < floor then continue end
        if next(xDTaraZ.GameLib.FuseQuality) and not xDTaraZ.GameLib.FuseQuality[pet.name or ""] then continue end
        if pet.mutated and xDTaraZ.Util.Opt("FuseKeepMutated") then continue end
        if xDTaraZ.Pets.Protected(pet, needs) then continue end
        picked[#picked + 1] = pet
    end
    return picked
end

---@return number|nil  cash the next fuse costs, nil when the preview does not say
function xDTaraZ.Fusion.Cost(state)
    local raw = state:GetAttribute("FusionPreviewJSON")
    if type(raw) ~= "string" or raw == "" then return nil end
    local ok, preview = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok or type(preview) ~= "table" then return nil end
    return tonumber(preview.FuseCost or preview.Cost or preview.Price)
end

---@return boolean  fired and the slot filled
function xDTaraZ.Fusion.PlaceOne(token, state, slot, attach, pet)
    local remote = xDTaraZ.GameLib.Remote("FusionPetPlace")
    local hum = xDTaraZ.Player.Humanoid
    if not remote or not hum or not pet.tool.Parent then return false end
    if not xDTaraZ.Tasks.Teleport(token, xDTaraZ.Fusion.Near(attach.WorldPosition)) then return false end

    hum:EquipTool(pet.tool)
    xDTaraZ.Mount.Dirty = true
    local equipped = xDTaraZ.Tasks.Await(token, function() return pet.tool.Parent == xDTaraZ.Player.Char end, xDTaraZ.Config.FuseSettle * 4)
    if not equipped then return false end
    xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.FusePlaceSettle)
    if not xDTaraZ.Tasks.Holds(token) or not xDTaraZ.Fusion.Pace(token) then return false end
    xDTaraZ.Fusion.Inputs[pet.key] = true
    xDTaraZ.Fusion.FiredAt = os.clock()
    remote:FireServer(slot)

    local filled = xDTaraZ.Tasks.Await(token, function()
        return state:FindFirstChild(tostring(slot)) ~= nil
    end, xDTaraZ.Config.FuseReplyTimeout)
    if not filled then xDTaraZ.Fusion.Inputs[pet.key] = nil end
    return filled
end

---@return boolean  all slots filled
function xDTaraZ.Fusion.Fill(token, state, slots)
    local missing = {}
    for index = 1, xDTaraZ.Config.FuseSlots do
        if slots[index] and not state:FindFirstChild(tostring(index)) then missing[#missing + 1] = index end
    end
    if #missing == 0 then return true end

    local allowed = xDTaraZ.Util.Opt("FuseRarities")
    if type(allowed) ~= "table" or not next(allowed) then
        xDTaraZ.Fusion.SetStatus("Pick which rarities to fuse")
        return false
    end
    local pets = xDTaraZ.Fusion.Candidates(#missing)
    if #pets < #missing then
        xDTaraZ.Fusion.SetStatus("Need " .. (#missing - #pets) .. " more pets to fuse")
        return false
    end

    local done = true
    for i, slot in ipairs(missing) do
        xDTaraZ.Fusion.SetStatus("Filling slot " .. slot .. " of " .. xDTaraZ.Config.FuseSlots)
        if not xDTaraZ.Fusion.PlaceOne(token, state, slot, slots[slot], pets[i]) then
            done = false
            break
        end
    end
    local hum = xDTaraZ.Player.Humanoid
    if hum then hum:UnequipTools() end
    return done
end

function xDTaraZ.Fusion.AtConsole(token, console, ...)
    local remote = xDTaraZ.GameLib.Remote("FusionAction")
    if not remote or select(1, ...) == "SkipPurchase" then return false end
    if not xDTaraZ.Tasks.Teleport(token, xDTaraZ.Fusion.Near(console)) then return false end
    xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.FuseSettle)
    if not xDTaraZ.Fusion.Pace(token) then return false end
    xDTaraZ.Fusion.FiredAt = os.clock()
    remote:FireServer(...)
    return true
end

---@return string|nil  key the Claim call wants
function xDTaraZ.Fusion.ResultKey(state)
    if state:GetAttribute("FusionFailed") == true then return state:GetAttribute("FusionResultKey") end
    local result = LocalPlayer:FindFirstChild("FusionResult")
    local pet = result and result:FindFirstChild("Pet")
    return pet and pet:GetAttribute("PetKey") or state:GetAttribute("FusionResultKey")
end

function xDTaraZ.Fusion.Waiting(token, state, console)
    local left = (tonumber(state:GetAttribute("EndsAt")) or math.huge) - xDTaraZ.Util.ServerNow()
    if left > 0 then
        xDTaraZ.Fusion.SetStatus("Fusing, " .. math.ceil(left) .. "s left")
        return
    end
    if xDTaraZ.Fusion.AtConsole(token, console, "Fuse") then xDTaraZ.Fusion.SetStatus("Fusion finished, claiming next") end
end

function xDTaraZ.Fusion.Claim(token, state, console)
    local fusion = xDTaraZ.Fusion
    local key = fusion.ResultKey(state)
    if not key or key == fusion.ClaimedKey then return end
    if not fusion.AtConsole(token, console, "Claim", key) then return end

    local claimed = xDTaraZ.Tasks.Await(token, function() return state:GetAttribute("FusionStatus") ~= "Result" end, xDTaraZ.Config.FuseResultTimeout)
    if not claimed then
        fusion.SetStatus("Claim not confirmed; retrying")
        return
    end
    fusion.ClaimedKey = key
    fusion.Fused += 1
    table.clear(fusion.Inputs)
    fusion.SetStatus("Claimed fusion result")
    fusion.PutAway(token)
end

---@return boolean  the result pet that lands in hand after a claim is back in the bag
function xDTaraZ.Fusion.PutAway(token)
    local hum, char = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Char
    if not hum or not char or xDTaraZ.Player:Riding() then return false end
    xDTaraZ.Tasks.Await(token, function() return char:FindFirstChildOfClass("Tool") ~= nil end, xDTaraZ.Config.DismountToolWindow)
    hum:UnequipTools()
    return char:FindFirstChildOfClass("Tool") == nil
end

function xDTaraZ.Fusion.StartFuse(token, state, console)
    local cost = xDTaraZ.Fusion.Cost(state)
    local economy = xDTaraZ.Economy
    if cost and economy and economy.Reserve then
        economy.Reserve("Fusion", cost)
        if economy.Budget("Fusion") < cost then
            xDTaraZ.Fusion.SetStatus("Saving $" .. xDTaraZ.Util.Format(cost) .. " to fuse")
            return
        end
    end
    local started = xDTaraZ.Fusion.AtConsole(token, console, "Start")
    if economy and economy.Reserve then economy.Reserve("Fusion", nil) end
    if started then xDTaraZ.Fusion.SetStatus("Fusion started") end
end

function xDTaraZ.Fusion.Run(token)
    local state = LocalPlayer:FindFirstChild("FusionSlots")
    local console, slots = xDTaraZ.Fusion.Machine()
    if not state or not console then
        xDTaraZ.Fusion.SetStatus("Fusion machine not found")
        return
    end

    local status = state:GetAttribute("FusionStatus")
    if status == "Waiting" then
        xDTaraZ.Fusion.Waiting(token, state, console)
        return
    end
    if status == "Result" then
        xDTaraZ.Fusion.Claim(token, state, console)
        return
    end

    if not xDTaraZ.Fusion.Fill(token, state, slots) then return end
    if state:GetAttribute("Ready") == false then return xDTaraZ.Fusion.SetStatus("Machine is not ready yet") end
    xDTaraZ.Fusion.StartFuse(token, state, console)
end

---@return boolean, string|nil  allowed, why not
function xDTaraZ.Fusion.Ready()
    if (tonumber(xDTaraZ.Pets.Saved("Rebirths")) or 0) < 1 then return false, "Needs one rebirth" end
    if not xDTaraZ.Fusion.Active() then return false, "Fusion event is closed" end
    return true
end

function xDTaraZ.Fusion.Now()
    local ok, why = xDTaraZ.Fusion.Ready()
    if not ok then
        xDTaraZ.Fusion.SetStatus(why)
        return
    end
    xDTaraZ.Fusion.SetStatus("")
    local ran = xDTaraZ.Pets.WithToken("Fusion", xDTaraZ.Tasks.Prio.Plot, function(token)
        xDTaraZ.Fusion.Run(token)
        if xDTaraZ.Tasks.Holds(token) then xDTaraZ.Pets.GoHome(token) end
        return true
    end)
    if not ran then
        xDTaraZ.Fusion.SetStatus("Waiting for a turn")
    elseif xDTaraZ.State.Status.Fusion == "" then
        xDTaraZ.Fusion.SetStatus("Nothing to fuse")
    end
end

function xDTaraZ.Fusion.Step()
    if not xDTaraZ.Util.Opt("AutoFusion") then return end
    xDTaraZ.Fusion.Now()
end

function xDTaraZ.Fusion.Status()
    return xDTaraZ.State.Status.Fusion or ""
end

function xDTaraZ.Fusion.Start() end

function xDTaraZ.Fusion.Stop()
    local hum = xDTaraZ.Player.Humanoid
    if hum and not xDTaraZ.Player:Riding() then hum:UnequipTools() end
end

xDTaraZ.Economy = {
    Reserves = {},
    Plan = "",
    PendingUpgrade = nil,
    PendingRebirth = nil,
    UpgradeBlockedUntil = 0,
    RebirthBlockedUntil = 0,
}

---@return any  SavedData value, nil when not replicated yet
function xDTaraZ.Economy.Saved(name)
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local node = saved and saved:FindFirstChild(name)
    return node and node.Value
end

function xDTaraZ.Economy.Cash()
    return tonumber(xDTaraZ.Economy.Saved("Cash")) or 0
end

---@return number  cash per second, as the leaderboard shows it
function xDTaraZ.Economy.Income()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    local node = stats and stats:FindFirstChild("Income/s")
    return node and tonumber(node.Value) or 0
end

function xDTaraZ.Economy.Rebirths()
    return tonumber(xDTaraZ.Economy.Saved("Rebirths")) or 0
end

function xDTaraZ.Economy.HatchUpgrades()
    return tonumber(xDTaraZ.Economy.Saved("HatchUpgrades")) or 0
end

---@return integer  free luck packs not spent yet
function xDTaraZ.Economy.FreePacks()
    local free = tonumber(xDTaraZ.Economy.Saved("FreeHatchUpgrades")) or 0
    local used = tonumber(xDTaraZ.Economy.Saved("UsedFreeHatchUpgrades")) or 0
    return math.max(free - used, 0)
end

---@param n integer  upgrades already owned
---@return number    price of the next one
function xDTaraZ.Economy.UpgradePrice(n)
    local tier = math.floor(n / 5)
    return 5 + 10 * n + 50 * (5 * tier * (tier - 1) / 2 + tier * (n - 5 * tier + 1))
end

---@return number  hatch luck multiplier with the live event bonus
function xDTaraZ.Economy.LuckMult()
    return GameLib.LuckMult()
end

---@param amount number|nil  nil or 0 clears the hold
function xDTaraZ.Economy.Reserve(owner, amount)
    if not amount or amount <= 0 then
        xDTaraZ.Economy.Reserves[owner] = nil
        return
    end
    xDTaraZ.Economy.Reserves[owner] = amount
end

---@return number  cash this owner may spend: keep floor and the other owners' holds removed
function xDTaraZ.Economy.Budget(owner)
    local budget = xDTaraZ.Economy.Cash() - (tonumber(xDTaraZ.Util.Opt("ShopKeepCash")) or 0)
    if not xDTaraZ.Util.Opt("SmartSpend") then return budget end

    for holder, amount in pairs(xDTaraZ.Economy.Reserves) do
        if holder ~= owner then budget -= amount end
    end
    return budget
end

---@return string|nil  name of the pet the next rebirth asks for, nil when every rebirth is done
function xDTaraZ.Economy.NextRequirement()
    local done = xDTaraZ.Economy.Rebirths()
    if done >= (xDTaraZ.GameLib.Rebirths.Cap or 0) then return nil end
    return xDTaraZ.GameLib.RebirthReq[done + 1]
end

---@return table|nil  first owned pet entry with that name
function xDTaraZ.Economy.OwnedPet(name)
    if not name then return nil end
    for _, pet in ipairs(xDTaraZ.Pets.Owned()) do
        if pet.name == name then return pet end
    end
    return nil
end

---@return table  { cost, pet, owned, ready, payback, reason }
function xDTaraZ.Economy.RebirthPlan()
    local done = xDTaraZ.Economy.Rebirths()
    local target = tonumber(xDTaraZ.Util.Opt("RebirthTarget")) or xDTaraZ.GameLib.Rebirths.Cap or 0
    local plan = { cost = math.huge, payback = math.huge }

    if done >= math.min(target, xDTaraZ.GameLib.Rebirths.Cap or 0) then
        plan.reason = "target reached"
        return plan
    end

    plan.cost = xDTaraZ.GameLib.Rebirths.Costs[done + 1] or math.huge
    plan.pet = xDTaraZ.Economy.NextRequirement()
    local owned = xDTaraZ.Economy.OwnedPet(plan.pet)
    plan.owned = owned ~= nil and xDTaraZ.Pets.Protected(owned) == true

    local gain = xDTaraZ.Economy.Income() / GameLib.RebirthMultiplier(done)
    if gain > 0 then plan.payback = plan.cost / gain end

    if not plan.owned then
        plan.reason = "need " .. tostring(plan.pet)
    elseif xDTaraZ.Economy.Cash() < plan.cost then
        plan.reason = "saving"
    else
        plan.ready = true
    end
    return plan
end

---@return integer  levels to buy now, 0 when the next one is not worth it
function xDTaraZ.Economy.UpgradeCount(budget, income)
    local n = xDTaraZ.Economy.HatchUpgrades()
    local cap = income * xDTaraZ.Config.UpgradePayback
    local count, spent = 0, 0

    repeat
        local price = xDTaraZ.Economy.UpgradePrice(n + count)
        if price >= cap or spent + price > budget then break end
        spent += price
        count += 1
    until count >= xDTaraZ.Config.UpgradeMaxBuy
    return count
end

---@return boolean  true when every level cash could buy also passes the payback rule
function xDTaraZ.Economy.MaxIsSafe(count)
    if xDTaraZ.Util.Opt("SmartSpend") and next(xDTaraZ.Economy.Reserves) then return false end
    if (tonumber(xDTaraZ.Util.Opt("ShopKeepCash")) or 0) > 0 then return false end
    local n = xDTaraZ.Economy.HatchUpgrades() + count
    return xDTaraZ.Economy.UpgradePrice(n) > xDTaraZ.Economy.Cash()
end

---@return integer  levels asked for
function xDTaraZ.Economy.Upgrade()
    local remote = xDTaraZ.Net["Plot.Upgrades"]
    if not remote then return 0 end
    if LocalPlayer:GetAttribute("Setting_LuckMultiplier") == false then
        xDTaraZ.State.Status.Upgrade = "Luck upgrades are turned off in game settings"
        return 0
    end

    local before = xDTaraZ.Economy.HatchUpgrades()
    if xDTaraZ.Economy.FreePacks() > 0 then remote:FireServer("MaxFree") end

    local count = xDTaraZ.Economy.UpgradeCount(xDTaraZ.Economy.Budget("Upgrade"), xDTaraZ.Economy.Income())
    if count == 0 then return 0 end

    if xDTaraZ.Economy.MaxIsSafe(count) then
        remote:FireServer("Max")
    else
        for i = 1, math.min(count, xDTaraZ.Config.UpgradeBatch) do
            remote:FireServer()
            if i < count then task.wait(xDTaraZ.Config.UpgradeGap) end
        end
    end
    xDTaraZ.Economy.PendingUpgrade = { before, os.clock() + xDTaraZ.Config.UpgradeVerify }
    return count
end

---@return boolean  false while a check is still waiting or the last buy was refused
function xDTaraZ.Economy.VerifyUpgrade()
    local pending = xDTaraZ.Economy.PendingUpgrade
    if not pending then return true end
    if os.clock() < pending[2] then return false end

    xDTaraZ.Economy.PendingUpgrade = nil
    if xDTaraZ.Economy.HatchUpgrades() > pending[1] then return true end
    xDTaraZ.Economy.UpgradeBlockedUntil = os.clock() + xDTaraZ.Config.UpgradeBackoff
    return false
end

function xDTaraZ.Economy.UpgradeNow()
    local count = xDTaraZ.Economy.Upgrade()
    xDTaraZ.Util.Notify("Upgrades", count > 0 and ("Buying " .. count .. " luck levels") or "Nothing worth buying now")
end

---@return boolean  fired
function xDTaraZ.Economy.Rebirth(plan)
    local remote = xDTaraZ.Net.Rebirth
    if not (remote and plan.ready) then return false end
    if os.clock() < xDTaraZ.Economy.RebirthBlockedUntil or xDTaraZ.Economy.PendingRebirth then return false end
    if xDTaraZ.Eggs and xDTaraZ.Eggs.CarryCritical then return false end

    xDTaraZ.Economy.PendingRebirth = { xDTaraZ.Economy.Rebirths(), os.clock() + xDTaraZ.Config.RebirthVerify }
    remote:FireServer()
    return true
end

function xDTaraZ.Economy.VerifyRebirth()
    local pending = xDTaraZ.Economy.PendingRebirth
    if not pending or os.clock() < pending[2] then return end
    xDTaraZ.Economy.PendingRebirth = nil

    if xDTaraZ.Economy.Rebirths() > pending[1] then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        xDTaraZ.Util.Notify("Rebirth", "Rebirth " .. xDTaraZ.Economy.Rebirths() .. " done")
        return
    end
    xDTaraZ.Economy.RebirthBlockedUntil = os.clock() + xDTaraZ.Config.RebirthBackoff
    xDTaraZ.State.Status.Economy = "Rebirth refused, retry in 1 min"
end

function xDTaraZ.Economy.RebirthNow()
    local plan = xDTaraZ.Economy.RebirthPlan()
    if not xDTaraZ.Economy.Rebirth(plan) then
        xDTaraZ.Util.Notify("Rebirth", "Not ready: " .. tostring(plan.reason or "busy"))
    end
end

---@return boolean  true while cash is being saved for a rebirth that resets luck upgrades
function xDTaraZ.Economy.SaveForRebirth(plan)
    if not (xDTaraZ.Util.Opt("AutoRebirth") and xDTaraZ.Util.Opt("SmartSpend")) then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        return false
    end
    if not plan.owned or plan.cost == math.huge then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        return false
    end

    local income = math.max(xDTaraZ.Economy.Income(), 1)
    local wait = (plan.cost - xDTaraZ.Economy.Cash()) / income
    if wait > xDTaraZ.Config.RebirthSaveWindow then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        return false
    end
    xDTaraZ.Economy.Reserve("Rebirth", plan.cost)
    return true
end

function xDTaraZ.Economy.Step()
    xDTaraZ.Economy.VerifyRebirth()
    local plan = xDTaraZ.Economy.RebirthPlan()
    local saving = xDTaraZ.Economy.SaveForRebirth(plan)

    if xDTaraZ.Util.Opt("AutoRebirth") and plan.ready then
        xDTaraZ.Economy.Rebirth(plan)
        xDTaraZ.Economy.Plan = "Rebirthing"
    elseif saving then
        xDTaraZ.Economy.Plan = "Saving for rebirth (" .. xDTaraZ.Util.Format(plan.cost) .. ")"
    else
        xDTaraZ.Economy.Plan = plan.reason and ("Rebirth: " .. plan.reason) or ""
    end

    local upgradeOk = xDTaraZ.Economy.VerifyUpgrade() and os.clock() >= xDTaraZ.Economy.UpgradeBlockedUntil
    if xDTaraZ.Util.Opt("AutoUpgrade") and upgradeOk and not saving and not xDTaraZ.Economy.PendingRebirth then
        xDTaraZ.Economy.Upgrade()
    end
    xDTaraZ.State.Status.Economy = xDTaraZ.Economy.Status()
end

function xDTaraZ.Economy.Status()
    local luck = "Luck x" .. xDTaraZ.Util.Format(xDTaraZ.Economy.LuckMult())
    if xDTaraZ.Economy.Plan == "" then return luck end
    return luck .. " | " .. xDTaraZ.Economy.Plan
end

function xDTaraZ.Economy.Stop()
    table.clear(xDTaraZ.Economy.Reserves)
    xDTaraZ.Economy.PendingUpgrade = nil
    xDTaraZ.Economy.PendingRebirth = nil
end

xDTaraZ.Shop = {
    Stock = nil,
    StockAt = 0,
    Signature = nil,
    LastCheck = 0,
    Conn = nil,
    Bought = 0,
}

---@return string[]  "Category/Item" labels for the picker, cheapest first
function xDTaraZ.Shop.Labels()
    local labels = {}
    for _, entry in ipairs(xDTaraZ.GameLib.ShopItems) do
        labels[#labels + 1] = entry.cat .. "/" .. entry.item
    end
    return labels
end

---@return number  price from game data, math.huge when unknown
function xDTaraZ.Shop.Price(category, item)
    for _, entry in ipairs(xDTaraZ.GameLib.ShopItems) do
        if entry.cat == category and entry.item == item then return entry.price end
    end
    return math.huge
end

function xDTaraZ.Shop.Bind()
    if xDTaraZ.Shop.Conn then return end
    local restock = xDTaraZ.GameLib.Listen("Restock")
    if not restock then return end
    xDTaraZ.Shop.Conn = xDTaraZ:Connect(restock.OnClientEvent, function(stock)
        if type(stock) ~= "table" then return end
        xDTaraZ.Shop.Stock = stock
        xDTaraZ.Shop.StockAt = os.clock()
    end)
end

---@return string  restock timestamps joined; changes when the shop restocks
function xDTaraZ.Shop.RestockSignature()
    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    if not serverData then return "" end

    local parts = {}
    for name, value in pairs(serverData:GetAttributes()) do
        if name:find("LastRestockTime", 1, true) then table.insert(parts, name .. "=" .. tostring(value)) end
    end
    for _, child in ipairs(serverData:GetChildren()) do
        if child.Name:find("LastRestockTime", 1, true) and child:IsA("ValueBase") then
            table.insert(parts, child.Name .. "=" .. tostring(child.Value))
        end
    end
    table.sort(parts)
    return table.concat(parts, ";")
end

---@return table|nil  stock[cat][item] = { Amount }, nil when the server did not answer
function xDTaraZ.Shop.ReadStock()
    local request = xDTaraZ.Net.ShopStock
    if not request then return nil end
    xDTaraZ.Shop.Bind()

    local asked = os.clock()
    request:FireServer()
    local deadline = asked + xDTaraZ.Config.ShopReplyTimeout
    repeat
        if xDTaraZ.Shop.StockAt >= asked then return xDTaraZ.Shop.Stock end
        task.wait(0.05)
    until os.clock() > deadline
    return nil
end

---@return integer  units fired
function xDTaraZ.Shop.Buy()
    local wanted = xDTaraZ.Util.Opt("ShopItems")
    local buy = xDTaraZ.Net.BuyWithCash
    if type(wanted) ~= "table" or not next(wanted) or not buy then return 0 end

    local stock = xDTaraZ.Shop.ReadStock()
    if not stock then return 0 end

    local budget, fired = xDTaraZ.Economy.Budget("Shop"), 0
    for label, on in pairs(wanted) do
        if not on then continue end
        local category, item = label:match("^(.-)/(.+)$")
        local slot = category and type(stock[category]) == "table" and stock[category][item]
        local amount = type(slot) == "table" and tonumber(slot.Amount) or 0
        local price = xDTaraZ.Shop.Price(category, item)

        for _ = 1, amount do
            if budget < price then break end
            buy:FireServer(category, item)
            budget -= price
            fired += 1
            task.wait(xDTaraZ.Config.ShopBuyGap)
        end
    end
    xDTaraZ.Shop.Bought += fired
    return fired
end

function xDTaraZ.Shop.BuyNow()
    local fired = xDTaraZ.Shop.Buy()
    xDTaraZ.Util.Notify("Shop", fired > 0 and ("Bought " .. fired .. " items") or "Nothing to buy in stock")
end

function xDTaraZ.Shop.Step()
    if not xDTaraZ.Util.Opt("AutoShop") then return end
    local signature = xDTaraZ.Shop.RestockSignature()
    local stale = os.clock() - xDTaraZ.Shop.LastCheck >= xDTaraZ.Config.ShopRecheck
    if signature == xDTaraZ.Shop.Signature and not stale then return end

    xDTaraZ.Shop.Signature = signature
    xDTaraZ.Shop.LastCheck = os.clock()
    xDTaraZ.Shop.Buy()
    xDTaraZ.State.Status.Shop = "Bought " .. xDTaraZ.Shop.Bought .. " this session"
end

function xDTaraZ.Shop.Stop()
    xDTaraZ.Shop.Signature = nil
    xDTaraZ.Shop.LastCheck = 0
end

xDTaraZ.Rewards = {
    OfflineDone = false,
    PromptAt = {},
    PendingIndex = nil,
    IndexBlockedUntil = 0,
}

---@return integer  game pets found in OwnedPets, counted the way the index does
function xDTaraZ.Rewards.IndexCount()
    local owned = tostring(xDTaraZ.Economy.Saved("OwnedPets") or "")
    if owned == "" then return 0 end

    local count = 0
    for name in pairs(xDTaraZ.GameLib.PetInfo) do
        if owned:find(name .. ",", 1, true) then count += 1 end
    end
    return count
end

---@return table|nil  next unclaimed stage { goal, reward } when its goal is met
function xDTaraZ.Rewards.IndexReady()
    local stage = tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0
    local nextStage = xDTaraZ.GameLib.IndexStages[stage + 1]
    if not nextStage then return nil end
    if xDTaraZ.Rewards.IndexCount() < nextStage.goal then return nil end
    return nextStage
end

---@return boolean  fired
function xDTaraZ.Rewards.ClaimIndex()
    local remote = xDTaraZ.Net.ClaimIndexReward
    if not remote or os.clock() < xDTaraZ.Rewards.IndexBlockedUntil then return false end
    if not xDTaraZ.Rewards.IndexReady() then return false end

    local stage = tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0
    remote:FireServer()
    task.delay(xDTaraZ.Config.ClaimVerify, function()
        local now = tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0
        if now <= stage then xDTaraZ.Rewards.IndexBlockedUntil = os.clock() + xDTaraZ.Config.PromptRetry end
    end)
    return true
end

---@return boolean  fired
function xDTaraZ.Rewards.ClaimOffline()
    local remote = xDTaraZ.Net.OfflineEarnings
    if not remote or xDTaraZ.Rewards.OfflineDone then return false end
    if (tonumber(LocalPlayer:GetAttribute("OfflineSeconds")) or 0) <= 0 then return false end

    xDTaraZ.Rewards.OfflineDone = true
    remote:FireServer()
    return true
end

---@return ProximityPrompt|nil
function xDTaraZ.Rewards.FindPrompt(holder)
    local functionals = Workspace:FindFirstChild("Functionals")
    local model = functionals and functionals:FindFirstChild(holder)
    local handle = model and model:FindFirstChild("Handle")
    local prompt = handle and handle:FindFirstChild("Claim")
    if prompt and prompt:IsA("ProximityPrompt") and prompt.Enabled then return prompt end
    return nil
end

---@return boolean  triggered, through the executor or a hold while in range
function xDTaraZ.Rewards.TriggerPrompt(prompt)
    if Library and Library.Compat and Library.Compat.Caps.Prompt then
        return (pcall(fireproximityprompt, prompt))
    end

    local root = xDTaraZ.Player.Root
    local part = prompt.Parent
    if not (root and part and part:IsA("BasePart")) then return false end
    if (root.Position - part.Position).Magnitude > prompt.MaxActivationDistance then return false end

    prompt:InputHoldBegin()
    task.wait(prompt.HoldDuration + 0.05)
    prompt:InputHoldEnd()
    return true
end

---@return boolean  group reward cooldown is over (or never claimed)
function xDTaraZ.Rewards.GroupReady()
    local last = tonumber(LocalPlayer:GetAttribute("GroupRewardClaimTime"))
    if not last then return true end
    return os.time() - last >= xDTaraZ.Config.GroupRewardCooldown
end

---@return integer  prompts triggered
function xDTaraZ.Rewards.ClaimPrompts(force)
    local fired = 0
    local list = {
        { "EventBoost", true },
        { "Meat", xDTaraZ.Rewards.GroupReady() },
    }

    for _, pair in ipairs(list) do
        local holder, ready = pair[1], pair[2]
        local due = force or os.clock() - (xDTaraZ.Rewards.PromptAt[holder] or -math.huge) >= xDTaraZ.Config.PromptRetry
        if not (ready and due) then continue end

        local prompt = xDTaraZ.Rewards.FindPrompt(holder)
        if not prompt then continue end
        xDTaraZ.Rewards.PromptAt[holder] = os.clock()
        if xDTaraZ.Rewards.TriggerPrompt(prompt) then fired += 1 end
    end
    return fired
end

---@return integer  claims fired
function xDTaraZ.Rewards.Claim(force)
    local fired = 0
    if xDTaraZ.Rewards.ClaimIndex() then fired += 1 end
    if xDTaraZ.Rewards.ClaimOffline() then fired += 1 end
    fired += xDTaraZ.Rewards.ClaimPrompts(force)
    return fired
end

function xDTaraZ.Rewards.ClaimNow()
    local fired = xDTaraZ.Rewards.Claim(true)
    xDTaraZ.Util.Notify("Rewards", fired > 0 and ("Claimed " .. fired .. " rewards") or "Nothing to claim right now")
end

function xDTaraZ.Rewards.Step()
    if not xDTaraZ.Util.Opt("AutoClaim") then return end
    xDTaraZ.Rewards.Claim(false)

    local nextStage = xDTaraZ.GameLib.IndexStages[(tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0) + 1]
    if nextStage then
        xDTaraZ.State.Status.Rewards = "Index " .. xDTaraZ.Rewards.IndexCount() .. "/" .. nextStage.goal
    else
        xDTaraZ.State.Status.Rewards = "Index complete"
    end
end

function xDTaraZ.Rewards.Stop()
    table.clear(xDTaraZ.Rewards.PromptAt)
end

xDTaraZ.Boosts = {
    Last = {},
    Lines = {},
    Primed = false,
}

---@return string|nil  readable line, nil when the boost is not running
function xDTaraZ.Boosts.Describe(name, value)
    if value == nil then return nil end
    local now = xDTaraZ.Util.ServerNow()

    if name:sub(-5) == "Until" then
        local left = (tonumber(value) or 0) - now
        if left <= 0 then return nil end
        return name:gsub("Until$", "") .. ": " .. math.floor(left / 60) .. "m left"
    end

    local amount = tonumber(value)
    if not amount or amount <= 1 then return nil end
    return name .. ": x" .. amount
end

---@return table  { name = line } of running boosts
function xDTaraZ.Boosts.Read()
    local running = {}
    for _, name in ipairs(xDTaraZ.Config.BoostAttributes) do
        running[name] = xDTaraZ.Boosts.Describe(name, ReplicatedStorage:GetAttribute(name))
    end
    running.EventBoostUntil = xDTaraZ.Boosts.Describe("EventBoostUntil", LocalPlayer:GetAttribute("EventBoostUntil"))

    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    local weather = serverData and serverData:GetAttribute("ActiveWeathers")
    local names = xDTaraZ.Boosts.WeatherNames(weather)
    if names then running.Weather = "Weather: " .. names end
    return running
end

---@param raw any     ServerData ActiveWeathers JSON
---@return string|nil  "Storm, Rain", nil when clear or unreadable
function xDTaraZ.Boosts.WeatherNames(raw)
    if type(raw) ~= "string" or raw == "" then return nil end
    local ok, list = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok then
        warn(xDTaraZ.Config.Tag, "weather decode:", list)
        return nil
    end
    if type(list) ~= "table" then return nil end

    local names = {}
    for _, entry in pairs(list) do
        local kind = type(entry) == "table" and entry.Type or entry
        local variant = type(entry) == "table" and entry.Variant
        if type(variant) == "string" and variant ~= "" then kind = tostring(kind) .. " (" .. variant .. ")" end
        if type(kind) == "string" and not table.find(names, kind) then names[#names + 1] = kind end
    end
    return #names > 0 and table.concat(names, ", ") or nil
end

function xDTaraZ.Boosts.Announce(name, line)
    xDTaraZ.Util.Notify("Boost", line, 8)
    local webhook = rawget(xDTaraZ, "Webhook")
    if not (webhook and webhook.Push) then return end
    xDTaraZ.Util.Try("boost webhook", webhook.Push, { Kind = "Boost", Title = name, Lines = { line } })
end

function xDTaraZ.Boosts.Step()
    local running = xDTaraZ.Boosts.Read()
    local lines = {}

    for name, line in pairs(running) do
        table.insert(lines, line)
        if xDTaraZ.Boosts.Primed and not xDTaraZ.Boosts.Last[name] then xDTaraZ.Boosts.Announce(name, line) end
    end
    table.sort(lines)

    xDTaraZ.Boosts.Last = running
    xDTaraZ.Boosts.Primed = true
    xDTaraZ.Boosts.Lines = lines
    xDTaraZ.State.Weather = running.Weather and { running.Weather } or {}
    xDTaraZ.State.Status.Boosts = #lines > 0 and table.concat(lines, "\n") or "No boosts running"
end

function xDTaraZ.Boosts.Stop()
    table.clear(xDTaraZ.Boosts.Last)
    xDTaraZ.Boosts.Primed = false
end

xDTaraZ.Prompts = { Active = false, Saved = setmetatable({}, { __mode = "k" }), Connections = {} }

function xDTaraZ.Prompts.Apply(prompt)
    local prompts = xDTaraZ.Prompts
    if not prompts.Active or not xDTaraZ.State.Alive or not prompt.Parent or not prompt:IsA("ProximityPrompt") then return end
    if prompts.Saved[prompt] == nil then prompts.Saved[prompt] = prompt.HoldDuration end
    if prompt.HoldDuration ~= 0 then prompt.HoldDuration = 0 end
end

function xDTaraZ.Prompts.Start()
    local prompts = xDTaraZ.Prompts
    if prompts.Active then return end
    prompts.Active = true
    local service = game:GetService("ProximityPromptService")
    for _, signal in ipairs({ service.PromptShown, service.PromptButtonHoldBegan, Workspace.DescendantAdded }) do
        prompts.Connections[#prompts.Connections + 1] = signal:Connect(prompts.Apply)
    end
    for _, instance in ipairs(Workspace:GetDescendants()) do prompts.Apply(instance) end
end

function xDTaraZ.Prompts.Stop()
    local prompts = xDTaraZ.Prompts
    prompts.Active = false
    for _, connection in ipairs(prompts.Connections) do connection:Disconnect() end
    table.clear(prompts.Connections)
    for prompt, duration in pairs(prompts.Saved) do
        if prompt.Parent then prompt.HoldDuration = duration end
    end
    table.clear(prompts.Saved)
end

do
    local defaults = {
        WalkSpeed = 60, JumpPower = 80, FlySpeed = 120,
        FlingSpin = 2000, FlingForce = 9e4, StickOffset = 2,
        StandLift = 3, StreamTimeout = 5,
        EspLift = 4, EspPool = 48,
        FloatSize = 52, FloatGap = 8,
        ReconnectDelay = 5, ReconnectRetry = 10, ReconnectTries = 6, ReconnectMax = 3, ReconnectWindow = 600,
        ReconnectFile = "MarioHub_RideAPet_reconnect.txt",
        HopPick = 15, ServerListUrl = "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
        ReloadSource = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua"))()',
        RarityColors = {
            Common = Color3.fromRGB(200, 200, 200), Rare = Color3.fromRGB(90, 170, 255), Epic = Color3.fromRGB(190, 110, 255),
            Legendary = Color3.fromRGB(255, 200, 60), Mythic = Color3.fromRGB(255, 90, 90), Divine = Color3.fromRGB(120, 255, 220),
            Ethereal = Color3.fromRGB(255, 130, 230),
        },
    }
    for key, value in pairs(defaults) do
        if Config[key] == nil then Config[key] = value end
    end
end

xDTaraZ.World = { Conn = nil, Gui = nil }

---@return Instance  hidden gui root, CoreGui or PlayerGui when gethui is missing
function xDTaraZ.World.GuiRoot()
    local caps = Library and Library.Compat and Library.Compat.Caps
    if caps and caps.Hui then
        local ok, hui = pcall(gethui)
        if ok and typeof(hui) == "Instance" then return hui end
    end
    local ok, core = pcall(function() return game:GetService("CoreGui") end)
    if ok and core and pcall(function() return core.Name end) then return core end
    return LocalPlayer:WaitForChild("PlayerGui", Config.LoadTimeout)
end

function xDTaraZ.World.Screen()
    local gui = xDTaraZ.World.Gui
    if gui and gui.Parent then return gui end

    gui = Instance.new("ScreenGui")
    gui.Name = "MarioWorld"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ok = pcall(function() gui.Parent = xDTaraZ.World.GuiRoot() end)
    if not ok then gui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") end
    xDTaraZ.World.Gui = gui
    return gui
end

---@return boolean  any per-frame movement or troll option is on
function xDTaraZ.World.NeedsFrame()
    local opt = xDTaraZ.Util.Opt
    return opt("SpeedOn") or opt("JumpOn") or opt("Fly") or opt("NoClip") or opt("Fling") or opt("Stick") or false
end

function xDTaraZ.World.Sync()
    local world = xDTaraZ.World
    if world.NeedsFrame() then
        if world.Conn then return end
        world.Conn = xDTaraZ:Connect(RunService.Heartbeat, function(dt)
            xDTaraZ.Util.Try("Move.Frame", xDTaraZ.Move.Frame, dt)
            xDTaraZ.Util.Try("Troll.Frame", xDTaraZ.Troll.Frame)
        end)
        return
    end
    if world.Conn then
        world.Conn:Disconnect()
        world.Conn = nil
    end
end

function xDTaraZ.World.Carrying()
    return xDTaraZ.Tasks.Carrying()
end

xDTaraZ.Teleport = {}

local GroundRay = RaycastParams.new()
GroundRay.FilterType = Enum.RaycastFilterType.Exclude
GroundRay.RespectCanCollide = true
local GroundRayOf = nil

---@return CFrame  stand height over the real surface at pos, raycast first
local function GroundCF(pos)
    local char = xDTaraZ.Player.Char
    if GroundRayOf ~= char then
        GroundRayOf = char
        GroundRay.FilterDescendantsInstances = { char or Workspace }
    end

    local origin = pos + Vector3.new(0, Config.GroundRayUp, 0)
    local hit = Workspace:Raycast(origin, Vector3.new(0, -(Config.GroundRayUp + Config.GroundRayDown), 0), GroundRay)
    if hit then
        return CFrame.new(hit.Position + Vector3.new(0, Config.StandLift, 0))
    end
    return CFrame.new(pos)
end

---@return CFrame  a standing spot on top of a part
local function Above(part)
    return GroundCF(part.Position + Vector3.new(0, part.Size.Y / 2 + Config.StandLift, 0))
end

---@return table<string, function>  label -> CFrame getter
function xDTaraZ.Teleport.Places()
    local places = {}
    places["My Plot"] = function()
        local _, bp = xDTaraZ.Player:Plot()
        return bp and Above(bp)
    end

    local spawns = Workspace:FindFirstChild("EggSpawns")
    local seen = {}
    for _, pad in ipairs(spawns and spawns:GetChildren() or {}) do
        if not pad:IsA("BasePart") then continue end
        local rarity = pad.Name:gsub("%-+$", "")
        seen[rarity] = (seen[rarity] or 0) + 1
        places["Eggs: " .. rarity .. " #" .. seen[rarity]] = function() return Above(pad) end
    end

    for _, folderName in ipairs({ "Stalls", "Functionals" }) do
        local folder = Workspace:FindFirstChild(folderName)
        for _, spot in ipairs(folder and folder:GetChildren() or {}) do
            if not (spot:IsA("Model") or spot:IsA("BasePart")) then continue end
            if spot.Name:find("^AlwaysStream") then continue end
            places[folderName .. ": " .. spot.Name] = function()
                return GroundCF(spot:GetPivot().Position + Vector3.new(0, Config.StandLift, 0))
            end
        end
    end

    local plots = Workspace:FindFirstChild("Plots")
    for _, plot in ipairs(plots and plots:GetChildren() or {}) do
        local owner = plot:FindFirstChild("Data") and plot.Data:FindFirstChild("Owner")
        local player = owner and owner.Value
        local bp = plot:FindFirstChild("Baseplate")
        if not bp or not player or player == LocalPlayer then continue end
        places["Plot: " .. player.Name] = function() return Above(bp) end
    end

    places["Volcano"] = xDTaraZ.Teleport.VolcanoSpot

    local halloween = rawget(xDTaraZ, "Halloween")
    if halloween and halloween.Places then
        for label, getter in pairs(halloween.Places()) do
            places[label] = getter
        end
    end
    return places
end

---@return CFrame|nil  top of the volcano once it streams in, else its centre
function xDTaraZ.Teleport.VolcanoSpot()
    local center = Config.VolcanoCenter
    pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, center, Config.StreamTimeout)

    local tagged = game:GetService("CollectionService"):GetTagged("VolcanoTop")
    for _, part in ipairs(tagged) do
        if part:IsA("BasePart") then return Above(part) end
    end
    return CFrame.new(center)
end

---@return string[]  sorted; egg pads by rarity order
function xDTaraZ.Teleport.PlaceNames()
    local rank = GameLib.RarityRank
    local names = {}
    for name in pairs(xDTaraZ.Teleport.Places()) do
        names[#names + 1] = name
    end

    table.sort(names, function(a, b)
        local ra = rank[a:match("^Eggs: (.-) #") or ""] or 0
        local rb = rank[b:match("^Eggs: (.-) #") or ""] or 0
        if ra ~= rb then return ra < rb end
        return a < b
    end)
    return names
end

---@return boolean  moved; refused while an egg is carried or another task drives
function xDTaraZ.Teleport.Go(cf)
    if not cf then return false end
    if xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Teleport", "Finish the egg delivery first")
        return false
    end

    local token = xDTaraZ.Tasks.Request("Manual", xDTaraZ.Tasks.Prio.Manual)
    if not token then
        xDTaraZ.Util.Notify("Teleport", "Busy with farming, try again in a moment")
        return false
    end
    token.home = nil
    local moved = xDTaraZ.Tasks.Teleport(token, cf)
    xDTaraZ.Tasks.Release(token)
    return moved
end

function xDTaraZ.Teleport.To(name)
    local getter = xDTaraZ.Teleport.Places()[name or ""]
    if not getter then return false end
    return xDTaraZ.Teleport.Go(getter())
end

function xDTaraZ.Teleport.ToPlayer(name)
    local target = Players:FindFirstChild(name or "")
    if not target or target == LocalPlayer then return false end
    local hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        xDTaraZ.Util.Notify("Teleport", target.Name .. " is too far to see right now")
        return false
    end
    return xDTaraZ.Teleport.Go(hrp.CFrame + Vector3.new(0, Config.StandLift, 0))
end

function xDTaraZ.Teleport.Home()
    return xDTaraZ.Teleport.To("My Plot")
end

xDTaraZ.Move = { Saved = {}, Patched = {}, Parts = {}, PartsOf = nil, Conns = {}, Floats = {}, FlyWarned = false }

---@param idx string   option id
---@param on  boolean
function xDTaraZ.Move.Set(idx, on)
    xDTaraZ.Options[idx] = on
    local move = xDTaraZ.Move
    local hum = xDTaraZ.Player.Humanoid

    if on and hum then
        if idx == "SpeedOn" and move.Saved.WalkSpeed == nil then move.Saved.WalkSpeed = hum.WalkSpeed end
        if idx == "JumpOn" and move.Saved.JumpPower == nil then
            move.Saved.JumpPower, move.Saved.UseJumpPower = hum.JumpPower, hum.UseJumpPower
        end
    end
    if idx == "InfJump" then move.BindJump(on) end
    if idx == "AntiAfk" then move.BindIdle(on) end
    if not on then move.Restore(idx) end
    xDTaraZ.World.Sync()
end

function xDTaraZ.Move.BindJump(on)
    local move = xDTaraZ.Move
    if move.Conns.Jump then
        move.Conns.Jump:Disconnect()
        move.Conns.Jump = nil
    end
    if not on then return end

    move.Conns.Jump = xDTaraZ:Connect(UserInputService.JumpRequest, function()
        local hum = xDTaraZ.Player.Humanoid
        if hum and hum.Health > 0 then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end

function xDTaraZ.Move.BindIdle(on)
    local move = xDTaraZ.Move
    if move.Conns.Idle then
        move.Conns.Idle:Disconnect()
        move.Conns.Idle = nil
    end
    if not on then return end

    move.Conns.Idle = xDTaraZ:Connect(LocalPlayer.Idled, function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end

---@return BasePart[]  character parts, rebuilt only when the character changes
function xDTaraZ.Move.CharParts()
    local move, char = xDTaraZ.Move, xDTaraZ.Player.Char
    if move.PartsOf == char then return move.Parts end

    table.clear(move.Parts)
    move.PartsOf = char
    for _, part in ipairs(char and char:GetDescendants() or {}) do
        if part:IsA("BasePart") then move.Parts[#move.Parts + 1] = part end
    end
    return move.Parts
end

function xDTaraZ.Move.NoClip(on)
    local patched = xDTaraZ.Move.Patched
    if not on then
        for part in pairs(patched) do
            if part.Parent then part.CanCollide = true end
        end
        table.clear(patched)
        return
    end

    for _, part in ipairs(xDTaraZ.Move.CharParts()) do
        if part.Parent and part.CanCollide then
            patched[part] = true
            part.CanCollide = false
        end
    end
end

---@return Vector3  wanted direction from keys or the touch stick
function xDTaraZ.Move.FlyDirection(hum, cam)
    local look = cam.CFrame.LookVector
    local dir = hum.MoveDirection
    if dir.Magnitude > 0 then
        local flat = Vector3.new(look.X, 0, look.Z)
        local forward = flat.Magnitude > 0 and dir:Dot(flat.Unit) or 0
        dir += Vector3.new(0, look.Y * forward, 0)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.yAxis end
    return dir
end

function xDTaraZ.Move.FlyStep(dt)
    local hrp, hum = xDTaraZ.Player.Root, xDTaraZ.Player.Humanoid
    local cam = Workspace.CurrentCamera
    if not hrp or not hum or not cam then return end

    if xDTaraZ.World.Carrying() or xDTaraZ.Tasks.Owner() then
        if not xDTaraZ.Move.FlyWarned and xDTaraZ.World.Carrying() then
            xDTaraZ.Move.FlyWarned = true
            xDTaraZ.Util.Notify("Fly", "Fly pauses while you carry an egg")
        end
        return
    end
    xDTaraZ.Move.FlyWarned = false

    hrp.AssemblyLinearVelocity = Vector3.zero
    local dir = xDTaraZ.Move.FlyDirection(hum, cam)
    if dir.Magnitude == 0 then return end
    hrp.CFrame += dir.Unit * (tonumber(xDTaraZ.Util.Opt("FlySpeed")) or Config.FlySpeed) * dt
end

function xDTaraZ.Move.Frame(dt)
    local opt = xDTaraZ.Util.Opt
    local hum = xDTaraZ.Player.Humanoid

    if opt("NoClip") or opt("Fly") or opt("Fling") then xDTaraZ.Move.NoClip(true) end
    if opt("Fly") then xDTaraZ.Move.FlyStep(dt) end
    if not hum then return end

    if opt("SpeedOn") then hum.WalkSpeed = tonumber(opt("WalkSpeed")) or Config.WalkSpeed end
    if opt("JumpOn") then
        hum.UseJumpPower = true
        hum.JumpPower = tonumber(opt("JumpPower")) or Config.JumpPower
    end
end

---@param idx string|nil  option that turned off; nil restores everything
function xDTaraZ.Move.Restore(idx)
    local move, opt = xDTaraZ.Move, xDTaraZ.Util.Opt
    local hum, hrp = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Root

    if hum and (idx == nil or idx == "SpeedOn") and move.Saved.WalkSpeed then
        hum.WalkSpeed = move.Saved.WalkSpeed
        move.Saved.WalkSpeed = nil
    end
    if hum and (idx == nil or idx == "JumpOn") and move.Saved.JumpPower then
        hum.JumpPower = move.Saved.JumpPower
        hum.UseJumpPower = move.Saved.UseJumpPower
        move.Saved.JumpPower, move.Saved.UseJumpPower = nil, nil
    end

    if idx == nil or not (opt("NoClip") or opt("Fly") or opt("Fling")) then move.NoClip(false) end
    if (idx == nil or idx == "Fly") and hrp then hrp.AssemblyLinearVelocity = Vector3.zero end

    if idx == nil then
        move.BindJump(false)
        move.BindIdle(false)
        move.ClearFloats()
        xDTaraZ.Esp.Clear()
        if xDTaraZ.World.Gui then
            xDTaraZ.World.Gui:Destroy()
            xDTaraZ.World.Gui = nil
        end
        if xDTaraZ.World.Conn then
            xDTaraZ.World.Conn:Disconnect()
            xDTaraZ.World.Conn = nil
        end
    end
end

---@param list table  { {idx, text}, ... } toggles that get a draggable touch button
function xDTaraZ.Move.BuildFloats(list)
    if not xDTaraZ.Platform.Touch then return end
    local move = xDTaraZ.Move
    move.ClearFloats()

    local screen = xDTaraZ.World.Screen()
    local size, gap = Config.FloatSize, Config.FloatGap
    for i, row in ipairs(list) do
        local button = move.FloatButton(screen, row[1], row[2])
        button.Position = UDim2.new(1, -(size + gap) * 2, 0.3, (i - 1) * (size + gap))
        table.insert(move.Floats, button)
    end
end

---@return TextButton
function xDTaraZ.Move.FloatButton(screen, idx, text)
    local button = Instance.new("TextButton")
    button.Name = "Float_" .. idx
    button.Size = UDim2.fromOffset(Config.FloatSize, Config.FloatSize)
    button.BackgroundColor3 = Color3.fromRGB(27, 21, 18)
    button.BackgroundTransparency = 0.25
    button.TextColor3 = Color3.fromRGB(232, 160, 76)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Text = text
    button.Active = true
    button.Draggable = true
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)
    button.Parent = screen

    local pressedAt
    button.MouseButton1Down:Connect(function() pressedAt = button.AbsolutePosition end)
    button.MouseButton1Up:Connect(function()
        if pressedAt and (button.AbsolutePosition - pressedAt).Magnitude > 6 then return end
        local option = Library and Library.Options and Library.Options[idx]
        if option then option:SetValue(not option.Value) end
    end)
    return button
end

function xDTaraZ.Move.ClearFloats()
    for _, button in ipairs(xDTaraZ.Move.Floats) do
        button:Destroy()
    end
    table.clear(xDTaraZ.Move.Floats)
end

xDTaraZ.Troll = { Token = nil, Home = nil }

function xDTaraZ.Troll.TargetRoot()
    local target = Players:FindFirstChild(xDTaraZ.Util.Opt("TrollTarget") or "")
    if not target or target == LocalPlayer then return nil end
    return target.Character and target.Character:FindFirstChild("HumanoidRootPart")
end

---@param idx string  "Fling" | "Stick"
function xDTaraZ.Troll.Set(idx, on)
    xDTaraZ.Options[idx] = on
    if on and xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Troll", "Finish the egg delivery first")
        table.insert(State.PendingToggleOff, idx)
        xDTaraZ.Options[idx] = false
        return
    end
    if not on then xDTaraZ.Troll.Stop(idx) end
    xDTaraZ.World.Sync()
end

---@return table|nil  manual task token, nil while farming drives the character
function xDTaraZ.Troll.Hold()
    local troll = xDTaraZ.Troll
    if troll.Token and xDTaraZ.Tasks.Holds(troll.Token) then return troll.Token end
    troll.Token = nil
    if xDTaraZ.World.Carrying() then return nil end

    local token = xDTaraZ.Tasks.Request("Troll", xDTaraZ.Tasks.Prio.Manual)
    if not token then return nil end
    token.home = nil
    troll.Token = token
    return token
end

function xDTaraZ.Troll.Frame()
    local opt = xDTaraZ.Util.Opt
    if not opt("Fling") and not opt("Stick") then return end
    local target, hrp = xDTaraZ.Troll.TargetRoot(), xDTaraZ.Player.Root
    if not target or not hrp then return end
    if not xDTaraZ.Troll.Hold() then return end

    xDTaraZ.Troll.Home = xDTaraZ.Troll.Home or hrp.CFrame
    if opt("Fling") then
        local spin = math.rad(os.clock() * Config.FlingSpin % 360)
        hrp.CFrame = target.CFrame * CFrame.Angles(0, spin, 0)
        hrp.AssemblyLinearVelocity = Vector3.new(0, Config.FlingForce, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, Config.FlingForce, 0)
        return
    end
    hrp.CFrame = target.CFrame * CFrame.new(0, 0, Config.StickOffset)
end

---@param idx string|nil  toggle that turned off; nil on unload
function xDTaraZ.Troll.Stop(idx)
    local troll, hrp = xDTaraZ.Troll, xDTaraZ.Player.Root
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end
    if idx then xDTaraZ.Move.Restore(idx) end
    local opt = xDTaraZ.Util.Opt
    if idx and (opt("Fling") or opt("Stick")) then return end

    local token = troll.Token
    troll.Token = nil
    if token and xDTaraZ.Tasks.Holds(token) then
        if troll.Home then xDTaraZ.Tasks.Teleport(token, troll.Home) end
        xDTaraZ.Tasks.Release(token)
    end
    troll.Home = nil
    if idx == nil then xDTaraZ.Troll.Spectate(nil) end
end

---@param name string|nil  nil returns the camera to us
function xDTaraZ.Troll.Spectate(name)
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local target = name and Players:FindFirstChild(name)
    local hum = target and target.Character and target.Character:FindFirstChildOfClass("Humanoid")
    cam.CameraSubject = hum or xDTaraZ.Player.Humanoid

    local troll = xDTaraZ.Troll
    if troll.LeaveConn then
        troll.LeaveConn:Disconnect()
        troll.LeaveConn = nil
    end
    if not hum then return end
    troll.LeaveConn = xDTaraZ:Connect(Players.PlayerRemoving, function(player)
        if player == target then xDTaraZ.Troll.Spectate(nil) end
    end)
end

xDTaraZ.Server = { Hopping = false }

function xDTaraZ.Server.QueueReload()
    return xDTaraZ.Util.Queue(Config.ReloadSource)
end

---@return boolean  teleport started
function xDTaraZ.Server.Rejoin()
    if xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Server", "Finish the egg delivery first")
        return false
    end
    xDTaraZ.Server.QueueReload()
    local ok, err = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, game.JobId, LocalPlayer)
    if not ok then warn(Config.Tag, "rejoin:", err) end
    return ok
end

---@return string[]  open public server ids other than ours
function xDTaraZ.Server.OpenServers()
    local body = xDTaraZ.Util.HttpGet(Config.ServerListUrl:format(game.PlaceId))
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, body or "")
    local open = {}
    if not ok or type(decoded) ~= "table" then return open end

    for _, server in ipairs(decoded.data or {}) do
        local playing, cap = tonumber(server.playing) or 0, tonumber(server.maxPlayers) or 0
        if server.id ~= game.JobId and playing < cap then table.insert(open, server.id) end
    end
    return open
end

---@return boolean  teleport started
function xDTaraZ.Server.Hop()
    local server = xDTaraZ.Server
    if server.Hopping then return false end
    if xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Server", "Finish the egg delivery first")
        return false
    end

    server.Hopping = true
    task.delay(Config.LoadTimeout, function() server.Hopping = false end)
    server.QueueReload()

    local open = server.OpenServers()
    local ok, err
    if #open > 0 then
        local pick = open[math.random(1, math.min(#open, Config.HopPick))]
        ok, err = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, pick, LocalPlayer)
    else
        ok, err = pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
    end
    if not ok then warn(Config.Tag, "hop:", err) end
    return ok
end

xDTaraZ.Server.IdleKeepers = { "AntiAfk", "AutoEggs", "EggHunter", "Kaitun" }

---@return boolean  under the cap, so a kick loop cannot rejoin forever
function xDTaraZ.Server.ReconnectBudget()
    if not (Library and Library.Compat and Library.Compat.Caps.FileSystem) then return true end
    local now, recent = os.time(), {}
    local ok, raw = pcall(readfile, Config.ReconnectFile)
    for stamp in (ok and tostring(raw) or ""):gmatch("%d+") do
        if now - tonumber(stamp) < Config.ReconnectWindow then recent[#recent + 1] = stamp end
    end
    if #recent >= Config.ReconnectMax then return false end
    recent[#recent + 1] = tostring(now)
    local wrote, err = pcall(writefile, Config.ReconnectFile, table.concat(recent, ","))
    if not wrote then warn(Config.Tag, "reconnect log:", err) end
    return true
end

function xDTaraZ.Server.OnError()
    local server = xDTaraZ.Server
    local message = GuiService:GetErrorMessage()
    if server.Reconnecting or message == "" or not xDTaraZ.Util.Opt("AutoReconnect") then return end
    if message:lower():find("ban") then return end
    server.Reconnecting = true

    task.delay(Config.ReconnectDelay, function()
        if not server.ReconnectBudget() then
            warn(Config.Tag, "reconnect: too many disconnects, staying out")
            return
        end
        server.QueueReload()
        for _ = 1, Config.ReconnectTries do
            local ok, err = pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
            if not ok then warn(Config.Tag, "reconnect:", err) end
            task.wait(Config.ReconnectRetry)
        end
    end)
end

function xDTaraZ.Server.Step()
    local server = xDTaraZ.Server
    if not server.ErrorConn and xDTaraZ.Util.Opt("AutoReconnect") then
        server.ErrorConn = xDTaraZ:Connect(GuiService.ErrorMessageChanged, server.OnError)
    end

    local want = false
    for _, idx in ipairs(xDTaraZ.Server.IdleKeepers) do
        if xDTaraZ.Util.Opt(idx) then want = true break end
    end
    if want ~= (xDTaraZ.Move.Conns.Idle ~= nil) then xDTaraZ.Move.BindIdle(want) end
end

function xDTaraZ.Server.Stop()
    xDTaraZ.Server.Hopping = false
end

xDTaraZ.Esp = { Boards = {}, Pool = {}, Anchors = {}, Made = {} }

---@return Color3  preset, or a hue by rank for rarities the game adds later
function xDTaraZ.Esp.Color(rarity)
    local preset = Config.RarityColors[rarity]
    if preset then return preset end
    local rank = GameLib.RarityRank[rarity]
    if not rank then return Color3.new(1, 1, 1) end
    return Color3.fromHSV(rank / math.max(#GameLib.RarityOrder, 1) * 0.85, 0.55, 1)
end

---@return table  { board, label, anchor } from the pool
function xDTaraZ.Esp.Take()
    local spare = table.remove(xDTaraZ.Esp.Pool)
    if spare then return spare end

    local anchor = Instance.new("Attachment")
    anchor.Name = "MarioEspAnchor"
    anchor.Parent = Workspace.Terrain

    local board = Instance.new("BillboardGui")
    board.Name = "MarioEsp"
    board.AlwaysOnTop = true
    board.Size = UDim2.fromOffset(xDTaraZ.Platform.Mobile and 150 or 200, xDTaraZ.Platform.Mobile and 30 or 40)
    board.StudsOffset = Vector3.new(0, Config.EspLift, 0)
    board.Adornee = anchor

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextStrokeTransparency = 0.3
    label.Parent = board
    board.Parent = xDTaraZ.World.Screen()
    local slot = { board = board, label = label, anchor = anchor }
    xDTaraZ.Esp.Made[slot] = true
    return slot
end

function xDTaraZ.Esp.Give(guid)
    local esp = xDTaraZ.Esp
    local slot = esp.Boards[guid]
    if not slot then return end
    esp.Boards[guid] = nil

    if #esp.Pool >= Config.EspPool then
        esp.Drop(slot)
        return
    end
    slot.board.Enabled = false
    table.insert(esp.Pool, slot)
end

---@param boards table  another module's board map
---@param key    string key in that map
function xDTaraZ.Esp.Disown(boards, key)
    local esp = xDTaraZ.Esp
    local slot = boards[key]
    if not slot then return end
    boards[key] = nil

    if #esp.Pool >= Config.EspPool then
        esp.Drop(slot)
        return
    end
    slot.board.Enabled = false
    table.insert(esp.Pool, slot)
end

---@return boolean  entry passes the rarity floor and is visible to us
function xDTaraZ.Esp.Shows(entry, minRank)
    if entry.removed or not entry.egg or typeof(entry.pos) ~= "Vector3" then return false end
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return false end
    local info = GameLib.EggInfo[entry.egg]
    return info ~= nil and (GameLib.RarityRank[info.rarity] or 1) >= minRank
end

function xDTaraZ.Esp.Drop(slot)
    xDTaraZ.Esp.Made[slot] = nil
    slot.board:Destroy()
    slot.anchor:Destroy()
end

function xDTaraZ.Esp.Step()
    if not xDTaraZ.State.Alive or not xDTaraZ.Util.Opt("EggEsp") then return end
    if not xDTaraZ.EggIndex.Start() then return end
    local esp = xDTaraZ.Esp
    local hrp = xDTaraZ.Player.Root
    local range = xDTaraZ.Platform.Mobile and Config.EspRangeMobile or Config.EspRange
    local minRank = GameLib.RarityRank[xDTaraZ.Util.Opt("EspMinRarity") or ""] or 1
    local seen = {}

    for guid, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if not esp.Shows(entry, minRank) then continue end
        local dist = hrp and (entry.pos - hrp.Position).Magnitude or 0
        if dist > range then continue end

        seen[guid] = true
        local slot = esp.Boards[guid]
        if not slot then
            slot = esp.Take()
            esp.Boards[guid] = slot
        end
        local info = GameLib.EggInfo[entry.egg]
        local mutation = entry.mutation and entry.mutation ~= "" and (" " .. entry.mutation) or ""
        slot.anchor.WorldPosition = entry.pos
        slot.board.MaxDistance = range
        slot.board.Enabled = true
        slot.label.TextColor3 = esp.Color(info.rarity)
        slot.label.Text = string.format("%s [%s]%s\n%.2fkg | %dm", entry.egg, info.rarity, mutation, entry.weight or 1, math.floor(dist))
    end

    for guid in pairs(esp.Boards) do
        if not seen[guid] then esp.Give(guid) end
    end
end

function xDTaraZ.Esp.Clear()
    local esp = xDTaraZ.Esp
    for slot in pairs(esp.Made) do
        esp.Drop(slot)
    end
    table.clear(esp.Boards)
    table.clear(esp.Pool)
end

function xDTaraZ.Esp.Stop()
    xDTaraZ.Esp.Clear()
end

do
    local defaults = {
        OwnPetReach = 25, BoostBatch = 400, FpsCapDefault = 240, FpsCapRestore = 60,
        BoostClasses = { ParticleEmitter = true, Trail = true, Beam = true, Smoke = true, Fire = true, Sparkles = true },
    }
    for key, value in pairs(defaults) do
        if Config[key] == nil then Config[key] = value end
    end
end

xDTaraZ.Visual = {
    Holder = Instance.new("Folder"),
    Conns = { Pets = {}, Eggs = {}, Boost = {} },
    Hidden = { Pets = {}, Eggs = {} },
    Disabled = {}, Props = {},
    BoostToken = 0,
    PetSetting = nil,
    CapOn = false,
}

function xDTaraZ.Visual.Drop(kind)
    local list = xDTaraZ.Visual.Conns[kind]
    for _, conn in ipairs(list) do conn:Disconnect() end
    table.clear(list)
end

function xDTaraZ.Visual.Watch(kind, signal, handler)
    table.insert(xDTaraZ.Visual.Conns[kind], xDTaraZ:Connect(signal, handler))
end

---@param kind string  "Pets" or "Eggs"
function xDTaraZ.Visual.Hide(kind, model)
    local hidden = xDTaraZ.Visual.Hidden[kind]
    if hidden[model] or not model.Parent then return end
    hidden[model] = model.Parent
    model.Parent = xDTaraZ.Visual.Holder
end

function xDTaraZ.Visual.Show(kind, model)
    local hidden = xDTaraZ.Visual.Hidden[kind]
    local home = hidden[model]
    if not home then return end
    hidden[model] = nil
    if model.Parent ~= xDTaraZ.Visual.Holder or not home.Parent then return end
    pcall(function() model.Parent = home end)
end

function xDTaraZ.Visual.ShowAll(kind)
    local models = {}
    for model in pairs(xDTaraZ.Visual.Hidden[kind]) do models[#models + 1] = model end
    for _, model in ipairs(models) do xDTaraZ.Visual.Show(kind, model) end
end

---@return boolean  true when the ridden pet belongs to someone else
function xDTaraZ.Visual.ForeignPet(model)
    if not model:IsA("Model") or model:GetAttribute("Ridden") ~= true then return false end
    local ownerId = model:GetAttribute("OwnerUserId")
    if ownerId ~= nil then return ownerId ~= LocalPlayer.UserId end
    local owner = model:GetAttribute("Owner")
    if owner ~= nil then return owner ~= LocalPlayer.UserId and owner ~= LocalPlayer.Name end

    local char = LocalPlayer.Character
    if char and model:IsDescendantOf(char) then return false end
    if LocalPlayer:GetAttribute("IsRiding") ~= true then return true end
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return (model:GetPivot().Position - hrp.Position).Magnitude > Config.OwnPetReach
end

function xDTaraZ.Visual.TrackPet(model)
    if not model:IsA("Model") then return end
    xDTaraZ.Visual.Watch("Pets", model:GetAttributeChangedSignal("Ridden"), function()
        if model:GetAttribute("Ridden") == true then
            if xDTaraZ.Visual.ForeignPet(model) then xDTaraZ.Visual.Hide("Pets", model) end
        else
            xDTaraZ.Visual.Show("Pets", model)
        end
    end)
    if xDTaraZ.Visual.ForeignPet(model) then xDTaraZ.Visual.Hide("Pets", model) end
end

function xDTaraZ.Visual.HidePets(on)
    xDTaraZ.Visual.Drop("Pets")
    local remote = xDTaraZ.GameLib.Remote("UpdateSetting")

    if not on then
        xDTaraZ.Visual.ShowAll("Pets")
        if remote and xDTaraZ.Visual.PetSetting ~= nil then remote:FireServer("ViewOtherPets", xDTaraZ.Visual.PetSetting) end
        xDTaraZ.Visual.PetSetting = nil
        return
    end

    if remote and xDTaraZ.Visual.PetSetting == nil then
        xDTaraZ.Visual.PetSetting = LocalPlayer:GetAttribute("Setting_ViewOtherPets") ~= false
        remote:FireServer("ViewOtherPets", false)
    end

    local objects = Workspace:FindFirstChild("GameObjects")
    if not objects then return end
    for _, model in ipairs(objects:GetChildren()) do xDTaraZ.Visual.TrackPet(model) end
    xDTaraZ.Visual.Watch("Pets", objects.ChildAdded, xDTaraZ.Visual.TrackPet)
end

function xDTaraZ.Visual.HideEggs(on)
    xDTaraZ.Visual.Drop("Eggs")
    if not on then return xDTaraZ.Visual.ShowAll("Eggs") end

    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return end
    for _, plot in ipairs(plots:GetChildren()) do
        local owner = plot:FindFirstChild("Data") and plot.Data:FindFirstChild("Owner")
        local eggs = plot:FindFirstChild("Eggs")
        if not owner or not eggs or owner.Value == LocalPlayer then continue end

        for _, egg in ipairs(eggs:GetChildren()) do
            if egg:IsA("Model") then xDTaraZ.Visual.Hide("Eggs", egg) end
        end
        xDTaraZ.Visual.Watch("Eggs", eggs.ChildAdded, function(egg)
            if egg:IsA("Model") and owner.Value ~= LocalPlayer then xDTaraZ.Visual.Hide("Eggs", egg) end
        end)
    end
end

---@param target Instance  property owner, original value saved once
function xDTaraZ.Visual.SetProp(target, prop, value)
    local key = target:GetFullName() .. "." .. prop
    local props = xDTaraZ.Visual.Props
    local ok, old = pcall(function() return target[prop] end)
    if not ok then return end
    if not props[key] then props[key] = { target, prop, old } end
    pcall(function() target[prop] = value end)
end

function xDTaraZ.Visual.Mute(inst)
    if not Config.BoostClasses[inst.ClassName] or xDTaraZ.Visual.Disabled[inst] ~= nil then return end
    local char = LocalPlayer.Character
    if char and inst:IsDescendantOf(char) then return end
    if not inst.Enabled then return end
    xDTaraZ.Visual.Disabled[inst] = true
    inst.Enabled = false
end

function xDTaraZ.Visual.Sweep(token)
    local list = Workspace:GetDescendants()
    for i, inst in ipairs(list) do
        if xDTaraZ.Visual.BoostToken ~= token then return end
        xDTaraZ.Visual.Mute(inst)
        if i % Config.BoostBatch == 0 then task.wait() end
    end
end

function xDTaraZ.Visual.Boost(on)
    xDTaraZ.Visual.Drop("Boost")
    xDTaraZ.Visual.BoostToken += 1

    if not on then
        for inst in pairs(xDTaraZ.Visual.Disabled) do
            if inst.Parent then pcall(function() inst.Enabled = true end) end
        end
        table.clear(xDTaraZ.Visual.Disabled)
        for _, row in pairs(xDTaraZ.Visual.Props) do
            pcall(function() row[1][row[2]] = row[3] end)
        end
        table.clear(xDTaraZ.Visual.Props)
        return
    end

    local lighting = game:GetService("Lighting")
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    xDTaraZ.Visual.SetProp(lighting, "GlobalShadows", false)
    for _, holder in ipairs({ lighting, Workspace.CurrentCamera }) do
        for _, effect in ipairs(holder and holder:GetChildren() or {}) do
            if effect:IsA("PostEffect") then xDTaraZ.Visual.SetProp(effect, "Enabled", false) end
        end
    end
    if terrain then
        xDTaraZ.Visual.SetProp(terrain, "Decoration", false)
        xDTaraZ.Visual.SetProp(terrain, "WaterWaveSize", 0)
        xDTaraZ.Visual.SetProp(terrain, "WaterReflectance", 0)
    end
    pcall(function() xDTaraZ.Visual.SetProp(settings().Rendering, "QualityLevel", Enum.QualityLevel.Level01) end)

    xDTaraZ.Visual.Watch("Boost", Workspace.DescendantAdded, xDTaraZ.Visual.Mute)
    task.spawn(xDTaraZ.Visual.Sweep, xDTaraZ.Visual.BoostToken)
end

---@return boolean  false when the executor cannot cap fps
---@return boolean  the cap was applied; turning it off puts back the cap the player had before
function xDTaraZ.Visual.Cap(on)
    local visual = xDTaraZ.Visual
    if on and not visual.CapOn then
        local ok, before = pcall(function() return getfpscap() end)
        visual.CapBefore = ok and tonumber(before) or nil
    end
    visual.CapOn = on
    local fps = on and (tonumber(xDTaraZ.Options.FpsCap) or Config.FpsCapDefault) or (visual.CapBefore or Config.FpsCapRestore)
    return xDTaraZ.Util.SetFpsCap(fps)
end

function xDTaraZ.Visual.Render(on)
    RunService:Set3dRenderingEnabled(not on)
end

function xDTaraZ.Visual.Stop()
    local try = xDTaraZ.Util.Try
    try("visual pets", xDTaraZ.Visual.HidePets, false)
    try("visual eggs", xDTaraZ.Visual.HideEggs, false)
    try("visual boost", xDTaraZ.Visual.Boost, false)
    if xDTaraZ.Visual.CapOn then try("visual cap", xDTaraZ.Visual.Cap, false) end
    try("visual render", xDTaraZ.Visual.Render, false)
end

do
    local defaults = {
        WebhookPattern = "^https://[%w%.]*discord[app]*%.com/api/webhooks/%d+/[%w_%-]+$",
        WebhookGap = 1.2, WebhookQueueMax = 20,
        WebhookLogo = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/main/logo.png",
        WebhookAvatarApi = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%d&size=150x150&format=Png",
        WebhookIcons = { Egg = "🥚", Server = "📡", Magma = "🌋", Pet = "🐾", Rebirth = "♻️", Kick = "⚠️", Report = "📊", Test = "✅", Fail = "🛑" },
        WebhookColors = { Egg = 0xE8A04C, Pet = 0x7DD87D, Magma = 0xFF5A2A, Server = 0xFF82E6, Rebirth = 0x5AB4FF, Kick = 0xE04848, Report = 0x9AA4B0, Test = 0xE8A04C, Fail = 0xE04848 },
    }
    for key, value in pairs(defaults) do
        if Config[key] == nil then Config[key] = value end
    end
end

xDTaraZ.Webhook = {
    Events = { "Rare Egg Picked", "Rare Egg In Server", "Magma Dip", "Pet Hatched", "Rebirth", "Egg Returned", "Kicked", "Status Report" },
    Queue = {}, Sending = false, Booted = false,
    SeenPets = {}, SeenEggs = {},
    LastReport = os.clock(), StartedAt = os.clock(),
    Avatar = nil, Baseline = nil, Conns = {},
    Counts = { Eggs = 0, Rare = 0, Dips = 0, Magma = 0, Pets = 0 },
}

---@return boolean  looks like a Discord webhook url
function xDTaraZ.Webhook.Valid(url)
    return type(url) == "string" and url:match(Config.WebhookPattern) ~= nil
end

function xDTaraZ.Webhook.Wants(event)
    local opt = xDTaraZ.Util.Opt
    if opt("Webhook") == false then return false end
    if not xDTaraZ.Webhook.Valid(opt("WebhookUrl")) then return false end
    local events = opt("WebhookEvents")
    return type(events) == "table" and events[event] == true
end

---@return number  embed colour, the event colour when the rarity has no preset
function xDTaraZ.Webhook.Color(rarity, kind)
    local color = rarity and Config.RarityColors and Config.RarityColors[rarity]
    if not color then return Config.WebhookColors[kind] or Config.WebhookColors.Report end
    return math.floor(color.R * 255) * 65536 + math.floor(color.G * 255) * 256 + math.floor(color.B * 255)
end

function xDTaraZ.Webhook.Duration(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours, minutes = math.floor(seconds / 3600), math.floor(seconds % 3600 / 60)
    if hours > 0 then return string.format("%dh %02dm", hours, minutes) end
    return string.format("%dm %02ds", minutes, seconds % 60)
end

---@return string|nil  headshot url, fetched once
function xDTaraZ.Webhook.AvatarUrl()
    local hook = xDTaraZ.Webhook
    if hook.Avatar ~= nil then return hook.Avatar or nil end
    hook.Avatar = false

    local body = xDTaraZ.Util.HttpGet(Config.WebhookAvatarApi:format(LocalPlayer.UserId))
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, body or "")
    local row = ok and type(decoded) == "table" and type(decoded.data) == "table" and decoded.data[1]
    if row and type(row.imageUrl) == "string" then hook.Avatar = row.imageUrl end
    return hook.Avatar or nil
end

---@return number
local function SavedNumber(name)
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local value = saved and saved:FindFirstChild(name)
    return value and tonumber(value.Value) or 0
end

function xDTaraZ.Webhook.Income()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    local income = stats and stats:FindFirstChild("Income/s")
    return income and tonumber(income.Value) or 0
end

---@return table  account and session lines shared by every alert
function xDTaraZ.Webhook.AccountFields()
    local hook = xDTaraZ.Webhook
    local counts, stats = hook.Counts, State.Stats
    local format = xDTaraZ.Util.Format
    return {
        { "💵 Cash", format(SavedNumber("Cash")) },
        { "📈 Income", format(hook.Income()) .. "/s" },
        { "♻️ Rebirths", SavedNumber("Rebirths") },
        { "🥚 Eggs (session)", stats.delivered .. " delivered, " .. counts.Rare .. " rare" },
        { "🌋 Magma (session)", counts.Magma .. " / " .. counts.Dips .. " dips" },
        { "⏱️ Session", hook.Duration(os.clock() - hook.StartedAt) .. " | " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. " players" },
    }
end

---@param event table  { Kind, Title, Lines?, Fields?, Rarity?, Ping?, Account?, Thumbnail? }
---@return string      json body
function xDTaraZ.Webhook.Build(event)
    local fields = {}
    for _, field in ipairs(event.Fields or {}) do
        fields[#fields + 1] = { name = field[1], value = tostring(field[2]), inline = field[3] ~= false }
    end
    if event.Account ~= false then
        table.insert(fields, { name = "\u{200B}", value = "**Account**", inline = false })
        for _, field in ipairs(xDTaraZ.Webhook.AccountFields()) do
            fields[#fields + 1] = { name = field[1], value = tostring(field[2]), inline = true }
        end
    end

    return HttpService:JSONEncode({
        username = "ZRHUB",
        avatar_url = Config.WebhookLogo,
        content = event.Ping and xDTaraZ.Util.Opt("WebhookPing") and "@everyone" or nil,
        embeds = { {
            author = { name = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")", icon_url = xDTaraZ.Webhook.AvatarUrl() },
            title = (Config.WebhookIcons[event.Kind] or "") .. " " .. event.Title,
            description = event.Lines and table.concat(event.Lines, "\n") or nil,
            color = xDTaraZ.Webhook.Color(event.Rarity, event.Kind),
            fields = fields,
            thumbnail = event.Thumbnail and { url = event.Thumbnail } or nil,
            footer = { text = "Mario Hub • Ride A Pet", icon_url = Config.WebhookLogo },
            timestamp = DateTime.now():ToIsoDate(),
        } },
    })
end

---@return boolean, string|nil  sent, or false and why
function xDTaraZ.Webhook.Post(url, json)
    local requester = (syn and syn.request) or (http and http.request) or http_request or request
    if not requester then return false, "no http function" end

    local ok, response = pcall(requester, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = json })
    if not ok or type(response) ~= "table" then return false, tostring(response) end
    local code = tonumber(response.StatusCode) or 0
    if code < 200 or code >= 300 then return false, "HTTP " .. code .. " " .. tostring(response.Body):sub(1, 120) end
    return true
end

function xDTaraZ.Webhook.Push(event)
    local queue = xDTaraZ.Webhook.Queue
    if #queue >= Config.WebhookQueueMax then table.remove(queue, 1) end
    queue[#queue + 1] = event
    xDTaraZ.Webhook.Flush()
end

function xDTaraZ.Webhook.Flush()
    local hook = xDTaraZ.Webhook
    if hook.Sending then return end
    hook.Sending = true

    task.spawn(function()
        local queue = hook.Queue
        for _ = 1, Config.WebhookQueueMax do
            if #queue == 0 or not State.Alive then break end
            local url = xDTaraZ.Util.Opt("WebhookUrl")
            if not hook.Valid(url) then
                table.clear(queue)
                break
            end

            local built, json = pcall(hook.Build, table.remove(queue, 1))
            local sent, why = false, json
            if built then sent, why = hook.Post(url, json) end
            if not sent then warn(Config.Tag, "webhook:", why) end
            task.wait(Config.WebhookGap)
        end
        hook.Sending = false
        if #queue > 0 and State.Alive then hook.Flush() end
    end)
end

---@return table|nil  GameLib.EggInfo row when it reaches the rarity floor picked in the menu
function xDTaraZ.Webhook.RareEgg(eggName)
    local info = GameLib.EggInfo[eggName or ""]
    if not info then return nil end
    local floor = GameLib.RarityRank[xDTaraZ.Util.Opt("WebhookEggRarity") or ""] or 1
    if (GameLib.RarityRank[info.rarity] or 0) < floor then return nil end
    return info
end

---@param entry table|nil  EggIndex entry
---@return table           fields for an egg embed
function xDTaraZ.Webhook.EggFields(eggName, entry)
    local info = GameLib.EggInfo[eggName] or {}
    local fields = {
        { "✨ Rarity", tostring(info.rarity or "?") },
        { "🍀 Luck", "1 in " .. xDTaraZ.Util.Format(info.luck or 0) },
    }
    if entry and entry.weight then fields[#fields + 1] = { "⚖️ Weight", string.format("%.2f", entry.weight) } end
    if entry and entry.mutation and entry.mutation ~= "" then fields[#fields + 1] = { "🧬 Mutation", entry.mutation } end
    if (info.growth or 0) > 0 then fields[#fields + 1] = { "⏳ Grow time", xDTaraZ.Webhook.Duration(info.growth) } end
    if info.volcanic then fields[#fields + 1] = { "🌋 Spawn", "Inside the volcano" } end
    return fields
end

---@param guid string|nil
---@param text any         server reply text, used when the guid is not indexed
function xDTaraZ.Webhook.EggPicked(guid, text)
    local hook = xDTaraZ.Webhook
    local entry = guid and xDTaraZ.EggIndex.Entries[guid]
    local eggName = entry and entry.egg or (type(text) == "string" and text) or nil
    hook.Counts.Eggs += 1

    local info = hook.RareEgg(eggName)
    if not info then return end
    hook.Counts.Rare += 1
    if not hook.Wants("Rare Egg Picked") then return end

    hook.Push({
        Kind = "Egg",
        Title = "Picked up " .. eggName,
        Lines = { "On the way home." },
        Fields = hook.EggFields(eggName, entry),
        Rarity = info.rarity,
        Ping = GameLib.RarityRank[info.rarity] == #GameLib.RarityOrder,
    })
end

---@param egg Instance|table  ActiveEggs child or EggIndex entry
function xDTaraZ.Webhook.EggSpawned(egg)
    local hook = xDTaraZ.Webhook
    local entry = type(egg) == "table" and egg or (typeof(egg) == "Instance" and xDTaraZ.EggIndex.Entries[egg.Name])
    if not entry or not entry.guid or hook.SeenEggs[entry.guid] then return end
    if entry.dropEndsAt then return end
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return end
    if not hook.Wants("Rare Egg In Server") then return end

    local info = hook.RareEgg(entry.egg)
    if not info then return end
    hook.SeenEggs[entry.guid] = true

    local fields = hook.EggFields(entry.egg, entry)
    fields[#fields + 1] = { "🆔 Server", "`" .. game.JobId .. "`", false }
    hook.Push({
        Kind = "Server",
        Title = entry.egg .. " spawned",
        Lines = { "A " .. info.rarity .. " egg is on the map in your server." },
        Fields = fields,
        Rarity = info.rarity,
        Ping = true,
    })
end

---@param reply table  VolcanoDipResult payload, already ours
function xDTaraZ.Webhook.Dipped(reply)
    local hook = xDTaraZ.Webhook
    local counts = hook.Counts
    counts.Dips += 1
    if reply.Success then counts.Magma += 1 end
    if not reply.Success or not hook.Wants("Magma Dip") then return end

    local eggName = tostring(reply.Egg)
    local info = GameLib.EggInfo[eggName] or {}
    hook.Push({
        Kind = "Magma",
        Title = eggName .. " became " .. tostring(reply.Mutation),
        Lines = { "The volcano dip worked." },
        Fields = {
            { "✨ Rarity", tostring(info.rarity or "?") },
            { "⚖️ Weight", string.format("%.2f", tonumber(reply.Weight) or 0) },
            { "🎲 Hit rate", string.format("%d / %d (%.0f%%)", counts.Magma, counts.Dips, counts.Magma / counts.Dips * 100) },
        },
        Rarity = info.rarity,
    })
end

function xDTaraZ.Webhook.PetAdded(tool)
    local hook = xDTaraZ.Webhook
    if not tool:IsA("Tool") then return end
    local key = tool:GetAttribute("PetKey")
    if not key or hook.SeenPets[key] then return end
    hook.SeenPets[key] = true
    hook.Counts.Pets += 1
    if not hook.Wants("Pet Hatched") then return end

    local petName = tool:GetAttribute("PetName") or tool.Name
    local info = GameLib.PetInfo[petName]
    local rarity = info and info.rarity or "?"
    local floor = GameLib.RarityRank[xDTaraZ.Util.Opt("WebhookPetRarity") or ""] or 1
    if (GameLib.RarityRank[rarity] or 0) < floor then return end

    local fields = {
        { "✨ Rarity", rarity },
        { "💰 Income", xDTaraZ.Util.Format(info and info.income or 0) .. "/s" },
    }
    local weight = tonumber(tool:GetAttribute("Weight") or tool:GetAttribute("BaseWeight"))
    if weight then table.insert(fields, { "⚖️ Weight", string.format("%.2f", weight) }) end
    for _, attr in ipairs({ "Mutation", "SpawnMutation" }) do
        local mutation = tool:GetAttribute(attr)
        if mutation and mutation ~= "" then fields[#fields + 1] = { "🧬 " .. (attr == "Mutation" and "Mutation" or "Spawn Mutation"), mutation } end
    end
    fields[#fields + 1] = { "🐾 New pets (session)", hook.Counts.Pets }

    hook.Push({
        Kind = "Pet",
        Title = "New pet: " .. petName,
        Fields = fields,
        Rarity = rarity,
        Ping = GameLib.RarityRank[rarity] == #GameLib.RarityOrder,
    })
end

---@param _plan table|nil  State.LastFail from Guard; mechanics stay out of Discord
function xDTaraZ.Webhook.DeliveryFailed(_plan)
    if not xDTaraZ.Webhook.Wants("Egg Returned") then return end
    xDTaraZ.Webhook.Push({
        Kind = "Fail",
        Title = "Egg farming stopped",
        Lines = { "An egg was returned, so egg farming switched itself off. Turn it back on in the menu to continue." },
        Fields = {
            { "📦 Delivered", State.Stats.delivered },
            { "❌ Lost", State.Stats.lost },
        },
        Ping = true,
    })
end

function xDTaraZ.Webhook.Snapshot()
    local counts = xDTaraZ.Webhook.Counts
    return { Cash = SavedNumber("Cash"), Eggs = State.Stats.delivered, Magma = counts.Magma, Pets = counts.Pets, At = os.clock() }
end

function xDTaraZ.Webhook.Report()
    local hook = xDTaraZ.Webhook
    local minutes = tonumber(xDTaraZ.Util.Opt("WebhookReportMins")) or 0
    if minutes <= 0 or os.clock() - hook.LastReport < minutes * 60 then return end
    if not hook.Wants("Status Report") then return end
    hook.LastReport = os.clock()

    local now = hook.Snapshot()
    local before = hook.Baseline or now
    hook.Baseline = now
    local span = math.max(now.At - before.At, 1)
    local gained = now.Cash - before.Cash
    local format = xDTaraZ.Util.Format

    hook.Push({
        Kind = "Report",
        Title = "Status report",
        Lines = { "**Doing:** " .. tostring(State.Status.Eggs or "Idle") },
        Fields = {
            { "💵 Cash gained", (gained >= 0 and "+" or "") .. format(gained) },
            { "⚡ Cash / hour", format(gained / span * 3600) },
            { "🥚 Eggs", "+" .. (now.Eggs - before.Eggs) },
            { "🌋 Magma", "+" .. (now.Magma - before.Magma) },
            { "🐾 New pets", "+" .. (now.Pets - before.Pets) },
            { "🕒 Window", hook.Duration(span) },
        },
    })
end

---@param message string  disconnect text; posted at once, the queue dies with the session
function xDTaraZ.Webhook.Kicked(message)
    if not xDTaraZ.Webhook.Wants("Kicked") then return end
    local built, json = pcall(xDTaraZ.Webhook.Build, {
        Kind = "Kick",
        Title = "Disconnected",
        Lines = { "```" .. tostring(message):sub(1, 500) .. "```" },
        Ping = true,
    })
    if built then xDTaraZ.Webhook.Post(xDTaraZ.Util.Opt("WebhookUrl"), json) end
end

---@return boolean  false when the url is not a Discord webhook
---@return boolean, string|nil  Discord accepted it, or false and why
function xDTaraZ.Webhook.Test()
    local url = xDTaraZ.Util.Opt("WebhookUrl")
    if not xDTaraZ.Webhook.Valid(url) then return false, "Paste a Discord webhook URL first" end

    local built, json = pcall(xDTaraZ.Webhook.Build, { Kind = "Test", Title = "Webhook connected", Lines = { "Alerts from Mario Hub will show up here." } })
    if not built then return false, tostring(json) end
    local sent, why = xDTaraZ.Webhook.Post(url, json)
    if sent then return true end
    if tostring(why):find("HTTP 404", 1, true) then return false, "Discord says this webhook does not exist" end
    return false, why
end

---@param signal RBXScriptSignal|table  Roblox signal or an xDTaraZ.Signal
function xDTaraZ.Webhook.Listen(signal, fn)
    if getmetatable(signal) == xDTaraZ.Signal then
        local off = signal:Connect(fn)
        table.insert(xDTaraZ.Webhook.Conns, { Disconnect = off })
        return
    end
    local conn = xDTaraZ:Connect(signal, fn)
    table.insert(xDTaraZ.Webhook.Conns, conn)
end

function xDTaraZ.Webhook.MarkPets(container)
    for _, tool in ipairs(container and container:GetChildren() or {}) do
        local key = tool:GetAttribute("PetKey")
        if key then xDTaraZ.Webhook.SeenPets[key] = true end
    end
end

function xDTaraZ.Webhook.WatchBackpack(backpack)
    xDTaraZ.Webhook.MarkPets(backpack)
    xDTaraZ.Webhook.Listen(backpack.ChildAdded, xDTaraZ.Webhook.PetAdded)
end

function xDTaraZ.Webhook.WatchGame()
    local hook, index = xDTaraZ.Webhook, xDTaraZ.EggIndex
    hook.Listen(index.OnReply, function(kind, guid, text)
        if kind == "PickedUp" then hook.EggPicked(guid, text) end
    end)
    hook.Listen(index.OnAdded, function(entry) task.defer(hook.EggSpawned, entry) end)

    local dip = GameLib.Remote("VolcanoDipResult")
    if dip then
        hook.Listen(dip.OnClientEvent, function(reply)
            if type(reply) ~= "table" then return end
            if reply.Owner ~= LocalPlayer.UserId and reply.Owner ~= LocalPlayer then return end
            hook.Dipped(reply)
        end)
    end

    local saved = LocalPlayer:FindFirstChild("SavedData")
    local rebirths = saved and saved:FindFirstChild("Rebirths")
    if rebirths then
        hook.Listen(rebirths.Changed, function(value)
            if not hook.Wants("Rebirth") then return end
            hook.Push({ Kind = "Rebirth", Title = "Rebirth " .. tostring(value) .. " done", Lines = { "Cash and luck reset, +1 pet slot." } })
        end)
    end

    hook.Listen(GuiService.ErrorMessageChanged, function()
        local message = GuiService:GetErrorMessage()
        if message ~= "" then task.spawn(hook.Kicked, message) end
    end)
end

function xDTaraZ.Webhook.Boot()
    local hook = xDTaraZ.Webhook
    if hook.Booted then return end
    hook.Booted = true

    hook.MarkPets(xDTaraZ.Player.Char)
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then hook.WatchBackpack(backpack) end
    hook.Listen(LocalPlayer.ChildAdded, function(child)
        if child:IsA("Backpack") then hook.WatchBackpack(child) end
    end)

    hook.WatchGame()
    hook.Baseline = hook.Snapshot()
    task.spawn(hook.AvatarUrl)
end

function xDTaraZ.Webhook.Step()
    local hook = xDTaraZ.Webhook
    if not hook.Booted then hook.Boot() end
    hook.Report()
end

function xDTaraZ.Webhook.Stop()
    local hook = xDTaraZ.Webhook
    for _, conn in ipairs(hook.Conns) do
        conn:Disconnect()
    end
    table.clear(hook.Conns)
    table.clear(hook.Queue)
    hook.Booted = false
end

xDTaraZ.Kaitun = {
    Running = false,
    Saved = {},
    Steered = nil,
    SteerKey = nil,
    SteerAt = 0,
}

---@param value any
function xDTaraZ.Kaitun.Set(idx, value)
    xDTaraZ.Options[idx] = value
    table.insert(xDTaraZ.State.PendingSet, { idx, value })
end

---@return any  a copy safe to store, tables shallow copied
function xDTaraZ.Kaitun.Snapshot(value)
    if type(value) ~= "table" then return value end
    local copy = {}
    for key, entry in pairs(value) do
        copy[key] = entry
    end
    return copy
end

function xDTaraZ.Kaitun.Start()
    if xDTaraZ.Kaitun.Running then return end
    xDTaraZ.Kaitun.Running = true
    table.clear(xDTaraZ.Kaitun.Saved)

    local remember = { "HuntMinRarity", "EggRarities", "MinEggRarity" }
    for _, idx in ipairs(xDTaraZ.Config.KaitunToggles) do
        table.insert(remember, idx)
    end
    for _, idx in ipairs(remember) do
        xDTaraZ.Kaitun.Saved[idx] = { xDTaraZ.Kaitun.Snapshot(xDTaraZ.Util.Opt(idx)) }
    end

    xDTaraZ.Kaitun.Set("HuntMinRarity", xDTaraZ.Config.KaitunHuntRarity)
    xDTaraZ.Kaitun.Set("MinEggRarity", xDTaraZ.GameLib.RarityOrder[1])
    for _, idx in ipairs(xDTaraZ.Config.KaitunToggles) do
        if not xDTaraZ.GameLib.Blocked(idx) then xDTaraZ.Kaitun.Set(idx, true) end
    end
    xDTaraZ.Kaitun.SteerAt = 0
end

function xDTaraZ.Kaitun.Stop()
    if not xDTaraZ.Kaitun.Running then return end
    xDTaraZ.Kaitun.Running = false

    for idx, boxed in pairs(xDTaraZ.Kaitun.Saved) do
        xDTaraZ.Kaitun.Set(idx, boxed[1] == nil and false or boxed[1])
    end
    table.clear(xDTaraZ.Kaitun.Saved)
    xDTaraZ.Kaitun.Steered = nil
    xDTaraZ.Kaitun.SteerKey = nil
    xDTaraZ.State.Status.Kaitun = "Off"
end

---@return table|nil  { [rarity] = true } of eggs that can hatch this pet, nil when none can
function xDTaraZ.Kaitun.RaritiesFor(pet)
    local mult = xDTaraZ.Economy.LuckMult()
    local wanted, any = {}, false

    for egg, info in pairs(xDTaraZ.GameLib.EggInfo) do
        if info.volcanic then continue end
        local odds = xDTaraZ.GameLib.Odds(egg, mult)
        for _, row in ipairs(odds or {}) do
            if row[1] == pet and row[2] > 0 then
                wanted[info.rarity] = true
                any = true
                break
            end
        end
    end
    return any and wanted or nil
end

---@return string  what the steer is chasing, for the status line
function xDTaraZ.Kaitun.Steer()
    local reached = xDTaraZ.Economy.RebirthPlan().reason == "target reached"
    if reached and xDTaraZ.Util.Opt("EggHunter") then xDTaraZ.Kaitun.Set("EggHunter", false) end
    local pet = not reached and xDTaraZ.Economy.NextRequirement() or nil
    local missing = pet and not xDTaraZ.Economy.OwnedPet(pet)
    local key = missing and (pet .. "@" .. math.floor(xDTaraZ.Economy.LuckMult())) or "none"

    local due = os.clock() - xDTaraZ.Kaitun.SteerAt >= xDTaraZ.Config.KaitunSteerEvery
    if key == xDTaraZ.Kaitun.SteerKey and not due then
        return missing and ("Hunting " .. pet) or "Farming"
    end
    xDTaraZ.Kaitun.SteerKey = key
    xDTaraZ.Kaitun.SteerAt = os.clock()

    local rarities = missing and xDTaraZ.Kaitun.RaritiesFor(pet)
    if rarities then
        xDTaraZ.Kaitun.Steered = rarities
        xDTaraZ.Kaitun.Set("EggRarities", rarities)
        return "Hunting " .. pet
    end

    if xDTaraZ.Kaitun.Steered then
        local saved = xDTaraZ.Kaitun.Saved.EggRarities
        xDTaraZ.Kaitun.Set("EggRarities", saved and xDTaraZ.Kaitun.Snapshot(saved[1]) or {})
        xDTaraZ.Kaitun.Steered = nil
    end
    return "Farming"
end

function xDTaraZ.Kaitun.Step()
    if not xDTaraZ.Kaitun.Running then return end
    local doing = xDTaraZ.Kaitun.Steer()

    local plan = xDTaraZ.Economy.Plan
    local rebirths = xDTaraZ.Economy.Rebirths() .. "/" .. (xDTaraZ.GameLib.Rebirths.Cap or 0)
    xDTaraZ.State.Status.Kaitun = doing .. " | Rebirth " .. rebirths .. (plan ~= "" and (" | " .. plan) or "")
end

function xDTaraZ.Kaitun.Status()
    return xDTaraZ.State.Status.Kaitun or "Off"
end

local function T(en, th)
    return Library:T(en, th)
end

xDTaraZ.UI = { Labels = {}, Shown = {} }

xDTaraZ.UI.WebhookEvents = {
    "Rare Egg Picked", "Rare Egg In Server", "Egg Returned", "Magma Dip", "Pet Hatched",
    "Rebirth", "Boost Started", "Kicked", "Status Report",
}

xDTaraZ.UI.Floats = { { "Fly", "Fly" }, { "NoClip", "Clip" }, { "SpeedOn", "Run" }, { "EggEsp", "ESP" } }

---@param module string    root module name
---@param group  string[]  toggles sharing that module; Stop runs when all are off
---@return function
function xDTaraZ.UI.Shared(module, group)
    return function(on)
        local mod = rawget(xDTaraZ, module)
        if not mod then return end
        if on then
            if mod.Start then mod.Start() end
            return
        end
        for _, idx in ipairs(group) do
            if xDTaraZ.Options[idx] then return end
        end
        if mod.Stop then mod.Stop() end
    end
end

---@return function
function xDTaraZ.UI.Switch(module)
    return function(on)
        local mod = xDTaraZ[module]
        if on then mod.Start() else mod.Stop() end
    end
end

---@return function
function xDTaraZ.UI.MoveHook(idx)
    return function(on) xDTaraZ.Move.Set(idx, on) end
end

---@return function
function xDTaraZ.UI.TrollHook(idx)
    return function(on) xDTaraZ.Troll.Set(idx, on) end
end

do
    local ui, shared = xDTaraZ.UI, xDTaraZ.UI.Shared
    local volcano = { "VolcanoDip", "VolcanoObby" }
    local hatch = { "AutoPlaceEggs", "AutoHatch" }
    local pets = { "AutoEquipBest", "AutoCollectCash", "AutoFeed" }
    local economy = { "AutoUpgrade", "AutoRebirth", "SmartSpend" }
    local halloween = { "AutoCandy", "AutoTrickOrTreat", "AutoPumpkin", "AutoHalloweenEgg", "AutoRitual" }

    ui.Hooks = {
        InstantPrompt = ui.Switch("Prompts"),
        AutoEggs = ui.Switch("Eggs"),
        EggHunter = ui.Switch("Hunter"),
        VolcanoDip = shared("Volcano", volcano),
        VolcanoObby = shared("Volcano", volcano),
        AutoCandy = shared("Halloween", halloween),
        AutoTrickOrTreat = shared("Halloween", halloween),
        AutoPumpkin = shared("Halloween", halloween),
        AutoHalloweenEgg = shared("Halloween", halloween),
        AutoRitual = shared("Halloween", halloween),
        HalloweenEsp = function(on)
            if not on then xDTaraZ.Halloween.ClearEsp() end
        end,
        AutoPlaceEggs = shared("Hatch", hatch),
        AutoHatch = shared("Hatch", hatch),
        ClearJunk = function(on)
            if on then
                xDTaraZ.Eggs.QuietInventory(true)
                xDTaraZ.Junk.Start()
                return
            end
            xDTaraZ.Junk.Stop()
            task.spawn(xDTaraZ.Eggs.Settle)
        end,
        AutoEquipBest = shared("Pets", pets),
        AutoCollectCash = shared("Pets", pets),
        AutoFeed = shared("Pets", pets),
        AutoSell = ui.Switch("Sell"),
        AutoFusion = ui.Switch("Fusion"),
        AutoShop = shared("Shop", { "AutoShop" }),
        AutoUpgrade = shared("Economy", economy),
        AutoRebirth = shared("Economy", economy),
        SmartSpend = shared("Economy", economy),
        AutoClaim = shared("Rewards", { "AutoClaim" }),
        Kaitun = ui.Switch("Kaitun"),
        EggEsp = function(on) if not on then xDTaraZ.Esp.Clear() end end,
        Fling = ui.TrollHook("Fling"),
        Stick = ui.TrollHook("Stick"),
        HideOtherPets = xDTaraZ.Visual.HidePets,
        HideOtherEggs = xDTaraZ.Visual.HideEggs,
        BoostFps = xDTaraZ.Visual.Boost,
        Render3D = xDTaraZ.Visual.Render,
        UnlockFps = function(on)
            if xDTaraZ.Visual.Cap(on) or not on then return end
            Library.Compat.Block("UnlockFps", T("Not supported on this executor", "executor นี้ไม่รองรับ"))
        end,
        FpsCap = function()
            if xDTaraZ.Options.UnlockFps then xDTaraZ.Visual.Cap(true) end
        end,
    }
    for _, idx in ipairs({ "SpeedOn", "JumpOn", "Fly", "NoClip", "InfJump", "AntiAfk" }) do
        ui.Hooks[idx] = ui.MoveHook(idx)
    end
end

---@return function  runs fn on its own thread so game calls never taint the UI thread
function xDTaraZ.UI.Detach(label, fn)
    return function(...)
        local args = table.pack(...)
        task.spawn(function()
            xDTaraZ.Util.Try("ui " .. label, fn, table.unpack(args, 1, args.n))
        end)
    end
end

---@return table  the option, mirrored into xDTaraZ.Options
function xDTaraZ.UI.Bind(idx, option)
    xDTaraZ.Options[idx] = option.Value
    option:OnChanged(function(value)
        xDTaraZ.Options[idx] = value
        if value == true then xDTaraZ.Scheduler.Resume(idx) end

        local hook = xDTaraZ.UI.Hooks[idx]
        if hook then task.spawn(xDTaraZ.Util.Try, "toggle " .. idx, hook, value == true) end
    end)
    return option
end

function xDTaraZ.UI.Toggle(group, idx, info)
    info.Default = false
    return xDTaraZ.UI.Bind(idx, group:AddToggle(idx, info))
end

---@return table  toggle; the key picker is saved as "<idx>Key"
function xDTaraZ.UI.KeyToggle(group, idx, info)
    local toggle = xDTaraZ.UI.Toggle(group, idx, info)
    toggle:AddKeyPicker(idx .. "Key", { Default = "None", Mode = "Toggle" })
    return toggle
end

function xDTaraZ.UI.CarryGuard(option)
    if type(option.AddGuard) ~= "function" then return end
    option:AddGuard(function(value)
        if value ~= true or xDTaraZ.Player:BasketCount() == 0 then return true end
        Library:Notify("ZRHUB", T("Finish the egg delivery first", "ส่งไข่ให้เสร็จก่อน"), 4, "Warning")
        task.defer(option.SetValue, option, false)
        return false
    end)
end

function xDTaraZ.UI.Status(group, key, fallback)
    local label = group:AddLabel(fallback)
    table.insert(xDTaraZ.UI.Labels, { label, key, fallback })
    return label
end

---@return table  list from a builder, empty when it errors
function xDTaraZ.UI.Values(source)
    local ok, list = pcall(source)
    return ok and type(list) == "table" and list or {}
end

---@return string[]
function xDTaraZ.UI.Rarities()
    return table.clone(xDTaraZ.GameLib.RarityOrder)
end

---@return string  "Mythic" when the game has it, else the rarest one
function xDTaraZ.UI.HuntDefault()
    local order = xDTaraZ.GameLib.RarityOrder
    if xDTaraZ.GameLib.RarityRank.Mythic then return "Mythic" end
    return order[#order]
end

---@return string[]  sorted keys of a GameLib table
function xDTaraZ.UI.Names(source)
    local names = {}
    for name in pairs(source) do
        names[#names + 1] = name
    end
    table.sort(names)
    return names
end

---@return string[]  "Auto (fastest)" then every ridable pet tool we hold
function xDTaraZ.UI.RideNames()
    local names = xDTaraZ.UI.Names(xDTaraZ.Mount.Tools())
    table.insert(names, 1, xDTaraZ.Mount.AutoLabel)
    return names
end

function xDTaraZ.UI.Pump()
    local sets = State.PendingSet
    if sets and #sets > 0 then
        State.PendingSet = {}
        for _, row in ipairs(sets) do
            local option = Library.Options[row[1]]
            if option then option:SetValue(row[2]) end
        end
    end
    xDTaraZ.Scheduler.Pump()

    local shown = xDTaraZ.UI.Shown
    for _, row in ipairs(xDTaraZ.UI.Labels) do
        local text = State.Status[row[2]] or row[3]
        if shown[row[1]] == text then continue end
        shown[row[1]] = text
        row[1]:SetText(text)
    end

    local stats = State.Stats
    local line = string.format("Delivered %d | Lost %d", stats.delivered, stats.lost)
    if State.Status.WaveAt then
        local left = math.max(0, math.floor(State.Status.WaveAt - os.clock()))
        line ..= string.format(" | Wave in %d:%02d | %s", math.floor(left / 60), left % 60, State.Status.EggRate or "0/min")
    end
    if shown.Rate ~= line and xDTaraZ.UI.RateLabel then
        shown.Rate = line
        xDTaraZ.UI.RateLabel:SetText(line)
    end
end

function xDTaraZ.UI.Gate()
    local blocked = 0
    for idx in pairs(xDTaraZ.GameLib.Needs) do
        local reason = xDTaraZ.GameLib.Blocked(idx)
        if not reason or not Library.Options[idx] then continue end
        blocked += 1
        warn(Config.Tag, idx .. " blocked:", reason)
        Library.Compat.Block(idx, T("The game changed, waiting for a script update", "เกมอัปเดต รอสคริปต์อัปเดต"))
    end
    if blocked == 0 then return end
    Library:Notify("ZRHUB", T(blocked .. " features are off until the next update", "ปิดไว้ " .. blocked .. " ฟีเจอร์ จนกว่าจะอัปเดต"), 8, "Warning")
end

return xDTaraZ
end)()

local v359 = {}

f50(autoFarmTab, "Main", function()
  -- ===== Collect Eggs + Egg Filters (new egg engine) =====
  do
    local M = MarioCore
    local UI, Config, State = M.UI, M.Config, M.State
    local try = M.Util.Try
    local obsTab = autoFarmTab._obs

    try("gamelib load", M.GameLib.LoadModules)
    try("gamelib build", M.GameLib.Build)
    local rarities = UI.Rarities()

    local farm = obsTab:AddLeftGroupbox("Collect Eggs", "egg")
    UI.RateLabel = farm:AddLabel("Delivered 0 | Lost 0")
    UI.Status(farm, "Eggs", "Egg farm is off")
    UI.Toggle(farm, "AutoEggs", { Text = "Auto Collect Eggs", Tooltip = "Brings every wanted egg on the map home" })
    farm:AddButton({ Text = "Collect Now", Func = UI.Detach("collect now", M.Eggs.CollectNow) })
      :AddButton({ Text = "Exit Now", Func = UI.Detach("exit now", M.Eggs.ExitNow) })
    UI.Toggle(farm, "ReturnAfter", { Text = "Wait At Home", Tooltip = "Waits at your plot between waves" })
    UI.Bind("DeliveryMode", farm:AddDropdown("DeliveryMode", { Text = "Delivery", Values = { "Auto", "Safe" }, Default = "Auto" }))

    local ride = UI.Bind("RidePet", farm:AddDropdown("RidePet", { Text = "Ride Pet", Values = UI.RideNames(), Default = M.Mount.AutoLabel, Searchable = true }))
    farm:AddButton({ Text = "Refresh Ride Pets", Func = function()
      ride:SetValues(UI.RideNames())
      M.Mount.Dirty = true
    end })

    UI.Bind("EggRoute", farm:AddDropdown("EggRoute", {
      Text = "Collection Route", Values = { "Fast nearby", "Best yield" }, Default = "Fast nearby",
      Tooltip = "Fast nearby uses short returns; Best yield also goes for far eggs",
    }))
    local settle = UI.Bind("DropSettle", farm:AddSlider("DropSettle", { Text = "Delivery Safety", Min = 0.2, Max = 0.45, Default = 0.2, Rounding = 2, Suffix = "s" }))
    settle:OnChanged(function(value)
      State.Tune.DropSettle = math.clamp(tonumber(value) or Config.DropSettle, Config.DropSettle, 0.45)
    end)
    local contest = UI.Bind("ContestWeight", farm:AddSlider("ContestWeight", { Text = "Beat Other Players", Min = 0, Max = Config.ContestWeightMax, Default = Config.ContestWeight, Rounding = 1 }))
    contest:OnChanged(function(value)
      State.Tune.ContestWeight = math.clamp(tonumber(value) or Config.ContestWeight, 0, Config.ContestWeightMax)
    end)

    -- Movement: Teleport (original) or Tween (glides instead of teleporting)
    do
      local baseTp, baseTravel = M.Tasks.Teleport, M.Tasks.Travel
      local travelling = false
      M.Tasks.Travel = function(...)
        local was = travelling
        travelling = true
        local ok, res = pcall(baseTravel, ...)
        travelling = was
        if not ok then error(res, 0) end
        return res
      end
      local eggOwners = { Eggs = true, Hunter = true, Recover = true }
      M.Tasks.Teleport = function(token, cf)
        if travelling or M.Options.EggMovement ~= "Tween" or not token or not eggOwners[token.owner] then
          return baseTp(token, cf)
        end
        local root = M.Player.Root
        if not root or typeof(cf) ~= "CFrame" then return baseTp(token, cf) end
        local dist = (cf.Position - root.Position).Magnitude
        if dist < 6 then return baseTp(token, cf) end
        local function speed()
          local s = tonumber(M.Options.TweenSpeed) or 250
          -- while carrying an egg never go faster than the safe carry speed
          if M.Player:BasketCount() > 0 then
            local carry = M.Mount.TravelSpeed()
            if carry <= 0 then carry = Config.UnmountedPlayerSpeed end
            s = math.min(s, carry)
          end
          return s
        end
        local reached = M.Tasks.Travel(token, cf, speed, dist / math.max(speed(), 1) + 3, { noClip = true, reach = 2 })
        if not reached and not M.Tasks.Holds(token) then return false end
        return baseTp(token, cf)   -- final small snap onto the exact spot
      end
    end
    UI.Bind("EggMovement", farm:AddDropdown("EggMovement", {
      Text = "Movement", Values = { "Teleport", "Tween" }, Default = "Teleport",
      Tooltip = "Teleport = original (fastest). Tween = glides to eggs and home instead of teleporting",
    }))
    UI.Bind("TweenSpeed", farm:AddSlider("TweenSpeed", {
      Text = "Tween Speed", Min = 50, Max = 1000, Default = 250, Rounding = 0,
      Tooltip = "Only for Tween. While carrying an egg it never goes faster than the safe Carry Speed",
    }))

    -- Carry Speed: scales how fast it rides home with the egg (1x = your pet's real speed)
    do
      local baseTravel = M.Mount.TravelSpeed
      M.Mount.TravelSpeed = function(...)
        return baseTravel(...) * math.clamp(tonumber(M.Options.CarrySpeed) or 1, 0.5, 1.3)
      end
    end
    UI.Bind("CarrySpeed", farm:AddSlider("CarrySpeed", {
      Text = "Carry Speed", Min = 0.5, Max = 1.3, Default = 1, Rounding = 2, Suffix = "x",
      Tooltip = "How fast it rides home with the egg. 1x = your pet's real speed. Capped at 1.3x, and drops back to 1x by itself if an egg gets lost",
    }))
    -- safety: if an egg is lost while sped up, go back to 1x
    task.spawn(function()
      local lastLost = State.Stats and State.Stats.lost or 0
      while State.Alive ~= false and not ZR_MarioLib._dead do
        task.wait(1)
        local lost = State.Stats and State.Stats.lost or 0
        if lost > lastLost and (tonumber(M.Options.CarrySpeed) or 1) > 1 then
          pcall(function() ZR_Obs.Options.CarrySpeed:SetValue(1) end)
          ZR_Obs:Notify({ Title = "Carry Speed", Description = "An egg was lost while sped up, so Carry Speed went back to 1x.", Time = 6 })
        end
        lastLost = lost
      end
    end)

    local filters = obsTab:AddRightGroupbox("Egg Filters", "filter")
    local minDrop = UI.Bind("MinEggRarity", filters:AddDropdown("MinEggRarity", { Text = "Minimum Egg Rarity", Values = rarities, Default = rarities[1], Tooltip = "Skips eggs below this rarity" }))
    local rarityDrop = UI.Bind("EggRarities", filters:AddDropdown("EggRarities", { Text = "Rarities (empty = all)", Values = rarities, Multi = true, Default = {} }))
    local nameDrop = UI.Bind("EggNames", filters:AddDropdown("EggNames", { Text = "Eggs (empty = all)", Values = UI.Names(M.GameLib.EggInfo), Multi = true, Searchable = true, Default = {} }))
    UI.Bind("MinLuck", filters:AddSlider("MinLuck", { Text = "Minimum Luck (1 in X)", Min = 0, Max = 1000000, Default = 0, Rounding = 0 }))
    UI.Bind("MinWeight", filters:AddSlider("MinWeight", { Text = "Minimum Weight", Min = 1, Max = 3, Default = 1, Rounding = 1, Suffix = "x" }))
    UI.Toggle(filters, "SmartEggs", { Text = "Top Eggs Of The Wave", Tooltip = "Skips eggs worth less than the wave average" })
    filters:AddButton({ Text = "Refresh Egg List", Func = function()
      M.GameLib.Build()
      minDrop:SetValues(UI.Rarities())
      rarityDrop:SetValues(UI.Rarities())
      nameDrop:SetValues(UI.Names(M.GameLib.EggInfo))
    end })

    -- Egg Checker: tells you why each egg on the map is or isn't being collected
    local function eggReport()
      local idx, lib, opts = M.EggIndex, M.GameLib, M.Options
      pcall(M.Planner.Rebuild)
      local modeOf = {}
      for _, pick in ipairs(M.Planner.Ranked or {}) do modeOf[pick[1].guid] = pick[2] end
      local root = M.Player and M.Player.Root
      local lines, wanted, total = {}, 0, 0
      local function why(entry)
        local info = entry.egg and lib.EggInfo[entry.egg]
        if not info then return "unknown egg type" end
        local ok, reason = idx.Wanted(entry)
        if ok then
          if opts.EggRoute == "Fast nearby" and modeOf[entry.guid] == "Drop" and not M.Planner.Narrowed() then
            return "skipped: far away (Collection Route = Fast nearby)"
          end
          return "WANTED"
        end
        if reason == "filtered" then
          local floor = lib.RarityRank[opts.MinEggRarity or ""]
          if floor and (lib.RarityRank[info.rarity] or 0) < floor then return "filtered: below Minimum Egg Rarity (" .. tostring(opts.MinEggRarity) .. ")" end
          if type(opts.EggRarities) == "table" and next(opts.EggRarities) and not opts.EggRarities[info.rarity] then return "filtered: rarity not ticked in Rarities list" end
          if type(opts.EggNames) == "table" and next(opts.EggNames) and not opts.EggNames[entry.egg] then return "filtered: egg not ticked in Eggs list" end
          if (info.luck or 0) < (tonumber(opts.MinLuck) or 0) then return "filtered: below Minimum Luck" end
          return "filtered: below Minimum Weight"
        end
        local nice = {
          private = "private egg for another player", volcanic = "volcano egg (not collected here)",
          falling = "still falling", claimed = "already claimed this wave", taken = "someone else just took it",
          failed = "failed to grab it twice, skipping", gone = "gone", ["low value"] = "Top Eggs Of The Wave: below average value",
        }
        return "skipped: " .. (nice[reason] or tostring(reason))
      end
      for _, entry in pairs(idx.Entries) do
        total += 1
        local info = entry.egg and lib.EggInfo[entry.egg]
        local r = why(entry)
        if r == "WANTED" then wanted += 1 end
        local dist = (root and typeof(entry.pos) == "Vector3") and math.floor((root.Position - entry.pos).Magnitude) or -1
        lines[#lines + 1] = { rank = info and lib.RarityRank[info.rarity] or 0, text = string.format("%-22s %-10s %.2fx  %5s studs  %-5s  -> %s",
          tostring(entry.egg), tostring(info and info.rarity or "?"), entry.weight or 1, dist >= 0 and tostring(dist) or "?", tostring(modeOf[entry.guid] or "-"), r) }
      end
      table.sort(lines, function(a, b) return a.rank > b.rank end)
      local out = {
        "==== ZRHUB Egg Checker ====",
        "Auto Collect: " .. tostring(opts.AutoEggs == true) .. " | Route: " .. tostring(opts.EggRoute) .. " | Min rarity: " .. tostring(opts.MinEggRarity),
        "Status: " .. tostring(State.Status.Eggs or "-"),
        string.format("Eggs on map: %d | wanted: %d", total, wanted),
        "egg / rarity / weight / distance / trip / result",
      }
      for _, l in ipairs(lines) do out[#out + 1] = l.text end
      if total == 0 then out[#out + 1] = "(no eggs on the map right now - wait for the next wave)" end
      return table.concat(out, "\n"), total, wanted
    end
    farm:AddButton({ Text = "Egg Checker", Tooltip = "Prints every egg on the map and why it is / isn't collected (F9 + clipboard)", Func = function()
      local text, total, wanted = eggReport()
      print(text)
      pcall(setclipboard, text)
      ZR_Obs:Notify({ Title = "Egg Checker", Description = string.format("%d eggs on map, %d wanted. Full list in F9 + copied.", total, wanted), Time = 6 })
    end })

    -- Movement tab
    local move = movementTab._obs:AddLeftGroupbox("Movement", "move")
    UI.KeyToggle(move, "SpeedOn", { Text = "Speed" })
    UI.Bind("WalkSpeed", move:AddSlider("WalkSpeed", { Text = "Walk Speed", Min = 16, Max = 300, Default = Config.WalkSpeed, Rounding = 0 }))
    UI.KeyToggle(move, "JumpOn", { Text = "Jump Power" })
    UI.Bind("JumpPower", move:AddSlider("JumpPower", { Text = "Jump Power", Min = 50, Max = 300, Default = Config.JumpPower, Rounding = 0 }))
    UI.KeyToggle(move, "InfJump", { Text = "Infinite Jump" })

    local fly = movementTab._obs:AddRightGroupbox("Fly and Noclip", "plane")
    local flyToggle = UI.KeyToggle(fly, "Fly", { Text = "Fly" })
    UI.Bind("FlySpeed", fly:AddSlider("FlySpeed", { Text = "Fly Speed", Min = 20, Max = 500, Default = Config.FlySpeed, Rounding = 0 }))
    UI.KeyToggle(fly, "NoClip", { Text = "Noclip" })
    UI.CarryGuard(flyToggle)

    -- start the engine
    try("scheduler", M.Scheduler.Boot)
    M.BindTeardown(game:GetService("RunService").Heartbeat)
    ZR_MarioLib:Every(Config.PumpTick, function() try("ui pump", UI.Pump) end)
    pcall(function() ZR_Obs:OnUnload(function() pcall(function() M:Unload() end) end) end)
    task.spawn(try, "gamelib check", M.GameLib.Check)
  end

  local section4 = autoFarmTab:Section({ Title = "Mutations", Opened = true })

  v359.PrioritizeMutations = section4:Toggle({
    Title = "Prioritize Mutated Eggs",
    Value = crownHubState.PrioritizeMutations,
    Callback = function(value89) crownHubState.PrioritizeMutations = value89 end,
  })

  v359.WeatherEggWait = section4:Toggle({
    Title = "Wait for Storm",
    Value = crownHubState.WeatherEggWait,
    Callback = function(value90) crownHubState.WeatherEggWait = value90 end,
  })

  v359.MinMutationTier = section4:Dropdown({
    Title = "Min Mutation Tier",
    Values = {
      "All Mutations (Shocked+)", "Volted & Above (3x+)", "Rage & Above (4x+)",
      "Void & Above (10x+)", "Magma & Above (10x+)", "Eternal Only (100x)",
    },
    Value = crownHubState.MinMutationTier or "All Mutations (Shocked+)",
    Callback = function(value91) crownHubState.MinMutationTier = value91 end,
  })

  v359.WeatherNotify = section4:Toggle({
    Title = "Storm Alerts",
    Value = crownHubState.WeatherNotify,
    Callback = function(value92) crownHubState.WeatherNotify = value92 end,
  })

  v359.AutoMagmaDip = section4:Toggle({
    Title = "Auto Magma Dip",
    Value = crownHubState.AutoMagmaDip,
    Callback = function(value93) crownHubState.AutoMagmaDip = value93 end,
  })


  v359.MinMutationTier = section4:Dropdown({
    Title = "Min Mutation Tier",
    Values = {
      "All Mutations (Shocked+)", "Volted & Above (3x+)", "Rage & Above (4x+)",
      "Void & Above (10x+)", "Magma & Above (10x+)", "Eternal Only (100x)",
    },
    Value = crownHubState.MinMutationTier or "All Mutations (Shocked+)",
    Callback = function(value91) crownHubState.MinMutationTier = value91 end,
  })

  local section5 = autoFarmTab:Section({ Title = "Auto Rebirth", Opened = true })

  v359.AutoRebirth = section5:Toggle({
    Title = "Auto Rebirth",
    Value = crownHubState.AutoRebirth,
    Callback = function(value94)
      crownHubState.AutoRebirth = value94

      if value94 then
        crownHubState.AutoHatchPlot = true
        crownHubState.AutoPlaceNest = true
      end
    end,
  })

  v359.PrioritizeRebirthPet = section5:Toggle({
    Title = "Prioritize Rebirth Pet",
    Value = crownHubState.PrioritizeRebirthPet,
    Callback = function(value95) crownHubState.PrioritizeRebirthPet = value95 end,
  })

  v359.AutoRebirthWhenReady = section5:Toggle({
    Title = "Auto Rebirth When Ready",
    Value = crownHubState.AutoRebirthWhenReady,
    Callback = function(value96) crownHubState.AutoRebirthWhenReady = value96 end,
  })

  section5:Button({
    Title = "Rebirth Now",
    Callback = function()
      local v369 = f27()

      if v369.canRebirth and not v369.isMaxCap then
        f28()

        if v347 and v347.Notify then
          v347:Notify({
            Title = "Rebirth Request Sent",
            Content = string.format("Rebirth Tier %d requested.", v369.nextTier),
            Duration = 3,
            Icon = "award",
          })
        end
      else
        local v370 = ""

        if not v369.hasPet then
          v370 = v370 .. "Missing Pet: " .. v369.reqPet .. " "
        end

        if not v369.hasCash then
          v370 = v370 .. "Insufficient Cash ($" .. f19(v369.currentCash) .. " / $"
            .. f19(v369.reqCash) .. ") "
        end

        if v369.isMaxCap then
          v370 = "Max Rebirth Cap Reached"
        end

        if v347 and v347.Notify then
          v347:Notify({
            Title = "Cannot Rebirth",
            Content = v370,
            Duration = 4,
            Icon = "alert-triangle",
          })
        end
      end
    end,
  })
end)

local dropdown

f50(plotPetsTab, "Misc", function()
  local section6 = plotPetsTab:Section({ Title = "Plot Eggs", Opened = true })

  v359.AutoHatchPlot = section6:Toggle({
    Title = "Auto Hatch",
    Value = crownHubState.AutoHatchPlot,
    Callback = function(value97) crownHubState.AutoHatchPlot = value97 end,
  })

  v359.AutoPlaceNest = section6:Toggle({
    Title = "Auto Plant",
    Value = crownHubState.AutoPlaceNest,
    Callback = function(value98) crownHubState.AutoPlaceNest = value98 end,
  })

  v359.SpawnNest = section6:Toggle({
    Title = "Spawn Nest",
    Value = crownHubState.SpawnNest,
    Callback = function(value99)
      crownHubState.SpawnNest = value99

      if f17 then
        pcall(function() f17(value99) end)
      end
    end,
  })

  local section7 = plotPetsTab:Section({ Title = "Plot Upgrades", Opened = true })

  v359.AutoUpgradeLuck = section7:Toggle({
    Title = "Auto Hatch Luck",
    Value = crownHubState.AutoUpgradeLuck,
    Callback = function(value100) crownHubState.AutoUpgradeLuck = value100 end,
  })

  if crownHubState.AutoPlaceBestPets == nil then
    crownHubState.AutoPlaceBestPets = false
  end

  if crownHubState.BestPetsStrategy == nil then
    crownHubState.BestPetsStrategy = "Smart Potential"
  end

  v359.AutoPlaceBestPets = section7:Toggle({
    Title = "Auto Place Best Pets",
    Value = crownHubState.AutoPlaceBestPets,
    Callback = function(value101) crownHubState.AutoPlaceBestPets = value101 end,
  })

  v359.BestPetsStrategy = section7:Dropdown({
    Title = "Best Pets Strategy",
    Values = { "Smart Potential", "Current Cash/s" },
    Value = crownHubState.BestPetsStrategy,
    Callback = function(value102) crownHubState.BestPetsStrategy = value102 end,
  })

  section7:Button({
    Title = "Place Best Pets",
    Callback = function()
      local v371, v372 = pcall(function() return f43(crownHubState.BestPetsStrategy) end)

      if v371 and v347 and v347.Notify then
        v347:Notify({
          Title = "Smart Best Pets",
          Content = tostring(v372 or "Complete!"),
          Duration = 3,
        })
      end
    end,
  })

  local section8 = plotPetsTab:Section({ Title = "Auto Feed Pets", Opened = true })

  if crownHubState.AutoFeedPets == nil then
    crownHubState.AutoFeedPets = false
  end

  if crownHubState.FeedTargetMode == nil then
    crownHubState.FeedTargetMode = "Smart Priority"
  end

  if crownHubState.SelectedPetKey == nil then
    crownHubState.SelectedPetKey = nil
  end

  if crownHubState.FeedPriorityMode == nil then
    crownHubState.FeedPriorityMode = "Smart Potential"
  end

  if crownHubState.FeedSkipMaxAge == nil then
    crownHubState.FeedSkipMaxAge = true
  end

  if crownHubState.FeedAllowPremiumFood == nil then
    crownHubState.FeedAllowPremiumFood = true
  end

  if crownHubState.FeedFoodSelection == nil then
    crownHubState.FeedFoodSelection = "All Foods"
  end

  local function f52()
    local v373 = { "All Placed Pets" }
    local v374 = { ["All Placed Pets"] = "ALL" }
    local v375 = { ALL = "All Placed Pets" }

    pcall(function()
      local v376 = f13()
      local pets5 = v376 and (v376:FindFirstChild("Pets") or v376:FindFirstChild("PlacedPets"))

      if pets5 then
        for index69, value103 in ipairs(pets5:GetChildren()) do
          local petName7 = value103:GetAttribute("PetName") or value103.Name
          local v377 = tonumber(value103:GetAttribute("Age")) or 1
          local v378 = tonumber(value103:GetAttribute("Weight")) or 1
          local petKey5 = value103:GetAttribute("PetKey") or value103.Name
          local v379 = v377 >= 100 and " [MAX]" or ""

          local v380 = string.format(
            "%d. %s (Age %d | %.1f KG)%s", index69, tostring(petName7), v377, v378, v379
          )

          table.insert(v373, v380)
          v374[v380] = petKey5
          v375[petKey5] = v380
        end
      end
    end)

    return v373, v374, v375
  end

  local v381, v382, v383 = f52()
  local v384 = v382
  local v385 = v383

  v359.AutoFeedPets = section8:Toggle({
    Title = "Auto Feed Pets",
    Value = crownHubState.AutoFeedPets,
    Callback = function(value104) crownHubState.AutoFeedPets = value104 end,
  })

  v359.FeedTargetMode = section8:Dropdown({
    Title = "Target Mode",
    Values = {
      "Smart Priority", "Selected Pet Only",
      "Highest Max Income", "Lowest Level First",
    },
    Value = crownHubState.FeedTargetMode or "Smart Priority",
    Callback = function(value105) crownHubState.FeedTargetMode = value105 end,
  })

  dropdown = section8:Dropdown({
    Title = "Target Pet",
    Values = v381,
    Value = crownHubState.SelectedPetKey and v385 and v385[crownHubState.SelectedPetKey]
      or v381[1] or "No Placed Pets Detected",
    Callback = function(value106)
      if v384[value106] then
        crownHubState.SelectedPetKey = v384[value106]
        crownHubState.FeedTargetMode = "Selected Pet Only"

        if v359.FeedTargetMode and v359.FeedTargetMode.Set then
          pcall(function() v359.FeedTargetMode:Set("Selected Pet Only") end)
        end

        if v347 and v347.Notify then
          v347:Notify({
            Title = "Target Pet Locked",
            Content = tostring(value106),
            Duration = 2,
            Icon = "shield-check",
          })
        end
      end
    end,
  })

  v359.SelectedPetKey = dropdown

  section8:Button({
    Title = "Feed Now",
    Callback = function()
      local v386, v387 = pcall(function() return f45(true) end)

      if v386 and v347 and v347.Notify then
        v347:Notify({
          Title = "Smart Feed",
          Content = tostring(v387 or "Complete!"),
          Duration = 3,
          Icon = "shield-check",
        })
      end
    end,
  })

  section8:Button({
    Title = "Refresh Pets",
    Callback = function()
      local v388, v389, v390 = f52()
      v384 = v389
      v385 = v390

      if dropdown and dropdown.Refresh then
        pcall(function() dropdown:Refresh(v388) end)
      end

      if v347 and v347.Notify then
        v347:Notify({
          Title = "Pet List Refreshed",
          Content = string.format("Detected %d pets on ranch", #v388),
          Duration = 2,
          Icon = "refresh-cw",
        })
      end
    end,
  })

  v359.FeedSkipMaxAge = section8:Toggle({
    Title = "Skip Max Age",
    Value = crownHubState.FeedSkipMaxAge,
    Callback = function(value107) crownHubState.FeedSkipMaxAge = value107 end,
  })

  v359.FeedAllowPremiumFood = section8:Toggle({
    Title = "Allow Premium Food",
    Value = crownHubState.FeedAllowPremiumFood,
    Callback = function(value108) crownHubState.FeedAllowPremiumFood = value108 end,
  })

  v359.FeedFoodSelection = section8:Dropdown({
    Title = "Food Filter",
    Values = { "All Foods", "Dragonfruit", "Magic Apple", "Meat", "Bone", "Grass" },
    Value = crownHubState.FeedFoodSelection,
    Callback = function(value109) crownHubState.FeedFoodSelection = value109 end,
  })
end)

f50(eggESPTab, "Visual", function()
  local espControlsSection = eggESPTab:Section({ Title = "Visual", Opened = true })

  v359.ESP_Enabled = espControlsSection:Toggle({
    Title = "Egg ESP",
    Value = crownHubState.ESP_Enabled,
    Callback = function(value110)
      crownHubState.ESP_Enabled = value110
      crownHubState.ESP_Highlights = true
      crownHubState.ESP_Billboards = true
      crownHubState.ESP_Tracers = false

      if value110 then
        pcall(function()
          v347:Notify({
            Title = "ZRHUB",
            Content = "Egg ESP on",
            Duration = 3,
            Icon = "eye",
          })
        end)
      else
        f30()
      end
    end,
  })

  v359.ESP_MinRarity = espControlsSection:Dropdown({
    Title = "Min ESP Rarity",
    Values = {
      "All Eggs", "Rare & Above", "Epic & Above", "Legendary & Above", "Mythic & Above",
      "Divine & Above", "Ethereal Only",
    },
    Value = crownHubState.ESP_MinRarity,
    Callback = function(value112)
      crownHubState.ESP_MinRarity = value112
      f30()
    end,
  })

  v359.ESP_MaxDistance = espControlsSection:Slider({
    Title = "ESP Max Distance",
    Step = 250,
    Value = {
      Min = 500,
      Max = 15000,
      Default = math.clamp(tonumber(crownHubState.ESP_MaxDistance) or 5000, 500, 15000),
    },
    Callback = function(value113)
      crownHubState.ESP_MaxDistance = tonumber(value113) or 5000
    end,
  })


  local scannerSection = eggESPTab:Section({ Title = "Egg Scanner", Opened = true })
  local paragraph2 = scannerSection:Paragraph({
    Title = "Egg Scanner",
    Desc = "Scanning map for high-tier eggs...",
  })

  task.spawn(function()
    while task.wait(2) do
      if _G.CrownHubInstanceId ~= crownHubInstanceId then
        break
      end
      pcall(function()
        local renderedEggs5 = workspaceService:FindFirstChild("RenderedEggs")
        local v391, v392 = f12()

        if renderedEggs5 and v392 then
          local v393 = {}

          for index70, value114 in ipairs(renderedEggs5:GetChildren()) do
            local v394 = f4(value114.Name)
            local v395 = v20[v394] or 0

            if v395 >= 600 then
              local eggWeight = f31(value114)
              local getPivot6 = value114:GetPivot()
              local v396 = math.floor((getPivot6.Position - v392.Position).Magnitude)

              table.insert(v393, {
                Name = value114.Name,
                Rarity = v394,
                Weight = v395,
                EggWeight = eggWeight,
                Dist = v396,
              })
            end
          end

          table.sort(v393, function(p82, p83)
            if p82.Weight ~= p83.Weight then
              return p82.Weight > p83.Weight
            end

            if p82.EggWeight ~= p83.EggWeight then
              return p82.EggWeight > p83.EggWeight
            end

            return p82.Dist < p83.Dist
          end)

          local v397 = {}
          local v398 = math.min(6, #v393)
          local count7 = 0

          while true do
            count7 = 1 + count7

            if not (count7 <= v398) then
              break
            end

            local v399 = count7

            if v393[v399].EggWeight and v393[v399].EggWeight > 0 then
              table.insert(v397, string.format(
                "- %s [%s] | %s - %d studs", v393[v399].Name, v393[v399].Rarity,
                f21(v393[v399].EggWeight), v393[v399].Dist
              ))
            else
              table.insert(v397, string.format(
                "- %s [%s] - %d studs", v393[v399].Name, v393[v399].Rarity, v393[v399].Dist
              ))
            end
          end

          if #v397 == 0 then
            paragraph2:SetTitle("Egg Scanner")
            paragraph2:SetDesc("No high-tier eggs on the map right now.")
          else
            paragraph2:SetTitle(string.format("Egg Scanner (%d rare+)", #v393))
            paragraph2:SetDesc(table.concat(v397, "\n"))
          end
        end
      end)
    end
  end)


end)

task.wait()

f50(discordTab, "Discord", function()
  local communitySection = discordTab:Section({ Title = "ZRHUB Community", Opened = true })

  communitySection:Paragraph({
    Title = "Join our Discord server",
    Desc = "Support, updates, announcements, and community chat.",
  })

  communitySection:Paragraph({
    Title = "Invite Link",
    Desc = DISCORD_SERVER_URL,
  })

  communitySection:Button({
    Title = "Copy Discord Invite",
    Icon = "copy",
    Callback = function()
      local copied = pcall(function()
        if setclipboard then
          setclipboard(DISCORD_SERVER_URL)
        else
          error("clipboard unavailable")
        end
      end)
      if v347 and v347.Notify then
        v347:Notify({
          Title = "ZRHUB",
          Content = copied and "Discord invite copied" or "Copy the invite link above",
          Duration = 3,
          Icon = copied and "check" or "alert-triangle",
        })
      end
    end,
  })
end)

f50(webhooksTab, "Webhooks", function()
  local sec = webhooksTab:Section({ Title = "Discord Webhook", Opened = true })

  sec:Input({
    Title = "Webhook URL",
    Placeholder = "https://discord.com/api/webhooks/...",
    Value = crownHubState.WebhookURL or "",
    Callback = function(v)
      crownHubState.WebhookURL = tostring(v or "")
    end,
  })

  v359.WebhookEnabled = sec:Toggle({
    Title = "Enable Webhooks",
    Value = crownHubState.WebhookEnabled,
    Callback = function(v) crownHubState.WebhookEnabled = v end,
  })

  v359.WebhookPingHere = sec:Toggle({
    Title = "Ping @here",
    Value = crownHubState.WebhookPingHere,
    Callback = function(v) crownHubState.WebhookPingHere = v end,
  })

  local events = webhooksTab:Section({ Title = "Notify For", Opened = true })

  v359.WebhookOnEggCollect = events:Toggle({
    Title = "Egg Collected",
    Value = crownHubState.WebhookOnEggCollect,
    Callback = function(v) crownHubState.WebhookOnEggCollect = v end,
  })

  v359.WebhookOnMutation = events:Toggle({
    Title = "Magma Mutation",
    Value = crownHubState.WebhookOnMutation,
    Callback = function(v) crownHubState.WebhookOnMutation = v end,
  })

  v359.WebhookOnRebirth = events:Toggle({
    Title = "Rebirth Success",
    Value = crownHubState.WebhookOnRebirth,
    Callback = function(v) crownHubState.WebhookOnRebirth = v end,
  })

  v359.WebhookOnRebirthFail = events:Toggle({
    Title = "Rebirth Missing Requirements",
    Value = crownHubState.WebhookOnRebirthFail,
    Callback = function(v) crownHubState.WebhookOnRebirthFail = v end,
  })

  v359.WebhookOnNestFull = events:Toggle({
    Title = "Nest Full",
    Value = crownHubState.WebhookOnNestFull,
    Callback = function(v) crownHubState.WebhookOnNestFull = v end,
  })

  sec:Button({
    Title = "Send Test Webhook",
    Callback = function()
      task.spawn(function()
        crownWebhook("Test Webhook", "ZRHUB webhook is working.", 5763719)
      end)
    end,
  })
end)

f50(settingsTab, "Settings", function()
  local interfaceControlsSection = settingsTab:Section({
    Title = "Interface & Controls",
    Opened = true,
  })

  interfaceControlsSection:Keybind({
    Title = "Toggle Keybind",
    Value = "RightShift",
    Callback = function() window:Toggle() end,
  })

  interfaceControlsSection:Button({
    Title = "Unload ZRHUB",
    Callback = function()
      if _G.CrownHubConnections then
        for index72, value132 in ipairs(_G.CrownHubConnections) do
          local v412 = value132
          pcall(function() v412:Disconnect() end)
        end
      end

      _G.CrownHubConnections = {}
      -- stop every background loop (they all check this id)
      _G.CrownHubInstanceId = (_G.CrownHubInstanceId or 0) + 1
      pcall(f30)

      -- mobile open pill is owned by Royal UI

      if window then
        window:Destroy()
      end
    end,
  })

  local section11 = settingsTab:Section({ Title = "Configs", Opened = true })

  local CFG_DIR = "CrownHub_RideAPet/configs"
  local CFG_INDEX = CFG_DIR .. "/_index.json"

  local function ensureCfgDir()
    pcall(function()
      if makefolder then
        pcall(makefolder, "CrownHub_RideAPet")
        pcall(makefolder, CFG_DIR)
      end
    end)
  end

  local function saveCfgIndex(names)
    pcall(function()
      if writefile then
        writefile(CFG_INDEX, httpService:JSONEncode({ configs = names }))
      end
    end)
  end

  local function f53()
    ensureCfgDir()
    local seen = {}
    local v413 = {}

    local function addName(name)
      name = tostring(name or ""):gsub("%.json$", "")
      if name == "" or name == "autoload" or name == "_index" then
        return
      end
      if not seen[name] then
        seen[name] = true
        table.insert(v413, name)
      end
    end

    pcall(function()
      if listfiles then
        for _, path in ipairs(listfiles(CFG_DIR) or {}) do
          local pathStr = tostring(path)
          local name = pathStr:match("([^/\\]+)%.json$") or pathStr:match("([^/\\]+)$")
          if name then
            addName(name)
          end
        end
      end
    end)

    pcall(function()
      if isfile and isfile(CFG_INDEX) and readfile then
        local ok, data = pcall(function()
          return httpService:JSONDecode(readfile(CFG_INDEX))
        end)
        if ok and type(data) == "table" and type(data.configs) == "table" then
          for _, name in ipairs(data.configs) do
            addName(name)
          end
        end
      end
    end)

    -- also pick up any known current profile
    if profile and profile ~= "" then
      addName(profile)
    end

    table.sort(v413)
    if #v413 == 0 then
      table.insert(v413, "default")
    end
    saveCfgIndex(v413)
    return v413
  end

  local function f54(p84)
    if not writefile then
      return false, "writefile not supported"
    end

    local v414, v415, v416

    if not p84 or p84 == "" or p84 == "autoload" or p84 == "_index" then
      return false, "Invalid config name"
    else
      ensureCfgDir()
      v414 = CFG_DIR .. "/" .. p84 .. ".json"
      v415 = {}

      for key13, value135 in pairs(crownHubState) do
        v415[key13] = value135
      end

      local v417
      v417, v416 = pcall(function() return httpService:JSONEncode(v415) end)

      if not v417 then
        return false, "JSON encoding error"
      else
        local v418, v419 = pcall(function() writefile(v414, v416) end)

        if not v418 then
          return false, tostring(v419)
        end

        -- track multi configs
        local names = f53()
        if not table.find(names, p84) then
          table.insert(names, p84)
          table.sort(names)
        end
        saveCfgIndex(names)

        return true
      end
    end
  end

  local function f55(p85, p86)
    if not readfile or not isfile then
      return false, "readfile not supported"
    end

    if not p85 or p85 == "" or p85 == "autoload" then
      return false, "Invalid config name"
    end

    local v420 = CFG_DIR .. "/" .. p85 .. ".json"
    local v421

    if not isfile(v420) then
      return false, "Config not found"
    else
      local v422
      v422, v421 = pcall(function() return readfile(v420) end)

      if not v422 or not v421 then
        return false, "Read error"
      else
        local v423, v424 = pcall(function() return httpService:JSONDecode(v421) end)

        if not v423 or type(v424) ~= "table" then
          return false, "Corrupted config"
        end

        for key14, value136 in pairs(v424) do
          if p86 and (key14 == "AutoFarm" or key14 == "AutoRebirth") then
            crownHubState[key14] = false
          else
            crownHubState[key14] = value136
          end
        end

        return true
      end
    end
  end

  local v425 = ""

  section11:Input({
    Title = "Create New Config",
    Placeholder = "e.g. my_config",
    Value = "",
    Callback = function(value137)
      if value137 and value137 ~= "" then
        v425 = value137
      end
    end,
  })

  local selectProfileDropdown

  local function f56(p87)
    local v426 = f53()

    if selectProfileDropdown then
      if selectProfileDropdown.SetValues then
        pcall(function() selectProfileDropdown:SetValues(v426) end)
      end

      if selectProfileDropdown.Refresh then
        pcall(function() selectProfileDropdown:Refresh(v426, true) end)
      end

      if p87 then
        if selectProfileDropdown.Select then
          pcall(function() selectProfileDropdown:Select(p87) end)
        elseif selectProfileDropdown.Set then
          pcall(function() selectProfileDropdown:Set(p87) end)
        end
      end
    end
  end

  section11:Button({
    Title = "Create Config",
    Callback = function()
      if v425 ~= "" then
        profile = v425
        local v427, v428 = f54(profile)

        if v427 then
          if v33 then
            pcall(function()
              writefile(
                "CrownHub_RideAPet/configs/autoload.json",
                httpService:JSONEncode({ AutoLoad = true, Profile = profile })
              )
            end)
          end

          f56(profile)

          v347:Notify({
            Title = "Created",
            Content = string.format("Created '%s.json'!", profile),
            Duration = 3,
            Icon = "check",
          })
        else
          v347:Notify({
            Title = "Error",
            Content = tostring(v428),
            Duration = 3,
            Icon = "x",
          })
        end
      else
        v347:Notify({
          Title = "Notice",
          Content = "Please enter a profile name first!",
          Duration = 3,
          Icon = "alert-circle",
        })
      end
    end,
  })

  selectProfileDropdown = section11:Dropdown({
    Title = "Select Config",
    Values = f53(),
    Value = profile,
    Callback = function(value138)
      if value138 and value138 ~= "" then
        profile = value138

        if v33 then
          pcall(function()
            writefile(
              "CrownHub_RideAPet/configs/autoload.json",
              httpService:JSONEncode({ AutoLoad = true, Profile = profile })
            )
          end)
        end
      end
    end,
  })

  section11:Button({
    Title = "Overwrite Config",
    Callback = function()
      local v429 = profile
      local v430, v431 = f54(v429)

      if v430 then
        if v33 then
          pcall(function()
            writefile(
              "CrownHub_RideAPet/configs/autoload.json",
              httpService:JSONEncode({ AutoLoad = true, Profile = profile })
            )
          end)
        end

        v347:Notify({
          Title = "Saved",
          Content = string.format("Overwrote '%s.json'!", v429),
          Duration = 3,
          Icon = "check",
        })
      else
        v347:Notify({
          Title = "Error",
          Content = tostring(v431),
          Duration = 3,
          Icon = "x",
        })
      end
    end,
  })

  section11:Button({
    Title = "Load Config",
    Callback = function()
      local v432 = profile
      local v433, v434 = f55(v432, false)

      if v433 then
        v347:Notify({
          Title = "Loaded",
          Content = string.format("Loaded '%s.json' & updated UI!", v432),
          Duration = 3,
          Icon = "check",
        })
      else
        v347:Notify({
          Title = "Error",
          Content = tostring(v434),
          Duration = 3,
          Icon = "x",
        })
      end
    end,
  })

  section11:Toggle({
    Title = "Auto Load Config On Startup",
    Value = v33,
    Callback = function(value139)
      v33 = value139

      if value139 then
        v347:Notify({
          Title = "AutoLoad ON",
          Content = string.format("Will auto-load '%s.json' on start", profile),
          Duration = 3,
          Icon = "check",
        })
      else
        v347:Notify({
          Title = "AutoLoad OFF",
          Content = "Disabled auto-load on start",
          Duration = 3,
          Icon = "x",
        })
      end
    end,
  })
end)

if v33 then
  pcall(function() loadProfile(profile, true) end)
end

-- first-run feature lock
crownHubState.AutoFarm = false
crownHubState.AutoRebirth = false
crownHubState.AutoMagmaDip = false
crownHubState.AutoHatchPlot = false
crownHubState.AutoPlaceNest = false
crownHubState.SpawnNest = false
crownHubState.AutoFeedPets = false
crownHubState.ESP_Enabled = false
if crownHubState.AutoPlaceBestPets ~= nil then
  crownHubState.AutoPlaceBestPets = false
end


task.wait()
f1()
task.wait(0.15)

pcall(function()
  -- Royal manages its own open pill / keybind

  if window then
    if window.Toggle then
      pcall(function() window:Toggle(true) end)
    elseif window.Open then
      pcall(function() window:Open() end)
    end
    if window.SelectTab and window.Tabs and window.Tabs[1] then
      pcall(function() window:SelectTab(window.Tabs[1]) end)
    end
  end
end)

pcall(function()
  if _G._CrownHubAllowNotify then _G._CrownHubAllowNotify(true) end
  if v347 and v347.Notify then
    v347:Notify({
      Title = "ZRHUB",
      Content = "Loaded",
      Duration = 3,
      Icon = "sparkles",
    })
  elseif window and window.Notify then
    window:Notify({
      Title = "ZRHUB",
      Content = "Loaded",
      Duration = 3,
      Icon = "sparkles",
    })
  end
  if _G._CrownHubAllowNotify then _G._CrownHubAllowNotify(false) end
end)
