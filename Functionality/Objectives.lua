-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local Objectives = import('/lua/ScenarioFramework.lua').Objectives
local SimObjects = import('/lua/SimObjectives.lua')

local NukeEvent = import(ScenarioInfo.MapPath .. 'Events/NukeEvent.lua')

local Statistics = import(ScenarioInfo.MapPath .. 'Events/Statistics.lua')

local PlayDialogue = import(ScenarioInfo.MapPath .. 'Utilities/PlayDialogue.lua')
local DialogueList = import(ScenarioInfo.MapPath .. 'Resources/DialogueList.lua')

function SetupObjectives(PlayerArmies, EnemyArmies)
	ForkThread(function()
		WaitSeconds(5)

        --------------------------- Protect Defence Unit Objective
	    local Text = "Until recall preperations are done"
	    local AllyArmy = "ARMY_ALLY_UEF"

        local Summit = GetArmyBrain(AllyArmy):GetListOfUnits(categories.ues0302 , false, false)[1]

	    ScenarioInfo.ProtectObject1 = Objectives.Protect('primary',
	    	'incomplete',
	    	"Defend Summit",
	    	Text,
	    	{
	    		Units = {Summit},
	    		Timer = nil,
	    		NumRequired = 1,
	    		MarkUnits = false,
	    	})

	    ScenarioInfo.ProtectObject1:AddResultCallback(function(result)
	    	if (result == false) then
				SetEndGame()
                for i, Army in PlayerArmies do
                    GetArmyBrain(Army):OnDefeat()
                end 
                for i, Army in EnemyArmies do 
                    GetArmyBrain(Army):OnVictory()
                end
	    	end
	    end)
        
        WaitSeconds(0.1)

        --------------------------- Fake Objective for Instructions
	    local Text = "Press\n Shift+F3 Show Game Statistics\nShift+F4 Display Settings\nCtrl+F4 Show Briefing\nShift+F5 Increase Hp \nCtrl+F5 Decrease Hp \nCrtl+Alt+F4 Decrease Dmg \nCrtl+Alt+F5 Increase Dmg \n---------------------------------\nMade by Jammer \nIf any bugs let me know"
	    local AllyArmy = "ARMY_ALLY_UEF"

        local FakeUnitTable = { }
        local FakeUnitId = 'URB5103'
        local FakeUnit = CreateUnitHPR(FakeUnitId, AllyArmy, 13, 20, 21, 0, 0, 0)
            table.insert(FakeUnitTable, FakeUnit)

	    ScenarioInfo.ProtectObject0 = Objectives.Protect('primary',
	    	'incomplete',
	    	"Game Options",
	    	Text,
	    	{
	    		Units = FakeUnitTable,
	    		Timer = nil,
	    		NumRequired = 0,
	    		MarkUnits = false,
	    	})
        
        KillUnits(FakeUnitTable) 

        WaitSeconds(0.1)

        --------------------------- Protect Commander Objective
	    local Text = ""

	    local CommanderTable = { }

        for i, Army in PlayerArmies do
            local Commander = GetArmyBrain(Army):GetListOfUnits(categories.COMMAND , false, false)[1]
	        table.insert(CommanderTable, Commander)
        end

	    ScenarioInfo.ProtectObject2 = Objectives.Protect('primary',
	    	'incomplete',
	    	"One Commander must survive.",
	    	Text,
	    	{
	    		Units = CommanderTable,
	    		Timer = nil,
	    		NumRequired = 1,
	    		MarkUnits = false,
	    	})

	    ScenarioInfo.ProtectObject2:AddResultCallback(function(result)
	    	if (result == false) then
				SetEndGame()
                for i, Army in PlayerArmies do
                    GetArmyBrain(Army):OnDefeat()
                end 
                for i, Army in EnemyArmies do 
                    GetArmyBrain(Army):OnVictory()
                end
	    	end
	    end)

	end)
end


function KillUnits(Table)
    ForkThread(function()
    WaitSeconds(1.5)
    IssueDestroySelf(Table)
    end)
end

function SetEndGame()
    ForkThread(function()
		PlayDialogue.Dialogue(DialogueList.Princess_70, nil, false)
		PlayDialogue.Dialogue(DialogueList.Celene_7, nil, false)
		WaitSeconds(10)
		Statistics.Setup()
		WaitSeconds(2)
		EndGame()
	end)
end