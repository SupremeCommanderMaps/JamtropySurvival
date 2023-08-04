-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

--the plan 
-- Can you make playable area round?
-- Make storm on planet so players cant move to edges 
-- Make strom give health to enemy units.

--SetTerrainType(x, z, type) check out this function
--SetTerrainTypeRect(rect, type)

local CircleCenter = ScenarioUtils.MarkerToPosition('Center')

function SetupWave()
    ForkThread(function()
        while true do 
            WaitSeconds(1)
            DrawCircle(CircleCenter, 5, 'ff00ff')
        end
    end)
end
