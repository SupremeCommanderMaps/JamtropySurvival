-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function SpawnAllFactions(PlayerArmies)
    if ScenarioInfo.Options.Option_AllFactions ~= 0 then 
        GetAllFactionOption()

        for x, Brain in PlayerArmies do
            Brain = GetArmyBrain(x)
            PosX, PosY = Brain:GetArmyStartPos()
            for _, Unit in GetUnitTable(Brain:GetFactionIndex()) do 
                Brain:CreateUnitNearSpot(Unit, PosX, PosY)
            end
        end
    end
end

function GetAllFactionOption()
    if ScenarioInfo.Options.Option_AllFactions == 1 then -- Extra Engineers Same Faction
        Uef = {"UEL0105", "UEL0105", "UEL0105",}
        Aeon = {"UAL0105", "UAL0105", "UAL0105",}
        Cybran = {"URL0105", "URL0105", "URL0105",}
        Seraphim = {"XSL0105", "XSL0105", "XSL0105",}
    end
    if ScenarioInfo.Options.Option_AllFactions == 2 then -- Extra Acus Same Faction
        Uef = {"UEL0001",}
        Aeon = {"UAL0001",}
        Cybran = {"URL0001",}
        Seraphim = {"XSL0001",}
    end
    if ScenarioInfo.Options.Option_AllFactions == 3 then -- Extra T1 engineers
        Uef = {"UAL0105", "URL0105", "XSL0105",}
        Aeon = {"UEL0105", "URL0105", "XSL0105",}
        Cybran = {"UEL0105", "UAL0105", "XSL0105",}
        Seraphim = {"UEL0105", "UAL0105", "URL0105",}
    end
    if ScenarioInfo.Options.Option_AllFactions == 4 then -- Extra Acu's
        Uef = {"UAL0001", "URL0001", "XSL0001",}
        Aeon = {"UEL0001", "URL0001", "XSL0001",}
        Cybran = {"UEL0001", "UAL0001", "XSL0001",}
        Seraphim = {"UEL0001", "UAL0001", "URL0001",}
    end
end

function GetUnitTable(FactionIndex)
    local Units = { }
    if FactionIndex == 1 then
        Units = Uef
    end
    if FactionIndex == 2 then
        Units = Aeon
    end
    if FactionIndex == 3 then
        Units = Cybran
    end
    if FactionIndex == 4 then
        Units = Seraphim
    end
    return Units
end