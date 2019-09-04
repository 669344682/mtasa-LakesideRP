--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local pedTable={
{40,1743.1,-1864.1,13.5,0,0,0,"Scooter","Lucy Mason [NPC]","Scooter Rental"},
{40,1184.8,-1304.5,14.2,270,0,0,"Scooter","Ella Anderson [NPC]","Scooter Rental"},
{11,359.7,173.6,1008.4,270,70,3,"Townhall","Eleanor Joyce [NPC]","License manager"},
{148,356.3,169,1008.4,270,70,3,"TownhallPin","Archie Bates [NPC]","Bank account"},
{150,356.3,178.7,1008.4,270,70,3,"TownhallJob","Anthony Wall [NPC]","Jobs"},
{192,912.4,-1233.8,17.2,0,0,0,"mechtow:buyoutcar_PED","Lauren Mills [NPC]","Towed vehicles"},

{76,1100,-1734.7,13.8,180,0,0,"Job:Bus","Nicole Little [NPC]","Busdriver job"},
{155,2106.4,-1790.7,13.6,0,0,0,"Job:Pizza","Sean Lane [NPC]","Pizza job"},
{187,1719.2,-1873.9,13.6,180,0,0,"Job:Taxi","Ben Hurst [NPC]","Taxidriver job"},

--//Tankstations
--//    Mulholland
{50,1001.8,-937.1,42.3,0,0,0,"tankstation_PED","Sam Miah [NPC]","Tankstation"},
{50,999.1,-937.6,42.3,180,0,0,"tankstation_PED","Lewis Hill [NPC]","Tankstation"},
{50,1006.4,-936.5,42.3,180,0,0,"tankstation_PED","Nicholas Kemp [NPC]","Tankstation"},
{50,1009.1,-936.1,42.3,0,0,0,"tankstation_PED","Jake Chapman [NPC]","Tankstation"},
--//    Idlewood
{50,1941.6,-1775.7,13.6,270,0,0,"tankstation_PED","Tyler Lambert [NPC]","Tankstation"},
{50,1941.6,-1777.1,13.6,90,0,0,"tankstation_PED","Jake Lambert [NPC]","Tankstation"},
{50,1941.7,-1770.0,13.6,270,0,0,"tankstation_PED","Andrew Cunningham [NPC]","Tankstation"},
{50,1941.8,-1768.7,13.6,90,0,0,"tankstation_PED","Tim Hill [NPC]","Tankstation"},
--//    Airports
{50,1455.7,-2418,13.6,180,0,0,"tankstation_PED","Jacob Cooper [NPC]","Tankstation"},--LS
{50,1463.1,-2418,13.6,180,0,0,"tankstation_PED","Kai Hammond [NPC]","Tankstation"},--LS

--//Shop peds
--//    Burgershot
{209,1175,-1439.9,15.8,90,0,0,"shop:burgershot_PED","David Hyde [NPC]","Burgershot"},
{205,1175,-1444.6,15.8,90,0,0,"shop:burgershot_PED","Eleanor Moran [NPC]","Burgershot"},
{205,376.5,-65.8,1001.5,180,50,10,"shop:burgershot_PED","Melissa Benson [NPC]","Burgershot"},
{205,376.5,-65.8,1001.5,180,51,10,"shop:burgershot_PED","Lydia Whitehouse [NPC]","Burgershot"},
{209,376.5,-65.8,1001.5,180,52,10,"shop:burgershot_PED","Joe Booth [NPC]","Burgershot"},
--//    Pizzastack
{155,372.7,-117.3,1001.5,180,60,5,"shop:pizzastack_PED","David Bartlett [NPC]","Pizzastack"},
--//    24/7 Market
{91,-26.9,-91.6,1003.5,0,70,18,"shop:normal_PED","Imogen Franklin [NPC]","24/7 Market"},
{225,-26.9,-91.6,1003.5,0,71,18,"shop:normal_PED","Tia Hutchinson [NPC]","24/7 Market"},
--//    Ammunation
{312,295.6,-82.5,1001.5,0,70,4,"shop:ammunation_PED","Charles Jarvis [NPC]","Ammunation"},
--//    Other
{21,1468.5,-1713.9,14.1,270,0,0,"shop:chestdealer_PED","Charlie Daniels [NPC]","Chest dealer"},
{94,1166,-1451.8,15.8,90,0,0,"shop:electro_PED","Matthew Reynolds [NPC]","Electro"},
{216,208.8,-98.7,1005.2,180,60,15,"shop:skin_PED","Yasmin Farmer [NPC]","Skins"},
{79,344.3,3116.9,1152.9,90,0,0,"shop:moonstonedealer_PED","Mollie Clayton [NPC]","Moonstone dealer"},
{210,374.7,-2067.3,7.8,180,0,0,"shop:fishing_PED","Lewis Doherty [NPC]","Fishing"},
{157,1107.8,-303.6,74,180,0,0,"shop:farm_PED","Alicia Chandler [NPC]","Farm"},

{227,-65.4,-1573.9,2.6,187,0,0,"shop:gangcardealer_PED","Joe Whittaker [NPC]","Car dealer"},

{43,1215.6,-26.8,1001,90,27,3,"shop:faction_PED","Owen Farmer [NPC]","Gang Shop"},
{105,2494.4,-1706,1014.7,270,30,3,"shop:faction_PED","Jacob Iqbal [NPC]","Gang Shop"},
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Peds={}
	for i,v in pairs(pedTable)do
		if(#pedTable>=1)then
			Peds[i]=createPed(v[1],v[2],v[3],v[4],v[5])
			
			setElementDimension(Peds[i],v[6])
			setElementInterior(Peds[i],v[7])
			setElementFrozen(Peds[i],true)
			setElementData(Peds[i],"dontdamagePED",true)
			
			if(v[8]=="Scooter")then
				setElementData(Peds[i],"scooterPED",true)
			end
			if(v[8]=="Townhall")then
				setElementData(Peds[i],"townhallPED",true)
			end
			if(v[8]=="TownhallPin")then
				setElementData(Peds[i],"townhallPinPED",true)
			end
			if(v[8]=="TownhallJob")then
				setElementData(Peds[i],"jobPED",true)
			end
			if(v[8]=="mechtow:buyoutcar_PED")then
				setElementData(Peds[i],"mechtow:buyoutcarPED",true)
			end
			--//Tankstation
			if(v[8]=="tankstation_PED")then
				setElementData(Peds[i],"tankstationPED",true)
			end
			--//Shop peds
			if(v[8]=="shop:pizzastack_PED")then
				setElementData(Peds[i],"shop:pizzastackPED",true)
			end
			if(v[8]=="shop:burgershot_PED")then
				setElementData(Peds[i],"shop:burgershotPED",true)
			end
			if(v[8]=="shop:chestdealer_PED")then
				setElementData(Peds[i],"shop:chestdealerPED",true)
			end
			if(v[8]=="shop:moonstonedealer_PED")then
				setElementData(Peds[i],"shop:moonstonedealerPED",true)
			end
			if(v[8]=="shop:fishing_PED")then
				setElementData(Peds[i],"shop:fishingPED",true)
			end
			if(v[8]=="shop:farm_PED")then
				setElementData(Peds[i],"shop:farmPED",true)
			end
			if(v[8]=="shop:normal_PED")then
				setElementData(Peds[i],"shop:normalPED",true)
			end
			if(v[8]=="shop:electro_PED")then
				setElementData(Peds[i],"shop:electroPED",true)
			end
			if(v[8]=="shop:skin_PED")then
				setElementData(Peds[i],"shop:skinPED",true)
			end
			if(v[8]=="shop:ammunation_PED")then
				setElementData(Peds[i],"shop:ammunationPED",true)
			end
			
			if(v[8]=="shop:faction_PED")then
				setElementData(Peds[i],"shop:factionPED",true)
			end
			
			if(v[8]=="shop:gangcardealer_PED")then
				setElementData(Peds[i],"shop:gangcardealerPED",true)
			end
			--//Job peds
			if(v[8]=="Job:Bus")then
				setElementData(Peds[i],"job:busPED",true)
			end
			if(v[8]=="Job:Pizza")then
				setElementData(Peds[i],"job:pizzaPED",true)
			end
			if(v[8]=="Job:Taxi")then
				setElementData(Peds[i],"job:taxiPED",true)
			end
			
			
			
			if(v[9])then
				setElementData(Peds[i],"set:pedtext",v[9])
			end
			if(v[10])then
				setElementData(Peds[i],"set:peddescription",v[10])
			end
		end
	end
end)


local weedBuyPedpositions={
	{1688.5,-1525.1,13.5,250},
	{1131.9,-1346.5,14,270},
	{1631.3,-1508.3,13.6,180},
	{1074.9,-873.8,43.4,0},
	{2351.7,-1225,22.5,90},
}
local weedSellPedpositions={
	{2382.3,-1814.8,13.5,170},
	{2551.6,-2350.3,13.6,46},
	{2269.5,-2673.6,13.6,177},
	{1395.1,-1459.1,8.7,252},
	{1530.3,-1107.1,20.9,180},
}

function createBuyWeedPed()
	weedBuyPrice=math.random(5,12)
	weedBuyAmount=math.random(10,35)
	local rnd=math.random(1,#weedBuyPedpositions)
	local buyWeedPedPos=weedBuyPedpositions[rnd]
	buyWeedped=createPed(29,buyWeedPedPos[1],buyWeedPedPos[2],buyWeedPedPos[3],buyWeedPedPos[4])
	setPedAnimation(buyWeedped,"DEALER","DEALER_IDLE")
	setElementData(buyWeedped,"dealer:buyweedPED",true)
end
addEventHandler("onResourceStart",resourceRoot,createBuyWeedPed)
function createSellWeedPed()
	weedSellPrice=math.random(3,10)
	weedSellAmount=math.random(10,45)
	local rdmPOS=math.random(1,#weedSellPedpositions)
	local sellWeedPedPos=weedSellPedpositions[rdmPOS]
	sellWeedped=createPed(29,sellWeedPedPos[1],sellWeedPedPos[2],sellWeedPedPos[3],sellWeedPedPos[4])
	setPedAnimation(sellWeedped,"DEALER","DEALER_IDLE")
	setElementData(sellWeedped,"dealer:sellweedPED",true)
end
addEventHandler("onResourceStart",resourceRoot,createSellWeedPed)

addEvent("buy:weedfromped",true)
addEventHandler("buy:weedfromped",root,function(price,amount)
	local amount=tonumber(amount)
	if(tonumber(syncGetElementData(client,"Money"))>=amount*price)then
		if(isElement(buyWeedped))then
			buyWeedped:destroy()
			
			syncSetElementData(client,"Weed",tonumber(syncGetElementData(client,"Weed"))+amount)
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*price)
			setTimer(createBuyWeedPed,15*60*1000,1)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The dealer is not more here!",8000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*price..")",8000)
	end
end)
addEvent("sell:weedfromped",true)
addEventHandler("sell:weedfromped",root,function(price,amount)
	if(tonumber(syncGetElementData(client,"Weed"))>=amount)then
		if(isElement(sellWeedped))then
			sellWeedped:destroy()
			
			syncSetElementData(client,"Weed",tonumber(syncGetElementData(client,"Weed"))-amount)
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+amount*price)
			setTimer(createSellWeedPed,10*60*1000,1)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The dealer is not more here!",8000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough weed! (x"..amount..")",8000)
	end
end)