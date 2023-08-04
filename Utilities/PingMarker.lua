-----------------------------------------------------------------------------------------------------------
---------- 									   Made by Jammer                                    ----------
----------         For the latest version go to: https://github.com/SupremeCommanderMaps         ----------
---------- 				   Do not remove this message when modifying the map				     ----------
---------- 							   For information see Readme						   	     ----------
-----------------------------------------------------------------------------------------------------------

local SimPing = import('/lua/simping.lua')

-- format of the ping
-- local data = {Owner = army - 1, Type = pingType, Location = position}
-- data = table.merged(data, PingTypes[pingType])

local PingTypes = {
    alertCybranSound = {Lifetime = 6, Mesh = 'alert_marker', Ring = '/game/marker/ring_yellow02-blur.dds', ArrowColor = 'yellow', Sound = 'UI_Main_IG_Click'},    
    alert = {Lifetime = 6, Mesh = 'alert_marker', Ring = '/game/marker/ring_yellow02-blur.dds', ArrowColor = 'yellow', Sound = 'UEF_Select_Radar'},    
    alertlong = {Lifetime = 12, Mesh = 'alert_marker', Ring = '/game/marker/ring_yellow02-blur.dds', ArrowColor = 'yellow', Sound = 'UEF_Select_Radar'},
    move = {Lifetime = 6, Mesh = 'move', Ring = '/game/marker/ring_blue02-blur.dds', ArrowColor = 'blue', Sound = 'Cybran_Select_Radar'},
    attack = {Lifetime = 6, Mesh = 'attack_marker', Ring = '/game/marker/ring_red02-blur.dds', ArrowColor = 'red', Sound = 'Aeon_Select_Radar'},
    marker = {Lifetime = 5, Ring = '/game/marker/ring_yellow02-blur.dds', ArrowColor = 'yellow', Sound = 'UI_Main_IG_Click', Marker = true},
}

function getMoveMarker(position, army)
    local data = { }
    data.Owner = army
    data.Type = 'move'
    data.Location = position
    SimPing.SpawnPing(table.merged(data, PingTypes[data.Type]))
end

function getAlertMarkerReinforcementDrops(position, army)
    local data = { }
    data.Owner = army
    data.Type = 'alertCybranSound'
    data.Location = position
    SimPing.SpawnPing(table.merged(data, PingTypes[data.Type]))
end

function getAlertMarker(position, army)
    local data = { }
    data.Owner = army
    data.Type = 'alert'
    data.Location = position
    SimPing.SpawnPing(table.merged(data, PingTypes[data.Type]))
end

function getAlertMarkerLong(position, army)
    local data = { }
    data.Owner = army
    data.Type = 'alertlong'
    data.Location = position
    SimPing.SpawnPing(table.merged(data, PingTypes[data.Type]))
end

function getAttackMarker(position, army)
    local data = { }
    data.Owner = army
    data.Type = 'attack'
    data.Location = position
    SimPing.SpawnPing(table.merged(data, PingTypes[data.Type]))
end


