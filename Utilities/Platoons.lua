-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

CacheDropPlatoons = { }
CacheNavyPlatoons = { }

function RandomArmyGroup(CachePlatoons)
    CreatePlatoons()
    local n = table.getn(CachePlatoons)
    local i = math.floor(Random() * n) + 1
    return CachePlatoons[i]
end

function SpawnArmyGroup(tblData, Army, Position)
    local Transports = { }
    for k, UnitBlueprint in tblData.Transports do 
        local Unit = CreateUnitHPR(UnitBlueprint, Army, Position[1], Position[2], Position[3], 0, 0, 0)
        table.insert(Transports, Unit)
    end

    local Transportees = { }
    for k, UnitBlueprint in tblData.Transportees do 
        local Unit = CreateUnitHPR(UnitBlueprint, Army, Position[1], Position[2], Position[3], 0, 0, 0)
        table.insert(Transportees, Unit)
    end   
    return Transports, Transportees
end

function SpawnNavyGroup(tblData, Army, Position)
    local NavyT1 = { }
    for k, UnitBlueprint in tblData.NavyT1 do 
       local Unit = CreateUnitHPR(UnitBlueprint, Army, Position[1], Position[2], Position[3], 0, 0, 0)
        table.insert(NavyT1, Unit)
    end
    return NavyT1
end

local PlatoonCache = false
function CreatePlatoons()
    if PlatoonCache then
        return
    end

    local function UnitToBlueprintID(Unit)
        return Unit:GetBlueprint().BlueprintId
    end

    local function UnitsToBlueprintID(Units)
        local Ids = { }
        for k, Unit in Units do 
            table.insert(Ids, UnitToBlueprintID(Unit))
        end
        return Ids
    end

    -- Transport Drop T1

    local Army = "ARMY_ENEMY"
    local tblNode = Scenario.Armies[Army].Units
    --LOG(repr(tblNode))
    for k = 1, 100 do
        local GroupName = 'DropT1S' .. k
        local GroupExist = ScenarioUtils.FindUnitGroup(GroupName, tblNode)
        if GroupExist then
            local Units = ScenarioUtils.CreateArmyGroup(Army, GroupName, false, false)

            local Transport = { }
            local Transportees = { }

            -- about category operators
            -- + = or 
            -- - = subtracting
            -- * = and 
            -- / = ?

            local Transports = UnitsToBlueprintID(EntityCategoryFilterDown(categories.TRANSPORTATION, Units))

            local Transportees = UnitsToBlueprintID(EntityCategoryFilterDown(categories.ALLUNITS - categories.TRANSPORTATION, Units))

            for k, Unit in Units do 
                Unit:Destroy()
            end
            
            local Cache = { }
            Cache.Transports = Transports
            Cache.Transportees = Transportees 

            LOG(repr("Transportscache" .. table.getn(Cache.Transports)))

            table.insert(CacheDropPlatoons, Cache)

            --LOG("DropPlatoons" .. repr(table.getn(CacheDropPlatoons)))
        end
        local GroupName = 'NavyT1S' .. k
        local GroupExist = ScenarioUtils.FindUnitGroup(GroupName, tblNode)
        if GroupExist then
            local Units = ScenarioUtils.CreateArmyGroup(Army, GroupName, false, false)

            local NavyT1 = { }

            local NavyT1 = UnitsToBlueprintID(EntityCategoryFilterDown(categories.ALLUNITS, Units))

            for k, Unit in Units do 
                Unit:Destroy()
            end
            
            local Cache1 = { }
            Cache1.NavyT1 = NavyT1

            LOG(repr("NavyPlatoonscache" .. table.getn(Cache1.NavyT1)))

            table.insert(CacheNavyPlatoons, Cache1)

            LOG(repr("NavyPlatoons" .. table.getn(CacheNavyPlatoons)))
        end
    end
    PlatoonCache = true
end

