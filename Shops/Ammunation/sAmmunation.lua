--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:ammuweapons",true)
addEventHandler("buy:ammuweapons",root,function(weapon,ammu)
	if(syncGetElementData(client,"GunLicense")==1)then
		if(weapon=="colt45")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.colt45)then
				if(getPedWeapon(client)~=22)then
					giveWeapon(client,22,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.colt45)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased this Weapon!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.colt45..")",8000)
			end
		elseif(weapon=="deagle")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.deagle)then
				if(getPedWeapon(client)~=24)then
					giveWeapon(client,24,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.deagle)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased this Weapon!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.deagle..")",8000)
			end
		elseif(weapon=="mp5")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.mp5)then
				if(getPedWeapon(client)~=29)then
					giveWeapon(client,29,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.mp5)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased this Weapon!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.mp5..")",8000)
			end
		elseif(weapon=="ak")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ak)then
				if(getPedWeapon(client)~=30)then
					giveWeapon(client,30,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ak)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased this Weapon!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.ak..")",8000)
			end
		elseif(weapon=="m4")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.m4)then
				if(getPedWeapon(client)~=31)then
					giveWeapon(client,31,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.m4)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased this Weapon!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.m4..")",8000)
			end
		end
		
		
		if(ammu=="colt45")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.colt45)then
				if(getPedWeapon(client)==22)then
					giveWeapon(client,22,17)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.colt45)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased the magazine!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.ammo.colt45..")",8000)
			end
		elseif(ammu=="deagle")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.deagle)then
				if(getPedWeapon(client)==24)then
					giveWeapon(client,24,7)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.deagle)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased the magazine!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.ammo.deagle..")",8000)
			end
		elseif(ammu=="mp5")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.mp5)then
				if(getPedWeapon(client)==29)then
					giveWeapon(client,29,30)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.mp5)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased the magazine!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.ammo.mp5..")",8000)
			end
		elseif(ammu=="ak")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.ak)then
				if(getPedWeapon(client)==30)then
					giveWeapon(client,30,30)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.ak)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased the magazine!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.ammo.ak..")",8000)
			end
		elseif(ammu=="m4")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.m4)then
				if(getPedWeapon(client)==31)then
					giveWeapon(client,31,50)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.m4)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased the magazine!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.weaponprices.ammo.m4..")",8000)
			end
		elseif(ammu=="armor")then
			if(tonumber(syncGetElementData(client,"Money"))>=200)then
				syncSetElementData(client,"Armor",tonumber(syncGetElementData(client,"Armor"))+1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-200)
				triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased 1 Armor!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($200)",8000)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not a Gun license!",8000)
	end
end)