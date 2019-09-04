--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:electroUI",true)
addEventHandler("open:electroUI",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-580/2,GLOBALscreenY/2-540/2,580,540,settings.general.servername.." - Electro shop",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(554,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,580,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-580/2,GLOBALscreenY/2-540/2,580,540,255,255,255,255,Lakeside.Window[1])
				
				dgsCreateImage(10,15,65,65,":"..settings.general.scriptname.."/Files/Images/Inventory/Mobilephone.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,20,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				--[[dgsCreateImage(10,85,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,90,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,155,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,160,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,225,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,230,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,295,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,300,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,365,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,370,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(10,435,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(80,440,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,15,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,20,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,85,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,90,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,155,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,160,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,225,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,230,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,295,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,300,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,365,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,370,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(200,435,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(270,440,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(390,15,65,65,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1])
				Lakeside.Button[2]=dgsCreateButton(460,20,110,55,"Mobilephone\n$"..settings.shop.mobilephonePrice.."",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)]]
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							triggerServerEvent("buy:shopitem",lp,"Mobilephone",1)
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