local json = require("json")

local mod = RegisterMod("Random Start Item Plus", 1)

local config = {
    ["NumberOfItems"] = 1,
    ["TreasurePool"] = true,
    ["ShopPool"] = false,
    ["BossPool"] = false,
    ["DevilPool"] = false,
    ["AngelPool"] = false,
    ["SecretPool"] = false,
    ["LibraryPool"] = false,
    ["UltraSecretPool"] = false,
    ["PlanetariumPool"] = false,
}

function getItemPool()
    local itemPools = {}

    if config["TreasurePool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_TREASURE
    end

    if config["ShopPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_SHOP
    end

    if config["BossPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_BOSS
    end

    if config["DevilPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_DEVIL
    end

    if config["AngelPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_ANGEL
    end

    if config["SecretPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_SECRET
    end

    if config["LibraryPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_LIBRARY
    end

    if config["UltraSecretPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_ULTRA_SECRET
    end

    if config["PlanetariumPool"] then
        itemPools[#itemPools+1] = ItemPoolType.POOL_PLANETARIUM
    end

    if #itemPools == 0 then
        itemPools[#itemPools+1] = ItemPoolType.POOL_TREASURE
    end

    local itemPool = itemPools[math.random(#itemPools)]

    return itemPool
end

function mod:spawnItem()
    if Game():GetFrameCount() == 1 then 

        local spawnLocations = {
            { Vector(320, 300) },
            { Vector(280, 300), Vector(360, 300) },
            { Vector(260, 300), Vector(320, 300), Vector(380, 300) },
        }

        for i = 1, config["NumberOfItems"], 1 do

            local spawnLocation = (spawnLocations[config["NumberOfItems"]])[i]

            Isaac.Spawn(EntityType.ENTITY_PICKUP, 
                PickupVariant.PICKUP_COLLECTIBLE, 
                Game():GetItemPool():GetCollectible(getItemPool()),
                spawnLocation, Vector(0,0), nil)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE , mod.spawnItem)

local isGameStarted = false

function mod.onGameStart()
    if mod:HasData() then
		config = json.decode(Isaac.LoadModData(mod))
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onGameStart)

--Saving Moddata--
function mod:SaveGame()
    mod.SaveData(mod, json.encode(config))
end

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.SaveGame)

if ModConfigMenu then

    function AnIndexOf(t,val)
		for k,v in ipairs(t) do 
			if v == val then return k end
		end

		return 1
	end

    local sizes = {1, 2, 3}
	ModConfigMenu.AddSetting("Random Start Item Plus", "General", {
		Type = ModConfigMenu.OptionType.NUMBER,
		CurrentSetting = function()
			return AnIndexOf(sizes, config["NumberOfItems"])
		end,
		Minimum = 1,
		Maximum = #sizes,
		Display = function()
			return "# of Items to Spawn: " .. config["NumberOfItems"]
		end,
		OnChange = function(currentNum)
			config["NumberOfItems"] = sizes[currentNum]
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["TreasurePool"]
		end,
		Display = function()
			local onOff = "False"

			if config["TreasurePool"] then
				onOff = "True"
			end
			return "Use Treasure Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["TreasurePool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["ShopPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["ShopPool"] then
				onOff = "True"
			end
			return "Use Shop Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["ShopPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["BossPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["BossPool"] then
				onOff = "True"
			end
			return "Use Boss Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["BossPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["DevilPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["DevilPool"] then
				onOff = "True"
			end
			return "Use Devil Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["DevilPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["AngelPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["AngelPool"] then
				onOff = "True"
			end
			return "Use Angel Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["AngelPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["SecretPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["SecretPool"] then
				onOff = "True"
			end
			return "Use Secret Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["SecretPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["LibraryPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["LibraryPool"] then
				onOff = "True"
			end
			return "Use Library Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["LibraryPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["UltraSecretPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["UltraSecretPool"] then
				onOff = "True"
			end
			return "Use Ultra Secret Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["UltraSecretPool"] = currentBool
		end,
	})

    ModConfigMenu.AddSetting("Random Start Item Plus","Item Pools", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		CurrentSetting = function()
			return config["PlanetariumPool"]
		end,
		Display = function()
			local onOff = "False"

			if config["PlanetariumPool"] then
				onOff = "True"
			end
			return "Use Planetarium Pool: " .. onOff
		end,
		OnChange = function(currentBool)
			config["PlanetariumPool"] = currentBool
		end,
	})
end