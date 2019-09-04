--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Hade         ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local cancel=false
local countertoenginestart=0

function startEngine(amount)
	if(isPedInVehicle(lp))then
	countertoenginestart=1
		local rdm=math.random(4,6)
		state=false
		if state==false then
			cancel=false
			setTimer(function()
				if(countertoenginestart<=rdm-1)then
					if(getKeyState("x")==true)then
						if(amount~=4)then
							triggerServerEvent("moveVehicle",lp)
						end
					else
						cancel=true
					end
					countertoenginestart=countertoenginestart+1
				else
					if(cancel==false)then
						if(amount~=4)then
							triggerServerEvent("startVehicle",lp)
						end
					end
				end
			end,480,rdm)
		end
	end
end
addEvent("start:engine",true)
addEventHandler("start:engine",lp,startEngine)

function toggleWindowsClient()
	local veh=getPedOccupiedVehicle(lp)
	if(isVehicleWindowOpen(veh,2)and isVehicleWindowOpen(veh,3)and isVehicleWindowOpen(veh,4)and isVehicleWindowOpen(veh,5))then
		setVehicleWindowOpen(veh,2,false)
		setVehicleWindowOpen(veh,3,false)
		setVehicleWindowOpen(veh,4,false)
		setVehicleWindowOpen(veh,5,false)
	else
		setVehicleWindowOpen(veh,2,true)
		setVehicleWindowOpen(veh,3,true)
		setVehicleWindowOpen(veh,4,true)
		setVehicleWindowOpen(veh,5,true)
	end
end
addCommandHandler("window",toggleWindowsClient)


addEventHandler("onClientVehicleExit",root,function(playere)
	if(playere==lp)then
		seatbeltSoundStop_Func()
	end
end)
addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==lp)then
		local id=getElementModel(source)
		if(cars[id]or lkws[id]or bus[id])then
			seatbeltSoundStart_Func()
		end
	end
end)


function getActualVelocity(element,x,y,z)
    return(x^2+y^2+z^2)^0.5
end

function updateDamage(veh)
    local c_speed=getActualVelocity(veh,getElementVelocity(veh))
	if(getElementData(veh,"veh:jobbus")==false)then
		if(c_lastspeed-c_speed>=0.25 and isElementFrozen(veh)==false)then
			if(c_lastspeed-c_speed>=0.35)then
				local vehicle=getPedOccupiedVehicle(lp)
				local x,y,z=getElementPosition(lp)
				local nx,ny,nz=nil,nil,nil
				local rz=getPedRotation(lp)
				local nx=x+math.sin(math.rad(rz))*2
				local ny=y+math.cos(math.rad(rz))*2
				local nz=getGroundPosition(nx,ny,z)
				setTimer(function()
					local bcollision,ex,ey,ez,element=processLineOfSight(x,y,z+1,nx,ny,nz+1,true,true,true,true,true,false,false,false,vehicle)
					if(bcollision)then
						local ez=getGroundPosition(ex,ey,ez)
						if(getElementData(lp,"seatbelt")==false and getVehicleType(vehicle)~="Train")then
							triggerServerEvent("crashThrowPlayerFromVehicle",vehicle,ex,ey,ez+1,vehicle)
						end
					else
						if(getElementData(lp,"seatbelt")==false and getVehicleType(vehicle)~="Train")then
							triggerServerEvent("crashThrowPlayerFromVehicle",vehicle,nx,ny,nz+1,vehicle)
						end
					end
				end,200,1)
			end
			c_lasthealth=getElementHealth(lp)-20*(c_lastspeed)
			if(c_lasthealth<=0)then
				c_lasthealth=0
			end
			setElementHealth(lp,c_lasthealth)
		end
    end
    c_lastspeed=c_speed
end

addEventHandler("onClientRender",root,function()
	if(isPedInVehicle(lp))then
		local veh=getPedOccupiedVehicle(lp)
		if(veh)then
			updateDamage(veh)
		end
	else
		c_speed=0
		c_lastspeed=0
	end
end)




function ResetRotor1_Func(heli)
	local h=tonumber(getHelicopterRotorSpeed(heli))
	if(h)then
		if(h<0.016)then
			setHelicopterRotorSpeed(heli,0)
		else
			setHelicopterRotorSpeed(heli,(h*0.935))
		end
	end
end
function ResetRotor2_Func(heli)
	local h=tonumber(getHelicopterRotorSpeed(heli))
	if(h)then
		if(h<0.22)then
			setHelicopterRotorSpeed(heli,h*1.01)
		else
			setHelicopterRotorSpeed(heli,0.22)
		end
	end
end
function ResetRotor_Func()
	local veh=getElementsByType("vehicle")
	for _,v in ipairs(veh)do
		local m=getElementModel(v)
		if((m==548)or(m==425)or(m==417)or(m==487)or(m==588)or(m==497)or(m==563)or(m==447)or(m==469)or(m==488))then
			if getVehicleEngineState(v) then
				ResetRotor2_Func(v)
			else
				ResetRotor1_Func(v)
			end
		end
	end
end
addEventHandler("onClientPreRender",root,ResetRotor_Func)