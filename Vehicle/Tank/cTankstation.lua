--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:tankstation",true)
addEventHandler("open:tankstation",root,function()
	if(isLoggedin())then
		if(isPedInVehicle(lp)and getPedOccupiedVehicleSeat(lp)==0)then
			if(getElementData(lp,"ElementClicked")==false)then
				local veh=getPedOccupiedVehicle(lp)
				local model=getElementModel(veh)
				local x,y,z=getElementPosition(lp)
				local location=getZoneName(x,y,z,true)
				
				setElementVelocity(getPedOccupiedVehicle(lp),0,0,0)
				setElementFrozen(getPedOccupiedVehicle(lp),true)
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-350/2,GLOBALscreenY/2-250/2,350,250,"Tankstation - "..location,false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(324,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,350,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-350/2,GLOBALscreenY/2-250/2,350,250,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Label[1]=dgsCreateLabel(5,5,100,20,"Liter price: $"..settings.vehicle.literprice,false,Lakeside.Window[1])
				dgsSetProperty(Lakeside.Label[1],"textSize",{1.2,1.2})
				
				Lakeside.Button[2]=dgsCreateButton(5,180,165,40,"fully refuel",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				dgsCreateLabel(180,120,100,20,"Enter a liter value",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(180,135,165,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[3]=dgsCreateButton(180,180,165,40,"refuel liter",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local liters=dgsGetText(Lakeside.Edit[1])
							if(#liters>0 and isOnlyNumbers(liters)and #liters<=100)then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
								triggerServerEvent("refuel",lp,"liter",liters)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							triggerServerEvent("refuel",lp,"full",_)
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							setElementFrozen(getPedOccupiedVehicle(lp),false)
						end
					end,
				false)
			end
		end
	end
end)