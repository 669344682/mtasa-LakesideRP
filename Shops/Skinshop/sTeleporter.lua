--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntPizzaIdlewood_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,207.7,-110,1005.1,0,15,60,true)
		end
	end
end
local function goOutIntPizzaIdlewood_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==15 and getElementDimension(player)==60)then
			fadeElementInterior(player,2244.7,-1664.1,15.5,0,0,0,true)
		end
	end
end

createCmarker(2244.4,-1665.2,15.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntPizzaIdlewood_Func)
createCmarker(207.7,-111,1005.1,15,60,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntPizzaIdlewood_Func)
