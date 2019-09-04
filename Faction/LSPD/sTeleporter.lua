--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInLSPD_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,246.8,63.6,1003.6,0,6,20,true)
		end
	end
end
local function goOutLSPD_Func(player)
	if(getElementInterior(player)==6 and getElementDimension(player)==20)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,1553.1,-1675.5,16.2,90,0,0,true)
		end
	end
end

local function goInIntLSPD_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,246.4,86.7,1003.6,180,6,20,true)
		end
	end
end
local function goOutIntLSPD_Func(player)
	if(getElementInterior(player)==6 and getElementDimension(player)==20)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,1525.7,-1678.1,5.9,270,0,0,true)
		end
	end
end

local function goUpLSPD_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isSTATE(player))then
			if(not isPedInVehicle(player))then
				setElementPosition(player,1570.8,-1639.6,28.4)
				setElementRotation(player,0,0,180)
			end
		end
	end
end
local function goDownLSPD_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(isSTATE(player))then
			if(not isPedInVehicle(player))then
				setElementPosition(player,1570.9,-1633.9,13.6)
				setElementRotation(player,0,0,0)
			end
		end
	end
end


createCmarker(1554.6,-1675.5,16.2,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInLSPD_Func)
createCmarker(246.8,62.6,1003.6,6,20,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutLSPD_Func)

createCmarker(1524.7,-1678,5.9,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntLSPD_Func)
createCmarker(246.4,87.7,1003.6,6,20,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntLSPD_Func)

createCmarker(1570.8,-1635.6,13.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/ArrowUP.png",nil,0.9,goUpLSPD_Func)
createCmarker(1570.8,-1638.1,28.4,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/ArrowDown.png",nil,0.9,goDownLSPD_Func)