Config = {}

Config.Setting = {
    Pos = vector4(-273.7708, -955.1687, 144.5968, 152.8528);
    NPC = {
        Show = true;
        ModelName = "u_m_y_juggernaut_01";
        ModelHash = "u_m_y_juggernaut_01";
        AnimDictionary = "mini@strip_club@idles@bouncer@base";
        AnimationName = "base";
    };
    Alert = {
        DisplayHelpText = '<font face="sarabun">กด ~r~[E] ~w~เพื่อรับของผู้เล่นใหม่</font>'; -- @ 'Press ~r~[E] ~w~to ~r~Register User~w~'
    };
    Item = {
        { Name = "newplayer_box", Count = 1 };
    }
}