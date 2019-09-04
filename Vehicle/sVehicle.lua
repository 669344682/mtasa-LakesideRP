--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Tables
VehicleSoundNEW={
[411]=true,
[415]=true,
[451]=true,
[560]=true,
[541]=true,
[480]=true,
[494]=true,
[502]=true,
[503]=true,
[402]=true,
[429]=true,
[477]=true,
}

VehicleSoundBIKE={
[522]=true,
[521]=true,
[461]=true,
[581]=true,
[463]=true,
}

VehicleSoundLKW={
[403]=true,
[406]=true,
[407]=true,
[408]=true,
[414]=true,
[431]=true,
[437]=true,
[443]=true,
[455]=true,
[456]=true,
[514]=true,
[515]=true,
[524]=true,
[544]=true,
[578]=true,
}

function setSeatbeltState(player,typ)
	if(typ=="true")then
		setElementData(player,"seatbelt",true)
		triggerClientEvent(player,"stop:seatbeltsound",player)
		triggerClientEvent(player,"start:seatbeltclicksound",player)
	elseif(typ=="false")then
		setElementData(player,"seatbelt",false)
		triggerClientEvent(player,"start:seatbeltsound",player)
	end
end

function Seatbelt_Func(player,key,state)
	local veh=getPedOccupiedVehicle(player)
	if(veh and isPedInVehicle(player))then
		if(getElementData(player,"seatbelt")==true)then
			setSeatbeltState(player,"false")
		else
			setSeatbeltState(player,"true")
		end
	end
end

--//Light Function
function Light_Func(player,key,state)
	if(getPedOccupiedVehicleSeat(player)==0)then
		local veh=getPedOccupiedVehicle(player)
		if(getVehicleOverrideLights(veh)~=2)then
			veh:setOverrideLights(2)
			setElementData(veh,"light",true)
		else
			veh:setOverrideLights(1)
			setElementData(veh,"light",false)
		end
	end
end

function lockVehicle(player)
	if(player:getDimension()==0 and player:getInterior()==0)then
		for _,v in pairs(getElementsByType("vehicle"))do
			if(getElementData(v,"Owner")==getPlayerName(player)or getElementData(v,"Owner")==tonumber(syncGetElementData(player,"Faction"))or getElementData(v,"Owner")==tonumber(syncGetElementData(player,"Company")))then
				if(getElementDimension(v)==getElementDimension(player))then
					local x,y,z=getElementPosition(v)
					local occupants=(getVehicleOccupants(v)or{})
					if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=3.2)then
						if(isVehicleLocked(v)==false)then
							setVehicleLocked(v,true)
							triggerClientEvent(player,"draw:infobox",root,"info","Vehicle was locked!",7500)
							if(x)and(y)and(z)then
								if(isPedInVehicle(player))then
									for i,_ in pairs(occupants)do
										triggerClientEvent(occupants[i],"playSound_mp3",root,"Vehicle/Carlock_In","mp3",false,1)
									end
								else
									triggerClientEvent(root,"playSound3D_mp3",root,player,"Vehicle/Carlock_Out",x,y,z,false,1)
								end
							end
						else
							setVehicleLocked(v,false)
							triggerClientEvent(player,"draw:infobox",root,"info","Vehicle was unlocked!",7500)
							if(x)and(y)and(z)then
								if(isPedInVehicle(player))then
									for i,_ in pairs(occupants)do
										triggerClientEvent(occupants[i],"playSound_mp3",root,"Vehicle/Carunlock_In","mp3",false,1)
									end
								else
									triggerClientEvent(root,"playSound3D_mp3",root,player,"Vehicle/Carlock_Out",x,y,z,false,1)
								end
							end
						end
					end
				end
			end
		end
	end
end

function parkVehicle(player)
	if(isPedInVehicle(player))then
		local veh=getPedOccupiedVehicle(player)
		local seat=getPedOccupiedVehicleSeat(player)
		if(seat==0)then
			local owner=getElementData(veh,"Owner")
			local slot=tonumber(getElementData(veh,"Slot"))
			local fuel=getElementData(veh,"Fuel")
			local vx,vy,vz=getElementVelocity(getPedOccupiedVehicle(player))
			local speed=math.sqrt(vx^2+vy^2+vz^2)
			if(speed<5*0.00464)then
			else
				return
			end
			if(owner==getPlayerName(player))then
				local x,y,z=getElementPosition(veh)
				local rx,ry,rz=getElementRotation(veh)
				
				if(owner and slot)then
					handler:exec("UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=? AND ??=?","uservehicles","SpawnX",x,"SpawnY",y,"SpawnZ",z,"RotX",rx,"RotY",ry,"RotZ",rz,"Fuel",fuel,"Owner",owner,"Slot",slot)
					triggerClientEvent(player,"draw:infobox",root,"success","Your vehicle was successfully parked!",8000)
				end
			end
		end
	end
end
addCommandHandler("park",parkVehicle)

--//Engine Function
function Engine_Func(player,key,state)
	local veh=getPedOccupiedVehicle(player)
	if(isPedInVehicle(player))then
	local rdm=math.random(1,16)
		if(getPedOccupiedVehicleSeat(player)==0)then
		if getElementData(veh,"motorworking")==true then return end
			local x,y,z=getElementPosition(veh)
			local enginestate=getVehicleEngineState(veh)
			if(not getElementData(veh,"Fuel"))then
				setElementData(veh,"Fuel",100)
				setElementData(veh,"engine",false)
				setElementData(veh,"light",false)
				veh:setEngineState(false)
				veh:setOverrideLights(1)
			end
			if(getVehicleEngineState(veh))then
				setElementData(veh,"engine",false)
				veh:setEngineState(false)
				triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_Stop",x,y,z,false)
			elseif(getElementData(veh,"Owner")==getPlayerName(player))then
				if(tonumber(getElementData(veh,"Fuel"))>=2)then
					if(tonumber(getElementData(veh,"Totalloss"))==0)then
						if(rdm==4)then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
						else
							if VehicleSoundNEW[getElementModel(veh)]then
								triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
							elseif VehicleSoundBIKE[getElementModel(veh)]then
								triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
							elseif VehicleSoundLKW[getElementModel(veh)]then
								triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
							else
								triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
							end
						end
						if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
							if(rdm~=4)then
								setElementData(veh,"motorworking",true)
								setTimer(function()
									setElementData(veh,"motorworking",false)
									setElementData(veh,"engine",true)
									veh:setEngineState(true)
									if not getElementData(veh,"timerrunning")then
										setElementData(veh,"timerrunning",true)
										setVehicleNewFuelState(veh)
									end
								end,2000,1)
							end
						else
							triggerClientEvent(player,"start:engine",player,rdm)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","This vehicle is broken, buy a repairkit to repair it!",8000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","The vehicle has no more fuel!",8000)
				end
			elseif(getElementData(veh,"Owner")==tonumber(syncGetElementData(player,"Faction")))then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if VehicleSoundNEW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif VehicleSoundBIKE[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif VehicleSoundLKW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
									setVehicleNewFuelState(veh)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			elseif(getElementData(veh,"Owner")==tonumber(syncGetElementData(player,"Company")))then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if VehicleSoundNEW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif VehicleSoundBIKE[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif VehicleSoundLKW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
									setVehicleNewFuelState(veh)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			elseif(getElementData(veh,"Owner")==2 and getElementData(player,"inpruefung")==true)then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if VehicleSoundNEW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif VehicleSoundBIKE[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif VehicleSoundLKW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
									setVehicleNewFuelState(veh)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			elseif(not getElementData(veh,"Owner"))then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if VehicleSoundNEW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif VehicleSoundBIKE[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif VehicleSoundLKW[getElementModel(veh)]then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			end
		end
	end
end

function startVehicle(veh)
local veh=getPedOccupiedVehicle(source)
	if(veh)then
		setElementData(veh,"motorworking",true)
		setElementData(veh,"motorworking",false)
		veh:setEngineState(true)
		setElementData(veh,"engine",true)
		if not getElementData(veh,"timerrunning")then
			setElementData(veh,"timerrunning",true)
			setVehicleNewFuelState(veh)
		end
	end
end
addEvent("startVehicle",true)
addEventHandler("startVehicle",root,startVehicle)

function moveVehicle(veh)
local veh=getPedOccupiedVehicle(source)
	if(veh)then
		local rotX,rotY,rotZ=getElementRotation(veh)
		setElementAngularVelocity(veh,math.random(-2,2)/100,math.random(-2,2)/100,math.random(-1,1)/100)
	end
end
addEvent("moveVehicle",true)
addEventHandler("moveVehicle",root,moveVehicle)

addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if(seat==0)then
		if(not getElementData(veh,"engine"))then
			setElementData(veh,"engine",false)
			veh:setEngineState(false)
		end
		if(getElementType(source)=="player")then
			if(not isKeyBound(source,"x","down",Engine_Func))then
				bindKey(source,"x","down",Engine_Func,"Engine an/aus")
			end
			if(not isKeyBound(source,"l","down",Light_Func))then
				bindKey(source,"l","down",Light_Func,"Light an/aus")
			end
			local id=getElementModel(veh)
			if(cars[id]or lkws[id]or bus[id])then
				if(not isKeyBound(source,"z","down",Seatbelt_Func))then
					bindKey(source,"z","down",Seatbelt_Func)
				end
			end
			if(not isKeyBound(source,"num_1","down",leftBlinker_statechange))then
				bindKey(source,"num_1","down",leftBlinker_statechange)
			end
			if(not isKeyBound(source,"num_3","down",rightBlinker_statechange))then
				bindKey(source,"num_3","down",rightBlinker_statechange)
			end
			if(not isKeyBound(source,"num_2","down",allBlinker_statechange))then
				bindKey(source,"num_2","down",allBlinker_statechange)
			end
			setBlinker_func(source)
		end
		
		local owner=getElementData(veh,"Owner")
		local slot=tonumber(getElementData(veh,"Slot"))
		local fuel=getElementData(veh,"Fuel")
		local totalloss=getElementData(veh,"Totalloss")
		local health=getElementHealth(veh)
		if(owner and slot)then
			handler:exec("UPDATE ?? SET ??=?,??=?,??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"Health",health,"Totalloss",totalloss,"Owner",owner,"Slot",slot)
		end
	elseif(seat==1 or seat==2 or seat==3)then
		local id=getElementModel(veh)
		if(cars[id]or lkws[id]or bus[id])then
			if(getElementType(source)=="player")then
				if(not isKeyBound(source,"z","down",Seatbelt_Func))then
					bindKey(source,"z","down",Seatbelt_Func)
				end
			end
		end
	end
end)
addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		local id=getElementData(veh,"ID")
		local owner=getElementData(veh,"Owner")
		local slot=tonumber(getElementData(veh,"Slot"))
		local fuel=getElementData(veh,"Fuel")
		local totalloss=getElementData(veh,"Totalloss")
		local health=getElementHealth(veh)
		if(owner and slot)then
			handler:exec("UPDATE ?? SET ??=?,??=?,??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"Health",health,"Totalloss",totalloss,"Owner",owner,"Slot",slot)
		elseif(owner==tonumber(syncGetElementData(source,"Faction"))and id)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","factionvehicles","Fuel",fuel,"Owner",owner,"ID",id)
		elseif(owner==tonumber(syncGetElementData(source,"Company"))and id)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","companyvehicles","Fuel",fuel,"Owner",owner,"ID",id)
		end
		if(getElementType(source)=="player")then
			if(not isKeyBound(source,"x","down",Engine_Func))then
				unbindKey(source,"x","down",Engine_Func)
			end
			if(not isKeyBound(source,"l","down",Light_Func))then
				unbindKey(source,"l","down",Light_Func)
			end
			if(not isKeyBound(source,"z","down",Seatbelt_Func))then
				unbindKey(source,"z","down",Seatbelt_Func)
			end
			if(not isKeyBound(source,"num_1","down",leftBlinker_statechange))then
				unbindKey(source,"num_1","down",leftBlinker_statechange)
			end
			if(not isKeyBound(source,"num_3","down",rightBlinker_statechange))then
				unbindKey(source,"num_3","down",rightBlinker_statechange)
			end
			if(not isKeyBound(source,"num_2","down",allBlinker_statechange))then
				unbindKey(source,"num_2","down",allBlinker_statechange)
			end
		end
	elseif(seat==1 or seat==2 or seat==3)then
		if(getElementType(source)=="player")then
			if(not isKeyBound(source,"z","down",Seatbelt_Func))then
				unbindKey(source,"z","down",Seatbelt_Func)
			end
		end
	end
end)
function remSeatbelt_Func(player)
	if(getElementData(player,"seatbelt")==true)then
		setElementData(player,"seatbelt",false)
	end
end
addEventHandler("onVehicleStartExit",root,remSeatbelt_Func)



--//Fueltimer Function
function setVehicleNewFuelState(veh)
	if(isElement(veh))then
		if(getVehicleEngineState(veh)==true)then
			vehfactor=450
			if(vehfactor)then
				local speed=getElementSpeed(veh)
				if(VehicleSoundNEW[getElementModel(veh)])then
					if(speed>=0)then
						speed=getElementSpeed(veh)/vehfactor+0.10
					elseif(speed>=15)then
						speed=getElementSpeed(veh)/vehfactor+0.30
					elseif(speed>=45)then
						speed=getElementSpeed(veh)/vehfactor+0.45
					elseif(speed>=100)then
						speed=getElementSpeed(veh)/vehfactor+0.55
					elseif(speed>=160)then
						speed=getElementSpeed(veh)/vehfactor+0.65
					end
				else
					if(speed>=0)then
						speed=getElementSpeed(veh)/vehfactor+0.25
					elseif(speed>=15)then
						speed=getElementSpeed(veh)/vehfactor+0.40
					elseif(speed>=45)then
						speed=getElementSpeed(veh)/vehfactor+0.52
					elseif(speed>=100)then
						speed=getElementSpeed(veh)/vehfactor+0.60
					elseif(speed>=160)then
						speed=getElementSpeed(veh)/vehfactor+0.68
					end
				end
				
				local newFuel=tonumber(getElementData(veh,"Fuel"))-speed
				setElementData(veh,"Fuel",newFuel)
				if(getElementData(veh,"Fuel")<1)then
					saveBenzinForPrivVeh(veh)
					veh:setEngineState(false)
					setElementData(veh,"engine",false)
					setElementData(veh,"timerrunning",false)
				elseif math.floor(getElementData(veh,"Fuel"))/5==math.floor(getElementData(veh,"Fuel")/5)then
					saveBenzinForPrivVeh(veh)
					setTimer(setVehicleNewFuelState,8000,1,veh)
				else
					setTimer(setVehicleNewFuelState,8000,1,veh)
				end
			end
		else
			setElementData(veh,"timerrunning",false)
		end
	end
end
function saveBenzinForPrivVeh(veh)
	local owner=getElementData(veh,"Owner")
	local slot=getElementData(veh,"Slot")
	local fuel=getElementData(veh,"Fuel")
	local totalloss=getElementData(veh,"Totalloss")
	local health=getElementHealth(veh)
	if(owner and slot)then
		handler:exec("UPDATE ?? SET ??=?,??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"Health",health,"Totalloss",totalloss,"Owner",pname,"Slot",slot)
	end
end












addEventHandler("onVehicleDamage",root,function(loss)
	if(isElement(source))then
		--[[if(not source:getOccupant(0))then
			if(source:getHealth(loss)>1000)then
				source:setHealth(1000)
			else
				source:setHealth(source:getHealth()+loss)
			end
		end]]
		if(source:getOccupant(0))then
			source:setHealth(source:getHealth()-loss)
		else
			if(source:getHealth(loss)>1000)then
				source:setHealth(1000)
			else
				source:setHealth(source:getHealth()+loss)
			end
		end
		if(getElementData(source,"Owner")and getElementData(source,"Slot"))then
			if((getElementHealth(source)-loss)<=280)then
				setTotalloss(source)
			end
		end
	end
end)
function setTotalloss(veh)
    if(veh)then
		setElementHealth(veh,275)
		setVehicleDamageProof(veh,true)
        setVehicleEngineState(veh,false)
        setElementData(veh,"engine",false)
		setElementData(veh,"Totalloss",1)
		local driver=getVehicleOccupant(veh)
		if(driver)then
			outputChatBox("This vehicle has a write-off. Continue driving is impossible!",driver,255,255,0)
			outputChatBox("Buy a Repairkit in a Shop.",driver,255,255,0)
		end
		handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Totalloss",1,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
    end
end


local respawntime=25000
addEventHandler("onVehicleExplode",root,function()
	if(isElement(source))then
		if(getElementData(source,"Owner")and getElementData(source,"Slot"))then
			toggleVehicleRespawn(source,true)
			setVehicleRespawnDelay(source,respawntime)
		elseif(getElementData(source,"Owner"))then
			toggleVehicleRespawn(source,true)
			setVehicleRespawnDelay(source,respawntime)
		else
			source:destroy()
		end
	end
end)

function throwPlayerThroughWindow(x,y,z)  
    if(isVehicleLocked(source))then
        setVehicleLocked(source,false)
    end
    removePedFromVehicle(client,vehicle)
    setElementPosition(client,x,y,z)
    setPedAnimation(client,"CRACK","crckdeth2",15000,true,false,false)
    setTimer(setPedAnimation,15005,1,client)
end
addEvent("crashThrowPlayerFromVehicle",true)
addEventHandler("crashThrowPlayerFromVehicle",root,throwPlayerThroughWindow)

local locateBlipTimer={}
addEvent("locate:pivvehicle",true)
addEventHandler("locate:pivvehicle",root,function(slot)
	local pname=getPlayerName(client)
	if(slot)then
		if(isElement(Vehicles[pname..slot]))then
			if(getElementData(Vehicles[pname..slot],"Towed")==0)then
				if(not isTimer(locateBlipTimer[client]))then
					if(not isElement(locateBlip))then
						local x,y,z=getElementPosition(Vehicles[pname..slot])
						locateBlip=createBlip(x,y,z,0,2.5,255,0,0,255,0,99999.0,client)
						
						locateBlipTimer[client]=setTimer(function()
							locateBlip:destroy()
							if(isTimer(locateBlipTimer[client]))then
								locateBlipTimer[client]:destroy()
							end
						end,15000,1)
					end
				end
			end
		end
	end
end)

function openVehpanel(player)
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","Owner",getPlayerName(player)),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["VehID"]),v["Slot"],v["Totalloss"]})
		end
		triggerClientEvent(player,"open:uservehpanel",player,tbl)
	else
		triggerClientEvent(player,"draw:infobox",root,"error","You do have not a Vehicle!",8000)
	end
end