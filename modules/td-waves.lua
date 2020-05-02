local event = require 'utils.event'
local math_random = math.random

local wave_info = {
}

local Public = {}

function Public.reset_wave_engine()
    wave_info.current_wave_number = 1
    wave_info.current_spawn_index = 1
    wave_info.current_wave_spawning = true
    wave_info.active = false
    wave_info.wave_force = "enemy"
end

local function waves_on_tick()
    if game.tick % 40 == 0 then
        if wave_info.current_wave_spawning then
            local unit_type = global.wave_definitions[wave_info.current_wave_number][wave_info.current_spawn_index]
            local spawn_areas = game.surfaces.nauvis.get_script_areas('wave_spawn')
            if (#spawn_areas ~= 1) then
                game.print('Failed to find single spawn area')
            end
            local position = game.surfaces.nauvis.find_non_colliding_position_in_box(unit_type, spawn_areas[1].area, 0.5)
            local unit = game.surfaces.nauvis.create_entity{name=unit_type, position = position, force=wave_info.wave_force, }

            wave_info.current_spawn_index = wave_info.current_spawn_index + 1
            if wave_info.current_spawn_index > #(global.wave_definitions[wave_info.current_wave_number]) then
                wave_info.current_wave_spawning = false
            end
        end
    end
end

local waves_on_init = function ()
    Public.reset_wave_engine()
end

event.on_init(waves_on_init)
event.add(defines.events.on_tick, waves_on_tick)

return Public