--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onVehicleStartEnter",root,function(player)
	if(getPedOccupiedVehicleSeat(player)==0)then
		if(getElementData(source,"veh:jobbus")==true)then
			if(syncGetElementData(player,"Job")~="Busdriver")then
				cancelEvent(true)
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a Busdriver!",8000)
			end
		elseif(getElementData(source,"veh:jobpizza")==true)then
			if(syncGetElementData(player,"Job")~="Pizzaboy")then
				cancelEvent(true)
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a Pizzaboy!",8000)
			end
		elseif(getElementData(source,"veh:jobtaxi")==true)then
			if(syncGetElementData(player,"Job")~="Taxidriver")then
				cancelEvent(true)
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a Taxidriver!",8000)
			end
		end
	end
end)

addEventHandler("onVehicleEnter",root,function(player)
	if(getElementData(source,"veh:jobbus")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Busdriver")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a Busdriver!",8000)
			else
				setElementFrozen(source,false)
				setElementData(player,"ImBusjob",true)
				triggerClientEvent(player,"createBusMarker",player,"create")
			end
		end
	end
	if(getElementData(source,"veh:jobpizza")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Pizzaboy")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a Pizzaboy!",8000)
			else
				if(isElement(pizzaObject[player])or pizzaFirst[player]==true)then
					if(isTimer(pizzaTimer[source]))then
						killTimer(pizzaTimer[source])
					end
					setElementFrozen(source,false)
					if(isElement(pizzaObject[player]))then
						destroyElement(pizzaObject[player])
					end
					if(pizzaLoaded[player]==true and isPizzaMarker[player]~=true)then
						triggerClientEvent(player,"createPizzaMarker",player,"create")
						isPizzaMarker[player]=true
					end
					pizzaFirst[player]=true
				else
					removePedFromVehicle(player)
					pizzaFirst[player]=false
					triggerClientEvent(player,"draw:infobox",root,"error","Get a pizza from the kitchen first!",8000)
				end
			end
		end
	end
	if(getElementData(source,"veh:jobtaxi")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Taxidriver")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a Taxidriver!",8000)
			else
				setElementFrozen(source,false)
				setElementData(player,"ImTaxijob",true)
			end
		else
			if(getElementType(player)=="player")then
				local veh=getPedOccupiedVehicle(player)
				taxiPayTimer[player]=setTimer(function(player)
					local driver=getVehicleOccupant(veh,0)
					if(driver)then
						if(tonumber(syncGetElementData(player,"Money"))>=3)then
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-3)
							syncSetElementData(driver,"Jobmoney",tonumber(syncGetElementData(driver,"Jobmoney"))+3)
							infoShow(driver,"plus","You get $3")
						else
							removePedFromVehicle(player)
							triggerClientEvent(player,"draw:infobox",root,"error","You have no more money! ($3)",8000)
						end
					end
				end,5000,0,player)
			end
		end
	end
end)
addEventHandler("onVehicleExit",root,function(player)
	if(getElementData(source,"veh:jobbus")==true)then
		if(getElementData(player,"ImBusjob")==true)then
			respawnVehicle(source)
			setElementFrozen(source,true)
			setVehicleEngineState(source,false)
			setElementData(source,"engine",false)
			setElementData(player,"ImBusjob",false)
			triggerClientEvent(player,"createBusMarker",player)
			triggerClientEvent(player,"refreshBusMarker",player)
		end
	end
	if(getElementData(source,"veh:jobpizza")==true)then
		if(syncGetElementData(player,"Job")=="Pizzaboy")then
			if(not isTimer(pizzaTimer[source]))then
				pizzaTimer[source]=setTimer(function(source)
					respawnVehicle(source)
					fixVehicle(source)
					setElementFrozen(source,true)
					setVehicleEngineState(source,false)
					setElementData(source,"engine",false)
					pizzaFirst[player]=false
					triggerClientEvent(player,"draw:infobox",root,"info","Pizzascooter destroyed!",8000)
				end,2*60*1000,1,source)
				if(pizzaLoaded[player]==true)then
					createPlayerPizza(player)
				end
			end
		end
	end
	if(getElementData(source,"veh:jobtaxi")==true)then
		if(getElementData(player,"ImTaxijob")==true)then
			respawnVehicle(source)
			fixVehicle(source)
			setElementFrozen(source,true)
			setVehicleEngineState(source,false)
			setElementData(source,"engine",false)
		end
	end
	if(isTimer(taxiPayTimer[player]))then
		taxiPayTimer[player]:destroy()
	end
end)

addEventHandler("onVehicleExplode",root,function()
	if(isTimer(pizzaTimer[source]))then
		pizzaTimer[source]:destroy()
	end
end)

function giveJobMoney(typ,amount)
	if(amount)then
		if(typ=="Busdriver" or typ=="Pizzaboy" or typ=="Taxidriver")then
			syncSetElementData(client,"Jobmoney",tonumber(syncGetElementData(client,"Jobmoney"))+amount)
			uLevel(client,"Job")
			infoShow(client,"plus","You get $"..amount.."")
			if(typ=="Busdriver")then
				local rdmexp=math.random(8,19)
				uEXP(client,"Job",rdmexp)
				uLevel(client,"Job")
			end
		end
	end
end
addEvent("give:jobmoney",true)
addEventHandler("give:jobmoney",root,giveJobMoney)