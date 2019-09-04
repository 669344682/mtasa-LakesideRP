--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntAmmunationLS_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,286.5,-86.6,1001.5,0,4,70,true)
		end
	end
end
local function goOutIntAmmunationLS_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==4 and getElementDimension(player)==70)then
			fadeElementInterior(player,1368.9,-1279.1,13.5,90,0,0,true)
		end
	end
end

createCmarker(1368.8,-1280.5,13.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntAmmunationLS_Func)
createCmarker(285,-86.6,1001.5,4,70,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntAmmunationLS_Func)