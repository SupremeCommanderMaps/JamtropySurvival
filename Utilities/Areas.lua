-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

-- Global Value
SpawnNavyArea = { }


SpawnLandRift = { }
SpawnNavyRift = { }

function GetRandomPositionInArea(AreaData)
    GetAreas()
    -- Random Area
    local Area = table.getn(AreaData)
    local RandomNumber = math.floor(Random() * Area) + 1
    local RandomArea = AreaData[RandomNumber]
    -- Random Point in Area
    local DifferenceX = RandomArea.x1 - RandomArea.x0
    local DifferenceY = RandomArea.y1 - RandomArea.y0
    local RandomX = Random() * DifferenceX
    local RandomY = Random() * DifferenceY
    -- Vector Points
    local x = RandomArea.x0 + RandomX
    local z = RandomArea.y0 + RandomY
    local y = GetSurfaceHeight(x, z) 
    return VECTOR3(x, y, z)
end

local AreasCache = false
function GetAreas()
    if AreasCache then
        return
    end

    local Areas = ScenarioInfo.Env.Scenario.Areas
    -- Spawn Navy
    --for k = 1, 100 do
    --    local AreaType = 'spawn-navy-' .. k
    --    if Areas[AreaType] then
    --        local Area = Areas[AreaType]
    --        local Data = Area.rectangle
    --        local Rectangle = Rect(Data[1], Data[2], Data[3], Data[4])
    --        table.insert(SpawnNavyArea, Rectangle)
    --    end
    --    if table.getn(SpawnNavyArea) == 0 then
    --        WARN("Utilities.Areas: No Makers found: " .. AreaType)
    --    end
    --end

    for k = 1, 100 do
        local AreaType = 'riftland-' .. k
        if Areas[AreaType] then
            local Area = Areas[AreaType]
            local Data = Area.rectangle
            local Rectangle = Rect(Data[1], Data[2], Data[3], Data[4])
            table.insert(SpawnLandRift, Rectangle)
        end
        if table.getn(SpawnLandRift) == 0 then
            WARN("Utilities.Areas: No Makers found: " .. AreaType)
        end
    end

    for k = 1, 100 do
        local AreaType = 'riftnavy-' .. k
        if Areas[AreaType] then
            local Area = Areas[AreaType]
            local Data = Area.rectangle
            local Rectangle = Rect(Data[1], Data[2], Data[3], Data[4])
            table.insert(SpawnNavyRift, Rectangle)
        end
        if table.getn(SpawnNavyRift) == 0 then
            WARN("Utilities.Areas: No Makers found: " .. AreaType)
        end
    end
    
    if ScenarioInfo.Debug then
        LOG("Utilities.Areas: Spawn navy area's: " .. repr (SpawnNavyArea))
    end
    AreasCache = true
end
