--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local CarRadioStreams={
	[0]={"Radio off",nil},
	[1]={"I Love Radio","http://stream01.iloveradio.de/iloveradio1.mp3"},
	[2]={"I Love Dance","http://stream01.iloveradio.de/iloveradio2.mp3"},
	[3]={"I Love Battle","http://stream01.iloveradio.de/iloveradio3.mp3"},
	[4]={"Noise.FM","http://noisefm.ru:8000/play_256.m3u"},
	[5]={"Dubstep.FM","https://www.dubstep.fm/listen.m3u"},
}

local id=0
local alpha=200
local text="Radio off"


addEventHandler("onClientRender",root,function()
	if(isPedInVehicle(lp))then
		if(alpha>0)then
			alpha=alpha-1
		end
		
		dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,80*Gsy,tocolor(0,0,0,alpha),false)
		dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,21*Gsy,tocolor(0,0,0,alpha),false)
		dxDrawText("Radio",1725*Gsx,61.5*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,alpha),1.00*Gsx,dxFONT3,"center",_,_,_,false,_,_)
		dxDrawImage(820*Gsx,80*Gsy,280*Gsx,2*Gsy,":"..settings.general.scriptname.."/Files/Images/White.png",0,0,0,tocolor(150,0,0,alpha),false)
		dxDrawText(text,1725*Gsx,100*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,alpha),1.30*Gsx,dxFONT3,"center",_,_,_,false,_,_)
	end
end)

bindKey("mouse_wheel_up","down",function()
	if(isPedInVehicle(lp))then
		if(id<#CarRadioStreams)then
			if(isElement(CarMusic))then
				CarMusic:destroy()
			end
			alpha=255
			id=id+1
			CarMusic=playSound(CarRadioStreams[id][2])
			text=CarRadioStreams[id][1]
		end
	end
end)
bindKey("mouse_wheel_down","down",function()
	if(isPedInVehicle(lp))then
		if(id>0)then
			if(isElement(CarMusic))then destroyElement(CarMusic)end
			id=id-1
			if(id~=0)then
				CarMusic=playSound(CarRadioStreams[id][2])
			end
			text=CarRadioStreams[id][1]
			alpha=255
		end
	end
end)

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==lp)then
		alpha=255
		if(isElement(CarMusic))then
			CarMusic:destroy()
		end
		if(id~=0)then
			CarMusic=playSound(CarRadioStreams[id][2])
		end
		RadioDestroyTimer=setTimer(function()
			if(not(isPedInVehicle(lp)))then
				if(isElement(CarMusic))then
					CarMusic:destroy()
				end
				if(isTimer(RadioDestroyTimer))then
					RadioDestroyTimer:destroy()
				end
			end
		end,50,0)
	end
end)
addEventHandler("onClientVehicleExit",root,function(player)
	if(player==lp)then
		if(isElement(CarMusic))then
			CarMusic:destroy()
		end
	end
end)
addEventHandler("onClientPlayerWasted",root,function(player)
	if(player==lp)then
		if(isElement(CarMusic))then
			CarMusic:destroy()
		end
	end
end)