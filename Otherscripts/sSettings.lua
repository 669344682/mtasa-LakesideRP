--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("set:settings",true)
addEventHandler("set:settings",root,function(typ,amount)
	if(typ)then
		if(typ=="Radar")then
			if(amount>=1 and amount<=2)then
				if(tonumber(syncGetElementData(client,"Radar"))~=amount)then
					syncSetElementData(client,"Radar",tonumber(amount))
					triggerClientEvent(client,"refresh:settingsmenu",client,"Radar")
					triggerClientEvent(client,"draw:infobox",root,"success","Radar successfully changed!",8000)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You have already this radar!",8000)
				end
			end
		elseif(typ=="Snowshader")then
			if(tonumber(syncGetElementData(client,"Snowshader"))==1)then
				syncSetElementData(client,"Snowshader",tonumber(2))
				triggerClientEvent("switchGoundSnow",resourceRoot,true)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Snowshader")
			elseif(tonumber(syncGetElementData(client,"Snowshader"))==2)then
				syncSetElementData(client,"Snowshader",tonumber(1))
				triggerClientEvent("switchGoundSnow",resourceRoot,false)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Snowshader")
			end
		elseif(typ=="Blurshader")then
			if(tonumber(syncGetElementData(client,"Blurshader"))==1)then
				syncSetElementData(client,"Blurshader",tonumber(2))
				setPlayerBlurLevel(client,36)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Blurshader")
			elseif(tonumber(syncGetElementData(client,"Blurshader"))==2)then
				syncSetElementData(client,"Blurshader",tonumber(1))
				setPlayerBlurLevel(client,0)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Blurshader")
			end
		end
	end
end)