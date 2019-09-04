--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--front-back-front-back  -sideinout-frontback-highdown
VehicleBlinkerTable={}
VehicleBlinkerTable[596]={{-1,2.4,-0.2},{-1.1,-2.7,-0.2},{1,2.4,-0.2},{1.1,-2.7,-0.2}}
VehicleBlinkerTable[597]={{-1,2.4,-0.2},{-1.1,-2.7,-0.2},{1,2.4,-0.2},{1.1,-2.7,-0.2}}
VehicleBlinkerTable[528]={{-1.1,2.5,-0.35},{-1.1,-2.65,-0.35},{1.1,2.5,-0.35},{1.1,-2.65,-0.35}}
VehicleBlinkerTable[490]={{-1.1,3.1,-0.25},{-1.1,-3.1,0.05},{1.1,3.1,-0.25},{1.1,-3.1,0.05}}
VehicleBlinkerTable[550]={{-1.1,2.7,-0.25},{-1.05,-2.75,-0.25},{1.1,2.7,-0.25},{1.05,-2.75,-0.25}}
VehicleBlinkerTable[585]={{-1.05,2.75,-0},{-1.05,-2.95,0.1},{1.05,2.75,-0},{1.05,-2.95,0.1}}
VehicleBlinkerTable[549]={{-1.05,2.5,-0.1},{-1.05,-2.6,-0.1},{1.05,2.5,-0.1},{1.05,-2.6,-0.1}}
VehicleBlinkerTable[496]={{-1,2.25,-0.1},{-1,-2.15,-0.1},{1,2.25,-0.1},{1,-2.15,-0.1}}
VehicleBlinkerTable[445]={{-1,2.4,-0.2},{-1,-2.8,-0.2},{1,2.4,-0.2},{1,-2.8,-0.2}}
VehicleBlinkerTable[410]={{-0.85,2.1,-0.1},{-0.9,-2.2,-0},{0.85,2.1,-0.1},{0.9,-2.2,-0}}
VehicleBlinkerTable[429]={{-0.8,2.25,-0.35},{-0.9,-2.4,-0.1},{0.8,2.25,-0.35},{0.9,-2.4,-0.1}}
VehicleBlinkerTable[560]={{-1,2.6,-0.35},{-0.9,-2.35,-0.05},{1,2.6,-0.35},{0.9,-2.35,-0.05}}
VehicleBlinkerTable[541]={{-1,2.25,-0.25},{-1,-2.25,-0.05},{1,2.25,-0.25},{1,-2.25,-0.05}}
VehicleBlinkerTable[480]={{-0.95,2.25,-0.25},{-0.9,-2.4,-0.2},{0.95,2.25,-0.25},{0.9,-2.4,-0.2}}
VehicleBlinkerTable[411]={{-1,2.55,-0.25},{-1,-2.4,-0.05},{1,2.55,-0.25},{1,-2.4,-0.05}}
VehicleBlinkerTable[415]={{-0.95,2.55,-0.25},{-0.8,-2.4,-0.05},{0.95,2.55,-0.25},{0.8,-2.4,-0.05}}
VehicleBlinkerTable[451]={{-0.9,2.2,-0.25},{-0.9,-2.45,-0.1},{0.9,2.2,-0.25},{0.9,-2.45,-0.1}}
VehicleBlinkerTable[492]={{-0.9,2.55,-0.25},{-0.9,-2.8,-0.1},{0.9,2.55,-0.25},{0.9,-2.8,-0.1}}
VehicleBlinkerTable[517]={{-1,2.7,-0.15},{-1.0,-2.75,-0.2},{1,2.7,-0.15},{1.0,-2.75,-0.2}}
VehicleBlinkerTable[420]={{-1,2.4,-0.15},{-1.0,-2.7,-0.2},{1,2.4,-0.15},{1.0,-2.7,-0.2}}
VehicleBlinkerTable[402]={{-0.9,2.3,-0.15},{-0.9,-2.7,-0.2},{0.9,2.3,-0.15},{0.9,-2.7,-0.2}}
VehicleBlinkerTable[431]={{-0.95,5.85,0.4},{-1.06,-5.75,-0.1},{0.95,5.85,0.4},{1.06,-5.75,-0.1}}


TABLE_BlinkerDefault={}
TABLE_timer={{},{},{}}

function setBlinker_func(player)
	local vehicle=getPedOccupiedVehicle(player)
	if(vehicle)then
		if(getVehicleController(vehicle)==player)then
			local vehid=getElementModel(vehicle)
			if(cars[vehid]or lkws[vehid]or bus[vehid])then
				if(not getElementData(vehicle,"blinker"))then
					setElementData(vehicle,"blinker",true)
					TABLE_BlinkerDefault[vehicle]={}
					TABLE_BlinkerDefault[vehicle][1]=createMarker(0,0,0,"cylinder",0.25,255,102,0,0)
					TABLE_BlinkerDefault[vehicle][2]=createMarker(0,0,0,"cylinder",0.25,255,102,0,0)
					TABLE_BlinkerDefault[vehicle][3]=createMarker(0,0,0,"cylinder",0.25,255,102,0,0)
					TABLE_BlinkerDefault[vehicle][4]=createMarker(0,0,0,"cylinder",0.25,255,102,0,0)
					
					attachElements(TABLE_BlinkerDefault[vehicle][1],vehicle,VehicleBlinkerTable[vehid][1][1],VehicleBlinkerTable[vehid][1][2],VehicleBlinkerTable[vehid][1][3])
					attachElements(TABLE_BlinkerDefault[vehicle][2],vehicle,VehicleBlinkerTable[vehid][2][1],VehicleBlinkerTable[vehid][2][2],VehicleBlinkerTable[vehid][2][3])
					attachElements(TABLE_BlinkerDefault[vehicle][3],vehicle,VehicleBlinkerTable[vehid][3][1],VehicleBlinkerTable[vehid][3][2],VehicleBlinkerTable[vehid][3][3])
					attachElements(TABLE_BlinkerDefault[vehicle][4],vehicle,VehicleBlinkerTable[vehid][4][1],VehicleBlinkerTable[vehid][4][2],VehicleBlinkerTable[vehid][4][3])
				end
			end				
		end
	end
end

function leftBlinker_statechange(player)
	local vehicle=getPedOccupiedVehicle(player)
	if(vehicle)then
		if getVehicleController ( vehicle ) == player then
			local id = getElementModel ( vehicle )
			if cars[id] or lkws[id] or bus[id] then
				if getElementData ( vehicle, "blinker_r") then
					setElementData ( vehicle, "blinker_r", false )
					killTimer ( TABLE_timer[2][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:right",root,false)
				elseif getElementData ( vehicle, "blinker_a" ) then
					setElementData ( vehicle, "blinker_a", false )
					killTimer ( TABLE_timer[3][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:all",root,false)
				end
				if not getElementData ( vehicle, "blinker_l" ) then
					setElementData ( vehicle, "blinker_l", true )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 255 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 255 )
					TABLE_timer[1][vehicle] = setTimer ( leftBlinker_timer, 500, 0, vehicle, 1, 2 )
					triggerClientEvent(player,"blinker:left",root,true)
				elseif getElementData ( vehicle, "blinker_l" ) then
					setElementData ( vehicle, "blinker_l", false )
					killTimer( TABLE_timer[1][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:left",root,false)
				end
			end
		end
	end
end
function leftBlinker_timer ( vehicle, vorne, hinten )
	local r,g,b,a = getMarkerColor ( TABLE_BlinkerDefault[vehicle][vorne] )
	if tonumber ( a ) == 50 then
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][vorne], 255, 102, 0, 255 )
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][hinten], 255, 102, 0, 255 )
		if(getVehicleOccupant(vehicle))then
			triggerClientEvent(getVehicleOccupant(vehicle),"blinker:left",root,true)
		end
	else
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][vorne], 255, 102, 0, 50 )
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][hinten], 255, 102, 0, 50 )
		if(getVehicleOccupant(vehicle))then
			triggerClientEvent(getVehicleOccupant(vehicle),"blinker:left",root,false)
		end
	end
end

function rightBlinker_statechange ( player )
	local vehicle = getPedOccupiedVehicle ( player )
	if vehicle then
		if getVehicleController ( vehicle ) == player then
			local id = getElementModel ( vehicle )
			if cars[id] or lkws[id] or bus[id] then
				if getElementData ( vehicle, "blinker_l" ) then
					setElementData ( vehicle, "blinker_l", false )
					killTimer( TABLE_timer[1][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:left",root,false)	
				elseif getElementData ( vehicle, "blinker_a" ) then
					setElementData ( vehicle, "blinker_a", false )
					killTimer ( TABLE_timer[3][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:all",root,false)
				end
				if not getElementData ( vehicle, "blinker_r" ) then
					setElementData ( vehicle, "blinker_r", true )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 255 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 255 )
					TABLE_timer[2][vehicle] = setTimer ( rightBlinker_timer, 500, 0, vehicle, 3, 4 )
					triggerClientEvent(player,"blinker:right",root,true)
				elseif getElementData ( vehicle, "blinker_r" ) then
					setElementData ( vehicle, "blinker_r", false )
					killTimer ( TABLE_timer[2][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:right",root,false)
				end
			end
		end
	end
end
function rightBlinker_timer ( vehicle, vorne, hinten )
	local r,g,b,a = getMarkerColor ( TABLE_BlinkerDefault[vehicle][vorne] )
	if tonumber ( a ) == 50 then
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][vorne], 255, 102, 0, 255 )
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][hinten], 255, 102, 0, 255 )
		if(getVehicleOccupant(vehicle))then
			triggerClientEvent(getVehicleOccupant(vehicle),"blinker:right",root,true)
		end
	else
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][vorne], 255, 102, 0, 50 )
		setMarkerColor ( TABLE_BlinkerDefault[vehicle][hinten], 255, 102, 0, 50 )
		if(getVehicleOccupant(vehicle))then
			triggerClientEvent(getVehicleOccupant(vehicle),"blinker:right",root,false)
		end
	end
end

-- Warnblinkanlage
function allBlinker_statechange ( player )
	local vehicle = getPedOccupiedVehicle ( player )
	if vehicle then
		if getVehicleController ( vehicle ) == player then
			local id = getElementModel ( vehicle )
			if cars[id] or lkws[id] or bus[id] then
				if getElementData ( vehicle, "blinker_l" ) then
					setElementData ( vehicle, "blinker_l", false )
					killTimer( TABLE_timer[1][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:right",root,true)
				elseif getElementData ( vehicle, "blinker_r") then
					setElementData ( vehicle, "blinker_r", false )
					killTimer ( TABLE_timer[2][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:right",root,false)
				end
				if not getElementData ( vehicle, "blinker_a" ) then
					setElementData ( vehicle, "blinker_a", true )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 255 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 255 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 255 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 255 )
					TABLE_timer[3][vehicle] = setTimer ( allBlinker_timer, 500, 0, vehicle )
					triggerClientEvent(player,"blinker:all",root,true)
				elseif getElementData ( vehicle, "blinker_a" ) then
					setElementData ( vehicle, "blinker_a", false )
					killTimer ( TABLE_timer[3][vehicle] )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][1], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][2], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][3], 255, 102, 0, 0 )
					setMarkerColor ( TABLE_BlinkerDefault[vehicle][4], 255, 102, 0, 0 )
					triggerClientEvent(player,"blinker:all",root,false)
				end
			end
		end
	end
end

function allBlinker_timer(vehicle)
	local r,g,b,a=getMarkerColor(TABLE_BlinkerDefault[vehicle][1])
	if(tonumber(a)==50)then
		setMarkerColor(TABLE_BlinkerDefault[vehicle][1],255,102,0,255)
		setMarkerColor(TABLE_BlinkerDefault[vehicle][2],255,102,0,255)
		setMarkerColor(TABLE_BlinkerDefault[vehicle][3],255,102,0,255)
		setMarkerColor(TABLE_BlinkerDefault[vehicle][4],255,102,0,255)
		if(getVehicleOccupant(vehicle))then
			triggerClientEvent(getVehicleOccupant(vehicle),"blinker:all",root,true)
		end
	else
		setMarkerColor(TABLE_BlinkerDefault[vehicle][1],255,102,0,50)
		setMarkerColor(TABLE_BlinkerDefault[vehicle][2],255,102,0,50)
		setMarkerColor(TABLE_BlinkerDefault[vehicle][3],255,102,0,50)
		setMarkerColor(TABLE_BlinkerDefault[vehicle][4],255,102,0,50)
		if(getVehicleOccupant(vehicle))then
			triggerClientEvent(getVehicleOccupant(vehicle),"blinker:all",root,false)
		end
	end
end

addEventHandler("onElementDestroy",root,function()
	if(getElementType(source)=="vehicle")then
		if(getElementData(source,"blinker_l"))then
			setElementData(source,"blinker_l",false)
			killTimer(TABLE_timer[1][source])
			destroyElement(TABLE_BlinkerDefault[source][1])
			destroyElement(TABLE_BlinkerDefault[source][2])
		elseif(getElementData(source,"blinker_r"))then
			setElementData(source,"blinker_r",false)
			killTimer(TABLE_timer[2][source])
			destroyElement(TABLE_BlinkerDefault[source][3])
			destroyElement(TABLE_BlinkerDefault[source][4])			
		elseif(getElementData(source,"blinker_a"))then
			setElementData(source,"blinker_a",false)
			killTimer(TABLE_timer[3][source])
			destroyElement(TABLE_BlinkerDefault[source][1])
			destroyElement(TABLE_BlinkerDefault[source][2])
			destroyElement(TABLE_BlinkerDefault[source][3])
			destroyElement(TABLE_BlinkerDefault[source][4])
		end
	end
end)

addEventHandler("onVehicleExplode",root,function()
	if(getElementData(source,"blinker_l"))then
		setElementData(source,"blinker_l",false)
		killTimer(TABLE_timer[1][source])
		destroyElement(TABLE_BlinkerDefault[source][1])
		destroyElement(TABLE_BlinkerDefault[source][2])
	elseif(getElementData(source,"blinker_r"))then
		setElementData(source,"blinker_r",false)
		killTimer(TABLE_timer[2][source])
		destroyElement(TABLE_BlinkerDefault[source][3])
		destroyElement(TABLE_BlinkerDefault[source][4])			
	elseif(getElementData(source,"blinker_a"))then
		setElementData(source,"blinker_a",false)
		killTimer(TABLE_timer[3][source])
		destroyElement(TABLE_BlinkerDefault[source][1])
		destroyElement(TABLE_BlinkerDefault[source][2])
		destroyElement(TABLE_BlinkerDefault[source][3])
		destroyElement(TABLE_BlinkerDefault[source][4])
	end
end)

function resetblinker(vehicle)
	if(getElementData(vehicle,"blinker_l"))then
		setElementData(vehicle,"blinker_l",false)
		killTimer(TABLE_timer[1][vehicle])
		destroyElement(TABLE_BlinkerDefault[vehicle][1])
		destroyElement(TABLE_BlinkerDefault[vehicle][2])
	elseif(getElementData(vehicle,"blinker_r"))then
		setElementData(vehicle,"blinker_r",false)
		killTimer(TABLE_timer[2][vehicle])
		destroyElement(TABLE_BlinkerDefault[vehicle][3])
		destroyElement(TABLE_BlinkerDefault[vehicle][4])			
	elseif(getElementData(vehicle,"blinker_a"))then
		setElementData(vehicle,"blinker_a",false)
		killTimer(TABLE_timer[3][vehicle])
		destroyElement(TABLE_BlinkerDefault[vehicle][1])
		destroyElement(TABLE_BlinkerDefault[vehicle][2])
		destroyElement(TABLE_BlinkerDefault[vehicle][3])
		destroyElement(TABLE_BlinkerDefault[vehicle][4])
	end
end


