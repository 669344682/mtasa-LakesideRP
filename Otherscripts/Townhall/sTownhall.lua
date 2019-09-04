--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntTownhall_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,389.4,172.2,1008.4,90,3,70,true)
		end
	end
end
local function goOutIntTownhall_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==3 and getElementDimension(player)==70)then
			fadeElementInterior(player,1479.4,-1771.1,18.8,0,0,0,true)
		end
	end
end

local goInIntTownhall=createCmarker(1479.4,-1772.1,18.8,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntTownhall_Func)
local goOutIntTownhall=createCmarker(390.5,172.3,1008.4,3,70,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntTownhall_Func)

function buyTownhallItem(item)
	if(syncGetElementData(client,item)==0)then
		if(tonumber(syncGetElementData(client,"Money"))>=townhallItemPrice[item])then
			syncSetElementData(client,townhallItem[item],syncGetElementData(client,townhallItem[item])+townhallItemAmount[item])
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-townhallItemPrice[item])
			triggerClientEvent(client,"draw:infobox",root,"success","You have successfully purchased an ID card",8000)
			triggerEvent("set:task",client,client,"IDcard")
		else
			triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..townhallItemPrice[item]..")",8000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You have already a ID card",8000)
	end
end
addEvent("buy:townhallitem",true)
addEventHandler("buy:townhallitem",root,buyTownhallItem)

function giveBankPin()
	if(tonumber(syncGetElementData(client,"Bankpin"))==0)then
		local rdm=math.random(1000,20000)
		syncSetElementData(client,"Bankpin",rdm)
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Bankpin",rdm,"Username",getPlayerName(client))
		outputChatBox("You have successfully created a bank account! PIN: "..rdm..". You can see your pin on your IDcard.",client,0,200,0)
		triggerEvent("set:task",client,client,"CreateBankaccount")
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You have already a bank account!",8000)
	end
end
addEvent("set:bankpin",true)
addEventHandler("set:bankpin",root,giveBankPin)

function acceptJob(player,job)
	if(syncGetElementData(player,"Job")=="none")then
		if(job=="Busdriver")then
			syncSetElementData(player,"Job","Busdriver")
		end
	end
end
addEvent("set:job",true)
addEventHandler("set:job",root,acceptJob)