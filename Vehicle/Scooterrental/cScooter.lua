--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:vehiclerental",true)
addEventHandler("open:vehiclerental",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-350/2,GLOBALscreenY/2-250/2,350,250,settings.general.servername.." - Scooter rental",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(324,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,350,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-350/2,GLOBALscreenY/2-250/2,350,250,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Image[1]=dgsCreateImage(5,5,340,170,":"..settings.general.scriptname.."/Files/Images/UI/ScooterBG.png",false,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,180,340,40,"Rent a scooter ($"..settings.vehicle.rentPrice..")",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							triggerServerEvent("rent:vehicle",lp)
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
						end
					end,
				false)
			end
		end
	end
end)