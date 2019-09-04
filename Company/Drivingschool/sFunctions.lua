--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

MechTowLSPD=createPickup(-2033.6,-117.6,1034.9,3,1275,50)
setElementInterior(MechTowLSPD,3)
setElementDimension(MechTowLSPD,110)

function openDutyUI(player)
	if(isLoggedin(player))then
		if(isDRIVINGSCHOOL(player))then
			triggerClientEvent(player,"open:drivingschoolUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not a Drivingschool member!",8000)
		end
	end
end
addEventHandler("onPickupHit",MechTowLSPD,openDutyUI)

function goMechTowOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isDRIVINGSCHOOL(client))then
				if(syncGetElementData(client,"DrivingschoolDuty")==false)then
					syncSetElementData(client,"DrivingschoolDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","You have entered the duty mode!",8000)
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,59)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,150)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You are already On duty!",8000)
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"DrivingschoolDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"DrivingschoolDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","You have left the duty mode!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You are not On duty!",8000)
			end
		end
	end
end
addEvent("go:driveonoffduty",true)
addEventHandler("go:driveonoffduty",root,goMechTowOnOffDuty)

addCommandHandler("exam",function(player,cmd,target)
	if(target)then
	local target=getPlayerFromName(target)
		if(isDRIVINGSCHOOL(player)and syncGetElementData(player,"DrivingschoolDuty")==true)then
			outputChatBox("You have "..getPlayerName(target).." offered a driving test.",player,255,255,255)
			outputChatBox(""..getPlayerName(player).." offers you to take the driving test with him.",target,255,255,255)
			outputChatBox("Type: '/examaccept "..getPlayerName(player).."' to accept!",target,255,255,255)
			setElementData(target,"infahrpruefung",true)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not On duty!",8000)
		end
	end
end)

addCommandHandler("examaccept",function(player,cmd,target)
	if(target)then
	local target=getPlayerFromName(target)
		if(getElementData(player,"infahrpruefung")==true)then
			setElementData(player,"inpruefung",true)
			outputChatBox("You are now in the driving test!",player,255,255,255)
			outputChatBox(""..getPlayerName(player).." accepted the requests.",target,255,255,255)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You have not received an offer yet!",8000)
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Enter the driving instructor!",8000)
	end
end)


addCommandHandler("examend",function(player,cmd,target,license)
	if(target)then
	local target=getPlayerFromName(target)
		if(isDRIVINGSCHOOL(player)and syncGetElementData(player,"DrivingschoolDuty")==true)then
			if(getElementData(target,"inpruefung")==true)then
				if(license)then
					if(license=="Car")then
						if(tonumber(syncGetElementData(target,"Money"))>=settings.company.ranknames[2].carlicensePrice)then
							syncSetElementData(target,"CarLicense",1)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+settings.company.ranknames[2].carlicensePrice)
							syncSetElementData(target,"Money",tonumber(syncGetElementData(target,"Money"))-settings.company.ranknames[2].carlicensePrice)
							outputChatBox("You have received the driver's license! (Cost: "..settings.company.ranknames[2].carlicensePrice..")",target,0,200,0)
							
							if(getElementData(target,"infahrpruefung")==true)then
								setElementData(target,"infahrpruefung",false)
							end
							if (getElementData(target,"inpruefung")==true)then
								setElementData(target,"inpruefung",false)
							end
						else
							outputChatBox("You do not have enough money ($"..settings.company.ranknames[2].carlicensePrice..")",target,200,0,0)
							outputChatBox("The examinee does not have enough money! ($"..settings.company.ranknames[2].carlicensePrice..")",player,200,0,0)
						end
					elseif(license=="Bike")then
						if(tonumber(syncGetElementData(target,"Money"))>=settings.company.ranknames[2].bikelicensePrice)then
							syncSetElementData(target,"BikeLicense",1)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+settings.company.ranknames[2].bikelicensePrice)
							syncSetElementData(target,"Money",tonumber(syncGetElementData(target,"Money"))-settings.company.ranknames[2].bikelicensePrice)
							outputChatBox("You have received the driver's license! (Cost: "..settings.company.ranknames[2].bikelicensePrice..")",target,0,200,0)
							
							if(getElementData(target,"infahrpruefung")==true)then
								setElementData(target,"infahrpruefung",false)
							end
							if (getElementData(target,"inpruefung")==true)then
								setElementData(target,"inpruefung",false)
							end
						else
							outputChatBox("You do not have enough money ($"..settings.company.ranknames[2].bikelicensePrice..")",target,200,0,0)
							outputChatBox("The examinee does not have enough money! ($"..settings.company.ranknames[2].bikelicensePrice..")",player,200,0,0)
						end
					end
				end
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not On duty!",8000)
		end
	end
end)