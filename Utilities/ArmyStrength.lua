-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')

local LogStats = false

function GetArmy(StrenghtArmy)

    local PlayerArmies = GameSetup.PlayerArmies

    local Value = StrenghtArmy -- can be Weakest or Strongest

    local PlayerStrengthTable = { }

    for Every, Player in PlayerArmies do
        local TotalMassCostUnits = 0
        local TotalProductionMass = 0

        UnitList = GetArmyBrain(Player):GetListOfUnits(categories.ALLUNITS, true, false)
        UnitCount = table.getn(UnitList)

        -- If player is dead set 0
        if UnitCount == 0 then 
            ArmyStrength = 0
        end

        for Every, Unit in UnitList do
            if Unit:IsBeingBuilt() then
                   -- do nothing 
            elseif not Unit:IsBeingBuilt() then
                local UnitProductionMass = Unit:GetProductionPerSecondMass()
                TotalProductionMass = TotalProductionMass + UnitProductionMass

                local UnitMassCost = Unit:GetBlueprint().Economy.BuildCostMass
                TotalMassCostUnits = TotalMassCostUnits + UnitMassCost 

                local MassProductionValue = (100 + (TotalProductionMass * 0.10)) * 0.01
                ArmyStrength = MassProductionValue * TotalMassCostUnits

            end
        end

        table.insert(PlayerStrengthTable, ArmyStrength , Player)
    end
    if Value == "Weakest" then
        local WeakestPlayer = GetWeakestPlayer(PlayerStrengthTable)
        return WeakestPlayer
    end
    if Value == "Strongest" then
        local StrongestPlayer = GetStrongestPlayer(PlayerStrengthTable)
        return StrongestPlayer
    end
end

function GetWeakestPlayer(PlayerStrengthTable)
    local CurrentWeakestPlayer = "ARMY_ALLY_UEF"
    local CurrentHighestArmy = 999999999999999999999999999999999999999
    for ArmyStrenght, Player in PlayerStrengthTable do
        local UnitCap = GetArmyBrain(Player):GetArmyStat("UnitCap_Current", 0.0).Value
        if LogStats == true then 
            LOG("LogStats: Strength: UnitCap:" .. repr(UnitCap))
            LOG("LogStats: Strength: " .. repr(Player) .. " / " .. repr(ArmyStrenght))
        end
        local BrainType = GetArmyBrain(Player).BrainType
        if BrainType == "Human" then --If Ai skip 
            if ArmyStrenght < CurrentHighestArmy then
                if UnitCap > 0 then -- If player is dead skip player
                    CurrentHighestArmy = ArmyStrenght
                    CurrentWeakestPlayer = Player
                end
            end
        end
    end
    return CurrentWeakestPlayer
end

function GetStrongestPlayer(PlayerStrengthTable)
    local CurrentLowestArmy = 0
    for ArmyStrenght, Player in PlayerStrengthTable do
        if ArmyStrenght > CurrentLowestArmy then
            CurrentLowestArmy = ArmyStrenght
            CurrentStrongestPlayer = Player
        end
    end
    return CurrentStrongestPlayer
end


function GetUnitCount(Player)
    local AllUnits = GetArmyBrain(Player):GetListOfUnits(categories.ALLUNITS, false, false)
    local Count = 0
    for Every, Unit in AllUnits do
        if Unit:IsBeingBuilt() then
               -- do nothing 
        elseif not Unit:IsBeingBuilt() then
            Count = Count + 1
        end
    end
    if LogStats == true then 
        LOG("LogStats: Strength: UnitCount:" .. repr(Count))
    end
    return Count
end