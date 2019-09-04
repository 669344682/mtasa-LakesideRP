--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:normalshopUI",true)
addEventHandler("open:normalshopUI",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-580/2,GLOBALscreenY/2-540/2,580,540,settings.general.servername.." - 24/7 Shop",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(554,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,580,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-580/2,GLOBALscreenY/2-540/2,580,540,255,255,255,255,Lakeside.Window[1])
				
				dgsCreateImage(10,15,65,65,":"..settings.general.scriptname.."/Files/Images/Inventory/Repairkit.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,20,110,55,"Repairkit\n$"..settings.shop.repairkitPrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,85,65,65,":"..settings.general.scriptname.."/Files/Images/Inventory/Cola.png",false,Lakeside.Window[1])
				Lakeside.Button[3]=dgsCreateButton(80,90,110,55,"Cola\n$"..settings.shop.colaPrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,155,65,65,":"..settings.general.scriptname.."/Files/Images/Inventory/Cigarette.png",false,Lakeside.Window[1])
				Lakeside.Button[4]=dgsCreateButton(80,160,110,55,"Cigarette\n$"..settings.shop.cigarettePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,225,65,65,":"..settings.general.scriptname.."/Files/Images/Inventory/AppleSeeds.png",false,Lakeside.Window[1])
				Lakeside.Button[5]=dgsCreateButton(80,230,110,55,"Apple seeds\n$"..settings.shop.appleseedPrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				dgsCreateLabel(7,450,100,10,"Enter a amount to buy a item x4 or more",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(5,465,570,45,"1",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=tonumber(dgsGetText(Lakeside.Edit[1]))
							if(amount~="" and amount>=1)then
								triggerServerEvent("buy:shopitem",lp,"AppleSeeds",amount)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=tonumber(dgsGetText(Lakeside.Edit[1]))
							if(amount~="" and amount>=1)then
								triggerServerEvent("buy:shopitem",lp,"Cigarette",amount)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=tonumber(dgsGetText(Lakeside.Edit[1]))
							if(amount~="" and amount>=1)then
								triggerServerEvent("buy:shopitem",lp,"Cola",amount)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=tonumber(dgsGetText(Lakeside.Edit[1]))
							if(amount~="" and amount>=1)then
								triggerServerEvent("buy:shopitem",lp,"Repairkit",amount)
							end
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