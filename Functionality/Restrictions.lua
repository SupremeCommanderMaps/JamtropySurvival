-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')



local EnergyFabricator = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/EnergyFabricator.lua')
local EnergyStorage = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/EnergyStorage.lua')
local MassFabricator = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/MassFabricator.lua')
local MassStorage = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/MassStorage.lua')

local BroadcastMsg = import(ScenarioInfo.MapPath .. 'Utilities/BroadcastMsg.lua')


local ResouceGenerator = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/ResouceGenerator.lua')
local Shield = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/Shield.lua')
local Units = import(ScenarioInfo.MapPath .. 'Functionality/Restrictions/Units.lua')

IncomeMultiplier = 0
StorageMultiplier = 0
BuildRateMultiplier = 0
BuildRangeMultiplier = 0
BuildCostMultiplier = 0
BannedUnitsCounter = 0

ModUnitIds = { }

function Setup(PlayerArmies)
	Army = ListArmies()
	ArmyCount = table.getn(Army)
	LastArmyInList = Army[ArmyCount]
	GetModifiers(LastArmyInList)

	SetupBuildRestrictions(PlayerArmies) 
	ModCheck(PlayerArmies)
	RestrictionActiveCheck(PlayerArmies)
end

function SetupBuildRestrictions(PlayerArmies)
	-- category operators
	-- + = or 
	-- - = subtracting
	-- * = and 
	-- / = ?
	ForkThread(function()
		WaitSeconds(5)
		for i, Army in PlayerArmies do
			ScenarioFramework.AddRestriction(Army, categories.WALL)
			ScenarioFramework.AddRestriction(Army, (categories.SCOUT * categories.LAND))

			--ScenarioFramework.AddRestriction(Army, (categories.MASSFABRICATION * categories.TECH3) - categories.SUBCOMMANDER) -- categories.SUBCOMMANDER
			--ScenarioFramework.RemoveBuildRestriction(Army, categories.uaa0101)	
			if ScenarioInfo.Options.Option_GameBreaker == 0 then
				ScenarioFramework.AddRestriction(Army, categories.xab1401) --Paragon	
			elseif ScenarioInfo.Options.Option_GameBreaker == 1 then
				ScenarioFramework.AddRestriction(Army, categories.xsb2401) --Yolona Oss	
			elseif ScenarioInfo.Options.Option_GameBreaker == 2 then			
				ScenarioFramework.AddRestriction(Army, categories.xab1401) --Paragon
				ScenarioFramework.AddRestriction(Army, categories.xsb2401) --Yolona Oss
			elseif ScenarioInfo.Options.Option_GameBreaker == 3 then			

			end
		end
	end)
end

function ModCheck(PlayerArmies, LastArmyInList)
	local InstalledMods = {}



	for index, moddata in __active_mods do
	    InstalledMods[moddata.name] = true
	    InstalledMods[moddata.uid] = true

	    LOG('ActiveMod: '..moddata.name..' - UID: '..moddata.uid .. "MOD Location: " .. moddata.location)

		Pattern = '*_unit.bp' -- file to look for
		ModPathLocation = moddata.location -- Mod directory on Disk
		UnitsDirectories = {'/hook/units', '/units'} -- Folders in Mod directory

       	for z,UnitDirectory in UnitsDirectories do
			UnitModFolder = moddata.location .. UnitDirectory
			UnitFolders = DiskFindFiles(UnitModFolder, Pattern)
			for x, UnitFolder in UnitFolders do 
				_UnitBp = string.gsub(UnitFolder, "^.*/", "")    -- strip redundant directory name
				UnitId = string.gsub(_UnitBp, "_unit.bp", "")    -- strip redundant _unit.bp
				table.insert(ModUnitIds, ""..UnitId.."")
			end
       	end
	end  

	if table.getn(__active_mods) > 0 then
		GetModUnitsSpecifics(PlayerArmies, ModUnitIds)
	end
end

function RestrictionActiveCheck(PlayerArmies)
	ForkThread(function()
		WaitSeconds(6)
		for i, Army in PlayerArmies do
			Wall = CreateUnitHPR('uab5101', Army, 2, 20, 2, 0, 0, 0)
			WaitSeconds(0.5)
			ListUnits = GetArmyBrain(Army):GetListOfUnits(categories.WALL, false)
			WallCount = table.getn(ListUnits)

			if WallCount > 0 then
				GameHasBeenTamperedWith(PlayerArmies)
			end
		end
	end)
end

function GetModUnitsSpecifics(PlayerArmies, ModUnitIds)
	ForkThread(function()
		WaitSeconds(1.0)
		for z, UnitId in ModUnitIds do		
			if __blueprints[UnitId].Economy.ProductionPerSecondMass ~= nil then 
				MassFabricator.IsMassFabricatorAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
			elseif __blueprints[UnitId].Economy.ProductionPerSecondEnergy ~= nil then
				EnergyFabricator.IsEnergyFabricatorAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
			elseif __blueprints[UnitId].Economy.AdjacentMassProductionMod ~= nil then
				MassStorage.IsMassStorageAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
			elseif __blueprints[UnitId].Economy.AdjacentEnergyProductionMod ~= nil then
				EnergyStorage.IsEnergyStorageAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
			elseif __blueprints[UnitId].Economy.MaxMass ~= nil or __blueprints[UnitId].Economy.MaxEnergy ~= nil then
				ResouceGenerator.IsResouceGeneratorAllowed(PlayerArmies, UnitId, IncomeMultiplier)
			elseif __blueprints[UnitId].Defense.Shield.Mesh ~= nil then
				Shield.IsShieldAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
			elseif table.getn(__blueprints[UnitId].Weapon) > 0 then
				Units.IsUnitAllowed(PlayerArmies, UnitId, IncomeMultiplier, BuildCostMultiplier)
			end
		end
		LOG("Mod Restriction Check Done")
	end)
end

function GetModifiers()

	--FetchBlueprints--
	--GetBlueprintsList()
	--local BP = import("/units/UAL0301/UAL0301_unit.bp").Economy.ProductionPerSecondMass

	--logbp = __blueprints['brmbt1airst'].Weapon
	--local MaxCategoriesCount = table.getn(logbp)
	--LOG("Weapon Count" .. repr(MaxCategoriesCount))
	--for i , weapon in logbp do
	--	LOG("Weapon Count" .. repr(weapon))
	--end

	SacuMassIcome = __blueprints['ual0301'].Economy.ProductionPerSecondMass
	IncomeMultiplier = SacuMassIcome / 1 -- Vanilla Aeon Sacu stats = 1
	LOG("Mod Multiplier Income: " .. repr(SacuMassIcome).. " Income Multiplier: " ..repr(IncomeMultiplier))

	SacuStorage = __blueprints['ual0301'].Economy.StorageMass
	StorageMultiplier = SacuStorage / 275 -- Vanilla Aeon Sacu stats = 275
	LOG("Mod Multiplier StorageCapacity: " .. repr(SacuStorage).. " StorageCapacity Multiplier: " ..repr(StorageMultiplier))

	SacuBuildRate = __blueprints['ual0301'].Economy.BuildRate
	BuildRateMultiplier = SacuBuildRate / 56 -- Vanilla Aeon Sacu stats = 56
	LOG("Mod Multiplier BuildRate: " .. repr(SacuBuildRate).. " BuildRate Multiplier: " ..repr(BuildRateMultiplier))

	SacuBuildRange = __blueprints['ual0301'].Economy.MaxBuildDistance
	BuildRangeMultiplier = SacuBuildRange / 10 -- Vanilla Aeon Sacu stats = 10
	LOG("Mod Multiplier BuildRange: " .. repr(SacuBuildRange).. " BuildRange Multiplier: " ..repr(BuildRangeMultiplier))

	SacuBuildCost = __blueprints['ual0301'].Economy.BuildCostMass
	BuildCostMultiplier = SacuBuildCost / 1950 -- Vanilla Aeon Sacu stats = 1950
	LOG("Mod Multiplier BuildCost: " .. repr(SacuBuildCost).. " BuildCost Multiplier: " ..repr(BuildCostMultiplier))
end

function RestrictionCounter(Count, UnitId)
	BannedUnitTable = { }
	
	BannedUnitsCounter = BannedUnitsCounter + Count
end


function GetWeaponCategories(PlayerArmies, UnitId, TechLevel)
	ValidWeaponCategory = true 
	local WeaponCategoryTable = { }
	local PossibleCategories = {
		'Anti Air', 'Anti Navy', 'Artillery', 'Bomb', 'Defense', 'Death', 'Direct Fire', 'Direct Fire Experimental', 
		'Direct Fire Naval', 'Experimental', 'Indirect Fire', 'Kamikaze', 'Missile', 'Teleport'}
	local Count = 1
	local MaxCountPossibleCategories = table.getn(PossibleCategories)

	for z, Weapon in __blueprints[UnitId].Weapon do 
		ValidCategory = false
		WeaponCategory = __blueprints[UnitId].Weapon[z].WeaponCategory
		--for x, PossibleCategory in PossibleCategories do 
		--	if PossibleCategory == WeaponCategory then
		--		if not (WeaponCategory == 'Death') or (WeaponCategory == 'Teleport') then
		--			table.insert(WeaponCategoryTable, WeaponCategory)
		--		end
		--		ValidCategory = true
		--	end
		--end
		if ValidCategory == false then 
			LOG("Mod Restriction Weapon: Failed To Specify a Valid Weapon Category: "  ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName).. " Category: " .. repr(WeaponCategory))
			ValidWeaponCategory = false
		end
	end

	if ValidWeaponCategory == false then 
		LOG("Mod Restriction Weapon: Failed To Specify a Valid Weapon Categories: Restrict Unit: " ..repr(UnitId) .." UnitName: ".. repr(__blueprints[UnitId].General.UnitName))
		AddBuildRestriction(PlayerArmies, UnitId)
		WeaponCategoryTable = { }
	end

	return WeaponCategoryTable
end 

function GameHasBeenTamperedWith(PlayerArmies)
	for i, Army in PlayerArmies do
		GetArmyBrain(Army):OnDefeat()

		Dialog1 = {
            {displayTime = 80, text =
            " \n\n\n\n\n\n\n\n\n\n ",}
        }
        Dialog2 = {
            {displayTime = 80, text =
            "Build Restrictions Failed.\n\n\n\n\n\n\n\n\nTerminating Game.\n                       Try disabling Mods!",}
		}
		for z = 1, 5 do 
			BroadcastMsg.DisplayDialogBox("right", Dialog1, false)
		end
		BroadcastMsg.DisplayDialogBox("right", Dialog2, false)

		ForkThread(function()
			WaitSeconds(1)
			EndGame()
		end)
	end
end
