options = 
{
	{
		default = 4,
		label = "Build Time", 
		help = "Length of initial building time.", 
		key = 'Option_BuildTime',
		pref = 'Option_BuildTime', 
		values = { 
			{text = "0:30",help = "", key = 30, }, 
			{text = "1:00",help = "", key = 60, }, 
			{text = "1:30",help = "", key = 90, }, 
			{text = "2:00",help = "", key = 120, }, 
			{text = "2:30",help = "", key = 150, }, 
			{text = "3:00",help = "", key = 180, }, 
			{text = "4:00",help = "", key = 240, }, 
		}, 
	},
	{ 
		default = 2,
		label = "Platoon difficulty",
		help = "How many platoons attack each wave (per player).", 
		key = 'Option_PlatoonWaveCount', 
		pref = 'Option_PlatoonWaveCount', 
		values = {
			{text = "Easy",help = "Best for first time Play", key = 1, },
			{text = "Moderate",help = "Hard even for Pro's", key = 2, },
			{text = "Hard",help = "Impossible. Quantum computer needed", key = 3, },
		}, 
	},
	{
		default = 10,
		label = "Health Multiplier",
		help = "Health of the (enemy) survival units",
		key = 'Option_HealthMultiplier',
		pref = 'Option_HealthMultiplier',
		values = {
			{ text = "10 percent", help = "10 percent", key = 0.1, },
			{ text = "20 percent", help = "10 percent", key = 0.2, },
			{ text = "30 percent", help = "30 percent", key = 0.3, },
			{ text = "40 percent", help = "10 percent", key = 0.4, },
			{ text = "50 percent", help = "50 percent", key = 0.5, },
			{ text = "60 percent", help = "10 percent", key = 0.6, },
			{ text = "70 percent", help = "70 percent", key = 0.7, },
			{ text = "80 percent", help = "80 percent", key = 0.8, },
			{ text = "90 percent", help = "90 percent", key = 0.9, },
			{ text = "100 percent", help = "100 percent", key = 1.0, },
			{ text = "110 percent", help = "110 percent", key = 1.1, },
			{ text = "120 percent", help = "120 percent", key = 1.2, },
			{ text = "130 percent", help = "130 percent", key = 1.3, },
			{ text = "140 percent", help = "140 percent", key = 1.4, },
			{ text = "150 percent", help = "150 percent", key = 1.5, },
			{ text = "160 percent", help = "160 percent", key = 1.6, },
			{ text = "170 percent", help = "170 percent", key = 1.7, },
			{ text = "180 percent", help = "180 percent", key = 1.8, },
			{ text = "190 percent", help = "190 percent", key = 1.9, },
			{ text = "200 percent", help = "200 percent", key = 2.0, },
			{ text = "210 percent", help = "210 percent", key = 2.1, },
			{ text = "220 percent", help = "225 percent", key = 2.2, },
			{ text = "230 percent", help = "225 percent", key = 2.3, },
			{ text = "240 percent", help = "225 percent", key = 2.4, },
			{ text = "250 percent", help = "250 percent", key = 2.5, },
			{ text = "260 percent", help = "225 percent", key = 2.6, },
			{ text = "270 percent", help = "225 percent", key = 2.7, },
			{ text = "280 percent", help = "225 percent", key = 2.8, },
			{ text = "290 percent", help = "225 percent", key = 2.9, },
			{ text = "300 percent", help = "300 percent", key = 3.0, },
			{ text = "310 percent", help = "310 percent", key = 3.1, },
			{ text = "320 percent", help = "320 percent", key = 3.2, },
			{ text = "330 percent", help = "330 percent", key = 3.3, },
			{ text = "340 percent", help = "340 percent", key = 3.4, },
			{ text = "350 percent", help = "350 percent", key = 3.5, },
			{ text = "360 percent", help = "360 percent", key = 3.6, },
			{ text = "370 percent", help = "370 percent", key = 3.7, },
			{ text = "380 percent", help = "380 percent", key = 3.8, },
			{ text = "390 percent", help = "390 percent", key = 3.9, },
			{ text = "400 percent", help = "400 percent", key = 4.0, },
			{ text = "410 percent", help = "410 percent", key = 4.1, },
			{ text = "420 percent", help = "420 percent", key = 4.2, },
			{ text = "430 percent", help = "420 percent", key = 4.3, },
			{ text = "440 percent", help = "420 percent", key = 4.4, },
			{ text = "450 percent", help = "450 percent", key = 4.5, },
			{ text = "460 percent", help = "420 percent", key = 4.6, },
			{ text = "470 percent", help = "420 percent", key = 4.7, },
			{ text = "480 percent", help = "420 percent", key = 4.8, },
			{ text = "490 percent", help = "420 percent", key = 4.9, },
			{ text = "500 percent", help = "500 percent", key = 5.0, },
			{ text = "750 percent", help = "750 percent", key = 7.5, },
			{ text = "10x", help = "10x", key = 10, },
			{ text = "25x", help = "25x", key = 25, },
			{ text = "100x", help = "100x", key = 100, },
			{ text = "500x", help = "500x", key = 500, },
			{ text = "1000x", help = "1000x", key = 1000, },
			{ text = "10000x", help = "Labs are the new GCs", key = 10000, },
		},
	},
	{
		default = 10,
		label = "Damage Multiplier",
		help = "Damage dealt by the (enemy) survival units",
		key = 'Option_DamageMultiplier',
		pref = 'Option_DamageMultiplier',
		values = {
			{ text = "10 percent", help = "10 percent", key = 0.1, },
			{ text = "20 percent", help = "10 percent", key = 0.2, },
			{ text = "30 percent", help = "30 percent", key = 0.3, },
			{ text = "40 percent", help = "10 percent", key = 0.4, },
			{ text = "50 percent", help = "50 percent", key = 0.5, },
			{ text = "60 percent", help = "10 percent", key = 0.6, },
			{ text = "70 percent", help = "70 percent", key = 0.7, },
			{ text = "80 percent", help = "80 percent", key = 0.8, },
			{ text = "90 percent", help = "90 percent", key = 0.9, },
			{ text = "100 percent", help = "100 percent", key = 1.0, },
			{ text = "110 percent", help = "110 percent", key = 1.1, },
			{ text = "120 percent", help = "120 percent", key = 1.2, },
			{ text = "130 percent", help = "130 percent", key = 1.3, },
			{ text = "140 percent", help = "140 percent", key = 1.4, },
			{ text = "150 percent", help = "150 percent", key = 1.5, },
			{ text = "160 percent", help = "160 percent", key = 1.6, },
			{ text = "170 percent", help = "170 percent", key = 1.7, },
			{ text = "180 percent", help = "180 percent", key = 1.8, },
			{ text = "190 percent", help = "190 percent", key = 1.9, },
			{ text = "200 percent", help = "200 percent", key = 2.0, },
			{ text = "210 percent", help = "210 percent", key = 2.1, },
			{ text = "220 percent", help = "225 percent", key = 2.2, },
			{ text = "230 percent", help = "225 percent", key = 2.3, },
			{ text = "240 percent", help = "225 percent", key = 2.4, },
			{ text = "250 percent", help = "250 percent", key = 2.5, },
			{ text = "260 percent", help = "225 percent", key = 2.6, },
			{ text = "270 percent", help = "225 percent", key = 2.7, },
			{ text = "280 percent", help = "225 percent", key = 2.8, },
			{ text = "290 percent", help = "225 percent", key = 2.9, },
			{ text = "300 percent", help = "300 percent", key = 3.0, },
			{ text = "310 percent", help = "310 percent", key = 3.1, },
			{ text = "320 percent", help = "320 percent", key = 3.2, },
			{ text = "330 percent", help = "330 percent", key = 3.3, },
			{ text = "340 percent", help = "340 percent", key = 3.4, },
			{ text = "350 percent", help = "350 percent", key = 3.5, },
			{ text = "360 percent", help = "360 percent", key = 3.6, },
			{ text = "370 percent", help = "370 percent", key = 3.7, },
			{ text = "380 percent", help = "380 percent", key = 3.8, },
			{ text = "390 percent", help = "390 percent", key = 3.9, },
			{ text = "400 percent", help = "400 percent", key = 4.0, },
			{ text = "410 percent", help = "410 percent", key = 4.1, },
			{ text = "420 percent", help = "420 percent", key = 4.2, },
			{ text = "430 percent", help = "420 percent", key = 4.3, },
			{ text = "440 percent", help = "420 percent", key = 4.4, },
			{ text = "450 percent", help = "450 percent", key = 4.5, },
			{ text = "460 percent", help = "420 percent", key = 4.6, },
			{ text = "470 percent", help = "420 percent", key = 4.7, },
			{ text = "480 percent", help = "420 percent", key = 4.8, },
			{ text = "490 percent", help = "420 percent", key = 4.9, },
			{ text = "500 percent", help = "500 percent", key = 5.0, },
			{ text = "750 percent", help = "750 percent", key = 7.5, },
			{ text = "10x", help = "10x", key = 10, },
			{ text = "25x", help = "25x", key = 25, },
			{ text = "100x", help = "100x", key = 100, },
			{ text = "500x", help = "500x", key = 500, },
			{ text = "1000x", help = "1000x", key = 1000, },
			{ text = "10000x", help = "Because scouts should obviously one-shot ACUs!", key = 10000, },
		},
	},
	{
		default = 2,
		label = "Extra Units / All Factions",
		help = "When enabled, each player get extra engineers or ACUs",
		key = 'Option_AllFactions',
		pref = 'Option_AllFactions',
		values = {
			{ text = "Disabled", help = "No extra units", key = 0, },
			{ text = "Enabled - Extra T1 engineers", help = "Player gets 3 T1 Engineers from same faction", key = 1, },
			{ text = "Enabled - Extra ACU", help = "Player gets 1 extra ACU from same faction", key = 2, },
			{ text = "Enabled - All Factions T1 Engineers", help = "Player gets 3 extra T1 Engineers", key = 3, },
			{ text = "Enabled - All Factions ACUs", help = "Player gets 3 extra ACUs", key = 4, },
		},
	},
	{
		default = 1,
		label = "Resources Settings",
		help = "Hydro and Mass Extractor Points",
		key = 'Option_ResourcesSettings',
		pref = 'Option_ResourcesSettings',
		values = {
			{ text = "Default Resources", help = "Default Resources", key = 0, },
			{ text = "Extra Resources", help = "More Hydro, Mass Points", key = 1, },
			{ text = "No Resources", help = "Disabled All Hydro, Mass Points ", key = 2, },
		},
	},
	{
		default = 1,
		label = "Endless Mode",
		help = "When enabled, the Seraphim attack keeps going on forever",
		key = 'Option_EndlessMode',
		pref = 'Option_EndlessMode',
		values = {
			{ text = "Disabled", help = "When all Rifts are Killed Game stops", key = 0, },
			{ text = "Enabled", help = "Units keep spawning forever", key = 1, },
		},
	},
	{
		default = 1,
		label = "Enable GameBreakers",
		help = "Disable or Enable Paragon and Yolona",
		key = 'Option_GameBreaker',
		pref = 'Option_GameBreaker',
		values = {
			{ text = "Paragon Disabled", help = "No Paragon", key = 0, },
			{ text = "Yolona Oss Disabled", help = "No Yolona Oss", key = 1, },
			{ text = "Paragon and Yolona Oss Disabled", help = "No Paragon and Yolona Oss ", key = 2, },
			{ text = "Gamebreakers Active", help = "Paragon and Yolona Oss is buildable", key = 3, },
		},
	},
};
