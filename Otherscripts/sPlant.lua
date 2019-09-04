--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local plantModelID={
	["AppleSeeds"]=738,
	["WeedSeeds"]=3409,
}
plantItemID={
	[738]="Apple",
	[3409]="Weed",
}

function loadPlants()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM userplants"),-1)
	if(result and result[1])then
		for i=1,#result do
			local model=tonumber(result[i]["Model"])
			local x=tonumber(result[i]["SpawnX"])
			local y=tonumber(result[i]["SpawnY"])
			local z=tonumber(result[i]["SpawnZ"])
			local rot=tonumber(result[i]["RotZ"])
			local id=tonumber(result[i]["ID"])
			
			createPlantModel(model,x,y,z,rot,id)
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,loadPlants)

function createPlant(player,seed)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player)and isPedOnGround(player)and not isElementInWater(player))then
			for _,v in pairs(getElementsByType("object"))do
				if(getElementModel(v)==3409 and getElementData(v,"PlantID"))then
					local x,y,z=getElementPosition(v)
					if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=3)then
						triggerClientEvent(player,"draw:infobox",root,"error","You cant plant a weed-plant in a weed-plant!",8000)
						return
					end
				end
			end
			if(getElementData(player,"plantstate")==false)then
			local pname=getPlayerName(player)
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userplants","UID",playerUID[pname]),-1)
				if(#result<15)then
					local model=plantModelID[seed]
					local x,y,z=getElementPosition(player)
					local rz=getPedRotation(player)
					
					setElementFrozen(player,true)
					setPedAnimation(player,"BOMBER","BOM_Plant_Loop")
					setElementData(player,"plantstate",true)
					if(model==3409)then
						time=6
						syncSetElementData(client,"WeedSeeds",tonumber(syncGetElementData(client,"WeedSeeds"))-1)
					elseif(model==738)then
						time=4
						syncSetElementData(client,"AppleSeeds",tonumber(syncGetElementData(client,"AppleSeeds"))-1)
					end
					local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE PID=PID","PID","globalcounter"),-1)[1]["PID"]
					handler:exec("UPDATE ?? SET ??=?","globalcounter","PID",IDcounter+1)
					
					handler:exec("INSERT INTO userplants (ID,UID,Model,SpawnX,SpawnY,SpawnZ,RotZ,Time) VALUES (?,?,?,?,?,?,?,?)",IDcounter,playerUID[pname],model,x,y,z,rz,getSecTime(time))
					
					setTimer(function(player)
						setElementData(player,"plantstate",false)
						setPedAnimation(player)
						createPlantModel(model,x,y,z,rz,IDcounter)
						setElementFrozen(player,false)
					end,12500,1,player)
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You have already reached the planting maximum of 15!",8000)
				end
			end
		end
	end
end

function createPlantModel(model,x,y,z,rz,id)
	local objectmodel=createObject(model,x,y,z-1,0,0,rz)
	if(model==3409)then
		setObjectScale(objectmodel,0.7)
	end
	setElementDoubleSided(objectmodel,true)
	setElementData(objectmodel,"PlantID",id)
end

function removePlant(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player)and isPedOnGround(player)and not isElementInWater(player))then
			for _,v in pairs(getElementsByType("object"))do
				if(getElementModel(v)==3409)then
					local x,y,z=getElementPosition(v)
					if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=2)then
						local plantID=getElementData(v,"PlantID")
						local plantIDTime=getData("userplants","ID",plantID,"Time")
						if(plantIDTime~=0 and plantIDTime-getSecTime(0)<=0 or isSTATE(player)and syncGetElementData(player,"CopDuty")==true or tonumber(syncGetElementData(player,"AdminLvL"))>=3)then
							local model=getElementModel(v)
							local rdm=math.random(8,12)
							
							syncSetElementData(player,plantItemID[model],syncGetElementData(player,plantItemID[model])+rdm)
							triggerClientEvent(player,"draw:infobox",root,"info","You harvested the plant. (x"..rdm..")",8000)
							handler:exec("DELETE FROM ?? WHERE ??=?","userplants","ID",plantID)
							v:destroy()
						else
							triggerClientEvent(player,"draw:infobox",root,"error","This plant can not be harvested yet!",8000)
							--triggerClientEvent(player,"draw:infobox",root,"error","This plant needs "..math.floor(((plantIDTime-getSecTime(0))/60)*100)/100 .." hours to grow until it can be harvested!",8000)
						end
					end
				end
			end
		end
	end
end