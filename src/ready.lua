---@meta _
---@diagnostic disable: lowercase-global

local function tableToString(tbl, indent)
	indent = indent or 0
	local formatting = string.rep("  ", indent)
	local lines = {}

	for k, v in pairs(tbl) do
		if type(v) == "table" then
			table.insert(lines, formatting .. k .. ":")
			local subLines = tableToString(v, indent + 1)
			for _, line in ipairs(subLines) do
				table.insert(lines, line)
			end
		else
			table.insert(lines, formatting .. k .. ": " .. tostring(v))
		end
	end

	return lines
end

local function printtable(tbl, indent)
	if type(tbl) ~= "table" then
		rom.log.warning(tostring(tbl))
		return
	end

	local lines = tableToString(tbl, indent)
	for _, line in ipairs(lines) do
		rom.log.warning(line)
	end
end

modutil.mod.Path.Wrap("GetEligibleLootNames", function(base, excludeLootNames)
	--[[
        We dont need to check for Max Gods, as this will return only 1 god
    --]]
	if config.enabled then
		local godOutput = {}
		local chosenReward = config.ChosenReward .. "Upgrade"

		local lootData = game.LootData[chosenReward]
		if lootData and not lootData.DebugOnly and lootData.GodLoot and IsGameStateEligible(lootData, lootData.GameStateRequirements) then
			table.insert(godOutput, chosenReward)
		else
			rom.log.warning(chosenReward .. " is not eligible, falling back to Aphrodite")
			table.insert(godOutput, "AphroditeUpgrade")
		end

		--! Don't really want to do this
		-- if excludeLootNames ~= nil then
		-- 	for k, excludeLootName in pairs(excludeLootNames) do
		-- 		RemoveValue(godOutput, excludeLootName)
		-- 	end
		-- end

		return godOutput
	else
		return base(excludeLootNames)
	end
end)

modutil.mod.Path.Wrap("GetEligibleLootNames", function(base, excludeLootNames)
	if config.enabled then
		local godOutput = {}
		local chosenRewardLootName = mod.originalGodNames[config.ChosenReward]

		local lootData = game.LootData[chosenRewardLootName]
		if lootData and not lootData.DebugOnly and lootData.GodLoot and IsGameStateEligible(lootData, lootData.GameStateRequirements) then
			table.insert(godOutput, chosenRewardLootName)
		else
			rom.log.warning(chosenRewardLootName .. " is not eligible, falling back to Aphrodite")
			table.insert(godOutput, "AphroditeUpgrade")
		end

		return godOutput
	else
		return base(excludeLootNames)
	end
end)
