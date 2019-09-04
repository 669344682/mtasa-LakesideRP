--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntPizzaIdlewood_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,372.4,-132.3,1001.5,0,5,60,true)
		end
	end
end
local function goOutIntPizzaIdlewood_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==5 and getElementDimension(player)==60)then
			fadeElementInterior(player,2103.7,-1806.5,13.6,90,0,0,true)
		end
	end
end

createCmarker(2105.2,-1806.5,13.6,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntPizzaIdlewood_Func)
createCmarker(372.4,-133.4,1001.5,5,60,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntPizzaIdlewood_Func)
