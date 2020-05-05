version = 3 -- Lua Version. Dont touch this
ScenarioInfo = {
    name = "Jamtropy Survival",
    description = "Adaptive survival map by Jammer and EntropyWins",
    preview = '',
    map_version = 1,
    type = 'skirmish',
    starts = true,
    size = {1024, 1024},
    reclaim = {0, 0},
    map = '/maps/Jamtropy_Survival.v0001/Jamtropy_Survival.scmap',
    save = '/maps/Jamtropy_Survival.v0001/Jamtropy_Survival_save.lua',
    script = '/maps/Jamtropy_Survival.v0001/Jamtropy_Survival_script.lua',
    norushradius = 40,
    Configurations = {
        ['standard'] = {
            teams = {
                {
                    name = 'FFA',
                    armies = {'ARMY_1', 'ARMY_2', 'ARMY_3', 'ARMY_4', 'ARMY_5', 'ARMY_6', 'ARMY_7', 'ARMY_8'}
                },
            },
            customprops = {
                ['ExtraArmies'] = STRING( 'SURVIVAL_ENEMY NEUTRAL_CIVILIAN' ),
            },
        },
    },
}
