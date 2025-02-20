function getCoreObject()
	local self = {};
	self.resource = GetCurrentResourceName();
	self.rname = function(name)
		if IsDuplicityVersion() then
			return self.resource .. ":server:" .. name;
		else
			return self.resource .. ":client:" .. name;
		end;
	end;
	self.gname = function(name)
		if IsDuplicityVersion() then
			return self.resource .. ":client:" .. name;
		else
			return self.resource .. ":server:" .. name;
		end;
	end;
	return self;
end;
exports("getCoreObject", getCoreObject);
RegisterNetEvent("onResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		dnk = exports['dnk.DailyLogin']:getCoreObject();
	end;
end);
