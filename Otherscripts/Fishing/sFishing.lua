--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local fishingTable={}
local fishingTimerTable={}
local fishingMarkerTable={
	--//Los santos
	{354.6,-2088.4,6.8,170},
	{362.1,-2088.4,6.8,170},
	{367.3,-2088.4,6.8,170},
	{369.8,-2088.4,6.8,170},
	{375,-2088.4,6.8,170},
	{383.3,-2088.4,6.8,170},
	{391.1,-2088.4,6.8,170},
	{396.2,-2088.4,6.8,170},
	{398.8,-2088.4,6.8,170},
	{403.8,-2088.4,6.8,170},
}

function createFishingMarker()
	local fishingMarker={}
	for i,v in pairs(fishingMarkerTable)do
		fishingMarker[i]=createMarker(v[1],v[2],v[3],"cylinder",1.1,255,255,255,140)
		
		
		addEventHandler("onMarkerHit",fishingMarker[i],function(player)
			if(isLoggedin(player))then
				if(not(isPedInVehicle(player)))then
					if(getElementDimension(player)==getElementDimension(source))then
						if(oilspill==false)then
							local x,y,z=getElementPosition(player)
							setElementPosition(player,v[1],v[2],z)
							setPedRotation(player,v[4])
							toggleAllControls(player,false)
							bindKey(player,"j","down",ejectAngel)
							bindKey(player,"backspace","down",endFishing)
							triggerClientEvent(player,"draw:infobox",root,"info","Backspace to exit, J to eject the fishing rod.",8000)
						else
							triggerClientEvent(player,"draw:infobox",root,"error","you can not fish as there is oil in the water.",8000)
						end
					end
				end
			end
		end)
		addEventHandler("onMarkerLeave",fishingMarker[i],function(player)
			if(isLoggedin(player))then
				if(isElement(fishingTable[player]))then
					fishingTable[player]:destroy()
				end
				if(isElement(fishingTimerTable[player]))then
					fishingTimerTable[player]:destroy()
				end
			end
		end)
	end
end
addEventHandler("onResourceStart",resourceRoot,createFishingMarker)

function ejectAngel(player)
	if(isLoggedin(player))then
		if(getElementData(player,"fishingstate")==false)then
			if(oilspill==false)then
				if(tonumber(syncGetElementData(player,"Fishingrod"))>=1)then
					if(tonumber(syncGetElementData(player,"Bait"))>=1)then
						if(tonumber(syncGetElementData(player,"Fishinghook"))>=1)then
							syncSetElementData(player,"Fishinghook",tonumber(syncGetElementData(player,"Fishinghook"))-1)
							syncSetElementData(player,"Bait",tonumber(syncGetElementData(player,"Bait"))-1)
							
							local x,y,z=getElementPosition(player)
							if(isElement(fishingTable[player]))then
								fishingTable[player]:destroy()
							end
							fishingTable[player]=createObject(338,0,0,0,0,0,0)
							attachElements(fishingTable[player],player,0.2,0.5,0.4,50,0,160)
							setElementPosition(player,x,y,z+0.1)
							setTimer(function(player)
								setPedAnimation(player,"ped","gun_stand")
							end,250,1,player)
							setElementData(player,"fishingstate",true)
							catchFish(player)
						else
							triggerClientEvent(player,"draw:infobox",root,"error","You do not have a Fishinghook x1",8000)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do not have a Bait x1",8000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do not have a Fishing rod x1",8000)
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","you can not fish as there is oil in the water.",8000)
			end
		end
	end
end
function catchFish(player)
	if(getElementData(player,"fishingstate")==true)then
		fishingTimerTable[player]=setTimer(function(player)
			local rdm=math.random(1,3)
			if(rdm==2)then
				triggerClientEvent(player,"draw:infobox",root,"info","Something has bitten!\nPress the space bar until the bar is full.",8000)
				triggerClientEvent(player,"draw:fishingbar",player,"create")
			else
				catchFish(player)
			end
		end,5000,1,player)
	end
end

function endFishing(player)
	unbindKey(player,"j","down",ejectAngel)
	unbindKey(player,"backspace","down",endFishing)
	if(isElement(fishingTable[player]))then
		fishingTable[player]:destroy()
		triggerClientEvent(player,"draw:fishingbar",player)
	end
	if(isElement(fishingTimerTable[player]))then
		fishingTimerTable[player]:destroy()
		triggerClientEvent(player,"draw:fishingbar",player)
	end
	toggleAllControls(player,true)
	triggerClientEvent(player,"draw:fishingbar",player)
	setElementData(player,"fishingstate",false)
	setPedAnimation(player)
end


addEvent("get:fishingloot",true)
addEventHandler("get:fishingloot",root,function()
	local rdm=math.random(1,35)
	local rdm2=math.random(1,15)
	local rdmFishAmount=math.random(1,2)
	if(rdm==8)then
		triggerClientEvent(client,"draw:infobox",root,"info","You fished Wood Chest x1",8000)
		syncSetElementData(client,"ChestWood",tonumber(syncGetElementData(client,"ChestWood"))+1)
	else
		triggerClientEvent(client,"draw:infobox",root,"info","You fished trout x"..rdmFishAmount.."",8000)
		syncSetElementData(client,"Trout",tonumber(syncGetElementData(client,"Trout"))+rdmFishAmount)
	end
	if(rdm2==4)then
		triggerClientEvent(client,"draw:infobox",root,"warning","Your Fishingrod has broken off!",8000)
		syncSetElementData(client,"Fishingrod",tonumber(syncGetElementData(client,"Fishingrod"))-1)
	end
	
	if(isElement(fishingTable[client]))then
		fishingTable[client]:destroy()
	end
	setElementData(client,"fishingstate",false)
	setPedAnimation(client)
end)

addEventHandler("onPlayerQuit",root,function()
	endFishing(source)
end)
addEventHandler("onPlayerWasted",root,function()
	endFishing(source)
end)


addEvent("buy:fishingitems",true)
addEventHandler("buy:fishingitems",root,function(typ,amount)
	local amount=tonumber(amount)
	if(amount>=1)then
		if(typ=="Fishingrod")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.fishingrodPrice)then
				syncSetElementData(client,"Fishingrod",tonumber(syncGetElementData(client,"Fishingrod"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.fishingrodPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have buyed x"..amount.." Fishingrod.",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.fishingrodPrice..")",8000)
			end
		elseif(typ=="Fishinghook")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.fishinghookPrice)then
				syncSetElementData(client,"Fishinghook",tonumber(syncGetElementData(client,"Fishinghook"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.fishinghookPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have buyed x"..amount.." Fishinghook.",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.fishinghookPrice..")",8000)
			end
		elseif(typ=="Baits")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.baitsPrice)then
				syncSetElementData(client,"Bait",tonumber(syncGetElementData(client,"Bait"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.baitsPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have buyed x"..amount.." Bait.",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.baitsPrice..")",8000)
			end
		end
	end
end)
addEvent("sell:fishingitems",true)
addEventHandler("sell:fishingitems",root,function(typ,amount)
	local amount=tonumber(amount)
	if(amount>=1)then
		if(typ=="Trout")then
			if(tonumber(syncGetElementData(client,"Trout"))>=amount)then
				syncSetElementData(client,"Trout",tonumber(syncGetElementData(client,"Trout"))-amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+amount*settings.shop.troutPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","You have selled x"..amount.." Trout.\nYou get $"..amount*settings.shop.troutPrice.."",8000)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough Trout! (x"..amount..")",8000)
			end
		end
	end
end)