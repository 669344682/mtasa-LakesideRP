--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//local variables
local Gate_1_Object=createObject(3055,1588.5,-1638.3,14.6,0,0,0)
local Gate_1_MovedState=false
local Gate_1_MovingState=false

--//Move gate functions
function moveLSPDgate_1(player)
	if(isSTATE(player))then
		if(getDistanceBetweenPoints3D(1589.65,-1638.4,14.5,getElementPosition(player))<10)then
			if(Gate_1_MovingState==false)then
				Gate_1_MovingState=true
				if(Gate_1_MovedState==false)then
					moveObject(Gate_1_Object,3000,1588.5,-1638.3,16.5,90,0,0)
					Gate_1_MovedState=true
					setTimer(triggerLSPDgate_1,5000,1)
				else
					moveObject(Gate_1_Object,3000,1588.5,-1638.3,14.6,-90,0,0)
					Gate_1_MovedState=false
					setTimer(triggerLSPDgate_1,5000,1)
				end
			end
		end
	end
end
addCommandHandler("gate",moveLSPDgate_1)
addCommandHandler("mv",moveLSPDgate_1)




--//Trigger gate states
function triggerLSPDgate_1()
	Gate_1_MovingState=false
end