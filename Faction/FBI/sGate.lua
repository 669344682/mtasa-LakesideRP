--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//local variables
local Gate_1_Object=createObject(988,1210.6,-1837,13.4,0,0,0)
local Gate_2_Object=createObject(988,1216.1,-1837,13.4,0,0,0)
local Gate_1_MovedState=false
local Gate_1_MovingState=false

--//Move gate functions
function moveFBIgate_1(player)
	if(isSTATE(player))then
		if(getDistanceBetweenPoints3D(1213.3,-1837,13.4,getElementPosition(player))<10)then
			if(Gate_1_MovingState==false)then
				Gate_1_MovingState=true
				if(Gate_1_MovedState==false)then
					moveObject(Gate_1_Object,3000,1205.6,-1837,13.4,0,0,0)
					moveObject(Gate_2_Object,3000,1221.1,-1837,13.4,0,0,0)
					Gate_1_MovedState=true
					setTimer(triggerFBIgate_1,5000,1)
				else
					moveObject(Gate_1_Object,3000,1210.6,-1837,13.4,0,0,0)
					moveObject(Gate_2_Object,3000,1216.1,-1837,13.4,0,0,0)
					Gate_1_MovedState=false
					setTimer(triggerFBIgate_1,5000,1)
				end
			end
		end
	end
end
addCommandHandler("gate",moveFBIgate_1)
addCommandHandler("mv",moveFBIgate_1)




--//Trigger gate states
function triggerFBIgate_1()
	Gate_1_MovingState=false
end