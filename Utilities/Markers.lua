-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

-- Global Value

DefenceObject = { }

PathWay = { }
PathWayNavy = { }
PathWayAir = { }

AmphibiousSpawn = { }
LandSpawn = { }
NavySpawn = { }

ArtySpawn = { }
NukeSpawn = { }

DropSpawn = { }


function GetRandomPosition(Positions)
    GetMarkers()
    local n = table.getn(Positions)
    local i = math.floor(Random() * n) + 1
    return Positions[i]
end

local MarkerCache = false
function GetMarkers()
    if MarkerCache then
        return
    end

    -- Defence Object
    local Markers = ScenarioInfo.Env.Scenario.MasterChain._MASTERCHAIN_.Markers
    for k = 1, 100 do 
        local MarkerType = 'defenceobject-' .. k
        if Markers[MarkerType] then
            table.insert(DefenceObject, Markers[MarkerType].position)
        end
        if table.getn(DefenceObject) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- PathWay
    for k = 1, 100 do 
        local MarkerType = 'pathwayland-' .. k
        if Markers[MarkerType] then
            table.insert(PathWay, Markers[MarkerType].position)
        end
        if table.getn(PathWay) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- PathWayNavy
    for k = 1, 100 do 
        local MarkerType = 'pathwaynavy-' .. k
        if Markers[MarkerType] then
            table.insert(PathWayNavy, Markers[MarkerType].position)
        end
        if table.getn(PathWayNavy) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- PathWayAir
    for k = 1, 100 do 
        local MarkerType = 'pathwayair-' .. k
        if Markers[MarkerType] then
            table.insert(PathWayAir, Markers[MarkerType].position)
        end
        if table.getn(PathWayAir) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- Land Spawn location
    for k = 1, 100 do 
        local MarkerType = 'spawnland-' .. k
        if Markers[MarkerType] then
            table.insert(LandSpawn, Markers[MarkerType].position)
            table.insert(AmphibiousSpawn, Markers[MarkerType].position)
        end
        if table.getn(LandSpawn) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- Arty location
    for k = 1, 100 do 
        local MarkerType = 'SURVIVAL_ARTY_' .. k
        if Markers[MarkerType] then
            table.insert(ArtySpawn, Markers[MarkerType].position)
        end
        if table.getn(ArtySpawn) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- Nuke location
    for k = 1, 100 do 
        local MarkerType = 'SURVIVAL_NUKE_' .. k
        if Markers[MarkerType] then
            table.insert(NukeSpawn, Markers[MarkerType].position)
        end
        if table.getn(NukeSpawn) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- Navy Spawn Location
    for k = 1, 100 do 
        local MarkerType = 'spawnnavy-' .. k
        if Markers[MarkerType] then
            table.insert(NavySpawn, Markers[MarkerType].position)
            table.insert(AmphibiousSpawn, Markers[MarkerType].position)
        end
        if table.getn(NavySpawn) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end
    -- Drop Spawn Location
    for k = 1, 100 do 
        local MarkerType = 'dropspawn-' .. k
        if Markers[MarkerType] then
            table.insert(DropSpawn, Markers[MarkerType].position)
        end
        if table.getn(NavySpawn) == 0 then
            if ScenarioInfo.Debug then
                WARN("Utilities.Markers: No Makers found: " .. MarkerType)
            end
        end
    end



    if ScenarioInfo.Debug then
        LOG("Utilities Markers: Defence Object  Markers: " .. repr (DefenceObject))
        LOG("Utilities Markers: Path Way        Markers: " .. repr (PathWay))
        LOG("Utilities Markers: Land Spawn      Markers: " .. repr (LandSpawn))
        LOG("Utilities Markers: Arty Spawn      Markers: " .. repr (ArtySpawn))
        LOG("Utilities Markers: Nuke Spawn      Markers: " .. repr (NukeSpawn))
        LOG("Utilities Markers: Navy Spawn      Markers: " .. repr (NavySpawn))
    end
    MarkerCache = true
end





