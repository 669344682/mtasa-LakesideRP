--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntBallas_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isBALLAS(player))then
			if(not isPedInVehicle(player))then
				fadeElementInterior(player,1212.1,-27.7,1001,180,3,27,true)
			end
		end
	end
end
local function goOutIntBallas_Func(player)
	if(getElementInterior(player)==3 and getElementDimension(player)==27)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,2248.6,-1402.2,24,180,0,0,true)
		end
	end
end


createCmarker(2248.6,-1401,24,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntBallas_Func)
createCmarker(1212.1,-26,1001,3,27,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntBallas_Func)