--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Duty system
DutyFBI=createPickup(327,307,998.9,3,1275,50)
setElementInterior(DutyFBI,5)
setElementDimension(DutyFBI,18)

function openDutyUI(player)
	if(isLoggedin(player))then
		if(isFBI(player))then
			triggerClientEvent(player,"open:dutyfbiUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not a Cop!",8000)
		end
	end
end
addEventHandler("onPickupHit",DutyFBI,openDutyUI)

function goOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isFBI(client))then
				if(syncGetElementData(client,"CopDuty")==false)then
					syncSetElementData(client,"CopDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","You have entered the duty mode!",8000)
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,286)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,211)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You are already On duty!",8000)
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"CopDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"CopDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","You have left the duty mode!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You are not On duty!",8000)
			end
		end
	end
end
addEvent("gofbi:onoffduty",true)
addEventHandler("gofbi:onoffduty",root,goOnOffDuty)