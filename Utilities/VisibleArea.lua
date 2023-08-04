-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

function Create(Radius, Unit, Duration, VisibleArmy)

    local VisibleAreaTable = { }

    for i, Army in VisibleArmy do 
        local VisibleArea = ScenarioFramework.CreateVisibleAreaAtUnit(Radius, Unit, Duration, GetArmyBrain(Army))
        VisibleArea:AttachBoneTo(-1, Unit, -1)
        table.insert(VisibleAreaTable, VisibleArea)
    end

    Unit.OldOnKilled = Unit.OnKilled

    Unit.OnKilled = function(self, instigator, type, overkillRatio)

        for x, VisibleArea in VisibleAreaTable do 
            VisibleArea:Destroy()
        end

        self.OldOnKilled(self, instigator, type, overkillRatio)
    end
end
