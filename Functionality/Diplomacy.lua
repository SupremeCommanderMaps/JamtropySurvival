-----------------------------------------------------------------------------------------------------------ArmyOrderBoss
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

function SetupDiplomacy(PlayerArmies, EnemyArmies)  
    for _, Army in PlayerArmies do
        for _, ArmyX in PlayerArmies do
            SetAlliance(Army, ArmyX, 'Ally')
            SetAlliedVictory(Army, true)
        end
    end
    for _, Army in PlayerArmies do
        for _, ArmyEnemy in EnemyArmies do 
            SetAlliance(Army, ArmyEnemy, 'Enemy') 
        end
    end

    for _, ArmyEnemy in EnemyArmies do 
        SetIgnoreArmyUnitCap(ArmyEnemy, true)
        GetArmyBrain(ArmyEnemy):SetResourceSharing(false)
        GetArmyBrain(ArmyEnemy):GiveStorage('Energy', 10000)
    end
end

