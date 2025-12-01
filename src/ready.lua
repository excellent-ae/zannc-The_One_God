---@meta _
---@diagnostic disable: lowercase-global

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
