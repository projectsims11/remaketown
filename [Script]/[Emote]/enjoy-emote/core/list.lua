DP = {}

DP.Expressions = {
   ["Angry"] = {"Expression", "mood_angry_1"},
   ["Drunk"] = {"Expression", "mood_drunk_1"},
   ["Dumb"] = {"Expression", "pose_injured_1"},
   ["Electrocuted"] = {"Expression", "electrocuted_1"},
   ["Grumpy"] = {"Expression", "effort_1"},
   ["Grumpy2"] = {"Expression", "mood_drivefast_1"},
   ["Grumpy3"] = {"Expression", "pose_angry_1"},
   ["Happy"] = {"Expression", "mood_happy_1"},
   ["Injured"] = {"Expression", "mood_injured_1"},
   ["Joyful"] = {"Expression", "mood_dancing_low_1"},
   ["Mouthbreather"] = {"Expression", "smoking_hold_1"},
   ["Never Blink"] = {"Expression", "pose_normal_1"},
   ["One Eye"] = {"Expression", "pose_aiming_1"},
   ["Shocked"] = {"Expression", "shocked_1"},
   ["Shocked2"] = {"Expression", "shocked_2"},
   ["Sleeping"] = {"Expression", "mood_sleeping_1"},
   ["Sleeping2"] = {"Expression", "dead_1"},
   ["Sleeping3"] = {"Expression", "dead_2"},
   ["Smug"] = {"Expression", "mood_smug_1"},
   ["Speculative"] = {"Expression", "mood_aiming_1"},
   ["Stressed"] = {"Expression", "mood_stressed_1"},
   ["Sulking"] = {"Expression", "mood_sulk_1"},
   ["Weird"] = {"Expression", "effort_2"},
   ["Weird2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Armored"] = {"anim_group_move_ballistic"},
  ["Arrogant"] = {"move_f@arrogant@a"},
  ["Brave"] = {"move_m@brave"},
  ["Casual"] = {"move_m@casual@a"},
  ["Casual2"] = {"move_m@casual@b"},
  ["Casual3"] = {"move_m@casual@c"},
  ["Casual4"] = {"move_m@casual@d"},
  ["Casual5"] = {"move_m@casual@e"},
  ["Casual6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Confident"] = {"move_m@confident"},
  ["Cop"] = {"move_m@business@a"},
  ["Cop2"] = {"move_m@business@b"},
  ["Cop3"] = {"move_m@business@c"},
  ["Default Female"] = {"move_f@multiplayer"},
  ["Default Male"] = {"move_m@multiplayer"},
  ["Drunk"] = {"move_m@drunk@a"},
  ["Drunk"] = {"move_m@drunk@slightlydrunk"},
  ["Drunk2"] = {"move_m@buzzed"},
  ["Drunk3"] = {"move_m@drunk@verydrunk"},
  ["Femme"] = {"move_f@femme@"},
  ["Fire"] = {"move_characters@franklin@fire"},
  ["Fire2"] = {"move_characters@michael@fire"},
  ["Fire3"] = {"move_m@fire"},
  ["Flee"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster2"] = {"move_m@gangster@ng"},
  ["Gangster3"] = {"move_m@gangster@var_e"},
  ["Gangster4"] = {"move_m@gangster@var_f"},
  ["Gangster5"] = {"move_m@gangster@var_i"},
  ["Grooving"] = {"anim@move_m@grooving@"},
  ["Guard"] = {"move_m@prison_gaurd"},
  ["Handcuffs"] = {"move_m@prisoner_cuffed"},
  ["Heels"] = {"move_f@heels@c"},
  ["Heels2"] = {"move_f@heels@d"},
  ["Hiking"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Hurry"] = {"move_f@hurry@a"},
  ["Janitor"] = {"move_p_m_zero_janitor"},
  ["Janitor2"] = {"move_p_m_zero_slow"},
  ["Jog"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester2"] = {"move_lester_caneup"},
  ["Maneater"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Money"] = {"move_m@money"},
  ["Muscle"] = {"move_m@muscle@a"},
  ["Posh"] = {"move_m@posh@"},
  ["Posh2"] = {"move_f@posh@"},
  ["Quick"] = {"move_m@quick"},
  ["Runner"] = {"female_fast_runner"},
  ["Sad"] = {"move_m@sad@a"},
  ["Sassy"] = {"move_m@sassy"},
  ["Sassy2"] = {"move_f@sassy"},
  ["Scared"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Shady"] = {"move_m@shadyped@a"},
  ["Slow"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Tough"] = {"move_m@tough_guy@"},
  ["Tough2"] = {"move_f@tough_guy@"},
--  ["Trash"] = {"clipset@move@trash_fast_turn"},
 -- ["Trash2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Wide"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "hug", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["Hugnew"] = {"misscarsteal2chad_goodbye", "chad_armsaround_chad", "Hugnew", "Hugnew2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.35,
       SyncOffsetX = -0.04
   }},
   ["Hugnew2"] = {"misscarsteal2chad_goodbye", "chad_armsaround_girl", "Hugnew2", "Hugnew", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.35,
       SyncOffsetX = -0.04
   }},
   ["Hugnew3"] = {"misscarsteal2chad_goodbye", "chad_idle_chad", "Hugnew3", "Hugnew4", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.70,
       SyncOffsetX = -0.15
   }},
   ["Hugnew4"] = {"misscarsteal2chad_goodbye", "chad_idle_girl", "Hugnew4", "Hugnew3", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       SyncOffsetFront = 0.70,
       SyncOffsetX = -0.15
   }},
   ["Kiss"] = {"hs3_ext-20", "cs_lestercrest_3_dual-20", "Kiss", "Kiss2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08,
   }},
   ["Kiss2"] = {"hs3_ext-20", "csb_georginacheng_dual-20", "Kiss 2", "Kiss", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08
   }},
   ["Kiss3"] = {"hs3_ext-19", "cs_lestercrest_3_dual-19", "Kiss 3", "Kiss4", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08,
   }},
   ["Kiss4"] = {"hs3_ext-19", "csb_georginacheng_dual-19", "Kiss 4", "Kiss3", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 10000,
       SyncOffsetFront = 0.08
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "hug2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["Blowjob"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "Blowjob", "Blowjob2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 20000,
       SyncOffsetFront = 0.13,
       SyncOffsetX = -0.02,
       
   }},
   ["Blowjob2"] = {"misscarsteal2pimpsex", "pimpsex_pimp", "Blowjob 2", "Blowjob", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 20000,
       SyncOffsetFront = 0.53,
       SyncOffsetX = -0.02,
       
   }},

   ["Sex"] = {"misscarsteal2pimpsex", "shagloop_hooker", "Sex", "Sex2", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53
   }},
   
   ["Sex2"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Sex2", "Sex", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53
   }},

  --[[ ["sex3"] = {"random@drunk_driver_2", "cardrunksex_loop_m", "sex3", "sex4", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = -0.40,
       SyncOffsetX = -0.50,
   }},
   ["sex4"] = {"random@drunk_driver_2", "cardrunksex_loop_f", "sex4", "sex3", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53
   }},]]

   ["Doggy"] = {"rcmpaparazzo_2", "shag_action_a", "Doggy", "Doggy2", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53,
       --HeadingOffset = 0.0,
   }},
   ["Doggy2"] = {"rcmpaparazzo_2", "shag_action_poppy", "Doggy2", "Doggy", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53,
       HeadingOffset = 0.0,
   }},

--    ["joinhand"] = {"timetable@trevor@ig_1", "ig_1_thedesertissobeautiful_trevor", "joinhand", "joinhand2", AnimationOptions =
--    {
--        EmoteMoving = false,
--        EmoteLoop = true,
--        SyncNoOffsetFront = true,
--        --SyncOffsetFront = 0.00,
--        SyncOffsetY = -0.65,
--        SyncOffsetX = 0.55,
--        HeadingOffset = 0.0,
--    }},
--    ["joinhand2"] = {"timetable@trevor@ig_1", "ig_1_thedesertissobeautiful_patricia", "joinhand2", "joinhand", AnimationOptions =
--    {
--        EmoteMoving = true,
--        EmoteLoop = true,
--        SyncOffsetFront = 0.53
--    }},

  --[[ ["missace"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_trevor", "missace", "missace2", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.80,
       SyncOffsetX = -0.83,
       HeadingOffset = 0.0,
   }},
   ["missace2"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_floyd", "missace2", "missace", AnimationOptions =
   {
       EmoteLoop = true,
       SyncOffsetFront = 0.53,
       
   }},]]
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   
   ["give"] = {"mp_common", "givetake1_a", "Give", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Give 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Baseball Throw", "baseball"},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Stickup Scared", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Punch", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Punched", "punch"},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt", "headbutted"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Headbutted", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Slap 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Slapped", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Slapped 2", "slap2"},
}

DP.Dances = {
    ["Apenguin1"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_b_f02", "REMAKE · Dance 1", AnimationOptions =
    {
        EmoteLoop = true,
    }},

    ["Apenguin2"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_b_m03", "REMAKE · Dance 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin3"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_b_m04", "REMAKE · Dance 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin4"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_to_mi_m01", "REMAKE · Dance 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin5"] = {"anim@amb@nightclub_island@dancers@beachdance@", "li_idle_c_f01", "REMAKE · Dance 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin6"] = {"anim@amb@nightclub_island@dancers@beachdance@", "ti_to_hi_m03", "REMAKE · Dance 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin7"] = {"anim@amb@nightclub@mini@dance@dance_solo@jumper@", "high_center", "REMAKE · Dance 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin8"] = {"anim@amb@nightclub@mini@dance@dance_solo@jumper@", "high_center_down", "REMAKE · Dance 8 ", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin9"] = {"anim@amb@nightclub@mini@dance@dance_solo@jumper@", "high_center_up", "REMAKE · Dance 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin10"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", "high_center", "REMAKE · Dance 10", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin11"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", "low_center_up", "REMAKE · Dance 11", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin12"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", "med_center_up", "REMAKE · Dance 12", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin13"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_karate@", "med_right", "REMAKE · Dance 13", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin14"] = {"anim@amb@nightclub_island@dancers@club@", "li_idle_a_f01", "REMAKE · Dance 14", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin15"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_h@", "ped_a_dance_idle", "REMAKE · Dance 15", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin16"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_h@", "ped_b_dance_idle", "REMAKE · Dance 16", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin17"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "high_center_down", "REMAKE · Dance 17", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin18"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "low_center_down", "REMAKE · Dance 18", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin19"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_f@", "ped_b_dance_idle", "REMAKE · Dance 19", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Apenguin20"] = {"anim@amb@nightclub_island@dancers@club@", "hi_idle_a_f03", "REMAKE · Dance 20", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok1"] = {"custom@crossbounce", "crossbounce", "Tiktok Dance 1 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok2"] = {"custom@dont_start", "dont_start", "Tiktok Dance 2 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok3"] = {"custom@floss", "floss", "Tiktok Dance 3 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok4"] = {"custom@orangejustice", "orangejustice", "Tiktok Dance 4 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok5"] = {"custom@renegade", "renegade", "Tiktok Dance 5 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok6"] = {"custom@rickroll", "rickroll", "Tiktok Dance 6 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok7"] = {"custom@savage", "savage", "Tiktok Dance 7 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok8"] = {"custom@sayso", "sayso", "Tiktok Dance 8 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok9"] = {"custom@take_l", "take_l", "Tiktok Dance 9 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["tiktok10"] = {"custom@toosie_slide", "toosie_slide", "Tiktok Dance 10 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update1"] = {"divined@fndances@new", "dbdance1", "REMAKE Dance 1 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update2"] = {"divined@fndances@new", "dbdance2", "REMAKE Dance 2 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update3"] = {"divined@fndances@new", "dbdance3", "REMAKE Dance 3 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update4"] = {"divined@fndances@new", "dbdance4", "REMAKE Dance 4 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update5"] = {"divined@fndances@new", "dbdance5", "REMAKE Dance 5 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update6"] = {"divined@fndances@new", "dbdance6", "REMAKE Dance 6 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update7"] = {"divined@fndances@new", "dbdance7", "REMAKE Dance 7 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update8"] = {"divined@fndances@new", "dbdance8", "REMAKE Dance 8 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["2022update9"] = {"divined@fndances@new", "dbdance9", "REMAKE Dance 9 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update10"] = {"divined@fndances@new", "dbdance10", "REMAKE Dance 10 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update11"] = {"divined@fndances@new", "dbdance11", "REMAKE Dance 11 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update12"] = {"divined@fndances@new", "dbdance12", "REMAKE Dance 12 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update13"] = {"divined@fndances@new", "dbdance13", "REMAKE Dance 13 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update14"] = {"divined@fndances@new", "dbdance14", "REMAKE Dance 14 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update15"] = {"divined@fndances@new", "dbdance15", "REMAKE Dance 15 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update16"] = {"divined@fndances@new", "dbdance16", "REMAKE Dance 16 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update17"] = {"divined@fndances@new", "dbdance17", "REMAKE Dance 17 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update18"] = {"divined@fndances@new", "dbdance18", "REMAKE Dance 18 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update19"] = {"divined@fndances@new", "dbdance19", "REMAKE Dance 19 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
       ["2022update20"] = {"divined@fndances@new", "dbdance20", "REMAKE Dance 20 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
          ["2022update21"] = {"divined@fndances@new", "dbdance21", "REMAKE Dance 21 ~y~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    
    

    ["2022New1"] = {"mikey@dances@new", "mdance1", "REMAKE Dance N 1 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New2"] = {"mikey@dances@new", "mdance2", "REMAKE Dance N 2 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New3"] = {"mikey@dances@new", "mdance3", "REMAKE Dance N 3 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New4"] = {"mikey@dances@new", "mdance4", "REMAKE Dance N 4 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New5"] = {"mikey@dances@new", "mdance5", "REMAKE Dance N 5 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New6"] = {"mikey@dances@new", "mdance6", "REMAKE Dance N 6 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New7"] = {"mikey@dances@new", "mdance7", "REMAKE Dance N 7 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New8"] = {"mikey@dances@new", "mdance8", "REMAKE Dance N 8 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New9"] = {"mikey@dances@new", "mdance9", "REMAKE Dance N 9 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New10"] = {"mikey@dances@new", "mdance10", "REMAKE Dance N 10 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New11"] = {"mikey@dances@new", "mdance11", "REMAKE Dance N 11 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New12"] = {"mikey@dances@new", "mdance12", "REMAKE Dance N 12 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New13"] = {"mikey@dances@new", "mdance13", "REMAKE Dance N 13 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["2022New14"] = {"mikey@dances@new", "mdance14", "REMAKE Dance N 14 ~y~ NEW", AnimationOptions =
   {
       EmoteLoop = true
   }},
    ["DiamondX1"] = {"custom@armswirl", "armswirl", "REMAKE 1 ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
   ["DiamondxX2"] = {"custom@armwave", "armwave", "REMAKE 2 ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
   ["DiamondX3"] = {"custom@circle_crunch", "circle_crunch", "REMAKE 3 ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
   ["DiamondX4"] = {"custom@gangnamstyle", "gangnamstyle", "REMAKE 4 ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
   ["DiamondX5"] = {"custom@makarena", "makarena", "REMAKE 5 ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
   ["DiamondX6"] = {"custom@maraschino", "maraschino", "REMAKE 6  ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
   ["DiamondX7"] = {"custom@salsa", "salsa", "REMAKE 7 ~y~New", AnimationOptions =
   {
    EmoteLoop = true,
    EmoteMoving = false,
   }},
    ["2022New15"] = {"custom@rollie", "rollie", "REMAKE Dance N 15 ~y~ NEW", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["2022New16"] = {"custom@wanna_see_me", "wanna_see_me", "REMAKE Dance N 16 ~y~ NEW", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["2022New17"] = {"custom@billybounce", "billybounce", "REMAKE Dance N 17 ~y~ NEW", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["2022New18"] = {"custom@downward_fortnite", "Downward_fortnite", "REMAKE Dance N 18 ~y~ NEW", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["2022New19"] = {"custom@pullup", "pullup", "REMAKE Dance N ~y~ NEW", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["ddance1"] = {"divined@dances@new", "ddance1", "REMAKE Dance A 1 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance2"] = {"divined@dances@new", "ddance2", "REMAKE Dance A 2 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance3"] = {"divined@dances@new", "ddance3", "REMAKE Dance A 3 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance4"] = {"divined@dances@new", "ddance4", "REMAKE Dance A 4 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance5"] = {"divined@dances@new", "ddance5", "REMAKE Dance A 5 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance6"] = {"divined@dances@new", "ddance6", "REMAKE Dance A 6 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance7"] = {"divined@dances@new", "ddance7", "REMAKE Dance A 7 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance8"] = {"divined@dances@new", "ddance8", "REMAKE Dance A 8 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance9"] = {"divined@dances@new", "ddance9", "REMAKE Dance A 9 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance10"] = {"divined@dances@new", "ddance10", "REMAKE Dance A 10 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance11"] = {"divined@dances@new", "ddance11", "LEGEHFUNNCY Dance A 11 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance12"] = {"divined@dances@new", "ddance12", "REMAKE Dance A 12 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["ddance13"] = {"divined@dances@new", "ddance13", "REMAKE Dance A 13 ~y~New", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dancef4"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dance (Female) 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dance (Female) 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance (Female) 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dance (Female)", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dance (Female) 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance (Female) 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dance (Slow) 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dance (Slow) 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dance (Slow) 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancem"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dance (Male)", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 ["dance6"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "med_center", "Dance 6 ", AnimationOptions =
 {
     EmoteLoop = true,      
 }},
 ["drill"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_15_v1_male^1", "REMAKE Drill ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["drill3"] = {"anim@mp_player_intcelebrationmale@oh_snap", "oh_snap", "REMAKE Drill 3 ~y~New", AnimationOptions =
 {
    EmoteMoving = false,
    EmoteLoop = true,
 }},
 ["danceslow6"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_15_v1_male^2", "Dance (Slow) 6 ", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["danceslow5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_13_v2_male^5", "Dance (Slow) 5 ", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["dancem5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^2", "Dance (Male) 5 ", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["dancef8"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_13_v1_female^1", "Dance (Female) 8 ", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
    ["dancem2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance (Male) 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancem3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance (Male) 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancem4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance (Male) 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceup"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance (Up)", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceup2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance (Up) 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance (Shy)", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance (Shy) 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance (Slow)", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dance (Crazy) 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance2"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dance 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance3"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance4"] = {"missfbi3_sniping", "dance_m_default", "Dance 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["drill2"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v2_male^2", "Drill 2 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["dancem6"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v2_male^3", "Dance (Male) 6 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["dancem7"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v2_male^4", "Dance (Male) 7 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["dancem8"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v2_male^5", "Dance (Male) 8 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,    
 }},
 ["danceslow7"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_li_12_v1_male^2", "Dance (Slow) 7  ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,    
 }},
 ["danceslow8"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_li_12_v1_male^5", "Dance (Slow) 8 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["danceslow9"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_li_12_v1_male^4", "Dance (Slow) 9 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["danceparty"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_li_12_v1_male^2", "Dance (Party) ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,
 }},
 ["danceparty2"] = {"anim@amb@nightclub@dancers@crowddance_facedj_transitions@", "trans_dance_facedj_li_to_hi_09_v1_male^4", "Dance (Party) 2 ~y~New", AnimationOptions =
 {
     EmoteLoop = true,
     EmoteMoving = false,                      
 }},
    ["dancecrazy"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance (Crazy)", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance (Crazy) 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance (Crazy) 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance (Crazy) 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance (Crazy) 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance (Crazy) 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance5"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancecrazy8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance (Crazy) 8", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dancecrazy7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance (Crazy) 7", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dance"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance", AnimationOptions =
    {
        EmoteLoop = true
    }},
    
    ["Lackdev10"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_17_v2_female^1", "DX Dance", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev11"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^3", "DX Dance 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    
    ["Lackdev12"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^2", "DX Dance 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev13"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^4", "DX Dance 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev14"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^3", "DX Dance 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev15"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^5", "DX Dance 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev16"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^3", "DX Dance 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev17"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^2", "DX Dance 8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev18"] = {"anim@amb@nightclub@djs@solomun@", "sol_trans_out_to_rt_a_sol", "DX Dance 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev19"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^3", "DX Dance 10", AnimationOptions =
    {
        EmoteLoop = true,
    }},
 
    ["Lackdev20"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^2", "DX Dance 11", AnimationOptions =
    {
        EmoteLoop = true,
    }},

   ["Lackdev10"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_17_v1_female^6", "DX Dance 12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev2"] = {"anim@amb@nightclub@dancers@crowddance_facedj_transitions@", "trans_dance_facedj_hi_to_mi_09_v1_female^3", "DX Dance 13", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev3"] = {"anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", "trans_dance_facedj_hi_to_li_07_v1_female^1", "DX Dance 14", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev4"] = {"anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", "trans_dance_facedj_hi_to_li_07_v1_female^3", "DX Dance 15", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev5"] = {"anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_low_intensity", "trans_dance_facedj_li_to_mi_11_v1_female^3", "DX Dance 16", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev6"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v1_female^1", "DX Dance 17", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev7"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_15_v2_female^3", "DX Dance 18", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev8"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "li_dance_crowd_11_v2_female^3", "DX Dance 19", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["Lackdev9"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_15_v1_female^3", "DX Dance 20", AnimationOptions =
   {
       EmoteLoop = true,
   }},


   
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "DX Dance 21", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "DX Dance 22", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "DX Dance 23", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "DX Dance 24", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "DX Dance 25", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["dancef6"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_11_v1_male^1", "DX Dance 26", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["dancef7"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "hi_dance_facedj_09_v2_male^5", "DX Dance 27", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["dancef8"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^2", "DX Dance 28", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["dancef9"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^6", "DX Dance 29", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "DX Dance 30", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "DX Dance 31", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "DX Dance 32", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["danceslow5"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "DX Dance 33", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["danceslow6"] = {"anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", "trans_crowd_prop_hi_to_li_09_v1_female^1", "DX Dance 34", AnimationOptions =
    {
        EmoteLoop = true,
    }},

    ["danceslow7"] = {"anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", "trans_crowd_prop_hi_to_li_09_v1_female^2", "DX Dance 35", AnimationOptions =
    {
        EmoteLoop = true,
    }},

    
    ["danceslow8"] = {"anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", "trans_crowd_prop_hi_to_li_09_v1_female^3", "DX Dance 36", AnimationOptions =
    {
        EmoteLoop = true,
    }},

    ["danceslow9"] = {"anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", "trans_crowd_prop_hi_to_li_09_v1_female^4", "DX Dance 37", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    


   
   --["Emote1"] = {"switch@trevor@jerking_off", "trev_jerking_off_loop", "Emote Sex", AnimationOptions =
   --{
   --    EmoteLoop = true
   --}},



   ["dance2"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "DX Dance 39", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "DX Dance 40", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^1", "DX Dance 41", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "DX Dance 42", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "DX Dance 43", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^4", "DX Dance 44", AnimationOptions =
   {  
       EmoteLoop = true,
   }},
   ["dance6"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^3", "DX Dance 45", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^4", "DX Dance 46", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^5", "DX Dance 47", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^5", "DX Dance 48", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^1", "DX Dance 49", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^2", "DX Dance 50", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^3", "DX Dance 51", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^4", "DX Dance 52", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^3", "DX Dance 53", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "DX Dance 54", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^3", "DX Dance 55", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^2", "DX Dance 56", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "DX Dance 57", AnimationOptions =
   {
       EmoteLoop = true
   }},

   ["Lackx1"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_11_v1_male^1", "DX Dance 58", AnimationOptions =
   {
       EmoteLoop = true
   }},

   ["Lackx2"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_11_v1_male^2", "DX Dance 59", AnimationOptions =
   {
       EmoteLoop = true
   }},



   ["LackStyle"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon", "DX Dance 60", AnimationOptions =
   {
       EmoteLoop = true,
   }},

   ["LackStyle1"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_11_v1_male^3", "DX Dance 61", AnimationOptions =
   {
       EmoteLoop = true
   }},

   ["LackStyle2"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_11_v1_male^4", "DX Dance 62", AnimationOptions =
   {
       EmoteLoop = true
   }},

   ["LackStyle3"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_11_v1_male^5", "DX Dance 63", AnimationOptions =
   {
       EmoteLoop = true
   }},

   ["LackStyle4"] = {"anim@amb@nightclub@dancers@crowddance_groups@", "mi_dance_crowd_11_v1_male^6", "DX Dance 64", AnimationOptions =
   {
       EmoteLoop = true
   }},

    ["jdrill"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "mi_dance_prop_13_v1_male^3", "REMAKE Dance B 1 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill2"] = {"anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", "mi_dance_crowd_13_v2_male^1", "REMAKE Dance B 2 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill3"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "mi_dance_facedj_17_v2_male^4", "REMAKE Dance B 3 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill4"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "mi_dance_facedj_15_v2_male^4", "REMAKE Dance B 4 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6 · Female", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill5"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "hi_dance_facedj_hu_15_v2_male^5", "REMAKE Dance B 5 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jDrill6"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj@", "hi_dance_facedj_hu_17_male^5", "REMAKE Dance B 6 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jdrill7"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_right_up", "REMAKE Dance B 7 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
     }},
     ["jdrill8"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "med_center", "REMAKE Dance B 8 - ~y~New", AnimationOptions =
     {
         EmoteLoop = true,
      }},
     ["jdrill9"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_right_down", "REMAKE Dance B 9 - ~y~New", AnimationOptions =
      {
          EmoteLoop = true,
       }}, 
       ["jdrill10"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_center", "REMAKE Dance B 10 - ~y~New", AnimationOptions =
      {
          EmoteLoop = true,
       }}, 
    ["jDrill11"] = {"anim@amb@nightclub@mini@dance@dance_solo@shuffle@", "high_left_down", "REMAKE Dance B 11 - ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance 2 · Male", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance 3 · Male", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance 4 · Male", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Upper · Female", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance Upper 2 · Female", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance Shy · Male", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance Shy 2 · Female", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["jshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "med_center_down", "REMAKE Dance Shy 3 ~y~New", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance Slow · Male", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["Salsor"] = {"anim@mp_player_intuppersalsa_roll", "idle_a", "Salso Roll", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dance 8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance Silly · Male 1", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance Silly · Male 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance Silly · Male 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance Silly · Female 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance Silly · Male 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance Silly · Male 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance · Female 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance Silly · Female 8", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Silly · Female 7", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance 5", AnimationOptions =
    {
        EmoteLoop = true
    }},
    ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dance Glowsticks", AnimationOptions =
    {
        Prop = 'ba_prop_battle_glowstick_01',
        PropBone = 28422,
        PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        SecondProp = 'ba_prop_battle_glowstick_01',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dance Glowsticks 2", AnimationOptions =
    {
        Prop = 'ba_prop_battle_glowstick_01',
        PropBone = 28422,
        PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        SecondProp = 'ba_prop_battle_glowstick_01',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        EmoteLoop = true,
    }},
    ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Glowsticks 3", AnimationOptions =
    {
        Prop = 'ba_prop_battle_glowstick_01',
        PropBone = 28422,
        PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
        SecondProp = 'ba_prop_battle_glowstick_01',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
        EmoteLoop = true,
    }},
    ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dance Horse", AnimationOptions =
    {
        Prop = "ba_prop_battle_hobby_horse",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dance Horse 2", AnimationOptions =
    {
        Prop = "ba_prop_battle_hobby_horse",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
    }},
    ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dance Horse 3", AnimationOptions =
    {
        Prop = "ba_prop_battle_hobby_horse",
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,  
     }},
     ["jmonkeyd"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "high_center", "REMAKE Monkey   ~y~New", AnimationOptions =
    {
        EmoteLoop = true
     }},
     ["jmonkeyd2"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "high_center_down", "REMAKE Monkey  2 ~y~New", AnimationOptions =
     {
         EmoteLoop = true
      }},
      ["jmonkeyd3"] = {"anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", "med_center_down", "REMAKE Monkey  3 ~y~New", AnimationOptions =
      {
          EmoteLoop = true
       }},
     ["jrightdown"] = {"anim@amb@nightclub@mini@dance@dance_solo@beach_boxing@", "med_right_down", "Boxing Dance Solo  ~y~New", AnimationOptions =
     {
         EmoteLoop = true
      }},
      ["jlowdance"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "low_center", "Low Dance · Female ", AnimationOptions =
     {
         EmoteLoop = true
        }},
        ["jlowdance2"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "high_center", "Low Dance · Female", AnimationOptions =
        {
         EmoteLoop = true
         }},
        ["jhiphop"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_d@", "ped_a_dance_idle", "REMAKE Hip Hop 1 ~y~New", AnimationOptions =
         {
            EmoteLoop = true
         }},
        ["jhiphop2"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_b@", "ped_a_dance_idle", "REMAKE Hip Hop 2 ~y~New", AnimationOptions =
        {
            EmoteLoop = true
          }},
         ["jhiphop3"] = {"anim@amb@nightclub@mini@dance@dance_paired@dance_a@", "ped_a_dance_idle", "REMAKE Hip Hop 3 ~y~New", AnimationOptions =
         {
            EmoteLoop = true
         }},
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dance F", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dance F2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dance F4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dance F5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dance Slow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dance Slow 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dance Slow 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow5"] = {"misslamar1leadinout", "denise_idle_d", "Dance Slow 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dance", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Upper", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance Upper 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance Shy", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance Shy 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance Slow", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dance Silly 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dance 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dance 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance Silly", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance Silly 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance Silly 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance Silly 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance Silly 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance Silly 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew1"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance New 1", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew2"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon", "Dance New 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew3"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_d_blamadon", "Dance New 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew4"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_11_v1_male^1", "Dance New 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew5"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "hi_dance_facedj_09_v2_male^5", "Dance New 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew6"] = {"anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_15_v2_male^2", "Dance New 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew7"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "mi_dance_prop_15_v1_male^1", "Dance New 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew8"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^1", "Dance New 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew9"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^2", "Dance New 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew10"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^3", "Dance New 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew11"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^4", "Dance New 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew12"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^5", "Dance New 12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew13"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^6", "Dance New 13", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew14"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^1", "Dance New 14", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew15"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^2", "Dance New 15", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew16"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^3", "Dance New 16", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew17"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^4", "Dance New 17", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew18"] = {"anim@amb@nightclub@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^5", "Dance New 18", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew19"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_a_dixon", "Dance New 19", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew20"] = {"anim@amb@nightclub@djs@solomun@", "sol_trans_out_to_rt_a_sol", "Dance New 20", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew21"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^1", "Dance New 21", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew22"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^2", "Dance New 22", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew23"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^3", "Dance New 23", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew24"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^4", "Dance New 24", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew25"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^5", "Dance New 25", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew26"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^6", "Dance New 26", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew27"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^1", "Dance New 27", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew28"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^2", "Dance New 28", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew29"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^3", "Dance New 29", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew30"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^4", "Dance New 30", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew31"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^5", "Dance New 31", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew32"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^6", "Dance New 32", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew33"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^2", "Dance New 33", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew34"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^3", "Dance New 34", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew35"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^4", "Dance New 35", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew36"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^5", "Dance New 36", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew37"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^6", "Dance New 37", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew38"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^1", "Dance New 38", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew39"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^2", "Dance New 39", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew40"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^3", "Dance New 40", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew41"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^4", "Dance New 41", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew42"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^5", "Dance New 42", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew43"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^6", "Dance New 43", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew44"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^1", "Dance New 44", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew45"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^2", "Dance New 45", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew46"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^3", "Dance New 46", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew47"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^4", "Dance New 47", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew48"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^5", "Dance New 48", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew49"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_female^6", "Dance New 49", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew50"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^1", "Dance New 50", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew51"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^2", "Dance New 51", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew52"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^3", "Dance New 52", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew53"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^4", "Dance New 53", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew54"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^5", "Dance New 54", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew55"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v1_male^6", "Dance New 55", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew56"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^1", "Dance New 56", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew57"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^2", "Dance New 57", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew58"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^3", "Dance New 58", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew59"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^4", "Dance New 59", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew60"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^5", "Dance New 60", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew61"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^6", "Dance New 61", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew62"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^1", "Dance New 62", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew63"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^2", "Dance New 63", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew64"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^3", "Dance New 64", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew65"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^4", "Dance New 65", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew66"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^5", "Dance New 66", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew67"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^6", "Dance New 67", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew68"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^1", "Dance New 68", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew69"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^2", "Dance New 69", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew70"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^3", "Dance New 70", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew71"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^4", "Dance New 71", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew72"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^5", "Dance New 72", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew73"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_female^6", "Dance New 73", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew74"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^1", "Dance New 74", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew75"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^2", "Dance New 75", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew76"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^3", "Dance New 76", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew77"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^4", "Dance New 77", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew78"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^5", "Dance New 78", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew79"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v1_male^6", "Dance New 79", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew80"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^1", "Dance New 80", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew81"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^2", "Dance New 81", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew82"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^3", "Dance New 82", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew83"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^4", "Dance New 83", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew84"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^5", "Dance New 84", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew85"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "mi_dance_facedj_09_v2_female^6", "Dance New 85", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew86"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^1", "Dance New 86", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew87"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^2", "Dance New 87", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew88"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^3", "Dance New 88", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew89"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^4", "Dance New 89", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew90"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^5", "Dance New 90", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew91"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v1_female^6", "Dance New 91", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew92"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^1", "Dance New 92", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew93"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^2", "Dance New 93", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew94"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^3", "Dance New 94", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew95"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^4", "Dance New 95", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew96"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^5", "Dance New 96", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew97"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity", "trans_dance_crowd_li_to_hi_09_v1_male^6", "Dance New 97", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew98"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^1", "Dance New 98", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew99"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^2", "Dance New 99", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew100"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^3", "Dance New 100", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew101"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^4", "Dance New 101", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew102"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^5", "Dance New 102", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancenew103"] = {"anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", "trans_dance_crowd_mi_to_hi_09_v1_male^6", "Dance New 103", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance Silly 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Silly 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dance Glowsticks", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dance Glowsticks 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Glowsticks 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dance Horse", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dance Horse 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dance Horse 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
    ------- V1 penguin ------
    ["Apenguin_Head"] = {"penguin@custom@v1", "penguinhead", "REMAKE Head ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_Love"] = {"penguin@custom@v1", "penguinlove", "REMAKE Love ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_standpickpocket"] = {"penguin@custom@v1", "penguin_standpickpocket", "REMAKE standpickpocket ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_2_fingers_up"] = {"penguin@custom@v1", "penguin_2_fingers_up", "REMAKE 2 fingers ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_pok_cheek"] = {"penguin@custom@v1", "penguin_pok_cheek", "REMAKE pokcheek ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_hold_the_cheek"] = {"penguin@custom@v1", "penguin_hold_the_cheek", "REMAKE hold the cheek ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_pose"] = {"penguin@custom@v1", "penguin_pose", "REMAKE pose 1 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose2"] = {"penguin@custom@v1", "penguin_pose2", "REMAKE pose 2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose3"] = {"penguin@custom@v1", "penguin_pose3", "REMAKE pose 3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose4"] = {"penguin@custom@v1", "penguin_pose4", "REMAKE pose 4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose5"] = {"penguin@custom@v1", "penguin_pose5", "REMAKE pose 5 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose6"] = {"penguin@custom@v1", "penguin_pose6", "REMAKE pose 6 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose7"] = {"penguin@custom@v1", "penguin_pose7", "REMAKE pose 7 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_pose8"] = {"penguin@custom@v1", "penguin_pose8", "REMAKE pose 8 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_pose9"] = {"penguin@custom@v1", "penguin_pose9", "REMAKE pose 9 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_pose10"] = {"penguin@custom@v1", "penguin_pose10", "REMAKE pose 10 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ["Apenguin_dab"] = {"penguin@custom@v1", "penguin_dab", "REMAKE dab ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["Apenguin_dab1"] = {"penguin@custom@v1", "penguin_dab1", "REMAKE dab 1 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},

    ------- penguin V2 ------

    ["apenguin_duo1_m"] = {"penguin@custom@v2", "penguin_duo1_m", "REMAKE duo m 1 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_duo1_f"] = {"penguin@custom@v2", "penguin_duo1_f", "REMAKE duo f 1 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_duo2_f"] = {"penguin@custom@v2", "penguin_duo2_f", "REMAKE duo f 2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_duo2_m"] = {"penguin@custom@v2", "penguin_duo2_m", "REMAKE duo m 2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose_couple_m"] = {"penguin@custom@v2", "penguin_pose_couple_m_v2", "REMAKE pose couple m ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose_couple_f"] = {"penguin@custom@v2", "penguin_pose_couple_f_v2", "REMAKE pose couple f ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_japanom"] = {"penguin@custom@v2", "penguin_japanom", "REMAKE japanom ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose1_v2"] = {"penguin@custom@v2", "penguin_pose1_v2", "REMAKE pose 1 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose2_v2"] = {"penguin@custom@v2", "penguin_pose2_v2", "REMAKE pose 2 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["apenguin_pose3_v2"] = {"penguin@custom@v2", "penguin_pose3_v2", "REMAKE pose3 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["apenguin_pose4_v2"] = {"penguin@custom@v2", "penguin_pose4_v2", "REMAKE pose 4 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose5_v2"] = {"penguin@custom@v2", "penguin_pose5_v2", "REMAKE pose 5 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose6_v2"] = {"penguin@custom@v2", "penguin_pose6_v2", "REMAKE pose 6 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose7_v2"] = {"penguin@custom@v2", "penguin_pose7_v2", "REMAKE pose 7 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["apenguin_pose8_v2"] = {"penguin@custom@v2", "penguin_pose8_v2", "REMAKE pose 8 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["apenguin_pose9_v2"] = {"penguin@custom@v2", "penguin_pose9_v2", "REMAKE pose 9 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose10_v2"] = {"penguin@custom@v2", "penguin_pose10_v2", "REMAKE pose 10 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose11_v2"] = {"penguin@custom@v2", "penguin_pose11_v2", "REMAKE pose 11 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["apenguin_pose12_v2"] = {"penguin@custom@v2", "penguin_pose12_v2", "REMAKE pose 12 v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["apenguin_respect"] = {"penguin@custom@v2", "penguin_respect", "REMAKE respect v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},

    ["apenguin_sorry1"] = {"penguin@custom@v2", "penguin_sorry1", "REMAKE sorry v2 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ---- penguin V3 ----
    ["Apenguin_mppos_pose1"] = {"penguin_mppos@pose_model", "penguin_mppos_pose1", "REMAKE pose1 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose2"] = {"penguin_mppos@pose_model", "penguin_mppos_pose2", "REMAKE pose2 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose3"] = {"penguin_mppos@pose_model", "penguin_mppos_pose3", "REMAKE pose3 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose4"] = {"penguin_mppos@pose_model", "penguin_mppos_pose4", "REMAKE pose4 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose5"] = {"penguin_mppos@pose_model", "penguin_mppos_pose5", "REMAKE pose5 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose6"] = {"penguin_mppos@pose_model", "penguin_mppos_pose6", "REMAKE pose6 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose7"] = {"penguin_mppos@pose_model", "penguin_mppos_pose7", "REMAKE pose7 v3 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose8"] = {"penguin_mppos@pose_model", "penguin_mppos_pose8", "REMAKE pose8 v3 ~p~ NEW", AnimationOptions =
    {
        Prop = 'prop_cs_ciggy_01',
        PropBone = 28422,
        PropPlacement = {0.09, 0.02, 0.0, 5.0, 109.0, 10.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose9"] = {"penguin_mppos@pose_model", "penguin_mppos_pose9", "REMAKE pose9 v3 ~p~ NEW", AnimationOptions =
    {
        Prop = 'prop_cs_ciggy_01',
        PropBone = 28422,
        PropPlacement = {0.09, 0.02, 0.0, 5.0, 109.0, 10.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_pose10"] = {"penguin_mppos@pose_model", "penguin_mppos_pose10", "REMAKE pose10 v3 ~p~ NEW", AnimationOptions =
    {
        Prop = "prop_phone_ing_03",
        PropBone = 28422,
        PropPlacement = {0.07, 0.03, -0.02, -127.0, -133.0, 2.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ---- penguin V4 ----
    ["Apenguin_mppos_v4_pose1"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose1", "REMAKE_mppos_pose1_v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_v4_pose2"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose2", "REMAKE_mppos_pose2_v4 ~p~ NEW", AnimationOptions =
    {
        Prop = "prop_cs_ciggy_01",
        PropBone = 28422,
        PropPlacement = {0.09, 0.02, 0.0, 5.0, 109.0, 10.0},
        SecondProp = 'prop_tumbler_01b_bar',
        SecondPropBone = 60309,
        SecondPropPlacement = {0.07, 0.01, 0.05, -87.0, 1.0, -9.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_v4_pose3"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose3", "Penguimppos pose3 v4 ~p~ NEW", AnimationOptions =
    {
        Prop = "prop_penguin_flag1", ---ธง
        PropBone = 28422,
        PropPlacement = {0.44, -0.83, -0.32, -63.0, -72.0, -11.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["Apenguin_mppos_v4_pose4"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose4", "Penguimppos pose4 v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_v4_pose5"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose5", "REMAKE pose5 v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_v4_pose6"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose6", "REMAKE pose6 v4 ~p~ NEW", AnimationOptions =
    {
        Prop = "ruler",
        PropBone = 12844,
        PropPlacement = {0.0, 0.12, 0.01, 0.0, 90.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_v4_pose7"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose7", "Penguimppos pose7 v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["Apenguin_mppos_v4_pose8"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_pose8", "REMAKE pose8 v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["Apenguin_mppos_v4_duo1_f"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_duo1_f", "penguin duo1 f v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["Apenguin_mppos_v4_duo1_m"] = {"penguin_mppos@custom@v4", "penguin_mppos_v4_duo1_m", "penguin duo1 m v4 ~p~ NEW", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
   ---- penguin V5 ----

   ["Apenguin_mppos_pose1_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose1_v5", "penguin_mppos_pose1_v5", AnimationOptions =
   {
       Prop = "flower_neck",  
       PropBone = 24818,
       PropPlacement = {-0.30, 0.04, 0.0, -3.0, 90.0, 180.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose2_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose2_v5", "penguin_mppos_pose2_v5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Apenguin_mppos_pose3_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose3_v5", "penguin_mppos_pose3_v5", AnimationOptions =
   {
       Prop = "find",  
       PropBone = 60309,
       PropPlacement = {0.05, 0.11, -0.01, -4.0, 92.0, -19.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose4_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose4_v5", "penguin_mppos_pose4_v5", AnimationOptions =
   {
       Prop = "red_card",  
       PropBone = 28422,
       PropPlacement = {0.11, 0.07, -0.05, -23.0, -61.0, 131.0},
       SecondProp = 'whistle',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.09, 0.04, 0.04, -94.0, 186.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose5_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose5_v5", "penguin_mppos_pose5_v5", AnimationOptions =
   {
       Prop = "yellow_card",  
       PropBone = 28422,
       PropPlacement = {0.11, 0.07, -0.05, -23.0, -61.0, 131.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose6_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose6_v5", "penguin_mppos_pose6_v5", AnimationOptions =
   {
       Prop = "watertank",  
       PropBone = 60309,
       PropPlacement = {0.12, 0.0, 0.09, 181.0, 23.0, -116.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose7_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose7_v5", "penguin_mppos_pose7_v5", AnimationOptions =
   {
       Prop = "penguin_flag2",  
       PropBone = 28422,
       PropPlacement = {0.09, -0.4, -0.18, -85.0, 65.0, 20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose8_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose8_v5", "penguin_mppos_pose8_v5", AnimationOptions =
   {
       Prop = "logo_label",  
       PropBone = 28422,
       PropPlacement = {0.2, 0.08, -0.03, -47.0, 128.0, 55.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Apenguin_mppos_pose9_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose9_v5", "penguin_mppos_pose9_v5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Apenguin_mppos_pose10_v5"] = {"penguin_mppos@custom@v5", "penguin_mppos_pose10_v5", "penguin_mppos_pose10_v5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
    ---- penguin V7 ----
    ["K4penguin_v7_pose1"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose1_v7", "penguin mppos pose1 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["K5penguin_v7_pose2"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose2_v7", "penguin mppos pose2 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["K6penguin_v7_pose3"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose3_v7", "penguin mppos pose3 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["K7penguin_v7_pose4"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose4_v7", "penguin mppos pose4 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["K8penguin_v7_pose5"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose5_v7", "penguin mppos pose5 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["K9penguin_v7_pose6"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose6_v7", "penguin mppos pose6 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["L1penguin_v7_pose7"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose7_v7", "penguin mppos pose7 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["L2penguin_v7_pose8"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose8_v7", "penguin mppos pose8 ~y~ V7", AnimationOptions =
    {
        Prop = "blanket",
        PropBone = 24818,
        PropPlacement = {-0.8, 0.27, 0.09, 1.0, 0.0, 160.0},
        SecondProp = 'pillow',
        SecondPropBone = 24818,
        SecondPropPlacement = {0.44, -0.02, -0.09, 0.0, 0.0, 160.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["L3penguin_v7_pose9"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose9_v7", "penguin mppos pose9 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 
    ["L4penguin_v7_pose9"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose9_v7", "penguin mppos pose9_1 ~y~ V7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }}, 
    ["L5penguin_v7_pose10"] = {"penguin@mppos@custom@v7", "penguin_mppos_pose10_v7", "penguin mppos pose10 ~y~ V7", AnimationOptions =
    {
        Prop = "pillow_1",
        PropBone = 24818,
        PropPlacement = {0.08, 0.21, 0.0, -18.0, 90.0, 180.0},
        EmoteLoop = true,
        EmoteMoving = false,
    }}, 

    ["Nekodow"] = {"monmon@her_style1", "her_style1", "REMAKE Her Style1 ~p~ NEW", AnimationOptions =
   { 
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodob"] = {"monmon@her_style2", "her_style2", "REMAKE Her Style2 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoa"] = {"monmon@her_style3", "her_style3", "REMAKE Her Style3 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoc"] = {"monmon@her_style4", "her_style4", "REMAKE Her Style4 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodog"] = {"monmon@her_style5", "her_style5", "REMAKE Her Style5 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodof"] = {"monmon@her_style6", "her_style6", "REMAKE Her Style6 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoj"] = {"monmon@her_style7", "her_style7", "REMAKE Her Style7 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodok"] = {"monmon@her_style8", "her_style8", "REMAKE Her Style8 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }}, 
   ["Nekodosaad"] = {"monmon@cute_pose1", "cute_pose1", "REMAKE Cute Pose1 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodosds"] = {"monmon@cute_pose2", "cute_pose2", "REMAKE Cute Pose2 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksaa"] = {"monmon@cute_pose3", "cute_pose3", "REMAKE Cute Pose3 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksds"] = {"monmon@cute_pose4", "cute_pose4", "REMAKE Cute Pose4 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksdaw"] = {"monmon@cute_pose5", "cute_pose5", "REMAKE Cute Pose5 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodokssd"] = {"monmon@cute_pose6", "cute_pose6", "REMAKE Cute Pose6 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodokbh"] = {"monmon@cute_pose7", "ccute_pose7", "REMAKE Cute Pose7 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsada"] = {"monmon@cute_pose8", "cute_pose8", "REMAKE Cute Pose8 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksdss"] = {"monmon@cute_pose9", "cute_pose9", "REMAKE Cute Pose9 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdssdsa"] = {"monmon@cute_pose10", "cute_pose10", "REMAKE Cute Pose10 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksdssdsa2520"] = {"monmon@pose1_base", "pose1_base", "REMAKE MonMon 1 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdssadsad"] = {"monmon@pose2_base", "pose2_base", "REMAKE MonMon 2 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksdsssdsdsd"] = {"monmon@pose3_base", "pose3_base", "REMAKE MonMon 3 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsssdsaasa"] = {"monmon@pose4_base", "pose4_base", "REMAKE MonMon 4 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsssdsdsdsdsd"] = {"monmon@pose5_base", "pose5_base", "REMAKE MonMon 5 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsssasd"] = {"monmon@pose6_base", "pose6_base", "REMAKE MonMon 6 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsssaaaa"] = {"monmon@pose7_base", "pose7_base", "REMAKE MonMon 7 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsswwqdsdad"] = {"monmon@pose8_base", "pose8_base", "REMAKE MonMon 8 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsswsdd"] = {"monmon@pose9_base", "pose9_base", "REMAKE MonMon 9 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodoksdsssdsds"] = {"monmon@pose10_base", "pose10_base", "REMAKE MonMon 10 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodoksdsssa"] = {"monmon@pose11_base", "pose11_base", "REMAKE MonMon 11 ~y~New", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs"] = {"monmon@couple_cute1_female", "couple_cute1_female", "REMAKE Couple Cute1 Female ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogssa"] = {"monmon@couple_cute1_male", "couple_cute1_male", "REMAKE Couple Cute1 Male ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogssas"] = {"monmon@couple_cute2_female", "couple_cute2_female", "REMAKE Couple Cute2 Female ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs32"] = {"monmon@couple_cute2_male", "couple_cute2_male", "REMAKE Couple Cute2 Male ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs33"] = {"monmon@couple_cute3_female", "couple_cute3_female", "REMAKE Couple Cute3 Female ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs34"] = {"monmon@couple_cute3_male", "couple_cute3_male", "REMAKE Couple Cute3 Male ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs35"] = {"monmon@couple_cute4_female", "couple_cute4_female", "REMAKE Couple Cute4 Female ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs36"] = {"monmon@couple_cute4_male", "couple_cute4_male", "REMAKE Couple Cute4 Male ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs37"] = {"monmon@couple_cute5_female", "couple_cute5_female", "REMAKE Couple Cute5 Female ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs38"] = {"monmon@couple_cute5_male", "couple_cute5_male", "REMAKE Couple Cute5 Male ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs39"] = {"monmon@reward_pose1", "reward_pose1", "REMAKE MonMon Reward Pose1 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs40"] = {"monmon@reward_pose2", "reward_pose2", "REMAKE MonMon Reward Pose2 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs41"] = {"monmon@reward_pose3", "reward_pose3", "REMAKE MonMon Reward Pose3 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs42"] = {"monmon@pose_man01", "pose_man01", "REMAKE MonMon Pose Man1  ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs43"] = {"monmon@pose_man02", "pose_man02", "REMAKE MonMon Pose Man2 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekodogs44"] = {"monmon@pose_man03", "pose_man03", "REMAKE MonMon Pose Man ~p~ NEW 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs45"] = {"monmon@pose_man04", "pose_man04", "REMAKE MonMon Pose Man4 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs46"] = {"monmon@pose_man05", "pose_man05", "REMAKE MonMon Pose Man5 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs47"] = {"monmon@cafe_pose1", "cafe_pose1", "REMAKE MonMon Cafe Pose1 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs48"] = {"monmon@cafe_pose2", "cafe_pose2", "REMAKE MonMon Cafe Pose2 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs49"] = {"monmon@cafe_pose3", "cafe_pose3", "REMAKE MonMon Cafe Pose3 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs50"] = {"monmon@cafe_pose4", "cafe_pose4", "REMAKE MonMon Cafe Pose4 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs51"] = {"monmon@cafe_pose5", "cafe_pose5", "REMAKE MonMon Cafe Pose5 ~p~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = fales,
   }},
   ["Nekodogs52"] = {"monmon@pose_relax1", "pose_relax1", "REMAKE Relax Pose1 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs53"] = {"monmon@pose_relax2", "pose_relax2", "REMAKE Relax Pose2 ~g~ NEW ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs54"] = {"monmon@pose_relax3", "pose_relax3", "REMAKE Relax Pose3 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs55"] = {"monmon@pose_relax4", "pose_relax4", "REMAKE Relax Pose4 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs56"] = {"monmon@pose_relax5", "pose_relax5", "REMAKE Relax Pose5 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs57"] = {"monmon@pose_relax6", "pose_relax6", "REMAKE Relax Pose6 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs58"] = {"monmon@pose_relax7", "pose_relax7", "REMAKE Relax Pose7 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs59"] = {"monmon@pose_relax8", "pose_relax8", "REMAKE Relax Pose8 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs60"] = {"monmon@pose_relax9", "pose_relax9", "REMAKE Relax Pose9 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodogs61"] = {"monmon@pose_relax10", "pose_relax10", "REMAKE Relax Pose10 ~g~ NEW", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},

   ------- Neko emo ------

   ["Nekopiggy"] = {"fos_ep_1_p1-9", "csb_imran_dual-9", "Neko piggy", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew"] = {"fos_ep_1_p0-0", "cs_lazlow_dual-0", "Neko new", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew2"] = {"fos_ep_1_p1-0", "cs_lazlow_dual-0", "Neko new2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew3"] = {"fos_ep_1_p1-0", "csb_imran_dual-0", "Neko new3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew4"] = {"fos_ep_1_p1-1", "cs_lazlow_dual-1", "Neko new4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},

   ["Nekonew5"] = {"fos_ep_1_p1-1", "csb_anita_dual-1", "Neko new5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew6"] = {"fos_ep_1_p1-1", "csb_imran_dual-1", "Neko new6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["Nekonew7"] = {"fos_ep_1_p5-2", "csb_william_dual-2", "Neko new7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekonew8"] = {"timetable@trevor@ig_1", "ig_1_therearejustsomemoments_patricia", "Neko new8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekonew9"] = {"impexp_int_l1-11", "mp_m_waremech_01_dual-11", "Neko new9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekonew10"] = {"amb@prop_human_seat_computer@male@react_shock", "forward", "Neko new10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonew11"] = {"amb@prop_human_seat_bar@male@elbows_on_bar@idle_b", "idle_d", "Neko new11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonew12"] = {"amb@incar@male@security@idle_a", "idle_a", "Neko new12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekopost4"] = {"mpcas_int-2", "s_m_y_casino_01^1_dual-2", "Neko post4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekohelp"] = {"missheist_agency3aig_19", "ground_call_help", "Neko help", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep3"] = {"missheist_agency3amcs_4b", "crew_dead_crew2", "Neko sleep3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep4"] = {"missheist_jewel", "gassed_npc_customer1", "Neko sleep4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep5"] = {"missheist_jewel", "gassed_npc_customer2", "Neko sleep5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep6"] = {"missheist_jewel", "gassed_npc_customer3", "Neko sleep6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep7"] = {"missheist_jewel", "gassed_npc_customer4", "Nekosleep7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekositpost8"] = {"missheistdockssetup1ig_10@base", "talk_pipe_base_worker1", "Neko sitpost8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["apenguin_pok_cheek"] = {"missheistdockssetup1ig_14", "floyd_ok_now_grab_the_container", "Neko Call", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekodrunk4"] = {"missheistpaletopinned", "pinned_against_wall_pro_loop_buddy", "Neko drunk4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekoyoga6"] = {"misslamar1leadinout", "yoga_02_idle_b", "Neko yoga6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekolieabout"] = {"missmic2ig_11", "mic_2_ig_11_a_p_one", "Neko lie about", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["apenguin_standpickpocket"] = {"missprologueig_2", "idle_on_floor_gaurd", "Neko bundle", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["apenguin_2_fingers_up"] = {"missprologueig_2", "idle_outside_cuboard_gaurd", "Neko bundle2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Nekosleep8"] = {"missprologueig_6", "lying_dead_brad", "Neko sleep8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekosleep9"] = {"missprologueig_6", "lying_dead_player0", "Neko sleep9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekorod"] = {"misstrevor1ig_3", "action_b", "Neko rod", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["apenguin_pose"] = {"misstrevor3", "bike_chat_b_loop_1", "Neko check2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["apenguin_pose2"] = {"misstvrram_5", "marines_idle_b", "Neko check3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonumb"] = {"mp_arrest_paired", "crook_p1_idle", "Neko numb", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["Nekonumb2"] = {"mp_cop_miss", "dazed", "Neko numb2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apenguin_Head"] = {"fam_4_int_alt1-17", "cs_amandatownley_dual-17", "Neko sawatdee", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["apenguin_Love"] = {"fos_ep_1_p1-26", "csb_imran_dual-26", "Neko sawatdee2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["incar"] = {"mini@prostitutes@sexnorm_veh", "bj_loop_male", "incar", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
   }},
   
   ["incar2"] = {"mini@prostitutes@sexnorm_veh", "bj_loop_prostitute", "incar2", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},
   ["incar3"] = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", "incar3", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekosex"] = {"misscarsteal2pimpsex", "pimpsex_hooker", "Neko Sex", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekosex2"] = {"misscarsteal2pimpsex", "pimpsex_pimp", "Neko Sex2", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekosex3"] = {"misscarsteal2pimpsex", "pimpsex_punter", "Neko Sex3", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekosex4"] = {"misscarsteal2pimpsex", "shagloop_hooker", "Neko Sex4", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekosex5"] = {"misscarsteal2pimpsex", "shagloop_pimp", "Neko Sex5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekosex6"] = {"rcmpaparazzo_2", "shag_action_poppy", "Neko Sex6", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekosex7"] = {"rcmpaparazzo_2", "shag_action_a", "Neko Sex5", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},
   ["Nekogivebirth"] = {"mini@cpr@char_a@cpr_str", "cpr_kol", "Neko Give birth", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekotiedup"] = {"random@burial", "b_burial", "Neko Tied up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositchair7"] = {"anim@amb@nightclub@smoking@", "blunt_idle_a", "Neko Sit Chair 7", AnimationOptions =
   {    
       Prop = 'p_cs_joint_02',
       PropBone = 28422,
       PropPlacement = {0.0800003, -0.004999998, -0.035, 175.5002, 311.0003, 232.0},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair8"] = {"anim@amb@nightclub@smoking@", "blunt_idle_b", "Neko Sit Chair 8", AnimationOptions =
   {    
       Prop = 'p_cs_joint_02',
       PropBone = 28422,
       PropPlacement = {0.0800003, -0.004999998, -0.035, 175.5002, 311.0003, 232.0},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_dab"] = {"friends@frl@ig_1", "drink_lamar", "Neko Drink 2", AnimationOptions =
   {    
       Prop = 'prop_beer_patriot',
       PropBone = 60309,
       PropPlacement = {-0.03499999, -0.165, -0.015, 436.7987, 412.3998, 177.4},
       EmoteLoop = false,
       EmoteMoving = true,
    
   }},

   ["Nekomc"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_dlg_tonymctony_laz", "Neko MC", AnimationOptions =
   {    
       Prop = 'p_ing_microphonel_01',
       PropBone = 57005,
       PropPlacement = {0.1249999, 0.03, -0.005000002, 87.10002, 149.8, 200.8},
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},


   ["Nekojump1"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_d_player_a", "Neko Jump 1", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekojump2"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_c_player_a", "Neko Jump 2", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekojump3"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_b_player_a", "Neko Jump 3", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekojump4"] = {"anim@arena@celeb@flat@solo@no_props@", "jump_a_player_a", "Neko Jump 4", AnimationOptions =
   {    
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},

   ["Nekoleanbar5"] = {"switch@michael@pier", "pier_lean_smoke_idle", "Neko Lean Bar 5", AnimationOptions =
   {   
       Prop = 'prop_cs_ciggy_01',
       PropBone = 58867,
       PropPlacement = {0.0599999, 0.005, -0.015, 40.29999, 78.3, 124.1},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoleanbar6"] = {"switch@michael@pier", "pier_lean_smoke_idle", "Neko Lean Bar 6", AnimationOptions =
   {   
       Prop = 'p_cs_joint_02',
       PropBone = 58867,
       PropPlacement = {0.0599999, 0.005, -0.015, 40.29999, 78.3, 124.1},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoleanbar7"] = {"switch@michael@pier", "pier_lean_smoke_idle", "Neko Lean Bar 7", AnimationOptions =
   {   
       Prop = 'prop_cigar_03',
       PropBone = 58867,
       PropPlacement = {0.06499989, 0.015, -0.01, 0.0, 78.3, 299.6001},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositmafia"] = {"safe@michael@ig_3", "cigar_idle_b_michael", "Neko Sit Mafia", AnimationOptions =
   {   
       Prop = 'prop_cigar_03',
       PropBone = 58867,
       PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekosmell2"] = {"safe@trevor@ig_8", "ig_8_huff_gas_player", "NekoSmell 2", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear"] = {"anim@heists@ornate_bank@hostages@cashier_b@", "flinch_loop_underfire", "Neko Fear", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekowipe"] = {"switch@franklin@cleaning_car", "001946_01_gc_fras_v2_ig_5_base", "Neko Wipe", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},

   ["Nekositchair9"] = {"mini@strip_club@wade@", "leadin_loop_idle_a_stripper_a", "Neko Sit Chair 9", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositmafia2"] = {"mini@strip_club@wade@", "leadin_loop_idle_a_wade", "Neko Sit Mafia 2", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_pose3"] = {"mini@triathlon", "male_one_handed_a", "Neko Cheer 2", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_pose4"] = {"mini@triathlon", "male_two_handed_a", "Neko Cheer 3", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean6"] = {"missarmenian1leadinoutarm_1_ig_14_leadinout", "leadin_loop", "Neko Lean 6", AnimationOptions =
   {   
       --Prop = 'prop_cigar_03',
       --PropBone = 13700,
       --PropPlacement = {0.03999992, 0.03, 0.015, 0.0, 78.3002, 180},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_dab1"] = {"missbigscore1leadinoutbs_1_int", "leadin_loop_c_trevor", "Neko Drunk", AnimationOptions =
   {   
       Prop = 'prop_wine_rose',
       PropBone = 58867,
       PropPlacement = {0.02499996, -0.009999998, -0.3599998, 172.9002, 183.6, 155.3},
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopee2"] = {"missbigscore1switch_trevor_piss", "piss_loop", "Neko Pee 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean7"] = {"misscarsteal1car_1_ext_leadin", "base_driver1", "Neko Lean 7", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopee3"] = {"misscarsteal2peeing", "peeing_loop", "Neko Pee 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekoleanbar8"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Neko Lean Bar 8", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["apenguin_pose9"] = {"misscarstealfinalecar_5_ig_3", "leanleft_loop", "Neko Dapap", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["apenguin_pose6"] = {"misschinese1leadinoutchi_1_mcs_4", "chi_1_mcs_4_tao_idle_2", "Neko Cool", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean8"] = {"missclothing", "idle_a", "Neko Lean 8", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean9"] = {"missclothing", "idle_b", "Neko Lean 9", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekolean10"] = {"missclothing", "idle_c", "Neko Lean 10", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekosadly"] = {"missfam4leadinoutmcs2", "tracy_loop", "Neko Sadly", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga2"] = {"missfam5_yoga", "c5_pose", "Neko Yoga 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga3"] = {"missfam5_yoga", "c6_pose", "Neko Yoga 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga4"] = {"missfam5_yoga", "c7_pose", "Neko Yoga 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopost"] = {"missfbi4leadinoutfbi_4_int", "agents_idle_a_andreas", "Neko post", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomonkey"] = {"missfbi5ig_30monkeys", "monkey_a_freakout_loop", "Neko Monkey", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomonkey2"] = {"missfbi5ig_30monkeys", "monkey_c_freakout_loop", "Neko Monkey 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_pose8"] = {"missfinale_a_ig_2", "trevor_death_reaction_pt", "Neko Cry", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoreverence"] = {"missfra2", "lamar_base_idle", "Neko Reverence", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekopost2"] = {"misshair_shop@barbers", "keeper_base", "Neko Post 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekopost3"] = {"misshair_shop@hair_dressers", "keeper_idle_a", "NekoPost 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_pose5"] = {"missheist_agency3aig_19", "ground_call_help", "Neko Clamber", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekosleep2"] = {"missheist_jewel", "cop_on_floor", "Neko Sleep 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoyoga5"] = {"misslamar1leadinout", "yoga_01_idle", "Neko Yoga 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair10"] = {"misslester1aig_3main", "air_guitar_01_b", "Neko Sit Chair 10", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair11"] = {"misslester1aig_5intro", "boardroom_intro_f_b", "Neko Sit Chair 11", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair12"] = {"misslester1aig_5intro", "boardroom_intro_f_c", "Neko Sit Chair 12", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_pose10"] = {"missmic1leadinoutmic_1_mcs_2", "_leadin_trevor", "Neko Dig", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekowashface"] = {"missmic2_washing_face", "michael_washing_face", "Neko Wash Face", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekorepent"] = {"misstrevor1", "threaten_ortega_endloop_ort", "Neko Repent", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositchair13"] = {"misstrevor3", "bike_chat_a_1", "Neko Sit Chair 13", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["apenguin_hold_the_cheek"] = {"misstvrram_5", "marines_idle_b", "Neko Check", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekowash"] = {"timetable@floyd@clean_kitchen@idle_a", "idle_a", "Neko Wash", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekowash2"] = {"timetable@floyd@clean_kitchen@base", "base", "Neko Wash 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},

   ["Nekositpost"] = {"switch@michael@smoking2", "loop", "Neko Sit Post", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost2"] = {"switch@trevor@pushes_bodybuilder", "001426_03_trvs_5_pushes_bodybuilder_idle_bb2", "Neko Sit Post 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost3"] = {"timetable@reunited@ig_10", "base_jimmy", "Neko Sit Post 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost4"] = {"anim@heists@fleeca_bank@hostages@intro", "intro_loop_ped_a", "Neko Sit Post 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost5"] = {"anim@amb@office@pa@male@", "greetng_b_intro", "Neko Sit Post 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositmafia3"] = {"anim@amb@office@boss@female@", "idle_d", "Neko Sit Mafia 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost6"] = {"timetable@ron@ig_3_p3", "ig_3_p3_base", "Neko Sit Post 6", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekositpost7"] = {"timetable@trevor@smoking_meth@idle_a", "idle_a", "Neko Sit Post 7", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodrunk2"] = {"timetable@tracy@ig_7@base", "base", "Neko Drunk 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoverydrunk"] = {"timetable@tracy@ig_7@idle_a", "idle_a", "Neko Very Drunk", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekodrunk3"] = {"timetable@tracy@ig_7@idle_a", "idle_b", "Neko Drunk 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoparody"] = {"anim@mp_player_intupperthumb_on_ears", "idle_a", "Neko Parody", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody2"] = {"anim@mp_player_intincarthumb_on_earsstd@ps@", "idle_a", "Neko Parody 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody3"] = {"anim@mp_player_intincarfreakoutstd@rps@", "idle_a", "Neko Parody 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody4"] = {"anim@mp_player_intcelebrationmale@thumb_on_ears", "thumb_on_ears", "Neko Parody 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoparody5"] = {"anim@mp_player_intcelebrationfemale@thumb_on_ears", "thumb_on_ears", "Neko Parody 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekoshow"] = {"missfbi_s4mop", "lobby_security_fp_player", "Neko Show", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = true,
    
   }},
   ["Nekopicksnot"] = {"anim@mp_player_intincarnose_pickstd@ps@", "exit", "Neko Pick snot", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = true,
    
   }},
   ["Nekoparody6"] = {"anim@mp_player_intincardockbodhi@rds@", "idle_a_fp", "Neko Parody 6", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekofear2"] = {"anim@heists@prison_heistunfinished_biz@popov_react", "popov_flinch_a", "Neko Fear 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear3"] = {"anim@heists@prison_heistunfinished_biz@popov_react", "popov_flinch_b", "Neko Fear 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoheartbroken"] = {"anim@heists@prison_heistig_5_p1_rashkovsky_idle", "idle", "Neko Heart Broken", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear4"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_c", "Neko Fear 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekofear5"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_d", "Neko Fear 5", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekoincite"] = {"fos_ep_1_p5-1", "csb_anita_dual-1", "Neko Incite", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = true,
    
   }},
   ["Nekomasturbate"] = {"switch@trevor@jerking_off", "trev_jerking_off_exit", "Neko Masturbate", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},
   ["Nekomasturbate2"] = {"switch@trevor@jerking_off", "trev_jerking_off_loop", "Neko Masturbate 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekotest87"] = {"switch@trevor@puking_into_fountain", "trev_fountain_puke_loop", "Neko test87", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekotest88"] = {"timetable@trevor@skull_loving_bear", "skull_loving_bear", "Neko test88", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekotest89"] = {"anim@move_hostages@male", "male_idle_to_cower", "Neko test89", AnimationOptions =
   {   
       EmoteLoop = false,
       EmoteMoving = false,
    
   }},
   ["Nekositmassage"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_floyd", "Neko Sit Massage", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_2_trevor", "Neko Massage", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage2"] = {"missheistdocks2aleadinoutlsdh_2a_int", "massage_loop_floyd", "Neko Massage 2", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage3"] = {"missheistdocks2bleadinoutlsdh_2b_int", "leg_massage_b_floyd", "Neko Massage 3", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   ["Nekomassage4"] = {"missheistdocks2bleadinoutlsdh_2b_int", "leg_massage_floyd", "Neko Massage 4", AnimationOptions =
   {   
       EmoteLoop = true,
       EmoteMoving = false,
    
   }},
   
   
   
   ["Nekofoldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Neko Fold Arms 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apenguin_pose7"] = {"random@shop_gunstore", "_idle", "Neko Crossarms 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["drink"] = {"mp_player_inteat@pnq", "loop", "Drink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["jpbox"] = {"mp_am_hold_up", "purchase_beerbox_shopkeeper", "Purchase Box ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 2500,
   }},
   ["jch"] = {"amb@code_human_police_investigate@idle_b", "idle_f", "Cop Search ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 7000,
   }},
   ["jgangsign5"] = {"anim@mp_player_intupperdock", "idle_a", "Gang Sign ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["jcheckwatch"] = {"amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", "Check Watch · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jpicking"] = {"amb@prop_human_movie_bulb@idle_a", "idle_a", "Picking ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["jgangaim"] = {"combat@aim_variations@1h@gang", "aim_variation_b", "Gang Aim ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["jshowboobs"] = {"mini@strip_club@backroom@", "stripper_b_backroom_idle_b", "Show Boobs ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 6000,
   }},
   ["jcleanleg"] = {"mini@strip_club@backroom@", "stripper_c_leadin_backroom_idle_a", "Clean Legs ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 6000,
   }},
   ["jshowboobs2"] = {"mini@strip_club@idles@stripper", "stripper_idle_05", "Show Boobs 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 6000,
   }},
   ["jlockcar"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Lock Car ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["jselfie5"] = {"cellphone@self", "selfie", "Selfie 3 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["jselfiewc"] = {"cellphone@self@franklin@", "west_coast", "Selfie West Coast ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["jselfie3"] = {"cellphone@self@michael@", "finger_point", "Selfie Finger ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["jselfie4"] = {"cellphone@self@franklin@", "chest_bump", "Selfie Chest Bump ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["jSelfie1"] = {"cellphone@self@trevor@", "throat_slit", "Selfie ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["jSelfie2"] = {"cellphone@self@trevor@", "proud_finger", "Selfie2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["oob2"] = {"rcmfanatic3leadinoutef_3_mcs_1", "fra_outofbreath_loop", "Out Of Breath 2", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["damn3"] = {"misscommon@response", "damn", "Damn", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jkhaby"] = {"missarmenian3@simeon_tauntsidle_b", "areyounotman", "Khaby · Special ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jdepressed"] = {"oddjobs@bailbond_hobodepressed", "base", "Depressed ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = true,
   }},
   ["jcarsign"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@bodhi@rds@base", "idle_a", "Gang Sign · Car ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["jcarsign2"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@low@ds@base", "idle_a", "Gang Signs 2 · Car ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["jcarlowrider"] = {"anim@veh@lowrider@low@front_ds@arm@base", "sit", "Lowrider Style · Car  ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["jcarlowrider2"] = {"anim@veh@lowrider@std@ds@arm@music@mexicanidle_a", "idle", "Lowrider Mexican Style · Car  ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["handsow"] = {"rcmjosh1", "idle", "Hands On Waist", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["washhand"] = {"missheist_agency3aig_23", "urinal_sink_loop", "Wash Hands", AnimationOptions =
   {
    EmoteMoving = true,
   }},
   ["jleaningwallback"] = {"anim@amb@casino@peds@", "amb_world_human_leaning_male_wall_back_mobile_idle_a", "Leaning Wall Back · Male", AnimationOptions =
   {
    Prop = "prop_npc_phone_02",
    PropBone = 28422,
    PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    EmoteLoop = true,
    EmoteMoving = true,
   }},
   ["stop"] = {"anim@amb@casino@peds@", "mini_strip_club_idles_bouncer_stop_stop", "Stop", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Chill", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Cloudgaze", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Cloudgaze 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["prone"] = {"missfbi3_sniping", "prone_dave", "Prone", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Pullover", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Idle", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
   ["idle9"] = {"friends@fra@ig_1", "base_idle", "Idle 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Idle 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["idle11"] = {"random@countrysiderobbery", "idle_a", "Idle 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Idle 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Idle 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Idle 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Idle 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Idle 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Idle 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wait 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Idle Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Drunk 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Idle Drunk 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Guitar"},
   ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Air Synth"},
   ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Argue", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Argue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Blow Kiss"},
   ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Blow Kiss 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Curtsy"},
   ["bringiton"] = {"misscommon@response", "bring_it_on", "Bring It On", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "Come at me bro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cop 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Cop 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Crossarms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Crossarms 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Crossarms 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Crossarms 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Crossarms 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Fold Arms 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms6"] = {"random@shop_gunstore", "_idle", "Crossarms 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Fold Arms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Crossarms Side", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Point Down", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["surrender"] = {"random@arrests@busted", "idle_a", "Surrender", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Fall Over"},
   ["fallover2"] = {"mp_suicide", "pistol", "Fall Over 2"},
   ["fallover3"] = {"mp_suicide", "pill", "Fall Over 3"},
   ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Fall Over 4"},
   ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Fall Over 5"},
   ["fallasleep"] = {"mp_sleep", "sleep_loop", "Fall Asleep", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Fight Me"},
   ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Fight Me 2"},
   ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Finger", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Finger 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wait 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait5"] = {"missclothing", "idle_storeclerk", "Wait 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wait 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wait 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait8"] = {"rcmjosh1", "idle", "Wait 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wait 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wait 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wait 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hiking"] = {"move_m@hiking", "idle", "Hiking", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug"},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2"},
   ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Hug 3"},
   ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
   ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jazzhands", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jog 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jog 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jog 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Jog 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel2"] = {"rcmextreme3", "idle", "Kneel 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kneel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Knock", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Knock 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Knuckle Crunch", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
   ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Lean 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Lean 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Lean 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Lean Flirt", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Lean Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Lean Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Lean Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Lean High", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Lean High 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside"] = {"timetable@mime@01_gc", "idle_a", "Leanside", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Leanside 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "Leanside 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Me", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mechanic"] = {"mini@repair", "fixing_a_ped", "Mechanic", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mechanic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Medic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditiate", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditiate 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate3"] = {"rcmepsilonism3", "base_loop", "Meditiate 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "No", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "No 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Nose Pick", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "No Way", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["outofbreath"] = {"re@construction", "out_of_breath", "Out of Breath", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Push", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Push 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["point"] = {"gestures@f@standing@casual", "gesture_point", "Point", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pushup", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["countdown"] = {"random@street_race", "grid_girl_race_start", "Countdown", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Point Right", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salute", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salute 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salute 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared"] = {"random@domestic", "f_distressed_loop", "Scared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["screwyou"] = {"misscommon@response", "screw_you", "Screw You", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Shake Off", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["shot"] = {"random@dealgonewrong", "idle_a", "Shot", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Sleep", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Shrug", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Shrug 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sit", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "Sit 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sit 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sit 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sit 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sit 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sit 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sit 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sit 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sit Lean", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sit Sad", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sit Scared", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sit Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sit Scared 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "Sit Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sit Chair 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "Sit Chair 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "Sit Chair 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sit Chair 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair6"] = {"timetable@maid@couch@", "base", "Sit Chair 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sit Chair Side", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Sit Up", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Clap Angry", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Slow Clap 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clap"] = {"amb@world_human_cheering@male_a", "base", "Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Slow Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Slow Clap 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Smell", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stumble"] = {"misscarsteal4@actor", "stumble", "Stumble", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stunned"] = {"stungun@standing", "damage", "Stunned", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Sunbathe", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Sunbathe 2", AnimationOptions =
   {
       EmoteLoop = true,
}},
["standfire"] = {"amb@world_human_stand_fire@male@base", "base", "standfire", AnimationOptions =
{
    EmoteLoop = true,
}},
   ["t"] = {"missfam5_yoga", "a2_pose", "Titanic", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "Titanic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Think 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Think", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think3"] = {"timetable@tracy@ig_8@base", "base", "Think 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Think 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Thumbs Up 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Thumbs Up 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Thumbs Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Type", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Type 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type3"] = {"mp_prison_break", "hack_loop", "Type 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type4"] = {"mp_fbi_heist", "loop", "Type 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Warmth", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Wave 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Wave 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Wave 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave"] = {"friends@frj@ig_1", "wave_a", "Wave", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave5"] = {"friends@frj@ig_1", "wave_b", "Wave 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave6"] = {"friends@frj@ig_1", "wave_c", "Wave 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave7"] = {"friends@frj@ig_1", "wave_d", "Wave 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave8"] = {"friends@frj@ig_1", "wave_e", "Wave 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Wave 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whistle"] = {"taxi_hail", "hail_taxi", "Whistle", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Whistle 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lift"] = {"random@hitch_lift", "idle_f", "Lift", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Statue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Statue 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Sign", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Sign 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["passout"] = {"missarmenian2", "drunk_loop", "Passout", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Passout 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Passout 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Passout 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Passout 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Petting", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crawl"] = {"move_injured_ground", "front_loop", "Crawl", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Flip 2"},
   ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Flip"},
   ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Slide"},
   ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slide 2"},
   ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Slide 3"},
   ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Slugger"},
   ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Flip Off", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Flip Off 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Bow", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Bow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Key Fob", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
   ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eat", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Reaching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait"] = {"random@shop_tattoo", "_idle_a", "Wait", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Wait 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait12"] = {"rcmjosh1", "idle", "Wait 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait13"] = {"rcmnigel1a", "base", "Wait 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt"},
   ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Fish Dance", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Ledge", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airplane"] = {"missfbi1", "ledge_loop", "Air Plane", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Peek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Cough", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stretch"] = {"mini@triathlon", "idle_e", "Stretch", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch2"] = {"mini@triathlon", "idle_f", "Stretch 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch3"] = {"mini@triathlon", "idle_d", "Stretch 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Stretch 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Celebrate", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["punching"] = {"rcmextreme2", "loop_punching", "Punching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superhero"] = {"rcmbarry", "base", "Superhero", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero2"] = {"rcmbarry", "base", "Superhero 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Mind Control", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Mind Control 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Try Clothes", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Try Clothes 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Try Clothes 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nervous 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nervous", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Nervous 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uncuff"] = {"mp_arresting", "a_uncuff", "Uncuff", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Threaten", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Pull", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bird"] = {"random@peyote@bird", "wakeup", "Bird"},
   ["chicken"] = {"random@peyote@chicken", "wakeup", "Chicken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bark"] = {"random@peyote@dog", "wakeup", "Bark"},
   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Rabbit"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["adjust"] = {"missmic4", "michael_tux_fidget", "Adjust", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Hands Up", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Pee", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Bum Bin"},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Bum Sleep"},
   ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Cheer"},
   ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Chinup"},
   ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Clipboard 2"},
   ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Cop"},
   ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Cop Beacon"},
   ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Film Shocking"},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Flex"},
   ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guard"},
   ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Hammer"},
   ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Hangout"},
   ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatient"},
   ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Janitor"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Jog"},
   ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Kneel"},
   ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Leafblower"},
   ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Lean"},
   ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Lean Bar"},
   ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Lookout"},
   ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Maid"},
   ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Medic"},
   ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Musician"},
   ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notepad 2"},
   ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parking Meter"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Party"},
   ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Texting"},
   ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostitue High"},
   ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostitue Low"},
   ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Puddle"},
   ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Record"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sit Chair"},
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Smoke"},
   ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Smoke Weed"},
   ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Statue"},
   --["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Sunbathe 3"},
   --["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Sunbathe Back"},
   ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Weld"},
   --["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Window Shop"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Cut Throat"},
   ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Cut Throat 2"},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Stink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Think 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Adjust Tie", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
   ["jreactiona"] = {"random@shop_robbery_reactions@", "absolutely", "Reaction Absolutely ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactanger"] = {"random@shop_robbery_reactions@", "anger_a", "Reaction Anger ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactwhy"] = {"random@shop_robbery_reactions@", "is_this_it", "Reaction Why ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactscrew"] = {"random@shop_robbery_reactions@", "screw_you", "Reaction Screw You ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactshock"] = {"random@shop_robbery_reactions@", "shock", "Reaction Shock ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactgoodc"] = {"missclothing", "good_choice_storeclerk", "Reaction Good Choice ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jtrynewc"] = {"clothingtie", "try_tie_neutral_c", "Try New Clothes ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jtrynewc2"] = {"clothingtie", "try_tie_neutral_d", "Try New Clothes 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreacteasy"] = {"gestures@m@car@std@casual@ds", "gesture_easy_now", "Reaction Easy Now ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactıwill"] = {"gestures@m@car@std@casual@ds", "gesture_i_will", "Reaction I will ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactnoway"] = {"gestures@m@car@std@casual@ds", "gesture_no_way", "Reaction No Way ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactbye"] = {"gestures@f@standing@casual", "gesture_bye_hard", "Reaction Bye Hard ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreacthello"] = {"gestures@f@standing@casual", "gesture_hello", "Reaction Hello ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
      ["jlookatplayer"] = {"friends@frl@ig_1", "look_lamar", "Look At Player ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
     ["jreactgreat"] = {"mp_cp_welcome_tutgreet", "greet", "Great ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jfakepunch"] = {"missarmenian2", "fake_punch_walk_by_lamar", "Fake Punch ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
      ["jreactdamn"] = {"missheist_jewel", "damn", "Reaction Damn ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
     ["jimtellingyou"] = {"missheist_jewel", "im_telling_you", "I'm telling you ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jreactno"] = {"missheist_jewel", "despair", "Reaction No ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jdontkillme"] = {"missheist_jewel", "manageress_kneel_loop", "Dont Kill Me ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jbangbang"] = {"anim@mp_player_intcelebrationfemale@bang_bang", "bang_bang", "Bang Bang ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jtryshirtn"] = {"clothingshirt", "try_shirt_negative_a", "Try Shirt Negative ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jtryshirtp"] = {"clothingshirt", "try_shirt_positive_a", "Try Shirt Positive ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
      ["jtryshoes"] = {"clothingshoes", "try_shoes_positive_d", "Try Shoes ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
    ["jtryshoes2"] = {"clothingshoes", "try_shoes_positive_c", "Try Shoes 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
    ["joverhere"] = {"friends@fra@ig_1", "over_here_idle_a", "Over Here ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
    ["jwashingface"] = {"missmic2_washing_face", "michael_washing_face", "Washing Face ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
    ["jlastday"] = {"misstrevor1", "ortega_outro_loop_ort", "Last Day ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteLoop = true,
   }},
    ["jtryg"] = {"mp_clothing@female@glasses", "try_glasses_positive_a", "Try Glasses · Female ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
    ["jpickup"] = {"pickup_object", "pickup_low", "Pick Up ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jstretchl"] = {"switch@franklin@bed", "stretch_long", "Stretch Long ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jhos"] = {"amb@world_human_hang_out_street@male_a@idle_a", "idle_a", "Hang Out Street · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteLoop = true,
   }},
   ["jhos2"] = {"amb@world_human_hang_out_street@male_c@base", "base", "Hang Out Street 2 · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteLoop = true,
   }},
   ["jguardaim"] = {"guard_reactions", "1hand_aiming_cycle", "Guard Aim ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jgready"] = {"switch@franklin@getting_ready", "002334_02_fras_v2_11_getting_dressed_exit", "Getting Ready ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jlao"] = {"move_clown@p_m_two_idles@", "fidget_look_at_outfit", "Look At Outfits ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 6000,
   }},
   ["jtoilet"] = {"switch@trevor@on_toilet", "trev_on_toilet_loop", "Have A Shit ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
   ["jtoilet2"] = {"timetable@trevor@on_the_toilet", "trevonlav_struggleloop", "Have A Shit 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
   ["jcovermale2"] = {"amb@code_human_cower@male@base", "base", "Cover · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jvalet"] = {"anim@amb@world_human_valet@normal@base@", "base_a_m_y_vinewood_01", "Valet ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jvalet2"] = {"anim@amb@world_human_valet@formal_right@base@", "base_a_m_y_vinewood_01", "Valet 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = true,
    EmoteLoop = true,
   }},
   ["jsunbathem"] = {"amb@world_human_sunbathe@male@back@idle_a", "idle_c", "Sunbathe · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["jsunbathem2"] = {"amb@world_human_sunbathe@male@front@base", "base", "Sunbathe 2 · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jleancar"] = {"anim@scripted@carmeet@tun_meet_ig2_race@", "base", "Lean Car ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jcheckout"] = {"anim@amb@carmeet@checkout_car@male_a@idles", "idle_b", "Check Out · Female ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jcheckout2"] = {"anim@amb@carmeet@checkout_car@male_c@idles", "idle_a", "Check Out 2 · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jcheckout"] = {"anim@amb@carmeet@checkout_car@female_d@base", "base", "Check Out 3 · Female ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jreadmessages"] = {"anim@amb@carmeet@take_photos@male_a@base", "base", "Read Messages · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["jreadmessages2"] = {"anim@amb@carmeet@take_photos@female_b@base", "base", "Read Messages 2 · Female ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,  
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["jlistenmusic"] = {"anim@amb@carmeet@listen_music@male_a@trans", "a_trans_d", "Listen Music ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
   ["jogger"] = {"move_f@jogger", "idle", "Jogger · Female ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteDuration = 2500,
       EmoteMoving = true,
   }},
   ["jogger2"] = {"move_m@jogger", "idle", "Jogger · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteDuration = 2500,
       EmoteMoving = true,
   }},
   ["jwtf"] = {"mini@triathlon", "wot_the_fuck", "Wot The Fuck ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jucdt"] = {"mini@triathlon", "u_cant_do_that", "U Cant Do That ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jwarmup"] = {"mini@triathlon", "ig_2_gen_warmup_01", "Warmup ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jwarmup2"] = {"mini@triathlon", "ig_2_gen_warmup_02", "Warmup 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jwarmup3"] = {"mini@triathlon", "jog_idle_f", "Warmup 3 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jwarmup4"] = {"mini@triathlon", "jog_idle_e", "Warmup 4 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jhmassage"] = {"missheistfbi3b_ig8_2", "cpr_loop_paramedic", "Heart Massage ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jpassout"] = {"missheistfbi3b_ig8_2", "cower_loop_victim", "Pass Out ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jddealer"] = {"amb@world_human_drug_dealer_hard@male@base", "base", "Drug Dealer · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jswatch"] = {"amb@world_human_strip_watch_stand@male_c@idle_a", "idle_b", "Watch Strip · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jcheckw"] = {"amb@world_human_bum_wash@male@high@base", "base", "Check Water ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jwaitt"] = {"oddjobs@taxi@", "idle_a", "Wait Taxi ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
   }},
   ["jnoway"] = {"oddjobs@towingpleadingbase", "base", "No Way ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jtsomething"] = {"oddjobs@bailbond_hobohang_out_street_c", "idle_c", "Tell Something ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jlfh"] = {"oddjobs@assassinate@old_lady", "looking_for_help", "Looking For Help ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
   ["jmstretch"] = {"oddjobs@assassinate@multi@", "idle_a", "Muscle Stretch ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
   ["jdj"] = {"anim@mp_player_intcelebrationmale@dj", "dj", "DJ ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jdj2"] = {"anim@scripted@nightclub@dj@dj_moodm@", "moodm_cdj_left_a_12", "DJ 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jdj3"] = {"anim@amb@nightclub@djs@switch@dixn_djset_switchover@", "dix_end_bg_female1", "DJ 3 ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteLoop = true,
   }},
   ["jdj4"] = {"anim@amb@nightclub_island@dancers@crowddance_facedj_transitions@from_low_intensity", "trans_dance_facedj_li_to_mi_11_v1_male^3", "DJ 4 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jlmic"] = {"anim@veh@lowrider@std@ds@arm@music@hiphopidle_a", "idle", "Listen Music In Car ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = true,
    EmoteDuration = 2500,
   }},
   ["jgotc"] = {"random@getawaydriver@thugs", "base_a", "Get Off The Car ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["jvsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Very Sad ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jdgrave"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Digging Grave ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       Prop = 'prop_tool_shovel006',
       PropBone = 28422,
       PropPlacement = {0.0, 0.1, -0.6, 0.0, 0.0, 180.0},
   }},
   ["jbow3"] = {"missheistdockssetup1ig_10@base", "talk_pipe_base_worker1", "Bend Over Wait ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 2500,
   }},
   ["jweeding"] = {"anim@amb@drug_field_workers@weeding@male_a@base", "base", "Weeding · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jlookplan"] = {"missheist_agency2aig_4", "look_plan_c_worker2", "Look Plan ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteDuration = 5000,
   }},
   ["jgangdrink"] = {"amb@world_human_drinking_fat@beer@male@base", "base", "Gang Drink ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = 'prop_cs_beer_bot_40oz_03',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jgangdrink"] = {"amb@world_human_drinking_fat@beer@male@idle_a", "idle_b", "Gang Drink 2 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = 'prop_cs_beer_bot_40oz_03',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jmleaning"] = {"amb@world_human_leaning@male@wall@back@mobile@base", "base", "Mobile Leaning · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
   }},
   ["jthanks"] = {"random@arrests", "thanks_male_05", "Thanks ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jtextingmale"] = {"amb@world_human_stand_mobile_fat@male@text@base", "base", "Texting · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
   }},
   ["jffb"] = {"timetable@trevor@skull_loving_bear", "skull_loving_bear", "F*ck From Behind ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jsitchair7"] = {"timetable@reunited@ig_10", "isthisthebest_jimmy", "Sit Chair 7 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jsitchair8"] = {"timetable@michael@on_sofabase", "sit_sofa_base", "Sit Chair 8 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jsitchair9"] = {"timetable@trevor@smoking_meth@base", "base", "Sit Chair 9 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jsitchair10"] = {"timetable@tracy@ig_7@base", "base", "Sit Chair 10 ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jstandingt"] = {"amb@world_human_bum_standing@twitchy@base", "base", "Standing Twitchy ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jstandingfit"] = {"amb@world_human_jog_standing@male@fitbase", "base", "Standing Fit ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jstandingm"] = {"anim@amb@casino@hangout@ped_male@stand@03b@base", "base", "Standing · Male ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jstandingf"] = {"anim@amb@casino@hangout@ped_female@stand@02a@base", "base", "Standing · Female ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["jgabgtaunt"] = {"switch@franklin@gang_taunt_p1", "gang_taunt_loop_lamar", "Gang Taunt ~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = true,
    EmoteLoop = true,
   }},
   ["jdj5"] = {"mini@strip_club@idles@dj@base", "base", "DJ 5 ~y~REMAKE~c~1.0", AnimationOptions =
   {
    EmoteMoving = false,
    EmoteLoop = true,
   }},
}

DP.PropEmotes = {
   ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "Umbrella", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Notepad", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["box"] = {"anim@heists@box_carry@", "idle", "Box", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rose", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Smoke 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["suitcase"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["suitcase2"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Mugshot", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ego Bar", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wine", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitar 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["book"] = {"cellphone@", "cellphone_text_read_base", "Book", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bouquet", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Teddy", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Backpack", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["clipboard"] = {"missfam4", "base", "Clipboard", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Map", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Beg", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Make It Rain", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Champagne Spray", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["brief3"] = {"missheistdocksprep1hold_cellphone", "static", "Brief 3", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "Phone Call", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phone"] = {"cellphone@", "cellphone_text_read_base", "Phone", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Clean", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean2"] = {"amb@world_human_maid_clean@", "base", "Clean 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jclean3"] = {"switch@franklin@cleaning_car", "001946_01_gc_fras_v2_ig_5_base", "Clean 3 - ~y~REMAKE~c~1.0", AnimationOptions =
   {
    Prop = "prop_sponge_01",
    PropBone = 28422,
    PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
    EmoteLoop = true,
    EmoteMoving = true,
}},
["jmicro"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Hold a microphone - ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = "p_ing_microphonel_01",
       PropBone = 18905,
       PropPlacement = {0.11, 0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["jmicro2"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Hold a microphone 2 - ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = "prop_microphone_02",
       PropBone = 18905,
       PropPlacement = {0.11, 0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["jmicro3"] = {"missfra1", "mcs2_crew_idle_m_boom", "Hold a microphone 3 - ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = "prop_v_bmike_01",
       PropBone = 28422,
       PropPlacement = {-0.08, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["jcamerabig"] = {"missfinale_c2mcs_1", "fin_c2_mcs_1_camman", "Hold A Camera - ~y~REMAKE~c~1.0", AnimationOptions =
   {
       Prop = "prop_v_cam_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jdgrave1"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Digging Grave ~y~REMAKE~c~1.0", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
       Prop = 'prop_tool_shovel006',
       PropBone = 28422,
       PropPlacement = {0.0, 0.1, -0.6, 0.0, 0.0, 180.0},
    }},
}