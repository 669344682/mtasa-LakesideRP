--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:vehicle",true)
addEventHandler("buy:vehicle",root,function(vehid,price,spawnx,spawny,spawnz,rotx,roty,rotz)
	local freeslot=0
	local owner=getPlayerName(client)
	
	for i=1,tonumber(syncGetElementData(client,"Vehicleslots"))do
		if(not(Vehicles[owner..i]))then
			freeslot=i
			break
		end
	end
	
	if(tonumber(syncGetElementData(client,"Money"))>=price)then
		if(not(freeslot==0))then
			local rdmPlate=math.random(10000,9999999)
			Vehicles[owner..freeslot]=createVehicle(vehid,spawnx,spawny,spawnz,rotx,roty,rotz,rdmPlate)
			
			local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE VID=VID","VID","globalcounter"),-1)[1]["VID"]
			handler:exec("UPDATE ?? SET ??=?","globalcounter","VID",IDcounter+1)
			
			setElementData(Vehicles[owner..freeslot],"ID",IDcounter)
			setElementData(Vehicles[owner..freeslot],"Owner",owner)
			setElementData(Vehicles[owner..freeslot],"Slot",freeslot)
			setElementData(Vehicles[owner..freeslot],"Totalloss",0)
			setElementHealth(Vehicles[owner..freeslot],1000)
			setElementData(Vehicles[owner..freeslot],"Fuel",100)
			setElementData(Vehicles[owner..freeslot],"Plate",rdmPlate)
			setElementData(Vehicles[owner..freeslot],"Towed",0)
			setElementData(Vehicles[owner..freeslot],"Sportmotor",0)
			setElementData(Vehicles[owner..freeslot],"Lowering",0)
			
			setVehicleLocked(Vehicles[owner..freeslot],true)
			setVehicleColor(Vehicles[owner..freeslot],0,0,0,0,0,0)
			setElementDimension(Vehicles[owner..freeslot],0)
			
			warpPedIntoVehicle(client,Vehicles[owner..freeslot])
			
			handler:exec("INSERT INTO uservehicles (ID,UID,Owner,VehID,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ,Sportmotor,Lowering,Slot,Totalloss,Health,Fuel,Plate,Towed) VALUES ('"..IDcounter.."','"..playerUID[owner].."','"..owner.."','"..vehid.."','"..spawnx.."','"..spawny.."','"..spawnz.."','"..rotx.."','"..roty.."','"..rotz.."','0','0','"..freeslot.."','0','1000','100','"..rdmPlate.."','0')")
			
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-price)
			triggerClientEvent(client,"draw:infobox",root,"success","Your have buyed succesfully a car!",8000)
			
			loadVehicles(owner)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..price..")",8000)
	end
end)

--//Create Privat Vehicles
function loadVehicles(owner)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","Owner",owner),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(not(isElement(Vehicles[v["Owner"]..v["Slot"]])))then
				Vehicles[v["Owner"]..v["Slot"]]=createVehicle(v["VehID"],v["SpawnX"],v["SpawnY"],v["SpawnZ"],v["RotX"],v["RotY"],v["RotZ"],v["Plate"])
				
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"ID",v["ID"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"UID",v["UID"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Owner",v["Owner"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Sportmotor",v["Sportmotor"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Lowering",v["Lowering"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Slot",v["Slot"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Totalloss",v["Totalloss"])
				setElementHealth(Vehicles[v["Owner"]..v["Slot"]],v["Health"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Fuel",v["Fuel"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Plate",v["Plate"])
				setElementData(Vehicles[v["Owner"]..v["Slot"]],"Towed",v["Towed"])
				
				if(getElementData(Vehicles[v["Owner"]..v["Slot"]],"Towed")==1)then
					local rdm=math.random(10,1000)
					setElementDimension(Vehicles[v["Owner"]..v["Slot"]],rdm)
				end
				
				setVehicleLocked(Vehicles[v["Owner"]..v["Slot"]],true)
				
				loadVehicleTunings(Vehicles[v["Owner"]..v["Slot"]])
				giveVehicleSpecialUpgrade(Vehicles[v["Owner"]..v["Slot"]])
			end
		end
	end
end
function loadFactionVehicles(owner)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factionvehicles","Owner",owner),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(not(isElement(FactionVehicles[v["Owner"]..v["ID"]])))then
				FactionVehicles[v["Owner"]..v["ID"]]=createVehicle(v["VehID"],v["SpawnX"],v["SpawnY"],v["SpawnZ"],v["RotX"],v["RotY"],v["RotZ"],v["Plate"])
				
				setElementData(FactionVehicles[v["Owner"]..v["ID"]],"ID",v["ID"])
				setElementData(FactionVehicles[v["Owner"]..v["ID"]],"Owner",v["Owner"])
				setElementData(FactionVehicles[v["Owner"]..v["ID"]],"Slot",v["Slot"])
				setElementData(FactionVehicles[v["Owner"]..v["ID"]],"Fuel",v["Fuel"])
				setElementData(FactionVehicles[v["Owner"]..v["ID"]],"Plate",v["Plate"])
				
				setVehicleLocked(FactionVehicles[v["Owner"]..v["ID"]],true)
				
				toggleVehicleRespawn(FactionVehicles[v["Owner"]..v["ID"]],true)
				setVehicleIdleRespawnDelay(FactionVehicles[v["Owner"]..v["ID"]],30*60*1000)
				
				if(getElementData(FactionVehicles[v["Owner"]..v["ID"]],"Owner")==1)then
				setVehicleColor(FactionVehicles[v["Owner"]..v["ID"]],0,0,0,255,255,255)
					if(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==597)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"policecar",true)
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:sapd",1)
						removeVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]])
						addVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,2,true,true,false,false)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],1,-0.5,-0.4,1,255,0,0,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],2,0.5,-0.4,1,0,0,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],3,0,-0.4,1,255,255,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],4,0.6,-2.1,0.4,255,255,0,255,140)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],5,0,-2.1,0.4,255,255,0,255,140)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,-0.6,-2.1,0.4,255,255,0,255,140)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==getVehicleModelFromName("Police LV"))then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"policecar",true)
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:patrol",1)
						removeVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]])
						addVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,2,true,true,false,false)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],1,-0.5,-0.4,1,255,0,0,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],2,0.5,-0.4,1,0,0,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],3,0,-0.4,1,255,255,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],4,0.6,-1.8,0.5,255,255,0,255,140)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],5,0.0,-1.8,0.5,255,255,0,255,140)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,-0.6,-1.8,0.5,255,255,0,255,140)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==getVehicleModelFromName("Enforcer"))then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"policecar",true)
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:sapd",1)
						removeVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]])
						addVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],8,2,true,true,false,false)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],1,1.2,0.1,1.3,255,142.8,0,198.9,198.9)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],2,1.2,-1.6,1.3,255,145.4,0,200,200)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],3,1.2,-3.4,1.3,255,145.4,0,200,200)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],4,-1.2,0.1,1.3,255,145.4,0,200,200)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],5,-1.2,-1.6,1.3,255,145.4,0,200,200)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,-1.2,-3.4,1.3,255,145.4,0,200,200)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],7,-0.4,1.1,1.5,0,0,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],8,0.4,1.1,1.5,255,0,0,255,255)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==601)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:swat",1)
					end
				end
				if(getElementData(FactionVehicles[v["Owner"]..v["ID"]],"Owner")==2)then
				setVehicleColor(FactionVehicles[v["Owner"]..v["ID"]],0,0,0,0,0,0)
					if(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==597)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"policecar",true)
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:fbi",1)
						removeVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]])
						addVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,2,true,true,false,false)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],1,-0.5,-0.4,1,255,0,0,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],2,0.5,-0.4,1,0,0,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],3,0,-0.4,1,255,255,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],4,0.6,-2.1,0.4,255,255,0,255,140)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],5,0,-2.1,0.4,255,255,0,255,140)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],6,-0.6,-2.1,0.4,255,255,0,255,140)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==490)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"policecar",true)
						removeVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]])
						addVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],5,3,false,false,false,false)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],1,0,1.5,0.5,0,0,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],2,0.9,3.4,-0.4,0,0,255,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],3,-0.9,3.4,-0.4,255,0,0,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],4,-0.9,-3.2,-0.4,255,0,0,255,255)
						setVehicleSirens(FactionVehicles[v["Owner"]..v["ID"]],5,0.9,-3.2,-0.4,0,0,255,255,255)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==490)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"policecar",true)
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:swat",1)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==601)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:swat",1)
					elseif(getElementModel(FactionVehicles[v["Owner"]..v["ID"]])==497)then
						setElementData(FactionVehicles[v["Owner"]..v["ID"]],"texture:fbi",1)
					end
				end
				if(getElementData(FactionVehicles[v["Owner"]..v["ID"]],"Owner")==3)then
				setVehicleColor(FactionVehicles[v["Owner"]..v["ID"]],0,160,0,0,160,0)
				end
				if(getElementData(FactionVehicles[v["Owner"]..v["ID"]],"Owner")==4)then
				setVehicleColor(FactionVehicles[v["Owner"]..v["ID"]],130,0,150,130,0,150)
				end
			end
		end
	end
end
function loadCompanyVehicles(owner)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companyvehicles","Owner",owner),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(not(isElement(CompanyVehicles[v["Owner"]..v["ID"]])))then
				CompanyVehicles[v["Owner"]..v["ID"]]=createVehicle(v["VehID"],v["SpawnX"],v["SpawnY"],v["SpawnZ"],v["RotX"],v["RotY"],v["RotZ"],v["Plate"])
				
				setElementData(CompanyVehicles[v["Owner"]..v["ID"]],"ID",v["ID"])
				setElementData(CompanyVehicles[v["Owner"]..v["ID"]],"Owner",v["Owner"])
				setElementData(CompanyVehicles[v["Owner"]..v["ID"]],"Slot",v["Slot"])
				setElementData(CompanyVehicles[v["Owner"]..v["ID"]],"Fuel",v["Fuel"])
				setElementData(CompanyVehicles[v["Owner"]..v["ID"]],"Plate",v["Plate"])
				
				setVehicleLocked(CompanyVehicles[v["Owner"]..v["ID"]],true)
				
				toggleVehicleRespawn(CompanyVehicles[v["Owner"]..v["ID"]],true)
				setVehicleIdleRespawnDelay(CompanyVehicles[v["Owner"]..v["ID"]],30*60*1000)
				
				if(getElementData(CompanyVehicles[v["Owner"]..v["ID"]],"Owner")==1)then
				setVehicleColor(CompanyVehicles[v["Owner"]..v["ID"]],255,255,255,120,120,120)
					if(getElementModel(CompanyVehicles[v["Owner"]..v["ID"]])==525)then
						addVehicleSirens(CompanyVehicles[v["Owner"]..v["ID"]],3,2,false,true,true,true)
						setVehicleSirens(CompanyVehicles[v["Owner"]..v["ID"]],1,0.55,-0.5,1.5,255,0,0,200,200)
						setVehicleSirens(CompanyVehicles[v["Owner"]..v["ID"]],2,-0.55,-0.5,1.5,255,0,0,255,200)
						setVehicleSirens(CompanyVehicles[v["Owner"]..v["ID"]],3,0,-0.5,1.5,255,255,0,255,200)
					end
				elseif(getElementData(CompanyVehicles[v["Owner"]..v["ID"]],"Owner")==2)then
				setVehicleColor(CompanyVehicles[v["Owner"]..v["ID"]],255,255,255,255,255,255)
				end
				
			end
		end
	end
end

addEventHandler("onPlayerQuit",root,function()
	for _,v in pairs(getElementsByType("vehicle"))do
		if(getElementData(v,"Owner")and getElementData(v,"Slot")and getElementData(v,"Owner")==getPlayerName(source))then
			v:destroy()
		end
	end
end)





carPrices={
[496]=42000,
[445]=39000,
[410]=23000,
[549]=17500,
[585]=19600,
[550]=32000,

[402]=105000,
[411]=250000,
[415]=195000,
[451]=320000,
[480]=210000,
[541]=235000,
[560]=97000,
[429]=115000,
}