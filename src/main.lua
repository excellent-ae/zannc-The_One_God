---@meta _

---@diagnostic disable-next-line: undefined-global
local mods = rom.mods

---@diagnostic disable: lowercase-global
---@module 'LuaENVY-ENVY-auto'
mods["LuaENVY-ENVY"].auto()

---@diagnostic disable-next-line: undefined-global
rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = PLUGIN

game = rom.game

modutil = mods["SGG_Modding-ModUtil"]
chalk = mods["SGG_Modding-Chalk"]
reload = mods["SGG_Modding-ReLoad"]

---@module 'The_One_God-zannc-config'
config = chalk.auto("config.lua")
public.config = config

import_as_fallback(rom.game)

local function on_ready()
	import("ready.lua")
end

local function on_reload()
	import("imgui.lua")
end

local loader = reload.auto_single()

modutil.once_loaded.game(function()
	mod = modutil.mod.Mod.Register(_PLUGIN.guid)
	loader.load(on_ready, on_reload)
end)
