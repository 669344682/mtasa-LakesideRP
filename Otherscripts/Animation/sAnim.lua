--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local animationListTable={
	["Fuck you"]={"ped","fucku",-1,true,true,true,nil,nil},
	["Handsup"]={"shop","SHP_HandsUp_Scr",-1,false,true,true,nil,nil},
	["Laugh"]={"rapping","Laugh_01",-1,true,false,true,nil,nil},
	["Show something"]={"on_lookers","point_loop",-1,true,false,true,nil,nil},
	["Wank"]={"PAULNMAC","wank_loop",-1,true,false,true,nil,nil},
}
local playerAnimTimer={}

addEvent("start:animation",true)
addEventHandler("start:animation",root,function(anim)
	if(animationListTable[anim])then
		if(not(isPedInVehicle(client)))then
			playerAnimTimer[client]=true
			setPedAnimation(client,animationListTable[anim][1],animationListTable[anim][2],animationListTable[anim][3],animationListTable[anim][4],animationListTable[anim][5],animationListTable[anim][6],animationListTable[anim][7],animationListTable[anim][8])
			bindKey(client,"space","down",stopPlayerAnimation)
		end
	end
end)

function stopPlayerAnimation(player)
	if(playerAnimTimer[player]==true)then
		playerAnimTimer[player]=nil
		setPedAnimation(player)
		unbindKey(player,"space","down",stopPlayerAnimation)
	end
end