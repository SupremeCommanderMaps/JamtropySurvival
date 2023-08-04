-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

-- Not using this version UnitsIdle.lua new one

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

function OrderIdleUnits(PlayerArmies, EnemyArmies)
    ForkThread(function()
        WaitSeconds(1)
        while true do 
            local CommanderPositionTable = GetCurrentCommanderPosition(PlayerArmies)
            for i, Army in EnemyArmies do
                local AllUnits = GetArmyBrain(Army):GetListOfUnits(categories.ALLUNITS - categories.STRUCTURE, false)
                for x, Unit in AllUnits do 
                    local CommanderPosition = RandomPosition(CommanderPositionTable)
                    local UnitPosition = Unit:GetPosition()
                    

                    UnitNotMovingCheck(Unit, UnitPosition, CommanderPosition)
                end
            end
        WaitSeconds(60)
        end
    end)
end

function GetCurrentCommanderPosition(PlayerArmies)
    local CommanderPositionTable = { }

    for i, Army in PlayerArmies do
        local Commander = GetArmyBrain(Army):GetListOfUnits(categories.COMMAND , false, false)[1]

        if Commander then
            local Position = Commander:GetPosition()
            table.insert(CommanderPositionTable, Position)
        end
    end    
    return CommanderPositionTable
end

function RandomPosition(CommanderPositionTable)
    local n = table.getn(CommanderPositionTable)
    local i = math.floor(Random() * n) + 1
    return CommanderPositionTable[i]
end

function UnitNotMovingCheck(Unit, UnitPosition, CommanderPosition)
    ForkThread(function()
        local PosX = string.format("%.0f", UnitPosition[1])
        local PosZ = string.format("%.0f", UnitPosition[3])
        WaitSeconds(59)
        local CurrentUnitPosition = Unit:GetPosition()
        local CurrentPosX = string.format("%.0f", CurrentUnitPosition[1])
        local CurrentPosZ = string.format("%.0f", CurrentUnitPosition[3])

        if PosX == CurrentPosX then
            if PosZ == CurrentPosZ then
                IssueStop({Unit})
                WaitSeconds(1)
                IssueAttack({Unit}, CommanderPosition)
            end
        end
    end)
end

