local Server = require 'utils.server'
local Score = require 'comfy_panel.score'

require 'maps.tower_defense.wave_definitions'
local waveEngine = require 'modules.td-waves'

local function on_player_joined_game(event)
	local player = game.players[event.player_index]
	player.character.character_running_speed_modifier = 3
end

local Event = require 'utils.event'
Event.add(defines.events.on_player_joined_game, on_player_joined_game)