--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntFBI_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,322.2,303.5,999.1,0,5,18,true)
		end
	end
end
local function goOutIntFBI_Func(player)
	if(getElementInterior(player)==5 and getElementDimension(player)==18)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,1210.7,-1748.9,13.6,0,0,0,true)
		end
	end
end

local function goInInt1FBI_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isSTATE(player))then
			if(not isPedInVehicle(player))then
				fadeElementInterior(player,322.3,311.3,999.1,180,5,18,true)
			end
		end
	end
end
local function goOutInt1FBI_Func(player)
	if(getElementInterior(player)==5 and getElementDimension(player)==18)then
		if(isSTATE(player))then
			if(not isPedInVehicle(player))then
				fadeElementInterior(player,1219.2,-1813,16.6,180,0,0,true)
			end
		end
	end
end

local function goUpFBI_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isSTATE(player))then
			if(not isPedInVehicle(player))then
				setElementPosition(player,1236.6,-1785,33.6)
				setElementRotation(player,0,0,180)
			end
		end
	end
end
local function goDownFBI_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isSTATE(player))then
			if(not isPedInVehicle(player))then
				setElementPosition(player,1216.5,-1812.9,16.6)
				setElementRotation(player,0,0,180)
			end
		end
	end
end


createCmarker(1211.4,-1749.9,13.6,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntFBI_Func)
createCmarker(322.2,302.6,999.1,5,18,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntFBI_Func)

createCmarker(1219.2,-1812,16.6,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInInt1FBI_Func)
createCmarker(322.3,312.4,999.1,5,18,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutInt1FBI_Func)

createCmarker(1216.5,-1812,16.6,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/ArrowUP.png",nil,0.9,goUpFBI_Func)
createCmarker(1236.7,-1783.9,33.6,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/ArrowDown.png",nil,0.9,goDownFBI_Func)