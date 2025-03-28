local GetPlayerPed = GetPlayerPed
local GetEntityCoords = GetEntityCoords

function CreateExtendedPlayer(playerId, identifier, group, accounts, inventory, job, loadout, name, coords, metadata)
	local targetOverrides = Config.PlayerFunctionOverride and Core.PlayerFunctionOverrides[Config.PlayerFunctionOverride] or {}

	local self = {}

	self.accounts = accounts
	self.coords = coords
	self.group = group
	self.identifier = identifier
	self.inventory = inventory
	self.job = job
	self.loadout = loadout
	self.name = name
	self.playerId = playerId
	self.source = playerId
	self.variables = {}
	self.metadata = metadata
    self.admin = Core.IsPlayerAdmin(playerId)

	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.license, self.group))

	local stateBag = Player(self.source).state
	stateBag:set("identifier", self.identifier, true)
	stateBag:set("license", self.license, true)
	stateBag:set("job", self.job, true)
	stateBag:set("group", self.group, true)
	stateBag:set("name", self.name, true)
	stateBag:set("metadata", self.metadata, true)

	function self.triggerEvent(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	function self.setCoords(coordinates)
		local Ped = GetPlayerPed(self.source)
		local vector = type(coordinates) == "vector4" and coordinates or type(coordinates) == "vector3" and vector4(coordinates, 0.0) or
			vec(coordinates.x, coordinates.y, coordinates.z, coordinates.heading or 0.0)
		SetEntityCoords(Ped, vector.xyz, false, false, false, false)
		SetEntityHeading(Ped, vector.w)
	end

	function self.getCoords(vector)
		local ped = GetPlayerPed(self.source)
		local coordinates = GetEntityCoords(ped)

		if vector then
			return coordinates
		else
			return {
				x = coordinates.x,
				y = coordinates.y,
				z = coordinates.z,
			}
		end
	end

	function self.kick(reason)
		DropPlayer(self.source, reason)
	end

	function self.setMoney(money)
		money = ESX.Math.Round(money)
		self.setAccountMoney('money', money)
	end

	function self.getMoney()
		return self.getAccount('money').money
	end

	function self.addMoney(money, reason)
		money = ESX.Math.Round(money)
		self.addAccountMoney('money', money, reason)
	end

	function self.removeMoney(money, reason)
		money = ESX.Math.Round(money)
		self.removeAccountMoney('money', money, reason)
	end

	function self.getIdentifier()
		return self.identifier
	end

	function self.setGroup(newGroup)
		ExecuteCommand(('remove_principal identifier.%s group.%s'):format(self.license, self.group))
		self.group = newGroup
		Player(self.source).state:set("group", self.group, true)
		ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.license, self.group))
	end

	function self.getGroup()
		return self.group
	end

	function self.set(k, v)
		self.variables[k] = v
		Player(self.source).state:set(k, v, true)
	end

	function self.get(k)
		return self.variables[k]
	end

	function self.getAccounts(minimal)
		if not minimal then
			return self.accounts
		end

		local minimalAccounts = {}

		for i = 1, #self.accounts do
			minimalAccounts[self.accounts[i].name] = self.accounts[i].money
		end

		return minimalAccounts
	end

	function self.getAccount(account)
		for i = 1, #self.accounts do
			if self.accounts[i].name == account then
				return self.accounts[i]
			end
		end
		return nil
	end

	function self.getInventory(minimal)
		if minimal then
			local minimalInventory = {}

			for _, v in ipairs(self.inventory) do
				if v.count > 0 then
					minimalInventory[v.name] = v.count
				end
			end

			return minimalInventory
		end

		return self.inventory
	end

	function self.getJob()
		return self.job
	end

	function self.getLoadout(minimal)
		if not minimal then
			return self.loadout
		end
		local minimalLoadout = {}

		for _, v in ipairs(self.loadout) do
			minimalLoadout[v.name] = { ammo = v.ammo }
			if v.tintIndex > 0 then minimalLoadout[v.name].tintIndex = v.tintIndex end

			if #v.components > 0 then
				local components = {}

				for _, component in ipairs(v.components) do
					if component ~= 'clip_default' then
						components[#components + 1] = component
					end
				end

				if #components > 0 then
					minimalLoadout[v.name].components = components
				end
			end
		end

		return minimalLoadout
	end

	function self.getName()
		return self.name
	end

	function self.setName(newName)
		self.name = newName
		Player(self.source).state:set("name", self.name, true)
	end

	function self.setAccountMoney(accountName, money, reason)
		reason = reason or 'unknown'
		if not tonumber(money) then
			-- print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
			return
		end
		if money >= 0 then
			local account = self.getAccount(accountName)

			if account then
				money = account.round and ESX.Math.Round(money) or money
				self.accounts[account.index].money = money

				self.triggerEvent('esx:setAccountMoney', account)
				TriggerEvent('esx:setAccountMoney', self.source, accountName, money, reason)
			else
				print(('[^1ERROR^7] Tried To Set Invalid Account ^5%s^0 For Player ^5%s^0!'):format(accountName, self.playerId))
			end
		else
			-- print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
		end
	end

	function self.addAccountMoney(accountName, money, reason)
		reason = reason or 'Unknown'
		if not tonumber(money) then
			-- print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
			return
		end
		if money > 0 then
			local account = self.getAccount(accountName)
			if account then
				money = account.round and ESX.Math.Round(money) or money
				self.accounts[account.index].money = self.accounts[account.index].money + money

				self.triggerEvent('esx:setAccountMoney', account)
				TriggerEvent('esx:addAccountMoney', self.source, accountName, money, reason)
			else
				print(('[^1ERROR^7] Tried To Set Add To Invalid Account ^5%s^0 For Player ^5%s^0!'):format(accountName, self.playerId))
			end
		else
			-- print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
		end
	end

	function self.removeAccountMoney(accountName, money, reason)
		reason = reason or 'Unknown'
		if not tonumber(money) then
			-- print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
			return
		end
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				money = account.round and ESX.Math.Round(money) or money
				self.accounts[account.index].money = self.accounts[account.index].money - money

				self.triggerEvent('esx:setAccountMoney', account)
				TriggerEvent('esx:removeAccountMoney', self.source, accountName, money, reason)
			else
				print(('[^1ERROR^7] Tried To Set Add To Invalid Account ^5%s^0 For Player ^5%s^0!'):format(accountName, self.playerId))
			end
		else
			-- print(('[^1ERROR^7] Tried To Set Account ^5%s^0 For Player ^5%s^0 To An Invalid Number -> ^5%s^7'):format(accountName, self.playerId, money))
		end
	end

	function self.getInventoryItem(itemName)
		for _, v in ipairs(self.inventory) do
			if v.name == itemName then
				return v
			end
		end
	end

	function self.addInventoryItem(itemName, count)
		local item = self.getInventoryItem(itemName)

		if item then
			count = ESX.Math.Round(count)
			item.count = item.count + count

			TriggerEvent('esx:onAddInventoryItem', self.source, item.name, item.count)
			self.triggerEvent('esx:addInventoryItem', item.name, item.count)
		end
	end

	function self.removeInventoryItem(itemName, count)
		local item = self.getInventoryItem(itemName)

		if item then
			count = ESX.Math.Round(count)
			if count > 0 then
				local newCount = item.count - count

				if newCount >= 0 then
					item.count = newCount

					TriggerEvent('esx:onRemoveInventoryItem', self.source, item.name, item.count)
					self.triggerEvent('esx:removeInventoryItem', item.name, item.count)
				end
			else
				print(('[^1ERROR^7] Player ID:^5%s Tried remove a Invalid count -> %s of %s'):format(self.playerId, count, itemName))
			end
		end
	end

	function self.setInventoryItem(itemName, count)
		local item = self.getInventoryItem(itemName)

		if item and count >= 0 then
			count = ESX.Math.Round(count)

			if count > item.count then
				self.addInventoryItem(item.name, count - item.count)
			else
				self.removeInventoryItem(item.name, item.count - count)
			end
		end
	end

	function self.canCarryItem(itemName, itemCount)
		local ItemObject = self.getInventoryItem(itemName)

		if ItemObject.limit ~= -1 and (ItemObject.count + itemCount) > ItemObject.limit then
			return false
		end

		return true
	end

	function self.setJob(newJob, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job))

		if ESX.DoesJobExist(newJob, grade) then
			local jobObject, gradeObject = ESX.Jobs[newJob], ESX.Jobs[newJob].grades[grade]

			self.job.id                  = jobObject.id
			self.job.name                = jobObject.name
			self.job.label               = jobObject.label

			self.job.grade               = tonumber(grade)
			self.job.grade_name          = gradeObject.name
			self.job.grade_label         = gradeObject.label
			self.job.grade_salary        = gradeObject.salary

			if gradeObject.skin_male then
				self.job.skin_male = json.decode(gradeObject.skin_male)
			else
				self.job.skin_male = {}
			end

			if gradeObject.skin_female then
				self.job.skin_female = json.decode(gradeObject.skin_female)
			else
				self.job.skin_female = {}
			end

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			self.triggerEvent('esx:setJob', self.job, lastJob)
			Player(self.source).state:set("job", self.job, true)
		else
			print(('[es_extended] [^3WARNING^7] Ignoring invalid ^5.setJob()^7 usage for ID: ^5%s^7, Job: ^5%s^7'):format(self.source, job))
		end
	end

	function self.addWeapon(weaponName, ammo)
		if not self.hasWeapon(weaponName) then
			local weaponLabel = ESX.GetWeaponLabel(weaponName)

			table.insert(self.loadout, {
				name = weaponName,
				ammo = ammo,
				label = weaponLabel,
				components = {},
				tintIndex = 0
			})

			GiveWeaponToPed(GetPlayerPed(self.source), GetHashKey(weaponName), ammo, false, false)
			self.triggerEvent('esx:addInventoryItem', weaponLabel, false, true)
		end
	end

	function self.addWeaponComponent(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if not self.hasWeaponComponent(weaponName, weaponComponent) then
					self.loadout[loadoutNum].components[#self.loadout[loadoutNum].components + 1] = weaponComponent
					local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash
					GiveWeaponComponentToPed(GetPlayerPed(self.source), GetHashKey(weaponName), componentHash)
					self.triggerEvent('esx:addInventoryItem', component.label, false, true)
				end
			end
		end
	end

	function self.addWeaponAmmo(weaponName, ammoCount)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo + ammoCount
			SetPedAmmo(GetPlayerPed(self.source), GetHashKey(weaponName), weapon.ammo)
		end
	end

	function self.updateWeaponAmmo(weaponName, ammoCount)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = ammoCount
		end
	end

	function self.setWeaponTint(weaponName, weaponTintIndex)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local _, weaponObject = ESX.GetWeapon(weaponName)

			if weaponObject.tints and weaponObject.tints[weaponTintIndex] then
				self.loadout[loadoutNum].tintIndex = weaponTintIndex
				self.triggerEvent('esx:setWeaponTint', weaponName, weaponTintIndex)
				self.triggerEvent('esx:addInventoryItem', weaponObject.tints[weaponTintIndex], false, true)
			end
		end
	end

	function self.getWeaponTint(weaponName)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then
			return weapon.tintIndex
		end

		return 0
	end

	function self.removeWeapon(weaponName)
		local weaponLabel, playerPed = nil, GetPlayerPed(self.source)

		if not playerPed then
			return print("[^1ERROR^7] xPlayer.removeWeapon ^5invalid^7 player ped!")
		end

		for k, v in ipairs(self.loadout) do
			if v.name == weaponName then
				weaponLabel = v.label

				for _, v2 in ipairs(v.components) do
					self.removeWeaponComponent(weaponName, v2)
				end

				local weaponHash = GetHashKey(v.name)

				RemoveWeaponFromPed(playerPed, weaponHash)
				SetPedAmmo(playerPed, weaponHash, 0)

				table.remove(self.loadout, k)
				break
			end
		end

		if weaponLabel then
			self.triggerEvent('esx:removeInventoryItem', weaponLabel, false, true)
		end
	end

	function self.removeWeaponComponent(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if self.hasWeaponComponent(weaponName, weaponComponent) then
					for k, v in ipairs(self.loadout[loadoutNum].components) do
						if v == weaponComponent then
							table.remove(self.loadout[loadoutNum].components, k)
							break
						end
					end

					self.triggerEvent('esx:removeWeaponComponent', weaponName, weaponComponent)
					self.triggerEvent('esx:removeInventoryItem', component.label, false, true)
				end
			end
		end
	end

	function self.removeWeaponAmmo(weaponName, ammoCount)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo - ammoCount
			self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	function self.hasWeaponComponent(weaponName, weaponComponent)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then
			for _, v in ipairs(weapon.components) do
				if v == weaponComponent then
					return true
				end
			end

			return false
		else
			return false
		end
	end

	function self.hasWeapon(weaponName)
		for _, v in ipairs(self.loadout) do
			if v.name == weaponName then
				return true
			end
		end

		return false
	end

	function self.hasItem(item)
		for _, v in ipairs(self.inventory) do
			if (v.name == item) and (v.count >= 1) then
				return v, v.count
			end
		end

		return false
	end

	function self.getWeapon(weaponName)
		for k, v in ipairs(self.loadout) do
			if v.name == weaponName then
				return k, v
			end
		end
	end

	function self.showNotification(msg, notifyType, length)
		self.triggerEvent('esx:showNotification', msg, notifyType, length)
	end

	function self.showAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
		self.triggerEvent('esx:showAdvancedNotification', sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	end

	function self.showHelpNotification(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end

	function self.getMeta(index, subIndex)
		if not (index) then return self.metadata end

		if type(index) ~= "string" then
			return print("[^1ERROR^7] xPlayer.getMeta ^5index^7 should be ^5string^7!")
		end

		local metaData = self.metadata[index]
		if (metaData == nil) then
			return Config.EnableDebug and print(("[^1ERROR^7] xPlayer.getMeta ^5%s^7 not exist!"):format(index)) or nil
		end

		if (subIndex and type(metaData) == "table") then
			local _type = type(subIndex)

			if (_type == "string") then
				local value = metaData[subIndex]
				return value
			end

			if (_type == "table") then
				local returnValues = {}

				for i = 1, #subIndex do
					local key = subIndex[i]
					if (type(key) == "string") then
						returnValues[key] = self.getMeta(index, key)
					else
						print(("[^1ERROR^7] xPlayer.getMeta subIndex should be ^5string^7 or ^5table^7! that contains ^5string^7, received ^5%s^7!, skipping..."):format(type(key)))
					end
				end

				return returnValues
			end

			return print(("[^1ERROR^7] xPlayer.getMeta subIndex should be ^5string^7 or ^5table^7!, received ^5%s^7!"):format(_type))
		end

		return metaData
	end

	function self.setMeta(index, value, subValue)
		if not index then
			return print("[^1ERROR^7] xPlayer.setMeta ^5index^7 is Missing!")
		end

		if type(index) ~= "string" then
			return print("[^1ERROR^7] xPlayer.setMeta ^5index^7 should be ^5string^7!")
		end

		if not value then
			return print(("[^1ERROR^7] xPlayer.setMeta ^5%s^7 is Missing!"):format(value))
		end

		local _type = type(value)

		if not subValue then
			if _type ~= "number" and _type ~= "string" and _type ~= "table" then
				return print(("[^1ERROR^7] xPlayer.setMeta ^5%s^7 should be ^5number^7 or ^5string^7 or ^5table^7!"):format(value))
			end

			self.metadata[index] = value
		else
			if _type ~= "string" then
				return print(("[^1ERROR^7] xPlayer.setMeta ^5value^7 should be ^5string^7 as a subIndex!"):format(value))
			end

            if not self.metadata[index] or type(self.metadata[index]) ~= "table" then
				self.metadata[index] = { }
			end

			self.metadata[index] = type(self.metadata[index]) == 'table' and self.metadata[index] or {}
			self.metadata[index][value] = subValue
		end

		Player(self.source).state:set('metadata', self.metadata, true)
	end

	function self.clearMeta(index, subValues)
		if not index then
			return print("[^1ERROR^7] xPlayer.clearMeta ^5index^7 is Missing!")
		end
	
		if type(index) ~= "string" then
			return print("[^1ERROR^7] xPlayer.clearMeta ^5index^7 should be ^5string^7!")
		end
	
		local metaData = self.metadata[index]
		if metaData == nil then
			return Config.EnableDebug and print(("[^1ERROR^7] xPlayer.clearMeta ^5%s^7 does not exist!"):format(index)) or nil
		end
	
		if not subValues then
			-- If no subValues is provided, we will clear the entire value in the metaData table
			self.metadata[index] = nil
		elseif type(subValues) == "string" then
			-- If subValues is a string, we will clear the specific subValue within the table
			if type(metaData) == "table" then
				metaData[subValues] = nil
			else
				return print(("[^1ERROR^7] xPlayer.clearMeta ^5%s^7 is not a table! Cannot clear subValue ^5%s^7."):format(index, subValues))
			end
		elseif type(subValues) == "table" then
			-- If subValues is a table, we will clear multiple subValues within the table
			for i = 1, #subValues do
				local subValue = subValues[i]
				if type(subValue) == "string" then
					if type(metaData) == "table" then
						metaData[subValue] = nil
					else
						print(("[^1ERROR^7] xPlayer.clearMeta ^5%s^7 is not a table! Cannot clear subValue ^5%s^7."):format(index, subValue))
					end
				else
					print(("[^1ERROR^7] xPlayer.clearMeta subValues should contain ^5string^7, received ^5%s^7, skipping..."):format(type(subValue)))
				end
			end
		else
			return print(("[^1ERROR^7] xPlayer.clearMeta ^5subValues^7 should be ^5string^7 or ^5table^7, received ^5%s^7!"):format(type(subValues)))
		end
	
		Player(self.source).state:set('metadata', self.metadata, true)
	end

	for fnName, fn in pairs(targetOverrides) do
		self[fnName] = fn(self)
	end

	return self
end
