-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioFramework = import('/lua/ScenarioFramework.lua')

function SetArea(PlayerArmies, EnemyArmies)

    ScenarioFramework.SetPlayableArea('AREA_1', false)

    for _, EnemyArmy in EnemyArmies do 
        ScenarioFramework.SetIgnorePlayableRect(EnemyArmy, true)
    end

    if ScenarioInfo.Debug then
        ScenarioFramework.SetPlayableArea('AREA_1', false)
    end
end