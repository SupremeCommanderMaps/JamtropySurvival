
function OnPopulate()
    import('/lua/sim/ScenarioUtilities.lua').InitializeArmies()
    import('/lua/ScenarioFramework.lua').SetPlayableArea('AREA_1' , false)
end

function OnStart(scenario)
end

local newAngleGenerator = function()
    local function angleIsValid(angle)
        return ( angle > -40 ) and ( angle < 40 )
            --( angle > -40 and angle < 40 )
            --or ( angle > 140 and angle < 220 )
            --or ( angle > 80 and angle < 100 )
            --or ( angle > 260 and angle < 280 )
    end

    return {
        randomAngle = function()
            local angle

            while true do
                angle = math.rad(Random(180, 360))

                if angleIsValid(angle) then
                    return angle
                end
            end
        end
    }
end

local newCircularSpawner = function(unitCreator, angleGenerator)
    local radius = 490
    local innerRadius = 50
    local z = 25.9844

    local center = {
        x = ScenarioInfo.size[2] / 2,
        y = ScenarioInfo.size[1] / 2
    }

    local function spawnSingleUnit(unitId)
        local angle = angleGenerator.randomAngle()

        local unit = unitCreator.create({
            blueprintName = unitId,
            armyName = "SURVIVAL_ENEMY",
            x = center.x + radius * math.sin(angle),
            y = center.y + radius * math.cos(angle),
            z = z,
            yawInRadians = angle - math.pi
        })

        IssueAggressiveMove(
            {unit},
            VECTOR3(
                center.x + innerRadius * math.sin(angle),
                z,
                center.y + innerRadius * math.cos(angle)
            )
        )
    end

    return {
        spawnUnit = function(unitId, unitCount)
            for _ = 0, unitCount or 1 do
                spawnSingleUnit(unitId)
            end
        end
    }
end

local mapPath = '/maps/Jamtropy_Survival.v0001/'
local entropyLib = import(mapPath .. 'vendor/EntropyLib/src/EntropyLib.lua').newInstance(mapPath .. 'vendor/EntropyLib/')
local circularSpawner = newCircularSpawner(entropyLib.newUnitCreator(), newAngleGenerator())

function OnShiftF3()
    circularSpawner.spawnUnit("XAL0203")
end

function OnShiftF4()
    circularSpawner.spawnUnit("XAL0203", 100)
end

function OnShiftF5()
    ForkThread(function()
        local iteration = 0

        while iteration < 15 do
            circularSpawner.spawnUnit("XAL0203", 20)
            WaitSeconds(1)
            iteration = iteration + 1
        end
    end)
end