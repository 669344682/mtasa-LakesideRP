--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function getCompanyPanelMembers(player)
	if(tonumber(syncGetElementData(player,"Company"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Company"]==tonumber(syncGetElementData(player,"Company")))then
					table.insert(tbl,{v["Username"],v["Company"],v["Companyrank"]})
				end
			end
			triggerClientEvent(player,"refresh:companypanel",player,tbl)
		end
	end
end
addEvent("get:companypanelmembers",true)
addEventHandler("get:companypanelmembers",root,getCompanyPanelMembers)

addEvent("invite:Cplayer",true)
addEventHandler("invite:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))==0)then
				syncSetElementData(targetPlayer,"Company",tonumber(syncGetElementData(client,"Company")))
				syncSetElementData(targetPlayer,"Companyrank",0)
				dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Company",tonumber(syncGetElementData(targetPlayer,"Company")),"Companyrank",tonumber(syncGetElementData(targetPlayer,"Companyrank")),"UID",playerUID[getPlayerName(targetPlayer)])
				triggerClientEvent(targetPlayer,"draw:infobox",root,"info","You was invited by "..getPlayerName(client).."!",8000)
				triggerClientEvent(client,"draw:infobox",root,"success","You have invited "..getPlayerName(targetPlayer).."!",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Company!",8000)
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The player is not exist/loggedin!",8000)
		end
	getCompanyPanelMembers(client)
	end
end)
addEvent("uninvite:Cplayer",true)
addEventHandler("uninvite:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))~=0)then
				if(tonumber(syncGetElementData(targetPlayer,"Company"))==tonumber(syncGetElementData(client,"Company")))then
					if(tonumber(syncGetElementData(targetPlayer,"Companyrank"))<=4)then
						syncSetElementData(targetPlayer,"Company",0)
						syncSetElementData(targetPlayer,"Companyrank",0)
						setElementModel(targetPlayer,syncGetElementData(targetPlayer,"SkinID"))
						syncSetElementData(targetPlayer,"CopDuty",false)
						dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Company",0,"Companyrank",0,"UID",playerUID[getPlayerName(targetPlayer)])
						triggerClientEvent(targetPlayer,"draw:infobox",root,"info","You was uninvited by "..getPlayerName(client).."!",8000)
						triggerClientEvent(client,"draw:infobox",root,"success","You have uninvited "..getPlayerName(targetPlayer).."!",8000)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player is not in your Company!",8000)
				end
			end
		else
			local targetFaction=getData("userdata","Username",target,"Company")
			if(tonumber(targetFaction)==tonumber(syncGetElementData(client,"Company")))then
				if(tonumber(getData("userdata","Username",target,"Companyrank"))<5)then
					dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Company",0,"Companyrank",0,"Username",target)
					triggerClientEvent(client,"draw:infobox",root,"success","You have uninvited "..target.."!",8000)
				end
			end
		end
	getCompanyPanelMembers(client)
	end
end)

addEvent("rankup:Cplayer",true)
addEventHandler("rankup:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))==tonumber(syncGetElementData(client,"Company")))then
				if(tonumber(syncGetElementData(targetPlayer,"Companyrank"))<4)then
					syncSetElementData(targetPlayer,"Companyrank",tonumber(syncGetElementData(client,"Companyrank"))+1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Companyrank",tonumber(syncGetElementData(client,"Companyrank")),"Username",getPlayerName(target))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player already has the highest assigned rank!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is not in your Company!",8000)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","The player is not exist/loggedin!",8000)
	end
end)

addEvent("rankdown:Cplayer",true)
addEventHandler("rankdown:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))==tonumber(syncGetElementData(client,"Company")))then
				if(tonumber(syncGetElementData(targetPlayer,"Companyrank"))>0 and tonumber(syncGetElementData(targetPlayer,"Companyrank"))<4)then
					syncSetElementData(targetPlayer,"Companyrank",tonumber(syncGetElementData(client,"Companyrank"))-1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Companyrank",tonumber(syncGetElementData(client,"Companyrank")),"Username",getPlayerName(target))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player already has the lowest rank!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is not in your Company!",8000)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","The player is not exist/loggedin!",8000)
	end
end)