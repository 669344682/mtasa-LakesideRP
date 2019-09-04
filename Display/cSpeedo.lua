--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

speedo_blinker_r=false
speedo_blinker_l=false

function drawSpeedo()
	if(isPedInVehicle(lp))then
		if(isPlayerMapVisible(lp)~=true)then
			if(getElementData(lp,"InTuninggarage")==false)then
				local veh=getPedOccupiedVehicle(lp)
				local vehfuel=getElementData(veh,"Fuel")
				local vehfuell=vehfuel
				local vehfuel=180/100*vehfuel
				local vehspeed=getElementSpeed(veh)
				local lights=getVehicleOverrideLights(veh)
				local engine=getVehicleEngineState(veh)
				local id=getElementModel(veh)
				
				if not CDN:getReady()then
					return
				end
				dxDrawImage(1640*Gsx,800*Gsy,280*Gsx,280*Gsy,"Files/Images/Speedo/Background.png",0,0,0,tocolor(255,255,255,140),false)
				dxDrawImage(1510*Gsx,915*Gsy,155*Gsx,155*Gsy,"Files/Images/Speedo/Fuel.png",0,0,0,tocolor(255,255,255,140),false)
				
				dxDrawImage(1640*Gsx,800*Gsy,280*Gsx,280*Gsy,"Files/Images/Speedo/Needle.png",vehspeed,0,0,tocolor(255,255,255,255),true)
				dxDrawImage(1510*Gsx,915*Gsy,155*Gsx,155*Gsy,"Files/Images/Speedo/FuelNeedle.png",vehfuel,0,0,tocolor(255,255,255,255),true)
				
				if(vehfuell<=15)then
					dxDrawImage(1775*Gsx,940*Gsy,25*Gsx,25*Gsy,"Files/Images/Speedo/TankWarning.png",0,0,0,tocolor(255,255,255,255),false)
				end
				
				if(getPedOccupiedVehicleSeat(lp)==0)then
					if(cars[id]or lkws[id]or bus[id])then
						if(speedo_blinker_l==true)then
							dxDrawImage(1720*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerLeft.png",0,0,0,tocolor(0,200,0,255),false)
						else
							dxDrawImage(1720*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerLeft.png",0,0,0,tocolor(255,255,255,255),false)
						end
						if(speedo_blinker_r==true)then
							dxDrawImage(1790*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerRight.png",0,0,0,tocolor(0,200,0,255),false)
						else
							dxDrawImage(1790*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerRight.png",0,0,0,tocolor(255,255,255,255),false)
						end
					end
				end
				
				if(cars[id]or lkws[id]or bus[id])then
					if(getElementData(lp,"seatbelt")==false)then
						dxDrawImage(1763*Gsx,875*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Seatbelt.png",0,0,0,tocolor(150,0,0,255),false)
					elseif(getElementData(lp,"seatbelt")==true)then
						dxDrawImage(1763*Gsx,875*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Seatbelt.png",0,0,0,tocolor(0,150,0,255),false)
					end
				end
				
				if(isVehicleLocked(veh)==true)then
					dxDrawImage(1765*Gsx,970*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/State.png",0,0,0,tocolor(0,150,0,255),false)
				elseif(isVehicleLocked(veh)==false)then
					dxDrawImage(1765*Gsx,970*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/State.png",0,0,0,tocolor(150,0,0,255),false)
				end
				
				if(lights)then
					if(lights==2)then
						dxDrawImage(1719*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Light.png",0,0,0,tocolor(0,85,200,255),false)
					else
						dxDrawImage(1719*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Light.png",0,0,0,tocolor(255,255,255,255),false)
					end
				end
				
				if(getElementData(veh,"Totalloss")==1)then
					dxDrawImage(1806*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(200,0,0,255),false)
				elseif(engine==true)then
					dxDrawImage(1806*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(200,85,0,255),false)
				elseif(engine==false)then
					dxDrawImage(1806*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(255,255,255,255),false)
				end
			end
		end
	else
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==lp)then
		removeEventHandler("onClientRender",root,drawSpeedo)
		addEventHandler("onClientRender",root,drawSpeedo)
	end
end)
addEventHandler("onClientVehicleExit",root,function(playere)
	if(playere==lp)then
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end)

function blinkerall(state)
    speedo_blinker_r=state
	speedo_blinker_l=state
	if(state==true)then
		--local sound = playSound ("sounds/indicator_on.wav", false)
		playSoundFrontEnd(38)
	else
		--local sound = playSound ("sounds/indicator_off.wav", false)
		playSoundFrontEnd(37)
	end
end
addEvent("blinker:all", true )
addEventHandler("blinker:all",root,blinkerall) 
function blinkerleft(state)
    speedo_blinker_l=state
	if(state==true)then
		--local sound = playSound ("sounds/indicator_on.wav", false)
		playSoundFrontEnd(38)
	else
		--local sound = playSound ("sounds/indicator_off.wav", false)
		playSoundFrontEnd(37)
	end
end
addEvent("blinker:left",true)
addEventHandler("blinker:left",root,blinkerleft)
function blinkerright(state)
    speedo_blinker_r=state
	if(state==true)then
		--local sound = playSound ("sounds/indicator_on.wav", false)
		playSoundFrontEnd(38)
	else
		--local sound = playSound ("sounds/indicator_off.wav", false)
		playSoundFrontEnd(37)
	end
end
addEvent("blinker:right",true)
addEventHandler("blinker:right",root,blinkerright)