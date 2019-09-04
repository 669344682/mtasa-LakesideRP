--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local MechTow_TowedMarker=createMarker(862.5,-1255.5,13.7,"cylinder",4,255,255,255,100)
local towedDIM=999

function openTowedVehpanel(player)
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","UID",playerUID[getPlayerName(player)]),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(v["Towed"]==1)then
				table.insert(tbl,{getVehicleNameFromModel(v["VehID"]),v["Slot"]})
			end
		end
		triggerClientEvent(player,"open:towedvehiclelist",player,tbl)
	end
end
addEvent("load:towedvehicle",true)
addEventHandler("load:towedvehicle",root,openTowedVehpanel)

addEvent("buyfree:vehicle",true)
addEventHandler("buyfree:vehicle",root,function(slot)
	if(tonumber(syncGetElementData(client,"Money"))>=1500)then
		local pname=getPlayerName(client)
		syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-1500)
		dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Towed",0,"UID",playerUID[pname],"Slot",slot)
		setElementData(Vehicles[pname..slot],"Towed",0)
		setElementPosition(Vehicles[pname..slot],920.4,-1167.7,18)
		setElementRotation(Vehicles[pname..slot],0,0,180)
		setElementDimension(Vehicles[pname..slot],0)
		setElementFrozen(Vehicles[pname..slot],false)
		triggerClientEvent(client,"draw:infobox",root,"info","Vehicle successfully buyed out!",8000)
	end
end)

addEventHandler("onMarkerHit",MechTow_TowedMarker,function(hitElement)
	if(getElementType(hitElement)=="vehicle")then
		local veh=hitElement
		local player=getVehicleOccupant(hitElement)
		if(isElement(player))then
			if(isMECHTOW(player)and syncGetElementData(player,"MechTowDuty")==true)then
				if(getElementModel(veh)==525)then
					local vehicleTowing=getVehicleTowedByVehicle(veh)
					if(vehicleTowing~=false)then
						if(getElementData(vehicleTowing,"Owner")and getElementData(vehicleTowing,"Slot"))then
							if(getElementData(vehicleTowing,"Towed")==0)then
								towedDIM=towedDIM+1
								setElementDimension(vehicleTowing,towedDIM)
								setElementFrozen(vehicleTowing,true)
								setElementData(vehicleTowing,"Towed",1)
								dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Towed",1,"Owner",getElementData(vehicleTowing,"Owner"),"Slot",getElementData(vehicleTowing,"Slot"))
								syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+25)
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","You can only tow private vehicles!",8000)
						end
					end
				end
			end
		end
	end
end)


MechTowLSPD=createPickup(-2033.6,-117.6,1034.9,3,1275,50)
setElementInterior(MechTowLSPD,3)
setElementDimension(MechTowLSPD,100)

function openDutyUI(player)
	if(isLoggedin(player))then
		if(isMECHTOW(player))then
			triggerClientEvent(player,"open:mechdutyUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not a Mech&Tow member!",8000)
		end
	end
end
addEventHandler("onPickupHit",MechTowLSPD,openDutyUI)

function goMechTowOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isMECHTOW(client))then
				if(syncGetElementData(client,"MechTowDuty")==false)then
					syncSetElementData(client,"MechTowDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","You have entered the duty mode!",8000)
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,50)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,192)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You are already On duty!",8000)
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"MechTowDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"MechTowDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","You have left the duty mode!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You are not On duty!",8000)
			end
		end
	end
end
addEvent("go:mechonoffduty",true)
addEventHandler("go:mechonoffduty",root,goMechTowOnOffDuty)



--//Tuning system
local TuningTimer={}

local MechTow_Tuningmarker1=createMarker(900.4,-1164.4,16,"cylinder",1.2,255,255,255,100)
local MechTow_TuningColshape1=createColSphere(902.2,-1165.9,17,12)
local MechTow_TuningColshape11=createColSphere(902.2,-1165.9,17,4)

addEventHandler("onMarkerHit",MechTow_Tuningmarker1,function(hitElement)
    if(getElementType(hitElement)=="player" and isPedInVehicle(hitElement)==false and(isMECHTOW(hitElement)))then
        local veh=getElementsWithinColShape(MechTow_TuningColshape11,"vehicle")
		
        triggerClientEvent(hitElement,"open:mechTuningUI",hitElement,veh)
    end
end)

local function sendMessageForAllInGarage(text)
    local players=getElementsWithinColShape(MechTow_TuningColshape1,"player")
    for i=1,#players do
        outputChatBox("[INFO]: "..text,players[i],200,200,0)
    end
end

function mechtowTuningFunction(vehicle,tuning,price)
	if(syncGetElementData(client,"MechTowDuty")==true)then
	if(vehicle)then
		if(not isTimer(TuningTimer[vehicle]))then
			local money=tonumber(syncGetElementData(client,"Money"))
			if(money>=price)then
				if(tuning=="Sportmotor")then
					if(tonumber(syncGetElementData(client,"Companyrank"))<2)then
						outputChatBox("Only allowed from rank 2!",client,150,0,0)
						return
					else
						if(getElementData(vehicle,"Owner")and getElementData(vehicle,"Slot"))then
							if(getElementData(vehicle,"Sportmotor")<3)then
								sendMessageForAllInGarage("The vehicle "..getVehicleNameFromModel(getElementModel(vehicle)).." Processing!")
								setElementFrozen(vehicle,true)
								syncSetElementData(client,"Money",money-price)
								TuningTimer[vehicle]=setTimer(function(vehicle)
									setElementFrozen(vehicle,false)
									setElementData(vehicle,"Sportmotor",getElementData(vehicle,"Sportmotor")+1)
									dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Sportmotor",getElementData(vehicle,"Sportmotor"),"Owner",getElementData(vehicle,"Owner"),"Slot",getElementData(vehicle,"Slot"))
									sendMessageForAllInGarage("The Sportengine was successfully installed in " ..getVehicleNameFromModel(getElementModel(vehicle)).." ("..getElementData(vehicle,"Sportmotor")..")!")
									giveVehicleSpecialUpgrade(vehicle)
								end,15000,1,vehicle)
							else
								triggerClientEvent(client,"draw:infobox",root,"error","This vehicles has the max Sportengine level!",8000)
							end
						end
					end
				elseif(tuning=="Lowering")then
					if(tonumber(syncGetElementData(client,"Companyrank"))<2)then
						outputChatBox("Only allowed from rank 2!",client,150,0,0)
						return
					else
						if(getElementData(vehicle,"Owner")and getElementData(vehicle,"Slot"))then
							if(getElementData(vehicle,"Lowering")<3)then
								sendMessageForAllInGarage("The vehicle "..getVehicleNameFromModel(getElementModel(vehicle)).." Processing!")
								setElementFrozen(vehicle,true)
								syncSetElementData(client,"Money",money-price)
								TuningTimer[vehicle]=setTimer(function(vehicle)
									setElementFrozen(vehicle,false)
									setElementData(vehicle,"Lowering",getElementData(vehicle,"Lowering")+1)
									dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Lowering",getElementData(vehicle,"Lowering"),"Owner",getElementData(vehicle,"Owner"),"Slot",getElementData(vehicle,"Slot"))
									sendMessageForAllInGarage("The Sportengine was successfully installed in " ..getVehicleNameFromModel(getElementModel(vehicle)).." ("..getElementData(vehicle,"Lowering")..")!")
									giveVehicleSpecialUpgrade(vehicle)
								end,13000,1,vehicle)
							else
								triggerClientEvent(client,"draw:infobox",root,"error","This vehicles has the max Sportengine level!",8000)
							end
						end
					end
				elseif(tuning=="Totalloss")then
					if(tonumber(syncGetElementData(client,"Companyrank"))<1)then
						outputChatBox("Only allowed from rank 1!",client,150,0,0)
						return
					else
						if(getElementData(vehicle,"Owner")and getElementData(vehicle,"Slot"))then
							if(getElementData(vehicle,"Totalloss")==1)then
								sendMessageForAllInGarage("The vehicle " .. getVehicleNameFromModel(getElementModel(vehicle)) .. " Processing!")
								setElementFrozen(vehicle,true)
								syncSetElementData(client,"Money",money-price)
								TuningTimer[vehicle]=setTimer(function(vehicle)
									setElementFrozen(vehicle,false)
									fixVehicle(vehicle)
									dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Totalloss",0,"Owner",getElementData(vehicle,"Owner"),"Slot",getElementData(vehicle,"Slot"))
									setElementData(vehicle,"Totalloss",0)
									sendMessageForAllInGarage("The write-off was successfully fixed in " ..getVehicleNameFromModel(getElementModel(vehicle)).."!")
								end,10000,1,vehicle)
							else
								triggerClientEvent(client,"draw:infobox",root,"error","This vehicles has not a write-off!",8000)
							end
						end
					end
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..money..")",8000)
			end
		else
			outputChatBox("This vehicle is already being processed!",client,150,0,0)
		end
	end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You are not On duty!",8000)
	end
end
addEvent("tune:privcar",true)
addEventHandler("tune:privcar",root,mechtowTuningFunction)


