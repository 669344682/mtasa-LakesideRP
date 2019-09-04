--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

CameraFly={
	[1]={x=1481.1,y=-1723.4,z=25.4,sx=1481.1,sy=-1746,sz=17.7,text="Hello and Welcome to "..settings.general.servername..".\nLook and enjoy this Intro.",timeToNext=26000,image=":"..settings.general.scriptname.."/Files/Images/Logo.png"},
	[2]={x=1381.3,y=-1724.8,z=30.2,sx=1376.1,sy=-1687.1,sz=22,text="This is the Drivingschool.\nHere you can get all Driving-licenses.",timeToNext=20000,image=":"..settings.general.scriptname.."/Files/Images/Radar/Blips/38.png"},
	[3]={x=1102.3,y=-1360.2,z=38.7,sx=1137.6,sy=-1426.6,sz=22.4,text="This is the Veronamall.\nHere you can buy Burger and more...",timeToNext=20000,image=":"..settings.general.scriptname.."/Files/Images/Radar/Blips/10.png"},
	[4]={x=2129.4,y=-1092.1,z=41.4,sx=2127.1,sy=-1140.2,sz=24.9,text="Here is a car house. 1 of several car houses.\nHere you can buy a privatcar.",timeToNext=20000,image=":"..settings.general.scriptname.."/Files/Images/Radar/Blips/55.png"},
	[5]={x=1010.9,y=-1261.6,z=56.6,sx=914.9,sy=-1235.2,sz=29,text="Here is the Mech&Tow(Mechanic & Towing) Base.\nHere you can let us tune your car.",timeToNext=20000,image=":"..settings.general.scriptname.."/Files/Images/Radar/Blips/37.png"},
}


local Client={}

function startFlyProtect()
	if(isElement(lp))then
		setElementFrozen(lp,true)
		setElementData(lp,"introstate",true)
		setElementDimension(lp,0)
		setElementInterior(lp,0)
		local flyCam=CameraFly[1]

		local x,y,z,sx,sy,sz,text,timeToNext,image=flyCam.x,flyCam.y,flyCam.z,flyCam.sx,flyCam.sy,flyCam.sz,flyCam.text,flyCam.timeToNext,flyCam.image
		Client[lp]={}
		Client[lp].flyText=text
		Client[lp].flyImage=image
		Client[lp].sound=playSound("https://46.105.179.102/Lakeside-IntroMusic.mp3")
		setSoundVolume(Client[lp].sound,2)
				
		setCameraMatrix(x,y,z,sx,sy,sz)
		
		setTimer(lookFadeScreen,timeToNext,1,2)
		
		addEventHandler("onClientRender",root,flyText_Function)
	end
end
addEvent("start:intro",true)
addEventHandler("start:intro",root,startFlyProtect)

function nextFlyProtect(i)
	local flyCam=CameraFly[i]
	if(flyCam.x and flyCam.y and flyCam.z)then
		local x,y,z,sx,sy,sz,text,timeToNext,image=flyCam.x,flyCam.y,flyCam.z,flyCam.sx,flyCam.sy,flyCam.sz,flyCam.text,flyCam.timeToNext,flyCam.image
		Client[lp].flyText=text
		Client[lp].flyImage=image
		setCameraMatrix(x,y,z,sx,sy,sz)
		if(CameraFly[i+1])then
			setTimer(lookFadeScreen,timeToNext,1,i+1)
		else
			setTimer(finishFlyProtect,timeToNext,1)
		end
	end
end


function lookFadeScreen(i)
	local nextID=i
	fadeCamera(false)
	Client[lp].flyText=false
	setTimer(function()
		nextFlyProtect(nextID)
		fadeCamera(true)
	end,2500,1)
end

local sx, sy = guiGetScreenSize()
local rx, ry = sx/1680, sy/1050

function flyText_Function()
	if(Client[lp])then
		if(Client[lp].flyText)then
			local text=Client[lp].flyText
			dxDrawRectangle(0, sy-106, sx, sy, tocolor(0, 0, 0, 160), false)
			dxDrawText(""..text.."", 0, sy-106, sx, sy, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawImage(20, sy-100, 85,85,Client[lp].flyImage,0,0,0,tocolor(255,255,255,255),false)
			showChat(false)
		end
	end
end

function finishFlyProtect()
	removeEventHandler("onClientRender",root,flyText_Function)
	showChat(true)
	if(isElement(Client[lp].sound))then
		Client[lp].sound:destroy()
	end
	triggerServerEvent("spawn:playerafterintro",lp)
	setElementData(lp,"introstate",false)
end