Quest = function(source, item, count)
-- FARM JOB
    if string.match(item, "orange") then
        exports.swift_quest:AddPoint(source, 2, 1) 
    end
end

