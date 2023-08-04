-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

ScenarioInfo.MapPath = '/maps/Jamtropy_Survival.v0001/'

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')
local GameStart = import(ScenarioInfo.MapPath .. 'Functionality/GameStart.lua')




function OnPopulate()
    ScenarioUtils.CreateResources = function() end
	Sync.CampaignMode = true
	ScenarioInfo.Debug = false
	ScenarioInfo.Options.Victory = 'sandbox'
	ScenarioUtils.InitializeArmies()
    GameSetup.TheRedOrTheBluePill()
end

function OnStart(scenario)
    GameStart.FullSend()
end


function OnShiftF3()
    SpawnUnits()
end

function OnShiftF4()
end

function OnShiftF5()
    ForkThread(function()
        local iteration = 0

        while iteration < 15 do
            SpawnUnits()
            WaitSeconds(5)
            iteration = iteration + 1
        end
    end)
end



