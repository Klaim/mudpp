----------------------------------------------------------------------------------------------------
-- Game Engine module
----------------------------------------------------------------------------------------------------
local command = {}

----------------------------------------------------------------------------------------------------
-- Load modules
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Quit command
----------------------------------------------------------------------------------------------------
function command.quit(current_player, cmd, args, states)
  current_player:send("Bye " .. current_player.name .. " !\n");
  current_player:disconnect()
  return states["disconnected"]
end

----------------------------------------------------------------------------------------------------
-- Shutdown command
----------------------------------------------------------------------------------------------------
function command.shutdown(current_player, cmd, args, states)
  current_player:send("Bye " .. current_player.name .. " !\nThe server will now shutdown ...\n");
  current_player:shutdown()
  return states["disconnected"]
end

----------------------------------------------------------------------------------------------------
-- Unknown command
----------------------------------------------------------------------------------------------------
function command.unknown(current_player, cmd, args, states)
  current_player:send("I... I don't understand. What do you mean by '" .. cmd .. "' ?\n");
  return states["play"]
end

----------------------------------------------------------------------------------------------------
-- Command repository
----------------------------------------------------------------------------------------------------
command.supported_commands =
{
  ["/SHUTDOWN"] = { callback=command.shutdown , permission="" },
  ["/QUIT"]     = { callback=command.quit     , permission="" },
  ["~"]         = { callback=command.unknown  , permission="" }
}

----------------------------------------------------------------------------------------------------
-- Select and execute command command
----------------------------------------------------------------------------------------------------
function command.perform(current_player, cmd, args, states)
  local com = utils.select_command(command.supported_commands,cmd)

  -- TODO : check permission with curren_player:has_permission(com.permission)
  return com.callback(current_player, cmd, args, states)
end

----------------------------------------------------------------------------------------------------
mudpp_log('Module command - loaded')
----------------------------------------------------------------------------------------------------

return command