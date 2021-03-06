----------------------------------------------------------------------------------------------------
-- Basic option for MUDpp
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Path to MUD files
----------------------------------------------------------------------------------------------------
path  = { asset   = "asset/"
        , saves   = "saves/"
        , strings = "config/strings.lua"
        , player  = "config/player.lua"
        }

----------------------------------------------------------------------------------------------------
-- Default listening port
----------------------------------------------------------------------------------------------------
port = 4000

----------------------------------------------------------------------------------------------------
-- Internal timers intervals in millisecond
----------------------------------------------------------------------------------------------------
base_period    =   100  -- base period for event
tick_period    =  5000  -- broadcast **TICK** every 5s
cleanup_period =  1000  -- Cleanup system resources every 1s
stats_period   = 10000  -- Display resources status every 10s
