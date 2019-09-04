--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function getFactionPanelMembers(player)
	if(tonumber(syncGetElementData(player,"Faction"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Faction"]==tonumber(syncGetElementData(player,"Faction")))then
					table.insert(tbl,{v["Username"],v["Faction"],v["Factionrank"]})
				end
			end
			triggerClientEvent(player,"refresh:factionpanel",player,tbl)
		end
	end
end
addEvent("get:factionpanelmembers",true)
addEventHandler("get:factionpanelmembers",root,getFactionPanelMembers)

addEvent("invite:Fplayer",true)
addEventHandler("invite:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))==0)then
				syncSetElementData(targetPlayer,"Faction",tonumber(syncGetElementData(client,"Faction")))
				syncSetElementData(targetPlayer,"Factionrank",0)
				dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Faction",tonumber(syncGetElementData(targetPlayer,"Faction")),"Factionrank",tonumber(syncGetElementData(targetPlayer,"Factionrank")),"UID",playerUID[getPlayerName(targetPlayer)])
				triggerClientEvent(targetPlayer,"draw:infobox",root,"info","You was invited by "..getPlayerName(client).."!",8000)
				triggerClientEvent(client,"draw:infobox",root,"success","You have invited "..getPlayerName(targetPlayer).."!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Faction!",8000)
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The player is not exist/loggedin!",8000)
		end
	getFactionPanelMembers(client)
	end
end)
addEvent("uninvite:Fplayer",true)
addEventHandler("uninvite:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))~=0)then
				if(tonumber(syncGetElementData(targetPlayer,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
					if(tonumber(syncGetElementData(targetPlayer,"Factionrank"))<=4)then
						syncSetElementData(targetPlayer,"Faction",0)
						syncSetElementData(targetPlayer,"Factionrank",0)
						setElementModel(targetPlayer,syncGetElementData(targetPlayer,"SkinID"))
						syncSetElementData(targetPlayer,"CopDuty",false)
						dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Faction",0,"Factionrank",0,"UID",playerUID[getPlayerName(targetPlayer)])
						triggerClientEvent(targetPlayer,"draw:infobox",root,"info","You was uninvited by "..getPlayerName(client).."!",8000)
						triggerClientEvent(client,"draw:infobox",root,"success","You have uninvited "..getPlayerName(targetPlayer).."!",8000)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player is not in your Faction!",8000)
				end
			end
		else
			local targetFaction=getData("userdata","Username",target,"Faction")
			if(tonumber(targetFaction)==tonumber(syncGetElementData(client,"Faction")))then
				if(tonumber(getData("userdata","Username",target,"Factionrank"))<5)then
					dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Faction",0,"Factionrank",0,"Username",target)
					triggerClientEvent(client,"draw:infobox",root,"success","You have uninvited "..target.."!",8000)
				end
			end
		end
	getFactionPanelMembers(client)
	end
end)

addEvent("rankup:Fplayer",true)
addEventHandler("rankup:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
				if(tonumber(syncGetElementData(targetPlayer,"Factionrank"))<4)then
					syncSetElementData(targetPlayer,"Factionrank",tonumber(syncGetElementData(client,"Factionrank"))+1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Factionrank",tonumber(syncGetElementData(client,"Factionrank")),"Username",getPlayerName(target))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player already has the highest assigned rank!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is not in your Faction!",8000)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","The player is not exist/loggedin!",8000)
	end
end)

addEvent("rankdown:Fplayer",true)
addEventHandler("rankdown:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
				if(tonumber(syncGetElementData(targetPlayer,"Factionrank"))>0 and tonumber(syncGetElementData(targetPlayer,"Factionrank"))<4)then
					syncSetElementData(targetPlayer,"Factionrank",tonumber(syncGetElementData(client,"Factionrank"))-1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Factionrank",tonumber(syncGetElementData(client,"Factionrank")),"Username",getPlayerName(target))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player already has the lowest rank!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is not in your Faction!",8000)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","The player is not exist/loggedin!",8000)
	end
end)


--//Panel
addEvent("change:factionnotes",true)
addEventHandler("change:factionnotes",root,function(notes)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(client,"Faction"))),-1)
	if(result or result[1])then
		if(tonumber(syncGetElementData(client,"Faction"))>=1 and tonumber(syncGetElementData(client,"Factionrank"))>=4)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Notes",notes,"Faction",tonumber(syncGetElementData(client,"Faction")))
			triggerClientEvent(client,"draw:infobox",root,"success","You have changed the Faction notes!",8000)
		end
	end
end)
addEvent("get:factionnotes",true)
addEventHandler("get:factionnotes",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","factiondepots"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["Notes"]})
			end
		end
		triggerClientEvent(client,"show:factionnotes",client,tbl)
	end
end)

addEvent("get:factionranksalary",true)
addEventHandler("get:factionranksalary",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","factiondepots"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["Rang1"],v["Rang2"],v["Rang3"],v["Rang4"],v["Rang5"]})
			end
		end
		triggerClientEvent(client,"show:factionranksalary",client,tbl)
	end
end)
addEvent("change:factionranksalary",true)
addEventHandler("change:factionranksalary",root,function(typ,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(client,"Faction"))),-1)
	if(result or result[1])then
		if(tonumber(syncGetElementData(client,"Faction"))>=1 and tonumber(syncGetElementData(client,"Factionrank"))>=5)then
			if(typ=="Rank1")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang1",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","You have changed this Factionrank salary!",8000)
			elseif(typ=="Rank2")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang2",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","You have changed this Factionrank salary!",8000)
			elseif(typ=="Rank3")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang3",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","You have changed this Factionrank salary!",8000)
			elseif(typ=="Rank4")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang4",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","You have changed this Factionrank salary!",8000)
			elseif(typ=="Rank5")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang5",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","You have changed this Factionrank salary!",8000)
			end
		end
	end
end)


addEvent("load:factionvehicles",true)
addEventHandler("load:factionvehicles",root,function()
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factionvehicles","Owner",tonumber(syncGetElementData(client,"Faction"))),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(v["Owner"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["VehID"])})
			end
		end
		triggerClientEvent(client,"show:factionvehicles",client,tbl)
	end
end)