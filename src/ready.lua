---@meta _
---@diagnostic disable: lowercase-global

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
			rom.log.warning("The One God: " .. chosenReward .. " is not eligible")
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
