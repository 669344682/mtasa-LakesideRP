--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntComerceShop_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,-31,-91,1003.5,0,18,70,true)
		end
	end
end
local function goOutIntComerceShop_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==18 and getElementDimension(player)==70)then
			fadeElementInterior(player,1352.4,-1757.7,13.5,0,0,0,true)
		end
	end
end

local function goInIntMulhollandTankstationShop_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,-31,-91,1003.5,0,18,71,true)
		end
	end
end
local function goOutIntMulhollandTankstationShop_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==18 and getElementDimension(player)==71)then
			fadeElementInterior(player,999.5,-920.2,42.2,0,0,0,true)
		end
	end
end

createCmarker(1352.4,-1759.1,13.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntComerceShop_Func)
createCmarker(-31,-91.9,1003.5,18,70,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntComerceShop_Func)

createCmarker(1000.3,-920,42.3,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntMulhollandTankstationShop_Func)
createCmarker(-31,-91.9,1003.5,18,71,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntMulhollandTankstationShop_Func)