--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

factionVehiclesTable={}
fraktionNames={}
fraktionNames={[0]="Civilian",[1]="LSPD",[2]="F.B.I"}


for i=1,#fraktionNames do
	factionVehiclesTable[i]={}
end


function isLSPD(player)
	if(tonumber(syncGetElementData(player,"Faction"))==1)then
		return true
	else
		return false
	end
end
function isFBI(player)
	if(tonumber(syncGetElementData(player,"Faction"))==2)then
		return true
	else
		return false
	end
end
function isGROVE(player)
	if(tonumber(syncGetElementData(player,"Faction"))==3)then
		return true
	else
		return false
	end
end
function isBALLAS(player)
	if(tonumber(syncGetElementData(player,"Faction"))==4)then
		return true
	else
		return false
	end
end

function isSTATE(player)
	if(isLSPD(player)or isFBI(player))then
		return true
	else
		return false
	end
end
function isEVIL(player)
	if(isGROVE(player)or isBALLAS(player))then
		return true
	else
		return false
	end
end

function sendMSGForFaction(text,id,r,g,b)
	if(not r)then r,g,b=255,255,255 end
	for _,v in ipairs(getElementsByType("player"))do
		if(tonumber(syncGetElementData(v,"Faction"))==id)then
			outputChatBox(text,v,r,g,b)
		end
	end
end


function getFactionMembersOnline(faction)
	local counter=0
	for _,v in pairs(getElementsByType("player"))do
		if(syncGetElementData(v,faction))then
			counter=counter+1
		end
	end
	return counter
end


function policeComputer(presser,key,state)
	if state=="down" and syncGetElementData(presser,"CopDuty")==true then
		triggerClientEvent(presser,"open:wantedpc",presser)
	end
end


addEventHandler("onVehicleStartEnter",root,function(player,seat)
	if(getPedOccupiedVehicleSeat(player)==0 or getPedOccupiedVehicleSeat(player)==1)then
		if(getElementData(source,"policecar")==true)then
			if(isSTATE(player))then
				if(not isKeyBound(player,"num_add","down",policeComputer)and syncGetElementData(player,"CopDuty")==true)then
					bindKey(player,"num_add","down",policeComputer)
				end
			end
		end
	end
end)



--//Park Function
LS_PD=createColSphere(1568.5,-1690,6,42)
LS_PD2=createColSphere(1569.6,-1629.5,13.4,32)
LS_FBI=createColSphere(1242.6,-1817.1,13.4,55)
LSGrove=createColSphere(2492.6,-1667,13.4,45)
LSBallas=createColSphere(2247.6,-1431.3,24.5,40)

function getColShapeToParkFactionVehicle(player)
    local faction=tonumber(syncGetElementData(player,"Faction"))
    if(faction==1)then
        col=LS_PD
        col2=LS_PD2
	elseif(faction==2)then
        col=LS_FBI
        col2=nil
	elseif(faction==3)then
        col=LSGrove
        col2=nil
	elseif(faction==4)then
        col=LSBallas
        col2=nil
	end
    return col,col2
end

function parkFactionVehicle(player)
	if(isPedInVehicle(player))then
		local veh=getPedOccupiedVehicle(player)
		local seat=getPedOccupiedVehicleSeat(player)
		if(seat==0)then
			local id=getElementData(veh,"ID")
			local owner=getElementData(veh,"Owner")
			local slot=tonumber(getElementData(veh,"Slot"))
			local fuel=getElementData(veh,"Fuel")
			local col,col2=getColShapeToParkFactionVehicle(player)
			local vx,vy,vz=getElementVelocity(getPedOccupiedVehicle(player))
			local speed=math.sqrt(vx^2+vy^2+vz^2)
			if(speed<5*0.00464)then
			else
				return
			end
			if(owner==tonumber(syncGetElementData(player,"Faction")))then
				if(tonumber(syncGetElementData(player,"Factionrank"))>=4)then
					if(isElementWithinColShape(player,col)or isElementWithinColShape(player,col2))then
						local x,y,z=getElementPosition(veh)
						local rx,ry,rz=getElementRotation(veh)
						
						if(owner and id)then
							handler:exec("UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=? AND ??=?","factionvehicles","SpawnX",x,"SpawnY",y,"SpawnZ",z,"RotX",rx,"RotY",ry,"RotZ",rz,"Fuel",fuel,"Owner",owner,"ID",id)
							triggerClientEvent(player,"draw:infobox",root,"success","This vehicle was successfully parked!",8000)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You can park a Faction-\nvehicle only in the base!",8000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You are not Rank Co/Leader!",8000)
				end
			end
		end
	end
end
addCommandHandler("fpark",parkFactionVehicle)


function respawnFactionVehicles()
	local faction=tonumber(syncGetElementData(client,"Faction"))
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",faction),-1)
	if(result or result[1])then
		if(tonumber(result[1]["Money"])>=tonumber(2500))then
			if(faction==3)then
				for i,v in ipairs(getElementsByType("vehicle"))do
					if(not getVehicleOccupant(v))then
						if(getElementData(v,"Owner")==faction)then
							respawnVehicle(v)
						end
					end
				end
			end
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-2500,"Faction",faction)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","So much money is not in the cash register! ($2500)",8000)
		end
	end
end
addEvent("respawn:factionvehicles",true)
addEventHandler("respawn:factionvehicles",root,respawnFactionVehicles)





