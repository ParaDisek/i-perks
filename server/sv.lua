ESX = nil
skillexy = {}
skillexyexp = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function (reason)
	local name = tostring(source)
    print('wyszedl')
	skillexy[name] = nil
end)

-- komenda dla medyków -- opis w configu co do działania
RegisterCommand("daj_healera", function(source, args, rawCommand)
    if (source > 0) then
		local xTarget = ESX.GetPlayerFromId(args[1])
		if xTarget ~= nil then
			local identifier = xTarget.getIdentifier()
			MySQL.Async.fetchAll('SELECT perks FROM perm_perks WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				}, function (result)
				if result[1] ~= nil then
					local data = json.decode(result[1].perks)
					if data['Uhealer'] == 0 then data['Uhealer'] = 1 end
					MySQL.Sync.execute('UPDATE `perm_perks` SET `perks` = @perks WHERE `identifier` = @identifier', {
                        ['@identifier'] = xTarget.identifier,
                        ['@perks'] = json.encode(data),
                    })
				end
			end)
		end
	end
end, false)

local pamiec = false

ESX.RegisterServerCallback('i-perks:getskills', function (source, cb)
    local perks = Config.perks
    local perksexp = Config.perksexp
	local _source = tostring(source)
	if skillexy[_source] ~= nil then
		cb(skillexy[_source])
	else
        local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
        local identifier = xPlayer.getIdentifier()
        MySQL.Async.fetchAll('SELECT * FROM perm_perks WHERE identifier = @identifier', {
            ['@identifier'] = identifier,
	        }, function (result)
			if result[1] ~= nil then
				local data = json.decode(result[1].perks)
                for i, l in pairs(Config.perks) do
                    if data[i] == nil then
                        data[i] = 0
                        pamiec = true
                    end
                end
                local data2 = json.decode(result[1].perksexp)
                for i, l in pairs(Config.perksexp) do
                    if data2[i] == nil then
                        data2[i] = 0
                        pamiec = true
                    end
                end
				cb(data, data2)
                pamiec = true
                if pamiec == true then
                    MySQL.Sync.execute('UPDATE `perm_perks` SET `perks` = @perks, `perksexp` = @perksexp WHERE `identifier` = @identifier', {
                        ['@identifier'] = xPlayer.identifier,
                        ['@perks'] = json.encode(data),
                        ['@perksexp'] = json.encode(data2),
                    })
                end 
                pamiec = false
		    elseif result[1] == nil then
                cb(Config.perks, Config.perksexp)
                --table.insert(data, perks)
                local debug = true
                if debug then
                    print("Data: "..perks.driver)
                    print("Json: "..json.encode(perks))
                    print("Json: "..json.encode(perksexp))
                end
                MySQL.Async.transaction({'INSERT INTO `perm_perks` (identifier, perks, perksexp) VALUES (@identifier, @perks, @perksexp)'}, {
                        ['@identifier'] = xPlayer.identifier,
                        ['@perks'] = json.encode(Config.perks),
                        ['@perksexp'] = json.encode(Config.perksexp),
                    },
                function(success)
                    print(success)
                end)
                perks = {}
		end
	  end)
end
end
end)

MySQL.ready(function ()
UpdatePerk = -1
MySQL.Async.store("UPDATE `perm_perks` SET `perksexp` = @perksexp WHERE `identifier` = @identifier", function(storeIt) UpdatePerk = storeIt end)
end)

ESX.RegisterServerCallback('i-perks:addExp', function (source, cb, id, tablica)
	local _source = id
	local l = nil
	print(id,tablica)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('SELECT perksexp FROM perm_perks WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	  }, function (result)
		local data = json.decode(result[1].perksexp)
		if result[1].perksexp ~= nil then
			MySQL.Async.transaction(
				{UpdatePerk}, 
				{['@identifier'] = xPlayer.identifier, ['@perksexp'] = json.encode(tablica)},
				function(success)
				print(success) 
				cb(success)
				
			end)
		data = {}
		else
		end
	  end)
end)

-- ESX.RegisterServerCallback('i-perks:addExp', function (source, cb, id, tablica)
-- 	local _source = id
-- 	local l = nil
-- 	print(id,tablica)
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local identifier = xPlayer.getIdentifier()
-- 	MySQL.Async.fetchAll('SELECT perksexp FROM perm_perks WHERE identifier = @identifier', {
-- 		['@identifier'] = xPlayer.identifier,
-- 	  }, function (result)
-- 		local data = json.decode(result[1].perksexp)
-- 		if result[1].perksexp ~= nil then
-- 			MySQL.Async.transaction(
-- 				{'UPDATE `perm_perks` SET `perksexp` = @perksexp WHERE `identifier` = @identifier'}, 
-- 				{['@identifier'] = xPlayer.identifier, ['@perksexp'] = json.encode(tablica)},
-- 				function(success)
-- 				print(success) 
-- 				l = success
-- 			end)
-- 		data = {}
-- 		else
-- 		end
-- 		cb(l)
-- 	  end)
-- end)


RegisterServerEvent("i-perks:addExp")
AddEventHandler("i-perks:addExp", function(id, tablica)
	local _source = id
	print(id,skill,ile)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('SELECT perksexp FROM perm_perks WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	  }, function (result)
		local data = json.decode(result[1].perksexp)
		if result[1].perksexp ~= nil then
				MySQL.Sync.execute('UPDATE `perm_perks` SET `perksexp` = @perksexp WHERE `identifier` = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@perksexp'] = json.encode(data),
				})

		else
		end
	  end)
end)

RegisterServerEvent("i-perks:addSkill")
AddEventHandler("i-perks:addSkill", function(id, skill)
	local _source = id
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('SELECT perks FROM perm_perks WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	  }, function (result)
		local data = json.decode(result[1].perks)
		if result[1].perks ~= nil then

			if data[skill] == 0 then
				data[skill] = data[skill] + 1
				MySQL.Sync.execute('UPDATE `perm_perks` SET `perks` = @perks WHERE `identifier` = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@perks'] = json.encode(data),
				})
                print('dodano punkt do: '..skill)
			else
				print("Nie znaleziono danych w bazie dotyczące skilla lub brak możliwosci dodania kolejnego punktu")
			end
		else
		end
	  end)
end)