-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local SpawnEnemyAir = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyAir.lua')
local SpawnEnemyLand = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyLand.lua')
local SpawnEnemyNavy = import(ScenarioInfo.MapPath .. 'Generator/SpawnEnemyNavy.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')

DefenceObject = nil

DefenceUnits = { }

local ShieldBlueprint = {
	ImpactEffects = 'SeraphimShieldHit01',
	ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
	Mesh = '/effects/entities/SeraphimShield01/SeraphimShield01_mesh',
	MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
	RegenAssistMult = 60,
	ShieldEnergyDrainRechargeTime = 60,
	ShieldMaxHealth = 5000,
	ShieldRechargeTime = 20,
	ShieldRegenRate = 300,
	ShieldRegenStartTime = 1,
	ShieldSize = 15,
	ShieldVerticalOffset = -5,
}

function DefenceObjectThread()


	local Interval = 0.5
	local DefenceObjectHP = 0
	local DefenceObjectLastHP = 0
	while not DefenceObject.Dead do
		local WaveCountLand = (SpawnEnemyLand.WaveCount - 1)
		local MaxWaveCountLand = SpawnEnemyLand.MaxWaveCount
		local WaveCountNavy = (SpawnEnemyNavy.WaveCount - 1)
		local MaxWaveCountNavy = SpawnEnemyNavy.MaxWaveCount
		local WaveCountAir = (SpawnEnemyAir.WaveCount - 1)
		local MaxWaveCountAir = SpawnEnemyAir.MaxWaveCount

		--Updating Wave Count as CustomName
		DefenceObject:SetCustomName(
			"Land: " .. WaveCountLand .."/" .. MaxWaveCountLand .. 
			" Navy: " .. WaveCountNavy .."/" .. MaxWaveCountNavy ..
			" Air: " .. WaveCountAir .."/" .. MaxWaveCountAir
		)


		--If damaged is true send message to players
		DefenceObjectHP = DefenceObjectHP - Interval
		if (DefenceObjectHP <= 0) then
			if (DefenceObject:GetHealth() < DefenceObjectLastHP) then
				local Formatted = string.format(
   					"%.2f %%", DefenceObject:GetHealth() / DefenceObject:GetMaxHealth() * 100)
				BroadcastMsg.TextMsg(string.rep(" ", 50) .. "", 25, 'e80a0a', 3, 'centertop')
				BroadcastMsg.TextMsg(string.rep(" ", 50) .. "Summit Hull Integrity at: " .. Formatted, 25, 'e80a0a', 3, 'centertop')
			DefenceObjectHP = 2;
			end
		end
		DefenceObjectLastHP = DefenceObject:GetHealth()

		--DefenceObject:DisableShield()
	WaitSeconds(1.0)	
	end
end

function SpawnDefenceObject()
    local POS = ScenarioUtils.MarkerToPosition("defenceobject-1")

	DefenceObject = CreateUnitHPR('UES0302', "ARMY_ALLY_UEF", POS[1], POS[2], POS[3], -0.07, -0.9932878, 0.25)
	DefenceObject:SetReclaimable(false)
	DefenceObject:SetCapturable(false)
	DefenceObject:SetProductionPerSecondMass(0)
	DefenceObject:SetProductionPerSecondEnergy(0 + ((table.getn(ListArmies()) - 3) * 0))
	DefenceObject:SetMaxHealth(43721 - (ScenarioInfo.Options.Option_PlatoonWaveCount * 1000))
	DefenceObject:SetHealth(nil, DefenceObject:GetMaxHealth() * 0.16)
	DefenceObject:SetRegenRate(4 - (ScenarioInfo.Options.Option_PlatoonWaveCount))
	DefenceObject:SetIntelRadius('Vision', 280)
	DefenceObject:SetImmobile(true)
	DefenceObject:SetElevation(20)
	
	
	table.insert(DefenceUnits, DefenceObject)

    ForkThread(DefenceObjectThread)

end

