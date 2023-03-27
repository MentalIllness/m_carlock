ESX.RegisterServerCallback('m_carlock:checkIsOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT citizenid FROM bbvehicles WHERE citizenid = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then
			cb('owner')
		else
			cb('notowner')
		end
	end)
end)