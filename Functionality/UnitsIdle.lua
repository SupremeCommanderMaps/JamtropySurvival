-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

function OrderIdleUnits(PlayerArmies, EnemyArmies)
    ForkThread(function()
        WaitSeconds(1)
        while true do 
            for i, Army in EnemyArmies do
                local AllUnits = GetArmyBrain(Army):GetListOfUnits(categories.ALLUNITS - categories.STRUCTURE, false)
                for x, Unit in AllUnits do 
                    UnitMovingFirstCheck(Unit, PlayerArmies)
                end
            end
        WaitSeconds(60)
        end
    end)
end

function UnitMovingFirstCheck(Unit, PlayerArmies)
    local Check1 = IsUnitMovingCheck(Unit)
    if Check1 == false then 
        UnitMovingSecondCheck(Unit, PlayerArmies)
    end
end

function UnitMovingSecondCheck(Unit, PlayerArmies)
    ForkThread(function()
        WaitSeconds(15)
        local Check = IsUnitMovingCheck(Unit)

        if Check == false then
            if not Unit.Dead then 
                IssueClearCommands({Unit})
                OrderUnit(Unit, PlayerArmies)
            end
        end
    end)    
end

function IsUnitMovingCheck(Unit)
    local UnitMoving = nil

    if not IsDestroyed(Unit) then
        UnitMoving = Unit:IsMoving()
    end
    return UnitMoving
end

function OrderUnit(Unit, PlayerArmies)
    local PlayerUnitsTable = GetUnitsPlayer(PlayerArmies)
    local RandomUnit = RandomUnitFromTable(PlayerUnitsTable)
    local RandomUnitPosition = RandomUnit:GetPosition()
    IssueMove({Unit}, RandomUnit)
    ForkThread(function()
        WaitSeconds(1)
        IssueClearCommands({Unit})
        WaitSeconds(1)
        IssueAggressiveMove({Unit}, RandomUnitPosition)
    end)
end

function GetUnitsPlayer(PlayerArmies)
    local UnitsTable = { }
    for i, Army in PlayerArmies do
        local PlayerUnits = GetArmyBrain(Army):GetListOfUnits(categories.ALLUNITS - categories.STRUCTURE, false)
        for x, Unit in PlayerUnits do
            table.insert(UnitsTable, Unit)
        end
    end
    return UnitsTable
end

function RandomUnitFromTable(UnitTable)
    local n = table.getn(UnitTable)
    local i = math.floor(Random() * n) + 1
    return UnitTable[i]
end