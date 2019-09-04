--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

taxiPayTimer={}

local taxiVehicles={
	{1723,-1874.8,13.3,0,0,0},
	{1715,-1874.8,13.3,0,0,0},
	{1723,-1884,13.3,0,0,0},
	{1715,-1884,13.3,0,0,0},
}

function createTaxiVehicles()
	local TAXIvehicle={}
	for i,v in ipairs(taxiVehicles)do
		local rdmPlate=math.random(1000000,99999999)
		TAXIvehicle[i]=createVehicle(420,v[1],v[2],v[3],v[4],v[5],v[6],rdmPlate)
		
		setElementFrozen(TAXIvehicle[i],true)
		setVehicleColor(TAXIvehicle[i],200,200,0,200,200,0)
		
		setElementData(TAXIvehicle[i],"veh:jobtaxi",true)
		setElementData(TAXIvehicle[i],"Fuel",100)
		setElementData(TAXIvehicle[i],"Plate",rdmPlate)
	end
end
addEventHandler("onResourceStart",resourceRoot,createTaxiVehicles)