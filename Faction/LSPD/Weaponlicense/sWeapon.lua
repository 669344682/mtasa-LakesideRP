--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local WeaponlicenseLSPD=createPickup(249.3,71.2,1003.6,3,348,50)
setElementInterior(WeaponlicenseLSPD,6)
setElementDimension(WeaponlicenseLSPD,20)

function openWeaponlicenseUI(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"GunLicense"))==0)then
			if(tonumber(syncGetElementData(player,"Money"))>=25000)then
				triggerClientEvent(player,"open:weaponlicenseUI",player)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money! ($25.000)",8000)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You have already a Gunlicense!",8000)
		end
	end
end
addEventHandler("onPickupHit",WeaponlicenseLSPD,openWeaponlicenseUI)

addEvent("give:weaponlicense",true)
addEventHandler("give:weaponlicense",root,function()
	if(tonumber(syncGetElementData(client,"GunLicense"))==0)then
		if(tonumber(syncGetElementData(client,"Money"))>=25000)then
			syncSetElementData(client,"GunLicense",1)
			syncSetElementData(client,"Monbey",syncGetElementData(client,"Money")-25000)
			outputChatBox("Congratulations! You have now a Gunlicense!",client,0,200,0)
		end
	end
end)