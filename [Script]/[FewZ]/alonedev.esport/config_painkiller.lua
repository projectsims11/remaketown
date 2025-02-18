
Config['Painkiller'] = {
    {
        ['item_name'] = 'bandage', 
        ['CheckCount'] = true ,
        ['Job'] = nil ,
        ['Zone'] = nil ,
        ['HealthPlus'] = 20,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 3,
        ['Remove'] = true,
    },
    {
        ['item_name'] = 'painkiller', 
        ['CheckCount'] = true ,
        ['Job'] = nil ,
        ['Zone'] = nil ,
        ['HealthPlus'] = 30,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 3,
        ['Remove'] = true,
    },
    {
        ['item_name'] = 'painkiller_agency',
        ['CheckCount'] = true ,
        ['Job'] = {'police' , 'ambulance' , 'council'} ,
        ['Zone'] = nil ,
        ['HealthPlus'] = 40,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 3,
        ['Remove'] = false,
    },
}