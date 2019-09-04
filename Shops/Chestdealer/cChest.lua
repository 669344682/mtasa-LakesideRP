--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:chestdealer",true)
addEventHandler("open:chestdealer",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Chest dealer",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,255,255,255,255,Lakeside.Window[1])
			
			dgsCreateImage(35,15,150,150,":"..settings.general.scriptname.."/Files/Images/Inventory/ChestWood.png",false,Lakeside.Window[1])
			dgsCreateImage(215,15,150,150,":"..settings.general.scriptname.."/Files/Images/Inventory/ChestIron.png",false,Lakeside.Window[1])
			
			Lakeside.Button[2]=dgsCreateButton(35,180,150,40,"Buy this chest\n(x1 Bronze ticket)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(215,180,150,40,"Buy this chest\n(x1 Silver ticket)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:shopitem",lp,"ChestIron",1)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:shopitem",lp,"ChestWood",1)
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
end)