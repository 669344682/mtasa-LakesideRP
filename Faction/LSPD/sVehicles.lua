--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

policeVehiclesTable={
	--[[{597,1558.9,-1710.6,5.7,0,0,0},
	{597,1563.1,-1710.6,5.7,0,0,0},
	{597,1566.5,-1710.6,5.7,0,0,0},
	{597,1570.3,-1710.6,5.7,0,0,0},
	{597,1574.4,-1710.6,5.7,0,0,0},
	{597,1578.5,-1710.6,5.7,0,0,0},
	{597,1583.4,-1710.6,5.7,0,0,0},
	{597,1587.4,-1710.6,5.7,0,0,0},
	{597,1591.4,-1710.6,5.7,0,0,0},
	{597,1595.4,-1710.6,5.7,0,0,0},
	{427,1538.9,-1645.3,6.0,0,0,180},
	{427,1534.6,-1645.3,6.0,0,0,180},
	{427,1530.6,-1645.3,6.0,0,0,180},
	{427,1526.6,-1645.3,6.0,0,0,180},
	{601,1545.5,-1651,5.6,0,0,90},
	{601,1545.5,-1655.1,5.6,0,0,90},
	{601,1545.5,-1659.1,5.6,0,0,90},
	{598,1601.8,-1704.0,5.7,0,0,90},
	{598,1601.8,-1700.0,5.7,0,0,90},
	{598,1601.8,-1696.0,5.7,0,0,90},
	{598,1601.8,-1692.0,5.7,0,0,90},
	{598,1601.8,-1688.0,5.7,0,0,90},
	{598,1601.8,-1684.0,5.7,0,0,90},
	
	--//LS - Helicopter
	{497,1562.3,-1647.9,28.5,0,0,90},
	{497,1562.3,-1660.0,28.5,0,0,90},
	{497,1562.3,-1691.2,28.5,0,0,90},
	{497,1562.3,-1703.3,28.5,0,0,90},]]
}

function createPoliceVehicles()
	local PoliceVEH={}
	for i,v in ipairs(policeVehiclesTable)do
		local rdmPlate=math.random(1000,9999)
		PoliceVEH[i]=createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],rdmPlate)
		PoliceVEH[i]:setColor(0,0,0,255,255,255)
		PoliceVEH[i]:setFrozen(true)
		PoliceVEH[i]:setLocked(true)
		
		setElementData(PoliceVEH[i],"Owner",1)
		setElementData(PoliceVEH[i],"policecar",true)
		setElementData(PoliceVEH[i],"Fuel",100)
		setElementData(PoliceVEH[i],"Plate",rdmPlate)
		
		toggleVehicleRespawn(PoliceVEH[i],true)
		setVehicleIdleRespawnDelay(PoliceVEH[i],15*60*1000)
		
		if(getElementModel(PoliceVEH[i])==getVehicleModelFromName("Police SF"))then
			setElementData(PoliceVEH[i],"policecar",true)
			setElementData(PoliceVEH[i],"texture:sapd",true)
			removeVehicleSirens(PoliceVEH[i])
			addVehicleSirens(PoliceVEH[i],6,2,true,true,false,false)
			setVehicleSirens(PoliceVEH[i],1,-0.5,-0.4,1,255,0,0,255,255)
			setVehicleSirens(PoliceVEH[i],2,0.5,-0.4,1,0,0,255,255,255)
			setVehicleSirens(PoliceVEH[i],3,0,-0.4,1,255,255,255,255,255)
			setVehicleSirens(PoliceVEH[i],4,0.6,-2.1,0.4,255,255,0,255,140)
			setVehicleSirens(PoliceVEH[i],5,0,-2.1,0.4,255,255,0,255,140)
			setVehicleSirens(PoliceVEH[i],6,-0.6,-2.1,0.4,255,255,0,255,140)
		elseif(getElementModel(PoliceVEH[i])==getVehicleModelFromName("Police LV"))then
			setElementData(PoliceVEH[i],"policecar",true)
			setElementData(PoliceVEH[i],"texture:patrol",true)
			removeVehicleSirens(PoliceVEH[i])
			addVehicleSirens(PoliceVEH[i],6,2,true,true,false,false)
			setVehicleSirens(PoliceVEH[i],1,-0.5,-0.4,1,255,0,0,255,255)
			setVehicleSirens(PoliceVEH[i],2,0.5,-0.4,1,0,0,255,255,255)
			setVehicleSirens(PoliceVEH[i],3,0,-0.4,1,255,255,255,255,255)
			setVehicleSirens(PoliceVEH[i],4,0.6,-1.8,0.5,255,255,0,255,140)
			setVehicleSirens(PoliceVEH[i],5,0.0,-1.8,0.5,255,255,0,255,140)
			setVehicleSirens(PoliceVEH[i],6,-0.6,-1.8,0.5,255,255,0,255,140)
		elseif(getElementModel(PoliceVEH[i])==getVehicleModelFromName("Enforcer"))then
			setElementData(PoliceVEH[i],"policecar",true)
			setElementData(PoliceVEH[i],"texture:sapd",true)
			removeVehicleSirens(PoliceVEH[i])
			addVehicleSirens(PoliceVEH[i],8,2,true,true,false,false)
			setVehicleSirens(PoliceVEH[i],1,1.2,0.1,1.3,255,142.8,0,198.9,198.9)
			setVehicleSirens(PoliceVEH[i],2,1.2,-1.6,1.3,255,145.4,0,200,200)
			setVehicleSirens(PoliceVEH[i],3,1.2,-3.4,1.3,255,145.4,0,200,200)
			setVehicleSirens(PoliceVEH[i],4,-1.2,0.1,1.3,255,145.4,0,200,200)
			setVehicleSirens(PoliceVEH[i],5,-1.2,-1.6,1.3,255,145.4,0,200,200)
			setVehicleSirens(PoliceVEH[i],6,-1.2,-3.4,1.3,255,145.4,0,200,200)
			setVehicleSirens(PoliceVEH[i],7,-0.4,1.1,1.5,0,0,255,255,255)
			setVehicleSirens(PoliceVEH[i],8,0.4,1.1,1.5,255,0,0,255,255)
		elseif(getElementModel(PoliceVEH[i])==599)then
			setElementData(PoliceVEH[i],"policecar",true)
			removeVehicleSirens(PoliceVEH[i])
			addVehicleSirens(PoliceVEH[i],6,2,true,true,false,false)
			setVehicleSirens(PoliceVEH[i],1,-0.6,0,1.2,255,0,0,255,255)
			setVehicleSirens(PoliceVEH[i],2,0.6,0,1.2,0,0,255,255,255)
			setVehicleSirens(PoliceVEH[i],3,0,0,1.2,255,255,255,255,255)
			setVehicleSirens(PoliceVEH[i],4,-0.5,-2.5,1,255,120,0,255,168.3)
			setVehicleSirens(PoliceVEH[i],5,0.0,-2.5,1,255,120,0,255,168.3)
			setVehicleSirens(PoliceVEH[i],6,0.5,-2.5,1,255,120,0,255,168.3)
		elseif(getElementModel(PoliceVEH[i])==601)then
			setElementData(PoliceVEH[i],"policecar",true)
		elseif(getElementModel(PoliceVEH[i])==497)then
			setElementData(PoliceVEH[i],"policecar",true)
			setElementData(PoliceVEH[i],"texture:sapd",true)
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,createPoliceVehicles)