--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("give:wanteds",true)
addEventHandler("give:wanteds",root,function(target,reason,amount)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		if(target)then
			local target=getPlayerFromName(target)
			if(isElement(target))then
				outputChatBox(""..getPlayerName(client).." gave you x"..amount.." Wanted(s)! Reason:" ..reason,target,200,0,0)
				outputChatBox("You gave "..getPlayerName(target).." x"..amount .." Wanted(s)! Reason: "..reason,client,0,200,0)
				syncSetElementData(target,"Wanteds",tonumber(syncGetElementData(target,"Wanteds"))+amount)
				sendMSGForFaction(getPlayerName(client).." gave "..getPlayerName(target).." x"..amount.." wanteds! Reason: "..reason,1,200,200,0)
				sendMSGForFaction(getPlayerName(client).." gave "..getPlayerName(target).." x"..amount.." wanteds! Reason: "..reason,2,200,200,0)
				if(tonumber(syncGetElementData(target,"Wanteds"))>=6)then
					syncSetElementData(target,"Wanteds",6)
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You are not On duty!",8000)
	end
end)
addEvent("delete:wanteds",true)
addEventHandler("delete:wanteds",root,function(target)
	if(isSTATE(client)and syncGetElementData(client,"Factionrank")>=3 and syncGetElementData(client,"CopDuty")==true)then
		if(target)then
			local target=getPlayerFromName(target)
			if(isElement(target))then
				syncSetElementData(target,"Wanteds",0)
				sendMSGForFaction(getPlayerName(client).." has cleared the wanteds from "..getPlayerName(target).."!",1,200,200,0)
				sendMSGForFaction(getPlayerName(client).." has cleared the wanteds from "..getPlayerName(target).."!",2,200,200,0)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You are not On duty or not rank 3!",8000)
	end
end)

addEvent("locate:player",true)
addEventHandler("locate:player",root,function(target)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		if(target)then
			local target=getPlayerFromName(target)
			if(isElement(target))then
				if(getElementInterior(target)==0 and getElementDimension(target)==0)then
					if(tonumber(syncGetElementData(target,"Mobilephone"))==1 and syncGetElementData(target,"PhoneState")==1)then
						triggerClientEvent(client,"create:locateblip",client,target)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","The Mobilephone from the targetplayer is off!",8000)
					end
				end
			end
		end
	end
end)