-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ResourceTable = nil
local DefaultResourceTable = import(ScenarioInfo.MapPath .. 'Jamtropy_Survival_tables.lua')
--local ExtraResourceTable = import(ScenarioInfo.MapPath .. 'Tables/Genesis_of_the_Order_Survival_tables_ExtraResources.lua')
--local NoResourceTable = import(ScenarioInfo.MapPath .. 'Tables/Genesis_of_the_Order_Survival_tables_NoResources.lua')

local Diplomacy = import(ScenarioInfo.MapPath .. 'Functionality/Diplomacy.lua')
--local IdleUnits = import(ScenarioInfo.MapPath .. 'Functionality/IdleUnits.lua')
--local Objectives = import(ScenarioInfo.MapPath .. 'Functionality/Objectives.lua')
local PlayableArea = import(ScenarioInfo.MapPath .. 'Functionality/PlayableArea.lua')
--local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')
--local UnitsIdle = import(ScenarioInfo.MapPath .. 'Functionality/UnitsIdle.lua')
--local WelcomeMessage = import(ScenarioInfo.MapPath .. 'Functionality/WelcomeMessage.lua')

local AllFactions = import(ScenarioInfo.MapPath .. 'Utilities/AllFactions.lua')
--local ArmyStrength = import(ScenarioInfo.MapPath .. 'Utilities/ArmyStrength.lua')
local ResourceSpawning = import(ScenarioInfo.MapPath .. 'Utilities/ResourceSpawning.lua')

PlayerArmyCount = 0
PlayerArmies = { }
PlayerIndex = { }
EnemyArmies = { }

function TheRedOrTheBluePill()
    local ArmyName = {
        "ARMY_1", "ARMY_2", "ARMY_3", "ARMY_4", "ARMY_5", "ARMY_6", "ARMY_7", "ARMY_8", 
        "ARMY_9", "ARMY_10", "ARMY_11", "ARMY_12", "ARMY_13", "ARMY_14", "ARMY_15", "ARMY_16"}
    local EnemyArmyName = {
        "ARMY_ENEMY_AEON", "SURVIVAL_ENEMY"}

    SetArmyColor("SURVIVAL_ENEMY",126,155,77) 

    for i, Player in ListArmies() do
        for x, PossibleName in ArmyName do 
            if PossibleName == Player then 
                table.insert(PlayerArmies, Player)
            end
        end
        for x, PossibleName in EnemyArmyName do
            if PossibleName == Player then
                table.insert(EnemyArmies, Player)
            end
        end
    end
    for Every, Player in PlayerArmies do
        for IndexNumber = 1, 16 do 
            if Player == "ARMY_" .. IndexNumber then
                table.insert(PlayerIndex, IndexNumber)
            end
        end   
    end
    --if ScenarioInfo.Options.Option_ResourcesSettings == 0 then
        ResourceTable = DefaultResourceTable
    --elseif ScenarioInfo.Options.Option_ResourcesSettings == 1 then
    --    ResourceTable = ExtraResourceTable
    --elseif ScenarioInfo.Options.Option_ResourcesSettings == 2 then			
    --    ResourceTable =	NoResourceTable
    --end
    PlayerArmyCount = table.getn(PlayerArmies)

    SetIgnoreArmyUnitCap('ARMY_1', true)

    InitializeGame()
end

function InitializeGame()
    --WelcomeMessage.ShowWelcomeMessage()
    --WelcomeMessage.ShowBriefing()
    ResourceSpawning.SetupResources(PlayerIndex, ResourceTable)
    PlayableArea.SetArea(PlayerArmies, EnemyArmies)
    Diplomacy.SetupDiplomacy(PlayerArmies, EnemyArmies)
    --Restrictions.Setup(PlayerArmies)
    AllFactions.SpawnAllFactions(PlayerArmies)
    --Objectives.SetupObjectives(PlayerArmies, EnemyArmies)
    --UnitsIdle.OrderIdleUnits(PlayerArmies, EnemyArmies)
end



