RegisterNetEvent("account:money:add")

AddEventHandler('account:money:add', function(player, money)
  MySQL.ready(function ()
    MySQL.Async.execute('UPDATE accounts SET money = money + @money WHERE owner = @owner', {
        ['owner'] = "Léon paquin", ['money'] = money
    })
  end)
end)

RegisterNetEvent("account:liquid")

AddEventHandler('account:liquid', function(cb)
  local sourceValue = source

  
	for k,v in pairs(GetPlayerIdentifiers(sourceValue))do
		print(v)
			
		  if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamid = v
		  elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		  elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xbl  = v
		  elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			ip = v
		  elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		  elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		  end
  end
  

  MySQL.Async.fetchScalar('SELECT liquid from players where fivem = @fivem', {
    ['fivem'] = discord
  }, function(result)
    TriggerClientEvent(cb, sourceValue, result)
  end)
end)