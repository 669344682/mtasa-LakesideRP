--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:shopitem",true)
addEventHandler("buy:shopitem",root,function(typ,amount)
	if(amount)then
		if(typ=="Burger")then
			if(amount:len()>=1)then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.burgerPrice*amount))then
					if(syncGetElementData(client,"Burger")+amount<=50)then
						syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+amount)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.burgerPrice*amount)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","You can not own more than x50 Burgers!",8000)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.burgerPrice..")",8000)
				end
			end
		elseif(typ=="Pizza")then
			if(amount:len()>=1)then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.pizzaPrice*amount))then
					if(syncGetElementData(client,"Pizza")+amount<=50)then
						syncSetElementData(client,"Pizza",tonumber(syncGetElementData(client,"Pizza"))+amount)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.pizzaPrice*amount)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","You can not own more than x50 Pizza!",8000)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.pizzaPrice..")",8000)
				end
			end
		elseif(typ=="Mobilephone")then
			--if(#amount:len()>=1)then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(amount*settings.shop.mobilephonePrice*amount))then
					if(syncGetElementData(client,"Mobilephone")==0)then
						local rdmNumber=math.random(10000000,99999999)
						syncSetElementData(client,"Mobilephone",tonumber(syncGetElementData(client,"Mobilephone"))+amount)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.mobilephonePrice)
						triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased a Mobilephone!\n(Press: U) Your number: "..rdmNumber.."",30000)
						syncSetElementData(client,"Telenr",rdmNumber)
						triggerEvent("set:task",client,client,"BuyMobilephone")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","You can not own more than x1 Mobilephone!",8000)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.mobilephonePrice..")",8000)
				end
			--end
		elseif(typ=="ChestWood")then
			if(tonumber(syncGetElementData(client,"TicketBronze"))>=tonumber(1))then
				syncSetElementData(client,"ChestWood",tonumber(syncGetElementData(client,"ChestWood"))+1)
				syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))-1)
				triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased an Wood Chest!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough tickets! (x1)",8000)
			end
		elseif(typ=="ChestIron")then
			if(tonumber(syncGetElementData(client,"TicketSilver"))>=tonumber(1))then
				syncSetElementData(client,"ChestIron",tonumber(syncGetElementData(client,"ChestIron"))+1)
				syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))-1)
				triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased an Iron Chest!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough tickets! (x1)",8000)
			end
		--//Normal shop items
		elseif(typ=="Repairkit")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.repairkitPrice*amount))then
				if(tonumber(syncGetElementData(client,"Repairkit"))<5)then
					syncSetElementData(client,"Repairkit",tonumber(syncGetElementData(client,"Repairkit"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.repairkitPrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased a Repairkit!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You can not own more than x5 Repairkits!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..settings.shop.repairkitPrice..")",8000)
			end
		elseif(typ=="Cola")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.colaPrice*amount))then
				if(syncGetElementData(client,"Cola")+amount<=50)then
					syncSetElementData(client,"Cola",tonumber(syncGetElementData(client,"Cola"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.colaPrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased a Cola!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You can not own more than x50 Cola!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.colaPrice..")",8000)
			end
		elseif(typ=="Cigarette")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.cigarettePrice*amount))then
				if(syncGetElementData(client,"Cigarette")+amount<=25)then
					syncSetElementData(client,"Cigarette",tonumber(syncGetElementData(client,"Cigarette"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.cigarettePrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased a Cigarette!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You can not own more than x25 Cigarette!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.cigarettePrice..")",8000)
			end
		elseif(typ=="AppleSeeds")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.appleseedPrice*amount))then
				syncSetElementData(client,"AppleSeeds",tonumber(syncGetElementData(client,"AppleSeeds"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.appleseedPrice*amount)
				triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased a Apple seeds!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.appleseedPrice..")",8000)
			end
		elseif(typ=="Present")then
			if(tonumber(syncGetElementData(client,"Candycane"))>=tonumber(5))then
				syncSetElementData(client,"Present",tonumber(syncGetElementData(client,"Present"))+amount)
				syncSetElementData(client,"Candycane",tonumber(syncGetElementData(client,"Candycane"))-5)
				triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased a Present!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough Candycane! (x5)",8000)
			end
		end
	end
end)