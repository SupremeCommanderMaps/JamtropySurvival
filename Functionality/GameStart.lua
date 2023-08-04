local EnemyWavesHover = import(ScenarioInfo.MapPath .. 'Events/EnemyWavesHover.lua')
local PlanetStorm = import(ScenarioInfo.MapPath .. 'Events/PlanetStorm.lua')


function FullSend()
    ForkThread(function()
        WaitSeconds(1)
        EnemyWavesHover.SetupWave()
        PlanetStorm.SetupWave()
    end)
end