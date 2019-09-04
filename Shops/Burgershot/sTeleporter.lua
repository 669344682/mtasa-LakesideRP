--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntBurgershotTemple_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,363.8,-74.5,1001.5,307,10,50,true)
		end
	end
end
local function goOutIntBurgershotTemple_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==10 and getElementDimension(player)==50)then
			fadeElementInterior(player,1199.3,-919.8,43.1,180,0,0,true)
		end
	end
end

local function goInIntBurgershotRedsants_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,363.8,-74.5,1001.5,307,10,51,true)
		end
	end
end
local function goOutIntBurgershotRedsants_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==10 and getElementDimension(player)==51)then
			fadeElementInterior(player,1874.1,2071.8,11.1,270,0,0,true)
		end
	end
end

local function goInIntBurgershotMarina_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,363.8,-74.5,1001.5,307,10,52,true)
		end
	end
end
local function goOutIntBurgershotMarina_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==10 and getElementDimension(player)==52)then
			fadeElementInterior(player,812,-1616.2,13.5,270,0,0,true)
		end
	end
end

--[[local function goInIntBurgershotVeronamall_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==0 and getElementDimension(player)==0)then
			fadeElementInterior(player,363.8,-74.5,1001.5,307,10,53,true)
		end
	end
end
local function goOutIntBurgershotVeronamall_Func(player)
	if(not isPedInVehicle(player))then
		if(getElementInterior(player)==10 and getElementDimension(player)==53)then
			fadeElementInterior(player,1153.6,-1440.2,15.8,90,0,0,true)
		end
	end
end]]

local goInIntBurgershotTemple=createCmarker(1199.2,-918.4,43.1,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntBurgershotTemple_Func)
local goOutIntBurgershotTemple=createCmarker(363.0,-75.1,1001.5,10,50,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntBurgershotTemple_Func)

local goInIntBurgershotRedsants=createCmarker(1872.5,2071.9,11.1,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntBurgershotRedsants_Func)
local goOutIntBurgershotRedsants=createCmarker(363.0,-75.1,1001.5,10,51,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntBurgershotRedsants_Func)

local goInIntBurgershotMarina=createCmarker(810.7,-1616.2,13.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntBurgershotMarina_Func)
local goOutIntBurgershotMarina=createCmarker(363.0,-75.1,1001.5,10,52,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntBurgershotMarina_Func)

--local goInIntBurgershotVeronamall=createCmarker(1155,-1440.2,15.8,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntBurgershotVeronamall_Func)
--local goOutIntBurgershotVeronamall=createCmarker(363.0,-75.1,1001.5,10,53,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntBurgershotVeronamall_Func)