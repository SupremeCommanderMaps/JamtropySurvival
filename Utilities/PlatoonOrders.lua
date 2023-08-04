-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local AIAttackUtils = import('/lua/ai/aiattackutilities.lua')

function GiveOrderLand(Army, WaveLayer, OrderId, Units, 
    SpawnLocation, AttackLocation, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6, 
    Formation, Number)
    if OrderId == 1 then
        IssueFormAggressiveMove(Units, AttackLocation, Formation, Number)
        IssueFormAggressiveMove(Units, FinalDestination, Formation, Number)
    elseif OrderId == 2 then
        IssueFormAttack(Units, AttackLocation, Formation, Number)
        IssueFormAttack(Units, FinalDestination, Formation, Number)
    elseif OrderId == 3 then
        IssueFormMove(Units, AttackLocation, Formation, Number)
        IssueFormMove(Units, FinalDestination, Formation, Number)
    elseif OrderId == 4 then
        IssueFormPatrol(Units, AttackLocation, Formation, Number)
        IssueFormPatrol(Units, FinalDestination, Formation, Number)
    elseif OrderId == 5 then
        IssueAggressiveMove(Units, AttackLocation)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 6 then
        IssueAttack(Units, AttackLocation)
        IssueAttack(Units, FinalDestination)
    elseif OrderId == 7 then
        IssueMove(Units, AttackLocation)
        IssueMove(Units, FinalDestination)
    elseif OrderId == 8 then
        IssuePatrol(Units, AttackLocation)
        IssuePatrol(Units, FinalDestination)
    else
        WARN("Invalid Land order id: " .. repr(OrderId))
    end
end



function GiveOrderNavy(Army, WaveLayer, OrderId, Units, 
        SpawnLocation, AttackLocation, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6, 
        Formation, Number)
    if OrderId == 1 then
        IssueFormAggressiveMove(Units, Location1, Formation, Number)
        IssueFormAggressiveMove(Units, Location2, Formation, Number)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 2 then
        IssueFormAttack(Units, Location1, Formation, Number)
        IssueFormAttack(Units, Location2, Formation, Number)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 3 then
        IssueFormMove(Units, Location1, Formation, Number)
        IssueFormMove(Units, Location2, Formation, Number)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 4 then
        IssueFormPatrol(Units, Location1, Formation, Number)
        IssueFormPatrol(Units, Location2, Formation, Number)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 5 then
        IssueAggressiveMove(Units, Location1)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 6 then
        IssueAttack(Units, Location1)
        IssueAttack(Units, FinalDestination)
    elseif OrderId == 7 then
        IssueMove(Units, Location1)
        IssueMove(Units, FinalDestination)
    elseif OrderId == 8 then
        IssuePatrol(Units, Location1)
        IssuePatrol(Units, Location2)
        IssueMove(Units, FinalDestination)


    elseif OrderId == 10 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, SpawnLocation, FinalDestination, 1)
        for x, Pointlocations in PathWayPoints do
            IssueFormAggressiveMove(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 11 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, SpawnLocation, FinalDestination, 1)
        for x, Pointlocations in PathWayPoints do
            IssueFormAttack(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 12 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, SpawnLocation, FinalDestination, 1)
        for x, Pointlocations in PathWayPoints do
            IssueFormMove(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 13 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, Location1, Location2, 1)
        for x, Pointlocations in PathWayPoints do
            IssueFormPatrol(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 14 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, SpawnLocation, FinalDestination, 1)
        for x, Pointlocations in PathWayPoints do
            IssueAggressiveMove(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 15 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, SpawnLocation, FinalDestination, 1)
        for x, Pointlocations in PathWayPoints do
            IssueAttack(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 16 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, SpawnLocation, FinalDestination, 1)
        for x, Pointlocations in PathWayPoints do
            IssueMove(Units, Pointlocations, Formation, Number)
        end
    elseif OrderId == 17 then
        local aiBrain = GetArmyBrain(Army)
        local PathWayPoints, PathWay  = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, WaveLayer, Location1, Location2, 1)
        for x, Pointlocations in PathWayPoints do
            IssuePatrol(Units, Pointlocations, Formation, Number)
        end
    else
        WARN("Invalid Navy order id: " .. repr(OrderId))
    end
end

function GiveOrderAir(Army, WaveLayer, OrderId, Units, 
    SpawnLocation, AttackLocation, FinalDestination, Location1, Location2, Location3, Location4, Location5, Location6, 
    Formation, Number)
    if OrderId == 1 then
        IssueFormAggressiveMove(Units, Location1, Formation, Number)   
        IssueFormAggressiveMove(Units, Location2, Formation, Number)   
        IssueFormAggressiveMove(Units, Location3, Formation, Number)   
        IssueFormAggressiveMove(Units, Location4, Formation, Number)   
        IssueFormAggressiveMove(Units, Location5, Formation, Number)                             
        IssueFormAggressiveMove(Units, Location6, Formation, Number)
        IssueFormAggressiveMove(Units, AttackLocation, Formation, Number)        
        IssueFormAggressiveMove(Units, FinalDestination, Formation, Number)
    elseif OrderId == 2 then
        IssueFormAttack(Units, AttackLocation, Formation, Number)
        IssueFormAttack(Units, FinalDestination, Formation, Number)
    elseif OrderId == 3 then
        IssueFormMove(Units, AttackLocation, Formation, Number)
        IssueFormMove(Units, FinalDestination, Formation, Number)
    elseif OrderId == 4 then
        IssueFormPatrol(Units, Location1, Formation, Number)  
        IssueFormPatrol(Units, Location2, Formation, Number)  
        IssueFormPatrol(Units, Location3, Formation, Number)
        IssueFormPatrol(Units, Location4, Formation, Number)
        IssueFormPatrol(Units, Location5, Formation, Number)
        IssueFormPatrol(Units, Location6, Formation, Number)
    elseif OrderId == 5 then
        IssueAggressiveMove(Units, AttackLocation)
        IssueAggressiveMove(Units, FinalDestination)
    elseif OrderId == 6 then
        IssueAttack(Units, AttackLocation)
        IssueAttack(Units, FinalDestination)
    elseif OrderId == 7 then
        IssueMove(Units, AttackLocation)
        IssueMove(Units, FinalDestination)
    elseif OrderId == 8 then
        IssuePatrol(Units, AttackLocation)
        IssuePatrol(Units, FinalDestination)
    else
        WARN("Invalid Air order id: " .. repr(OrderId))
    end
end