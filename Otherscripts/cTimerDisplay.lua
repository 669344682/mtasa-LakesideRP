--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("show:timerui",true)
addEventHandler("show:timerui",root,function(htext,time)
	if(isTimer(cATMrobTimer))then
		killTimer(cATMrobTimer)
	end
	timer=time
	headertext=htext
	
	addEventHandler("onClientRender",root,drawTimerDisplay)
	cATMrobTimer=setTimer(function()
		timer=timer-1
		if(timer==0)then
			removeEventHandler("onClientRender",root,drawTimerDisplay)
			if(isTimer(cATMrobTimer))then killTimer(cATMrobTimer)end
		end
	end,1000,timer)
end)

function drawTimerDisplay()
	if(isLoggedin())then
		if(not(isPedDead(lp)))then
			if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
				dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,80*Gsy,tocolor(0,0,0,140),false)
				dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,21*Gsy,tocolor(0,0,0,140),false)
				dxDrawText(headertext,1725*Gsx,61.5*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT3,"center",_,_,_,false,_,_)
				dxDrawImage(820*Gsx,80*Gsy,280*Gsx,2*Gsy,":"..settings.general.scriptname.."/Files/Images/White.png",0,0,0,tocolor(150,0,0,200),false)
				dxDrawText(timer.." seconds",1725*Gsx,100*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.30*Gsx,dxFONT3,"center",_,_,_,false,_,_)
			end
		end
	end
end


addEvent("show:desktopnotify",true)
addEventHandler("show:desktopnotify",root,function(typ,text)
	createTrayNotification("Lakeside RP:\n"..text.."",typ,true)
end)