QuestState = {}
RegisterCommand("quest", function(source)
    ExportQuestClient('quest_cabbage', 5)
end)
RegisterCommand(Config.CommandReset, function(source)
    ResetQuest()
end)
RegisEvent(true, e.cl["ClearQuestState"], function()
    ResetQuest()
end)
RegisEvent(true, e.cl["ResetQuestID"], function(a, d)
    QuestState[a].State = true
    QuestState[a].Count = d
    QuestStackUpdate()
end)
RegisEvent(true, "UpdateQuest", function(a,b)
    Wait(Config.WaitUpdate)
    ExportQuestClient(a,b)
end)
RegisterNUICallback("Exit",function()
    if Config.BlurMode then TriggerScreenblurFadeOut(1000) end
    SetNuiFocus(false, false)
end)
RegisterNUICallback("QuestAction",function(data)
    if data.type == "AcceptQuest" then 
        QuestState[data.key].State = false
        QuestStackUpdate()
    elseif data.type == "DropQuest" then
        t[2](e.sv["ResetQuestID"], data.key)
    end
end)
