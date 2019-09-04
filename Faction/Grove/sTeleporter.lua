--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntGrove_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isGROVE(player))then
			if(not isPedInVehicle(player))then
				fadeElementInterior(player,2496,-1693.6,1014.7,180,3,30,true)
			end
		end
	end
end
local function goOutIntGrove_Func(player)
	if(getElementInterior(player)==3 and getElementDimension(player)==30)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,2495.4,-1690,14.8,0,0,0,true)
		end
	end
end


createCmarker(2495.4,-1690.9,14.8,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntGrove_Func)
createCmarker(2496,-1692.4,1014.7,3,30,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntGrove_Func)