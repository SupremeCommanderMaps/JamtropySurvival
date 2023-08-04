-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')

function SetupResources(PlayerIndex, ResourceTable)
    MexSpawn(PlayerIndex, ResourceTable)
    HydroSpawn(PlayerIndex, ResourceTable)
end

function MexSpawn(PlayerIndex, ResourceTable)
    for _, IndexNumber in PlayerIndex do 
        for EveryMex, MexNumber in ResourceTable.spwnMexArmy[IndexNumber] do
            if MexNumber < 10 then
                MexNumber = "0" .. MexNumber
            end
            local SplatTexture = (ScenarioInfo.MapPath .. '/Resources/textures/splats/mass_marker.png')
            local Position = ScenarioUtils.MarkerToPosition('Mass ' .. MexNumber)
            CreateResourceDeposit("Mass", Position[1], Position[2], Position[3], 1.00)
            CreateSplat({Position[1], Position[2], Position[3]}, 0, SplatTexture, 2, 2, 500000, 0, -1, 0)
            CreatePropHPR("/env/common/props/massDeposit01_prop.bp", Position[1], Position[2], Position[3], 0, 0, 0)
        end
    end
end

function HydroSpawn(PlayerIndex, ResourceTable)
    for _, IndexNumber in PlayerIndex do 
        for EveryHydro, HydroNumber in ResourceTable.spwnHydroArmy[IndexNumber] do
            if HydroNumber < 10 then
                HydroNumber = "0" .. HydroNumber
            end
            local SplatTexture = (ScenarioInfo.MapPath .. '/Resources/textures/splats/hydrocarbon_marker.png')
            local Position = ScenarioUtils.MarkerToPosition('Hydrocarbon ' .. HydroNumber)
            CreateResourceDeposit("Hydrocarbon", Position[1], Position[2], Position[3], 3.00)
            CreateSplat({Position[1], Position[2], Position[3]}, 0, SplatTexture, 6, 6, 500000, 0, -1, 0)
            CreatePropHPR("/env/common/props/hydrocarbonDeposit01_prop.bp", Position[1], Position[2], Position[3], 0, 0, 0)
        end
    end
end
