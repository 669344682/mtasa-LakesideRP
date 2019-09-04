addEvent("buy:farmitems",true)
addEventHandler("buy:farmitems",root,function(typ,amount)
	local amount=tonumber(amount)
	if(amount>=1)then
		if(typ=="AppleSeeds")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.farmItems.appleSeedPrice)then
				syncSetElementData(client,"AppleSeeds",tonumber(syncGetElementData(client,"AppleSeeds"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.farmItems.appleSeedPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have buyed x"..amount.." AppleSeeds.",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.farmItems.appleSeedPrice..")",8000)
			end
		elseif(typ=="WeedSeeds")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.farmItems.weedSeedPrice)then
				syncSetElementData(client,"WeedSeeds",tonumber(syncGetElementData(client,"WeedSeeds"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.farmItems.weedSeedPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have buyed x"..amount.." WeedSeeds.",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.farmItems.weedSeedPrice..")",8000)
			end
		end
	end
end)

addEvent("sell:farmitems",true)
addEventHandler("sell:farmitems",root,function(typ,amount)
	local amount=tonumber(amount)
	if(amount>=1)then
		if(typ=="Apple")then
			if(tonumber(syncGetElementData(client,"Apple"))>=amount)then
				syncSetElementData(client,"Apple",tonumber(syncGetElementData(client,"Apple"))-amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+amount*settings.shop.farmItems.applePrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have selled x"..amount.." Apple.",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough Apple! (x"..amount..")",8000)
			end
		end
	end
end)