--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function cancelAllDamage(attacker,weapon,bodypart,loss)
	if(attacker==lp)then
		if(not(weapon==17 and getElementModel(source)==285))then
			if(attacker and weapon and bodypart and loss)then
				if(globalTables["weaponDMG"][weapon])then
					triggerServerEvent("damageCalcServer",lp,attacker,weapon,bodypart,loss,source)
				end
			end
		end
	elseif(lp==source)then
		if(attacker and weapon and bodypart and loss)then
			if(globalTables["weaponDMG"][weapon])then
				cancelEvent()
			end
		end
	end
end
addEventHandler("onClientPlayerDamage",root,cancelAllDamage)


addEvent("render.hospital",true)
addEventHandler("render.hospital",root,function(time)
	local deathsound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Wasted.mp3",false)
	setSoundVolume(deathsound,1)
	if(isTimer(HospitalStartTimer))then
		killTimer(HospitalStartTimer)
	end
	if(isElement(Lakeside.Window[1]))then
		dgsCloseWindow(Lakeside.Window[1])
	end
	HospitalStartTimer=setTimer(function()
		showChat(false)
		setElementData(lp,"ElementClicked",true)
		if(isPedInVehicle(lp))then
			removePedFromVehicle(lp)
		end
		setCameraMatrix(1216,-1323.6,21.5,1183.5,-1323.6,17.2)
		Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-380/2,GLOBALscreenY/2-355/2,380,355,settings.general.servername.." - Hospital",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
		dgsWindowSetSizable(Lakeside.Window[1],false)
		dgsWindowSetMovable(Lakeside.Window[1],false)
		dgsCreateImage(0,0,380,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
		Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-380/2,GLOBALscreenY/2-355/2,380,355,255,255,255,255,Lakeside.Window[1])
		
		Lakeside.Label[1]=dgsCreateLabel(140,40,100,20,"there is still "..time.." seconds \nuntil you exit Hospital",false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(Lakeside.Label[1],"textSize",{1.5,1.5})
		
		dgsCreateImage(10,180,360,140,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],tocolor(0,0,0,140))
		Lakeside.Label[2]=dgsCreateLabel(140,150,100,20,"Did you know already?",false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(Lakeside.Label[2],"textSize",{1.3,1.3})
		Lakeside.Label[3]=dgsCreateLabel(140,220,100,20,globalTables["facts"][math.random(1,#globalTables["facts"])],false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(Lakeside.Label[3],"textSize",{1.2,1.2})
		
		changeTextTimer=setTimer(function()
			dgsSetText(Lakeside.Label[3],globalTables["facts"][math.random(1,#globalTables["facts"])])
		end,8000,0)
		
		HospitalTimer=setTimer(function()
			time=time-1
			dgsSetText(Lakeside.Label[1],"there is still "..time.." seconds\nuntil you exit Hospital")
			if(time==1)then
				dgsCloseWindow(Lakeside.Window[1])
				setWindowData("remove","cursor_clicked",false)
				showChat(true)
				triggerServerEvent("spawn:hospital",lp)
				if(isTimer(HospitalTimer))then
					killTimer(HospitalTimer)
				end
				if(isTimer(HospitalStartTimer))then
					killTimer(HospitalStartTimer)
				end
				if(isTimer(changeTextTimer))then
					killTimer(changeTextTimer)
				end
			end
		end,1000,time)
		if(isTimer(HospitalStartTimer))then
			killTimer(HospitalStartTimer)
		end
		
	end,6700,1)
end)