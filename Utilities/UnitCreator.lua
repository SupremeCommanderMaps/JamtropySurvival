-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local UnitBuffer = import(ScenarioInfo.MapPath .. 'Utilities/UnitBuffer.lua')

function CreateUnit(UnitBlueprint, Army, Position)	
	local Unit = CreateUnitHPR(UnitBlueprint, Army, Position[1], Position[2], Position[3], 0, 0, 0)
	if Army == "ARMY_ENEMY_AEON" or "ARMY_ENEMY_SERAPHIM" then
		if UnitBlueprint == "XSS0201" then
			IssueDive({Unit})
		end

		UnitBuffer.HealthMultiplier(Unit)
		UnitBuffer.DamageMultiplier(Unit)
	
		Unit:SetProductionPerSecondEnergy(1000)
		Unit:SetProductionPerSecondMass(1000)
		if EntityCategoryContains(categories.TECH3 + categories.EXPERIMENTAL, Unit) then
			Unit:SetReclaimable(false)
		end
		Unit:SetCapturable(false)
	end
	return Unit		
end

function CreateUnits(TableData, Army, Position)
	local Units = { }
	for k, UnitBlueprint in TableData do 
	   	local Unit = CreateUnitHPR(UnitBlueprint, Army, Position[1], Position[2], Position[3], 0, 0, 0)
		   if (Army == "ARMY_ENEMY_AEON") or (Army == "ARMY_ENEMY_SERAPHIM") then


			UnitBuffer.HealthMultiplier(Unit)
			UnitBuffer.DamageMultiplier(Unit)
	
			Unit:SetProductionPerSecondEnergy(1000)
			Unit:SetProductionPerSecondMass(1000)
			if EntityCategoryContains(categories.TECH3 + categories.EXPERIMENTAL, Unit) then
				Unit:SetReclaimable(false)
			end
			Unit:SetCapturable(false)

		   end

		table.insert(Units, Unit)
	end
	return Units
end



function CreatePlatoonEnemy(TableData, Army, Position, WaveCount, MaxWaveCount, WaveType)
	local Units = { }
	for k, UnitBlueprint in TableData do 
	   	local Unit = CreateUnitHPR(UnitBlueprint, Army, Position[1], Position[2], Position[3], 0, 0, 0)
		Unit:SetCustomName(WaveType .. WaveCount .. "/" .. MaxWaveCount)

		UnitBuffer.HealthMultiplier(Unit)
		UnitBuffer.DamageMultiplier(Unit)

		
		Unit:SetProductionPerSecondEnergy(1000)
		Unit:SetProductionPerSecondMass(1000)
		if EntityCategoryContains(categories.TECH3 + categories.EXPERIMENTAL, Unit) then
			Unit:SetReclaimable(false)
		end
		Unit:SetCapturable(false)
		
		table.insert(Units, Unit)
	end
	return Units
end