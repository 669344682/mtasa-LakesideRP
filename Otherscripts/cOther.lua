--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("create:pisseffect",true)
addEventHandler("create:pisseffect",root,function(x,y,z,rot)
	local pissEffect=createEffect("coke_trail",x,y,z,0,0,rot,200,false)
	setTimer(function()
		pissEffect:destroy()
	end,9000,1)
end)