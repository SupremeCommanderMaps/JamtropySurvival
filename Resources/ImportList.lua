-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local AeonBoss = import(ScenarioInfo.MapPath .. 'Events/AeonBoss.lua')
local NukeEvent = import(ScenarioInfo.MapPath .. 'Events/NukeEvent.lua')
local Omni = import(ScenarioInfo.MapPath .. 'Events/Omni.lua') -- Not used
local Recall = import(ScenarioInfo.MapPath .. 'Events/Recall.lua')
local ReinforcementDrop = import(ScenarioInfo.MapPath .. 'Events/ReinforcementDrop.lua')
local SeraphimInvasion = import(ScenarioInfo.MapPath .. 'Events/SeraphimInvasion.lua')
local SeraphimRifts = import(ScenarioInfo.MapPath .. 'Events/SeraphimRifts.lua')
local Statistics = import(ScenarioInfo.MapPath .. 'Events/Statistics.lua')


local DefaultOptions = import(ScenarioInfo.MapPath .. 'Functionality/DefaultOptions.lua')
local DefenceObject = import(ScenarioInfo.MapPath .. 'Functionality/DefenceObject.lua')
local Dialogue = import(ScenarioInfo.MapPath .. 'Functionality/Dialogue.lua')
local Diplomacy = import(ScenarioInfo.MapPath .. 'Functionality/Diplomacy.lua')
local EmergencyShield = import(ScenarioInfo.MapPath .. 'Functionality/EmergencyShield.lua')
local GameProgression = import(ScenarioInfo.MapPath .. 'Functionality/GameProgression.lua')
local GameSetup = import(ScenarioInfo.MapPath .. 'Functionality/GameSetup.lua')
local GameStart = import(ScenarioInfo.MapPath .. 'Functionality/GameStart.lua')
local IdleUnits = import(ScenarioInfo.MapPath .. 'Functionality/IdleUnits.lua') -- Not used likely not working
local Objectives = import(ScenarioInfo.MapPath .. 'Functionality/Objectives.lua')
local PlayableArea = import(ScenarioInfo.MapPath .. 'Functionality/PlayableArea.lua')
local Props = import(ScenarioInfo.MapPath .. 'Functionality/Props.lua')
local Restrictions = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions.lua')
    local EnergyFabricatorCheck = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/EnergyFabricator.lua')
    local EnergyStorageCheck = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/EnergyStorage.lua')    
    local MassFabricatorCheck = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/MassFabricator.lua')
    local MassStorageCheck = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/MassStorage.lua')
    local ResourceGenerator = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/ResourceGenerator.lua')
    local Shield = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/Shield.lua')
    local Units = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/Units.lua')
        local UnitAnalyzer = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/UnitAnalyzer/UnitAnalyzer.lua')
local UnitsIdle = import(ScenarioInfo.MapPath .. 'Functionality/UnitsIdle.lua')
local WelcomeMessage = import(ScenarioInfo.MapPath .. 'Functionality/WelcomeMessage.lua')

local SpawnEnemyAir = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyAir.lua')
local SpawnEnemyLand = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyLand.lua')
local SpawnEnemyNavy = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyNavy.lua')

local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

local AllFactions = import(ScenarioInfo.MapPath .. 'Utilities/AllFactions.lua')
local ArmyStrength = import(ScenarioInfo.MapPath .. 'Utilities/ArmyStrength.lua')
local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')
local CircularPointGenerator = import(ScenarioInfo.MapPath .. 'Utilities/CircularPointGenerator.lua')
local PingMarker = import(ScenarioInfo.MapPath .. 'Utilities/PingMarker.lua')
local Markers = import(ScenarioInfo.MapPath .. 'Utilities/Markers.lua')
local PlatoonOrders = import(ScenarioInfo.MapPath .. 'Utilities/PlatoonOrders.lua')
local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local ResourceSpawning = import(ScenarioInfo.MapPath .. 'Utilities/ResourceSpawning.lua')
local UnitBuffer = import(ScenarioInfo.MapPath .. 'Utilities/UnitBuffer.lua')
local UnitCreator = import(ScenarioInfo.MapPath .. 'Utilities/UnitCreator.lua')

local WaveTableEnemyAir = import(ScenarioInfo.MapPath .. 'Tables/WaveTablesEnemyAir.lua')
local WaveTableEnemyLand = import(ScenarioInfo.MapPath .. 'Tables/WaveTablesEnemyLand.lua')
local WaveTableEnemyNavy = import(ScenarioInfo.MapPath .. 'Tables/WaveTablesEnemyNavy.lua')