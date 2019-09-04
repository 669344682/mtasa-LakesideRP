--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Duty system
DutyLSPD=createPickup(257,70.0,1003.6,3,1275,50)
setElementInterior(DutyLSPD,6)
setElementDimension(DutyLSPD,20)

function openDutyUI(player)
	if(isLoggedin(player))then
		if(isLSPD(player))then
			triggerClientEvent(player,"open:dutyUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not a Cop!",8000)
		end
	end
end
addEventHandler("onPickupHit",DutyLSPD,openDutyUI)

function goOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isLSPD(client))then
				if(syncGetElementData(client,"CopDuty")==false)then
					syncSetElementData(client,"CopDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","You have entered the duty mode!",8000)
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,280)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,263)
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
addEvent("go:onoffduty",true)
addEventHandler("go:onoffduty",root,goOnOffDuty)

--//Jail functions
function jailCheck(player)
	if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
		if(isPedInVehicle(player))then
			removePedFromVehicle(player)
		end
		local rdm=math.random(1,#globalTables["Faction"][1]["Jailspawns"])
		local x,y,z,rot=globalTables["Faction"][1]["Jailspawns"][rdm][1],globalTables["Faction"][1]["Jailspawns"][rdm][2],globalTables["Faction"][1]["Jailspawns"][rdm][3],globalTables["Faction"][1]["Jailspawns"][rdm][4]
		setElementPosition(player,x,y,z)
		setPedRotation(player,rot)
		setElementInterior(player,6)
		setElementDimension(player,20)
		takeAllWeapons(player)
		toggleAllControls(player,true)
	end
end

addEvent("tazer:target",true)
addEventHandler("tazer:target",root,function()
	if(isTimer(TazerTimer[client]))then
		killTimer(TazerTimer[client])
	end
	toggleAllControls(client,false,true,false)
	setPedAnimation(source,"CRACK","crckdeth2")
	TazerTimer[client]=setTimer(function(client)
		if(isElement(client))then
			setPedAnimation(client)
			toggleAllControls(client,true,true,false)
		end
	end,25000,1,client)
end)

local saveDeagleAmmoTable={}
function changeTazerToDeagle_changeDeagleToTazer(player)
	if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
		if(getElementData(player,"tazer")==false)then
			if(getPedWeapon(player)==24)then
				saveDeagleAmmoTable[player]=getPedTotalAmmo(player)
				takeWeapon(player,24)
				giveWeapon(player,23,999,true)
				triggerClientEvent(player,"draw:infobox",root,"info","You changed your Deagle to Taser.",8000)
				setElementData(player,"tazer",true)
			end
		else
			if(getPedWeapon(player)==23)then
				takeWeapon(player,23)
				giveWeapon(player,24,saveDeagleAmmoTable[player],true)
				triggerClientEvent(player,"draw:infobox",root,"info","You changed your Taser to Deagle.",8000)
				setElementData(player,"tazer",false)
			end
		end
	end
end

addEvent("look:illiegalitems",true)
addEventHandler("look:illiegalitems",root,function()
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
				local weed=syncGetElementData(target,"Weed")
				triggerClientEvent(client,"draw:infobox",root,"info","You have "..getPlayerName(target).." throughaddiction.",8000)
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(client).." has searched you through",8000)
				outputChatBox("Illegal items from: "..getPlayerName(target).."",client,255,255,255)
				if(weed>=1)then
					outputChatBox("Weed: "..weed.."",client,255,255,255)
				else
					outputChatBox("Nothing.",client,255,255,255)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is too far away!",8000)
			end
		end
	end
end)
addEvent("take:illiegalitems",true)
addEventHandler("take:illiegalitems",root,function()
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
				triggerClientEvent(client,"draw:infobox",root,"info","You've "..getPlayerName(target).." taken off his illegal items.",8000)
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(client).." has taken away your illegal items!",8000)
				syncSetElementData(target,"Weed",0)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is too far away!",8000)
			end
		end
	end
end)
addEvent("take:weapons",true)
addEventHandler("take:weapons",root,function()
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
				triggerClientEvent(client,"draw:infobox",root,"info","You disarmed "..getPlayerName(target)..".",8000)
				triggerClientEvent(target,"draw:infobox",root,"info","You have been disarmed by "..getPlayerName(client).."!",8000)
				takeAllWeapons(target)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is too far away!",8000)
			end
		end
	end
end)

function putPlayerInJail(player)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
				if(getElementData(veh,"policecar")==true)then
					for _,v in pairs(getElementsByType("player"))do
						if(isPedInVehicle(v))then
							if(getPedOccupiedVehicle(v)==getPedOccupiedVehicle(player))then
								if(tonumber(syncGetElementData(v,"Wanteds"))>=1)then
									syncSetElementData(v,"Jailtime",tonumber(syncGetElementData(v,"Wanteds"))*10)
									jailCheck(v)
									syncSetElementData(v,"Wanteds",tonumber(0))
									triggerClientEvent(player,"draw:infobox",root,"info","You have "..getPlayerName(v).." imprisoned!",8000)
								end
							end
						end
					end
				end
			end
		end
	end
end

local LSPDjailPICK=createCmarker(1568.6,-1694.2,5.9,0,0,":"..settings.general.scriptname.."/Files/Images/cMarker/Jail.png",nil,2,putPlayerInJail)

setWeaponProperty(23,"pro", "damage", 1)
setWeaponProperty(23,"std", "damage", 1)
setWeaponProperty(23,"poor", "damage", 1)
setWeaponProperty(23,"pro", "maximum_clip_ammo", 1)
setWeaponProperty(23,"std", "maximum_clip_ammo", 1)
setWeaponProperty(23,"poor", "maximum_clip_ammo", 1)
setWeaponProperty(23,"pro", "weapon_range", 35/3)
setWeaponProperty(23,"std", "weapon_range", 35/3)
setWeaponProperty(23,"poor", "weapon_range", 35/3)
setWeaponProperty(23,"pro", "move_speed", 2)
setWeaponProperty(23,"std", "move_speed", 2)
setWeaponProperty(23,"poor", "move_speed", 2)



addEvent("buy:staatweapons",true)
addEventHandler("buy:staatweapons",root,function(weapon,ammu)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		if(weapon=="colt45")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=0)then
				if(getPedWeapon(client)~=22)then
					giveWeapon(client,22,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank!",8000)
			end
		elseif(weapon=="deagle")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)~=24)then
					giveWeapon(client,24,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 1)",8000)
			end
		elseif(weapon=="mp5")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)~=29)then
					giveWeapon(client,29,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 1)",8000)
			end
		elseif(weapon=="ak")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=2)then
				if(getPedWeapon(client)~=30)then
					giveWeapon(client,30,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 2)",8000)
			end
		elseif(weapon=="m4")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=3)then
				if(getPedWeapon(client)~=31)then
					giveWeapon(client,31,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 3)",8000)
			end
		elseif(weapon=="sniper")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
				if(getPedWeapon(client)~=34)then
					giveWeapon(client,34,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 4)",8000)
			end
		end
		
		
		if(ammu=="colt45")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=0)then
				if(getPedWeapon(client)==22)then
					giveWeapon(client,22,17)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank!",8000)
			end
		elseif(ammu=="deagle")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)==24)then
					giveWeapon(client,24,7)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 1)",8000)
			end
		elseif(ammu=="mp5")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)==29)then
					giveWeapon(client,29,30)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 1)",8000)
			end
		elseif(ammu=="ak")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=2)then
				if(getPedWeapon(client)==30)then
					giveWeapon(client,30,30)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 2)",8000)
			end
		elseif(ammu=="m4")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=3)then
				if(getPedWeapon(client)==31)then
					giveWeapon(client,31,50)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 3)",8000)
			end
		elseif(ammu=="sniper")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=3)then
				if(getPedWeapon(client)==34)then
					giveWeapon(client,34,1)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","First take this weapon in your hand",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank! (R 4)",8000)
			end
		elseif(ammu=="armor")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=0)then
				if(tonumber(syncGetElementData(client,"Money"))>=100)then
					syncSetElementData(client,"Armor",tonumber(syncGetElementData(client,"Armor"))+1)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-100)
					triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased 1 Armor!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($100)",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have the required rank!",8000)
			end
		end
	end
end)