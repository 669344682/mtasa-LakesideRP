--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("refuel",true)
addEventHandler("refuel",root,function(typ,liters)
	if(isPedInVehicle(client))then
		if(typ=="full")then
			local veh=getPedOccupiedVehicle(client)
			local fuel=getElementData(veh,"Fuel")
			local newLiter=100-fuel
			
			if(veh and getPedOccupiedVehicleSeat(client)==0)then
				if(fuel<100)then
					if(getVehicleEngineState(veh)==false and getElementData(veh,"engine")==false)then
						if(tonumber(syncGetElementData(client,"Money"))>=settings.vehicle.literprice*newLiter)then
							setElementFrozen(veh,true)
							toggleAllControls(client,false)
							syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.vehicle.literprice*newLiter)
							
							if(fuel>=100)then
								setElementData(veh,"Fuel",100)
							end
							
							triggerClientEvent(client,"start:refuelsound",client)
							setTimer(function(client)
								setElementFrozen(veh,false)
								toggleAllControls(client,true)
								setElementData(veh,"Fuel",fuel+newLiter)
								triggerClientEvent(client,"stop:refuelsound",client)
								triggerClientEvent(client,"playSound_mp3",client,"FuelUnhook","ogg",false,1)
							end,newLiter*250,1,client)
							
						else
							setElementFrozen(veh,false)
							triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..math.floor(settings.vehicle.literprice*newLiter)..")",8000)
						end
					else
						setElementFrozen(veh,false)
						triggerClientEvent(client,"draw:infobox",root,"error","First turn off the engine before you refuel!",8000)
					end
				else
					setElementFrozen(veh,false)
				end
			end
		elseif(typ=="liter")then
			local veh=getPedOccupiedVehicle(client)
			local fuel=getElementData(veh,"Fuel")
			local liters=tonumber(liters)
			
			if(veh and getPedOccupiedVehicleSeat(client)==0)then
				if(fuel<100)then
					if(fuel+liters<100)then
						if(getVehicleEngineState(veh)==false and getElementData(veh,"engine")==false)then
							if(tonumber(syncGetElementData(client,"Money"))>=settings.vehicle.literprice*liters)then
								setElementFrozen(veh,true)
								toggleAllControls(client,false)
								syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.vehicle.literprice*liters)
								
								if(fuel>=100)then
									setElementData(veh,"Fuel",100)
								end
								
								triggerClientEvent(client,"start:refuelsound",client)
								setTimer(function(client)
									setElementFrozen(veh,false)
									toggleAllControls(client,true)
									setElementData(veh,"Fuel",fuel+liters)
									triggerClientEvent(client,"stop:refuelsound",client)
								end,liters*250,1,client)
							else
								setElementFrozen(veh,false)
								triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..math.floor(settings.vehicle.literprice*liters)..")",8000)
							end
						else
							setElementFrozen(veh,false)
							triggerClientEvent(client,"draw:infobox",root,"error","First turn off the engine before you refuel!",8000)
						end
					else
						setElementFrozen(veh,false)
					end
				else
					setElementFrozen(veh,false)
				end
			end
		end
	end
end)