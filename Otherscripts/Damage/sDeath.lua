--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local gunsPickup={}
local moneyPickup={}
local weedPickup={}
gotLastHit={}

local weaponPickupIDS={
[24]=348,
[25]=349,
[28]=352,
[29]=353,
[30]=355,
[31]=356,
[33]=357,
}

function player_Wasted(ammo,attacker,weapon,bodypart)
	local x,y,z=getElementPosition(source)
	local money=syncGetElementData(source,"Money")
	local weed=tonumber(syncGetElementData(source,"Weed"))
	local weapon=getPedWeapon(source)
	local ammo=getPedTotalAmmo(source)
	
	if(weaponPickupIDS[weapon])then
		if(isElement(gunsPickup[source]))then gunsPickup[source]:destroy()end
		gunsPickup[source]=createPickup(x,y,z,3,weaponPickupIDS[weapon],50)
		setElementData(gunsPickup[source],"weapon",weapon)
		setElementData(gunsPickup[source],"ammo",ammo)
		
		addEventHandler("onPickupHit",gunsPickup[source],function(player)
			if(not player:isDead())then
				local waffe=getElementData(source,"weapon")
				local munition=getElementData(source,"ammo")
				giveWeapon(player,waffe,munition,true)
				source:destroy()
				triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a weapon!",8000)
			end
		end)
	end
	
	if(isElement(moneyPickup[source]))then
		moneyPickup[source]:destroy()
	end
	if(isElement(weedPickup[source]))then
		weedPickup[source]:destroy()
	end
	
	if(tonumber(money)>=1)then
		moneyPickup[source]=createPickup(x,y,z,3,1212,50)
		syncSetElementData(moneyPickup[source],"Money",math.abs(math.floor(money/50)))
		syncSetElementData(source,"Money",tonumber(syncGetElementData(source,"Money"))-math.abs(math.floor(money/50)))
		
		addEventHandler("onPickupHit",moneyPickup[source],function(player)
			if(not isPedDead(player))then
				local pickupMoney=tonumber(syncGetElementData(source,"Money"))
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+pickupMoney)
				source:destroy()
				triggerClientEvent(player,"draw:infobox",root,"money","You have picked up $"..pickupMoney..".",8000)
			end
		end)
	end
	
	if(tonumber(weed)>=1)then
		weedPickup[source]=createPickup(x,y,z,3,1279,50)
		syncSetElementData(weedPickup[source],"Weed",weed/4)
		syncSetElementData(source,"Weed",math.floor(syncGetElementData(source,"Weed"))-math.abs(math.floor(weed/6)))
		
		addEventHandler("onPickupHit",weedPickup[source],function(player)
			if(not isPedDead(player))then
				local pickupDrugs=tonumber(syncGetElementData(source,"Weed"))
				syncSetElementData(player,"Weed",math.floor(syncGetElementData(player,"Weed"))+pickupDrugs)
				source:destroy()
				triggerClientEvent(player,"draw:infobox",root,"money","You have picked up x"..pickupDrugs.." Weed.",8000)
			end
		end)
	end
	
	
	if(attacker and attacker~=source and getElementType(attacker)=="player")then
		syncSetElementData(attacker,"Kills",tonumber(syncGetElementData(attacker,"Kills"))+1)
		if(isSTATE(attacker)and syncGetElementData(attacker,"CopDuty")==true)then
			if(tonumber(syncGetElementData(source,"Wanteds"))>=1)then
				syncSetElementData(source,"Jailtime",tonumber(syncGetElementData(source,"Wanteds"))*15)
				syncSetElementData(source,"Wanteds",0)
				jailCheck(source)
			end
		end
	end
	
	
	if(isPedInVehicle(source))then
		removePedFromVehicle(source)
	end
	setElementDimension(source,0)
	setElementInterior(source,0)
	syncSetElementData(source,"Deaths",tonumber(syncGetElementData(source,"Deaths"))+1)
	if(tonumber(syncGetElementData(source,"AdminLvL"))>=1)then
		triggerClientEvent(source,"render.hospital",source,30)
	else
		triggerClientEvent(source,"render.hospital",source,180)
	end
	if(syncGetElementData(source,"CopDuty")==true)then
		syncSetElementData(source,"CopDuty",false)
	end
	setElementData(source,"seatbelt",false)
	triggerClientEvent(source,"stop:seatbeltsound",source)
end
addEventHandler("onPlayerWasted",root,player_Wasted)


addEvent("damageCalcServer",true)
addEventHandler("damageCalcServer",root,function(attacker,weapon,bodypart,loss,player)
	if(attacker and weapon and bodypart and loss)then
		local x1,y1,z1=getElementPosition(attacker)
		local x2,y2,z2=getElementPosition(player)
		gotLastHit[player]=getTickCount()
		gotLastHit[attacker]=getTickCount()
		if(weapon==34 and bodypart==9)then
			if(getElementData(player,"duty:admin")==true)then
				return false
			end
			
			setPedHeadless(player,true)
			killPed(player,attacker,weapon,bodypart)
		else
			if(getElementData(player,"duty:admin")==true)then
				return false
			end
			
			local basicDMG=globalTables["weaponDMG"][weapon]
			if(bodypart==9)then
				multiply=1.3
			else
				multiply=1.0
			end
			
			if(globalTables["weaponDMG"][weapon])then
				damagePlayer(player,basicDMG*multiply,attacker,weapon)
			else
				damagePlayer(player,loss,attacker,weapon)
			end
			
		end
		
	end
end)

addEvent("spawn:hospital",true)
addEventHandler("spawn:hospital",root,function()
	setCameraTarget(client,client)
	local pname=getPlayerName(client)
	
	spawnPlayer(client,1179.1,-1327.4,14.2,270,getElementModel(client),0,0)
	
	gotLastHit[client]=0
	
	setPedHeadless(client,false)
	setElementHealth(client,50)
end)