-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local TAU = 6.28318530718

function CircularSpawner(UnitTable, Army, CircleSpawnPoints, CircleRadius, CircleCenter)



    local CircleCenterX = CircleCenter[1] --X
    local CircleCenterZ = CircleCenter[2] --Z height
    local CircleCenterY = CircleCenter[3] --Y

    for i = 1, CircleSpawnPoints do

        local t = i / CircleSpawnPoints

        local angRad = t * TAU

        local x = CircleCenterX + CircleRadius * math.cos(angRad)
        local z = CircleCenterZ
        local y = CircleCenterY + CircleRadius * math.sin(angRad)

        local Position = Vector(x,z,y)

        local Units = UnitCreator.CreateUnits(UnitTable, Army, Position)


    end 

end

function CircularPointGenerator(CircleSpawnPoints, CircleRadius, CircleCenter)
 
    local VectorPoints = { }

    local CircleCenterX = CircleCenter[1] --X
    local CircleCenterZ = CircleCenter[2] --Z height
    local CircleCenterY = CircleCenter[3] --Y

    for i = 1, CircleSpawnPoints do

        local t = i / CircleSpawnPoints

        local angRad = t * TAU

        local x = CircleCenterX + CircleRadius * math.cos(angRad)
        local z = CircleCenterZ
        local y = CircleCenterY + CircleRadius * math.sin(angRad)

        local Position = Vector(x,z,y)

        table.insert(VectorPoints, Position)
    end
    return VectorPoints
end