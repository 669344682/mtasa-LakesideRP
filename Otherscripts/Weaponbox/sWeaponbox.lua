--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local weaponboxTable={
{1367,-1282.7,12.4,0,0,90},
{1549.4,-1700.5,12.4,0,0,0},
{1217.7,-1817.9,12.5,0,0,0},
}

addEventHandler("onResourceStart",resourceRoot,function()
	local BOX={}
	for i,v in ipairs(weaponboxTable)do
		BOX[i]=createObject(2977,v[1],v[2],v[3],v[4],v[5],v[6])
		BOX[i]:setDoubleSided(true)
		
		setElementData(BOX[i],"weaponbox",true)
	end
end)

function openWeaponbox(player)
	local pname=getPlayerName(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","weaponbox","UID",playerUID[pname]),-1)
	if(not result or not result[1])then
		handler:exec("INSERT INTO weaponbox (UID,Weapon1,Ammu1,Weapon2,Ammu2,Weapon3,Ammu3,Weapon4,Ammu4,Weapon5,Ammu5,Weapon6,Ammu6,Weapon7,Ammu7,Weapon8,Ammu8) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",playerUID[pname],'none','none','none','none','none','none','none','none','none','none','none','none','none','none','none','none')
	end
	
	local Weapon1=getData("weaponbox","UID",playerUID[pname],"Weapon1")
	local Weapon2=getData("weaponbox","UID",playerUID[pname],"Weapon2")
	local Weapon3=getData("weaponbox","UID",playerUID[pname],"Weapon3")
	local Weapon4=getData("weaponbox","UID",playerUID[pname],"Weapon4")
	local Weapon5=getData("weaponbox","UID",playerUID[pname],"Weapon5")
	local Weapon6=getData("weaponbox","UID",playerUID[pname],"Weapon6")
	local Weapon7=getData("weaponbox","UID",playerUID[pname],"Weapon7")
	local Weapon8=getData("weaponbox","UID",playerUID[pname],"Weapon8")
	
	local Ammu1=getData("weaponbox","UID",playerUID[pname],"Ammu1")
	local Ammu2=getData("weaponbox","UID",playerUID[pname],"Ammu2")
	local Ammu3=getData("weaponbox","UID",playerUID[pname],"Ammu3")
	local Ammu4=getData("weaponbox","UID",playerUID[pname],"Ammu4")
	local Ammu5=getData("weaponbox","UID",playerUID[pname],"Ammu5")
	local Ammu6=getData("weaponbox","UID",playerUID[pname],"Ammu6")
	local Ammu7=getData("weaponbox","UID",playerUID[pname],"Ammu7")
	local Ammu8=getData("weaponbox","UID",playerUID[pname],"Ammu8")
	
	if(Weapon1 and Weapon2 and Weapon3 and Weapon4 and Weapon5 and Weapon6 and Weapon7 and Weapon8)then
		triggerClientEvent(player,"open:weaponbox",player,Weapon1,Ammu1,Weapon2,Ammu2,Weapon3,Ammu3,Weapon4,Ammu4,Weapon5,Ammu5,Weapon6,Ammu6,Weapon7,Ammu7,Weapon8,Ammu8)
	end
end

addEvent("putin:weaponinweaponbox",true)
addEventHandler("putin:weaponinweaponbox",root,function(lager)
	local pname=getPlayerName(client)
	
	local Weapon,Muni=getPedWeapon(client),getPedTotalAmmo(client)
	local Gun=getData("weaponbox","UID",playerUID[pname],"Weapon"..lager)
	local Ammu=getData("weaponbox","UID",playerUID[pname],"Ammu"..lager)
	
	if(Gun=="none" and Ammu=="none")then
		if(Weapon>=1)then
			handler:exec("UPDATE ?? SET ??=?,??=? WHERE ??=?","weaponbox","Weapon"..lager,Weapon,"Ammu"..lager,Muni,"UID",playerUID[pname])
			takeWeapon(client,Weapon)
			openWeaponbox(client)
			triggerClientEvent(client,"draw:infobox",root,"info","You have put in a weapon!",8000)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","You have no weapon in your hand!",8000)
		end
	end
end)
addEvent("putout:weaponinweaponbox",true)
addEventHandler("putout:weaponinweaponbox",root,function(lager)
	local pname=getPlayerName(client)
	
	local Gun=getData("weaponbox","UID",playerUID[pname],"Weapon"..lager)
	local Ammu=getData("weaponbox","UID",playerUID[pname],"Ammu"..lager)
	
	if(Gun~="none" and Ammu~="none")then
		handler:exec("UPDATE ?? SET ??=?,??=? WHERE ??=?","weaponbox","Weapon"..lager,"none","Ammu"..lager,"none","UID",playerUID[pname])
		giveWeapon(client,Gun,Ammu,true)
		openWeaponbox(client)
		triggerClientEvent(client,"draw:infobox",root,"info","You have put out a weapon!",8000)
	else
		triggerClientEvent(client,"draw:infobox",root,"error","There is no weapon in this storage area!",8000)
	end
end)