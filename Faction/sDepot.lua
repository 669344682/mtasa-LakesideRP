--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local fdepots={
	{251.7,71.3,1003.7,0,0,0,6,20},--LSPD
	{2498.2,-1703.4,1014.6,0,0,270,3,30},--Grove
	{1209.1,-25.6,1000.6,0,0,0,3,27},--Ballas
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Depot={}
	for i,v in pairs(fdepots)do
		Depot[i]=createObject(2332,v[1],v[2],v[3],v[4],v[5],v[6])
		Depot[i]:setInterior(v[7])
		Depot[i]:setDimension(v[8])
		Depot[i]:setDoubleSided(true)
		
		setElementData(Depot[i],"factiondepot",true)
	end
end)

function loadDepotState(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
	if(result or result[1])then
		Money=result[1]["Money"]
		Weed=result[1]["Weed"]
		
		triggerClientEvent(player,"open:factiondepot",player,Money,Weed)
	end
end

addEvent("payin_payout:factionitems",true)
addEventHandler("payin_payout:factionitems",root,function(typ,item,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(getElementData(client,"Faction"))),-1)
	if(result or result[1])then
		if(typ=="payin")then
			if(item=="Money")then
				if(tonumber(syncGetElementData(client,item))>=tonumber(amount))then
					syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])+amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You do not have this item! (x"..amount..")",8000)
				end
			elseif(item=="Weed")then
				if(tonumber(syncGetElementData(client,item))>=tonumber(amount))then
					syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Weed",tonumber(result[1]["Weed"])+amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You do not have this item! (x"..amount..")",8000)
				end
			end
		elseif(typ=="payout")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
				if(item=="Money")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
					else
						triggerClientEvent(client,"draw:infobox",root,"error","So much money is not in the cash register!",8000)
					end
				elseif(item=="Weed")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Weed",tonumber(result[1]["Weed"])-amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
					else
						triggerClientEvent(client,"draw:infobox",root,"error","So many drugs are not in the cash register!",8000)
					end
				end
			end
		end
		refreshFactionDepot(client)
	end
end)

function refreshFactionDepot(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(getElementData(client,"Faction"))),-1)
	if(result or result[1])then
		triggerClientEvent(client,"refresh:factiondepot",client,result[1]["Money"],result[1]["Weed"])
	end
end