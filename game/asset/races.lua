----------------------------------------------------------------------------------------------------
-- MUDpp Races
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- List all races
----------------------------------------------------------------------------------------------------
races = {}
dofile("asset/races/human.lua")
dofile("asset/races/elf.lua")
dofile("asset/races/dwarf.lua")

----------------------------------------------------------------------------------------------------
-- Display all races
----------------------------------------------------------------------------------------------------
function display_races(current_player)
  current_player:send("Choose your #bRace##:\n\r")
  for _,r in pairs(races) do
    current_player:send("#b@y" .. r.name .. "##\t- " .. r.desc .. "\n\r")
  end
end

----------------------------------------------------------------------------------------------------
-- Handle race selection
----------------------------------------------------------------------------------------------------
function handle_races(current_player, input)
  local choice = string.lower(input)
  if( contain_key(races, choice) ) then
    local chosen_race = races[choice]
    current_player.data["race"] = chosen_race.name
    current_player:send("Your #b@yRace## is #b@y" .. current_player.data["race"] .. "##\n\r")
    return true
  else
    return false
  end
end
