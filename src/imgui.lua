---@meta _
---@diagnostic disable: lowercase-global

local function CheckGods()
	local lootList = game.OrderedKeysToList(game.LootData)
	local godList = {}
	for i, lootName in ipairs(lootList) do
		local lootData = game.LootData[lootName]
		if lootData and not lootData.DebugOnly and lootData.GodLoot then
			local godName = lootName:gsub("Upgrade$", "")
			table.insert(godList, godName)
		end
	end
	return godList
end

local godList = CheckGods()

function drawMenu()
	local value, checked = rom.ImGui.Checkbox("Enabled", config.enabled)
	if checked then
		config.enabled = value
	end

	if config.enabled then
		rom.ImGui.Text("The One Chosen God.")
		rom.ImGui.Text("If a God is not in this list, manually type the GodName in config.")
		rom.ImGui.Spacing()

		for i, god in ipairs(godList) do
			if rom.ImGui.RadioButton(god, config.ChosenReward == god) then
				config.ChosenReward = god
			end

			if i % 3 ~= 0 and i ~= #godList then
				rom.ImGui.SameLine()
			end
		end

		rom.ImGui.Spacing()
	end
end

rom.gui.add_imgui(function()
	if rom.ImGui.Begin("The One God") then
		drawMenu()
		rom.ImGui.End()
	end
end)

rom.gui.add_to_menu_bar(function()
	if rom.ImGui.BeginMenu("Configure") then
		drawMenu()
		rom.ImGui.EndMenu()
	end
end)
