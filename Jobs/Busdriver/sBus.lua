--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local busVehicles={
	{1081.1,-1755.0,13.4,0,0,270},
	{1081.1,-1760.9,13.4,0,0,270},
	{1081.1,-1766.8,13.4,0,0,270},
	{1081.1,-1772.6,13.4,0,0,270},
}

function createBusVehicles()
	local BUSvehicle={}
	for i,v in ipairs(busVehicles)do
		local rdmPlate=math.random(1000000,99999999)
		BUSvehicle[i]=createVehicle(431,v[1],v[2],v[3],v[4],v[5],v[6],rdmPlate)
		
		setElementFrozen(BUSvehicle[i],true)
		setVehicleColor(BUSvehicle[i],0,80,200,0,80,200)
		
		setElementData(BUSvehicle[i],"veh:jobbus",true)
		setElementData(BUSvehicle[i],"Fuel",100)
		setElementData(BUSvehicle[i],"Plate",rdmPlate)
	end
end
addEventHandler("onResourceStart",resourceRoot,createBusVehicles)

function busFinish(player)
	if(getElementData(player,"ImBusjob")==true)then
		if(isPedInVehicle(player))then
			respawnVehicle(getPedOccupiedVehicle(player))
			setElementFrozen(getPedOccupiedVehicle(player),true)
			setVehicleEngineState(getPedOccupiedVehicle(player),false)
			setElementData(getPedOccupiedVehicle(player),"engine",false)
		end
		setElementData(player,"ImBusjob",false)
		triggerClientEvent(player,"createBusMarker",player)
		triggerClientEvent(player,"refreshBusMarker",player)
	end
end

addEventHandler("onPlayerQuit",root,function()
	busFinish(source)
end)
addEventHandler("onPlayerWasted",root,function()
	busFinish(source)
end)