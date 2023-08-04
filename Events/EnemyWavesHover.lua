-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')

local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')

local BuildTime = ScenarioInfo.Options.Option_BuildTime

function SetupWave()
    --Variables for Table 
    local Army = "SURVIVAL_ENEMY"
    local Faction = "ALLFACTION"
    local UnitMods = ""
    local WaveType = "Land"

    TechLevel = 1
    MaxTechLevels = 2
    TechAdvanceTimeInterval = 240
    TechLevelAdvancer(BuildTime, TechLevel, MaxTechLevels, TechAdvanceTimeInterval)

    --Variables for Spawn radius, interval 
    local SpawnInterval = 30
    local SpawnPoints = 200
    local CircleRadius = 450
    local CircleCenter = ScenarioUtils.MarkerToPosition('Center')
    local Spawnlocation = CircularPointGenerator.CircularPointGenerator(SpawnPoints, CircleRadius, CircleCenter)
    local WaypointsTable = GenerateWaypoints(SpawnPoints, CircleRadius, CircleCenter)

    local TargetMovementSpeed = 3
    SpawnUnitsThread(Army, Faction, UnitMods, WaveType, SpawnInterval, SpawnPoints, CircleRadius, CircleCenter, Spawnlocation, WaypointsTable, TargetMovementSpeed)
end

function TechLevelAdvancer(BuildTime, TechLevel, MaxTechLevels, TechAdvanceTimeInterval)
    ForkThread(function()
        while true do  
            local Time = (GetGameTimeSeconds() - BuildTime)  
            if Time > TechLevel * TechAdvanceTimeInterval then 
                if TechLevel < MaxTechLevels then
                    TechLevel = TechLevel + 1
                end
                if TechLevel == MaxTechLevels then
                    break
                end
            end
            WaitSeconds(1)
        end
    end)
end

function SpawnUnitsThread(Army, Faction, UnitMods, WaveType, SpawnInterval, SpawnPoints, CircleRadius, CircleCenter, Spawnlocation, WaypointsTable, TargetMovementSpeed)
    ForkThread(function()
        while true do 
            local SelectedTable = TablePicker(Army, Faction, WaveType, UnitMods)
            local MaxTables = table.getn(SelectedTable.Tables)
            local R1 = Random(1, MaxTables) 
            local LandUnitsTable = SelectedTable.Tables[R1]

            SpawnUnits(Army, LandUnitsTable, SpawnPoints, CircleRadius, CircleCenter, Spawnlocation, WaypointsTable, TargetMovementSpeed)
            WaitSeconds(SpawnInterval)
        end
    end)
end

function TablePicker(Army, Faction, WaveType, UnitMods)
    local Table = nil
    Table = import(ScenarioInfo.MapPath .. 'Tables/WaveTables'..WaveType..'/'..Army..'_'..Faction..'_T'..TechLevel..'_'..UnitMods..'.lua')
    return Table
end

function CountTableEntries(Table)
    local Count = 0
    for _ in pairs(Table) do 
        Count = Count + 1
    end
    return Count
end

function SpawnUnits(Army, Table, SpawnPoints, CircleRadius, CircleCenter, Spawnlocation, WaypointsTable, TargetMovementSpeed)

    for UnitNumber = 1, SpawnPoints do 
        HeightY = GetTerrainHeight(Spawnlocation[UnitNumber][1], Spawnlocation[UnitNumber][3])
        -- Land Spawn
        if HeightY > 19.5 then  
            local MaxTableEntries = CountTableEntries(Table.LandUnitsIds)
            local R2 = Random(1, MaxTableEntries)
            local SelectedUnitId = Table.LandUnitsIds[R2]
            local SpawnType = "Land"
            local Unit = CreateUnitHPR(SelectedUnitId, Army, Spawnlocation[UnitNumber][1], Spawnlocation[UnitNumber][2], Spawnlocation[UnitNumber][3], 0, 0, 0)
            local MovementSpeed = Table.LandMovementSpeed
            SetupMoveSpeed(Unit, MovementSpeed, SpawnType)
            GiveOrders(Unit, CircleCenter, WaypointsTable, UnitNumber) 
        -- Hover Spawn  
        elseif HeightY > 12.5 and HeightY < 19.5 then
            local MaxTableEntries = CountTableEntries(Table.HoverUnitsIds)
            local R2 = Random(1, MaxTableEntries)
            local SelectedUnitId = Table.HoverUnitsIds[R2]
            local SpawnType = "Hover"  
            local Unit = CreateUnitHPR(SelectedUnitId, Army, Spawnlocation[UnitNumber][1], Spawnlocation[UnitNumber][2], Spawnlocation[UnitNumber][3], 0, 0, 0)
            local MovementSpeed = Table.HoverMovementSpeed
            SetupMoveSpeed(Unit, MovementSpeed, SpawnType)
            GiveOrders(Unit, CircleCenter, WaypointsTable, UnitNumber) 
        -- Navy Spawn
        elseif HeightY > 0 and HeightY < 12.5 then
            local MaxTableEntries = CountTableEntries(Table.NavyUnitsIds)
            local R2 = Random(1, MaxTableEntries)
            local SelectedUnitId = Table.NavyUnitsIds[R2]
            local SpawnType = "Navy"  
            local Unit = CreateUnitHPR(SelectedUnitId, Army, Spawnlocation[UnitNumber][1], Spawnlocation[UnitNumber][2], Spawnlocation[UnitNumber][3], 0, 0, 0)
            local MovementSpeed = Table.NavyMovementSpeed
            SetupMoveSpeed(Unit, MovementSpeed, SpawnType)
            GiveOrders(Unit, CircleCenter, WaypointsTable, UnitNumber) 
        end
    end  
end

function GenerateWaypoints(SpawnPoints, CircleRadius, CircleCenter)
    local WaypointsTable = { }    
    local WaypointTableMade = false
    if WaypointTableMade == true then 
        return WaypointsTable
    end

    local Distance = 25 
    for z = 1, CircleRadius do 
        if z == Distance then 
            local NewRadius = CircleRadius - z
            local Pathway = CircularPointGenerator.CircularPointGenerator(SpawnPoints, NewRadius, CircleCenter)
            table.insert(WaypointsTable, Pathway)            
            Distance = Distance + 25
        end
    end
    if WaypointTableMade == false then 
        WaypointTableMade = true
    end
    return WaypointsTable
end

function GiveOrders(Unit, CircleCenter, WaypointsTable, UnitNumber)  
    MaxTableCount = table.getn(WaypointsTable)
    for Table = 1, MaxTableCount do 
        IssueMove({Unit}, WaypointsTable[Table][UnitNumber])
    end
end

function SetupMoveSpeed(Unit, TargetMovementSpeed, SpawnType)
    local UnitSpeed = nil
    if Unit:GetBlueprint().Physics.MaxSpeed ~= nil then
        UnitSpeed = Unit:GetBlueprint().Physics.MaxSpeed
    else
        UnitSpeed = TargetMovementSpeed
    end
    local SpeedDifference = TargetMovementSpeed/UnitSpeed
    if not Unit:IsDead() then
        Unit:SetSpeedMult(SpeedDifference)
    end
    if SpawnType == "Hover" then 
        local OldOnLayerChange = Unit.OnLayerChange
        function CustomOnLayerChange(self, new, old)
            if not Unit:IsDead() then
                Unit:SetSpeedMult(SpeedDifference)
            end
            OldOnLayerChange(self, new, old)
        end
        Unit.OnLayerChange = CustomOnLayerChange
    elseif SpawnType == "Navy" then
        local OldOnLayerChange = Unit.OnLayerChange
        function CustomOnLayerChange(self, new, old)
            if not Unit:IsDead() then
                Unit:SetSpeedMult(SpeedDifference)
            end
            OldOnLayerChange(self, new, old)
        end
        Unit.OnLayerChange = CustomOnLayerChange
    end
end
