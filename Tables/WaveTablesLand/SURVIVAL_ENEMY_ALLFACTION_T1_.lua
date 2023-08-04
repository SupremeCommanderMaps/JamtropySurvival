--Possible OrderIds
-- 1 = FormAggressiveMove 
-- 2 = FormAttack
-- 3 = FormMove
-- 4 = FormPatrol
-- 5 = AggressiveMove
-- 6 = IssueAttack
-- 7 = IssueMove
-- 8 = IssuePatrol

--Possible Formations = 'AttackFormation', 'GrowthFormation',

Tables = { 
    {   
        LandMovementSpeed = 3,
        LandUnitsIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
        HoverMovementSpeed = 3.3,
        HoverUnitsIds = {
            'UAL0101', 'UAL0101', 
        },
        NavyMovementSpeed = 3.5,
        NavyUnitsIds = {
            'UAS0103', 'UAS0103', 
        },
    },
    {
        LandMovementSpeed = 3,
        LandUnitsIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
        HoverMovementSpeed = 3.3,
        HoverUnitsIds = {
            'UAL0101', 'UAL0101', 
        },
        NavyMovementSpeed = 3.8,
        NavyUnitsIds = {
            'UAS0103', 'UAS0103', 
        },
    },
    {
        LandMovementSpeed = 3,
        LandUnitsIds = {
        --2* T1 Scout   
        'UAL0101', 'UAL0101', 
        --4* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
        HoverMovementSpeed = 3.3,
        HoverUnitsIds = {
            'UAL0101', 'UAL0101', 
        },
        NavyMovementSpeed = 3.8,
        NavyUnitsIds = {
            'UAS0103', 'UAS0103', 
        },
    },
    {
        LandMovementSpeed = 3,
        LandUnitsIds = {
        --8* T1BOT
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        'UAL0106', 'UAL0106', 'UAL0106', 'UAL0106',
        },
        HoverMovementSpeed = 3.3,
        HoverUnitsIds = {
            'UAL0101', 'UAL0101', 
        },
        NavyMovementSpeed = 3.8,
        NavyUnitsIds = {
            'UAS0103', 'UAS0103', 
        }
    }
}