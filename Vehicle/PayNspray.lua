--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local PNSStationsTable={
	[1]=createColSphere(-1904.3,285.5,41.4,3),
	[2]=createColSphere(1976.6,2162.4,9.6,3),
	[3]=createColSphere(-99.8,1118.4,18.3,3),
	[4]=createColSphere(2061.2,-1831.6,13.5,3),
	[5]=createColSphere(720.2,-455.8,16.3,3),
	[6]=createColSphere(1024.9,-1023.7,32.1,3),
	[7]=createColSphere(487.3,-1741.6,11.2,3)
}

setGarageOpen(36,true)
setGarageOpen(41,true)
setGarageOpen(8,true)
setGarageOpen(47,true)
setGarageOpen(11,true)
setGarageOpen(12,true)
setGarageOpen(19,true)

setElementData(PNSStationsTable[1],"gateID",19)
setElementData(PNSStationsTable[2],"gateID",36)
setElementData(PNSStationsTable[3],"gateID",41)
setElementData(PNSStationsTable[4],"gateID",8)
setElementData(PNSStationsTable[5],"gateID",47)
setElementData(PNSStationsTable[6],"gateID",11)
setElementData(PNSStationsTable[7],"gateID",12)


function paynSprayRepair(hitElement)
	if(hitElement and isElement(hitElement)and getElementType(hitElement)=="vehicle")then
		if(getVehicleOccupant(hitElement,0))then
			local player=getVehicleOccupant(hitElement,0)
			if(getElementDimension(hitElement)==getElementDimension(player))then
				if(getElementData(hitElement,"Owner")==getPlayerName(player)or getElementData(hitElement,"Owner")==tonumber(syncGetElementData(player,"Faction")))then
					if(getElementHealth(getPedOccupiedVehicle(player))<1000)then
						if(syncGetElementData(player,"Money")>=150)then
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-150)
							local x,y,z=player:getPosition()
							if(hitElement:getVehicleType()~="Plane" and hitElement:getVehicleType()~="Helicopter" and hitElement:getVehicleType()~="Boat" and hitElement:getVehicleType()~="Train" and hitElement:getVehicleType()~="Trailer")then
								player:setFrozen(true)
								hitElement:setFrozen(true)
								if(isGarageOpen(getElementData(source,"gateID"))~=false)then
									setGarageOpen(getElementData(source,"gateID"),false)
								end
								setTimer(paynSprayRepair_Func,4500,1,hitElement,player,getElementData(source,"gateID"))
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money! ($150)",8000)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"info","Your vehicle does not need to be repaired!",8000)
					end
				end
			end
		end
	end
end
for i=1,#PNSStationsTable do
	addEventHandler("onColShapeHit",PNSStationsTable[i],paynSprayRepair)
end


function paynSprayRepair_Func(veh,player,gateID)
	if(not isGarageOpen(gateID))then
		setGarageOpen(gateID,true)
	end
	playSoundFrontEnd(player,46)
	player:setFrozen(false)
	veh:fix()
	veh:setFrozen(false)
	triggerClientEvent(player,"draw:infobox",root,"success","This vehicle was successfully repaired.",8000)
end