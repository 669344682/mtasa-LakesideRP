--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:burgershotUI",true)
addEventHandler("open:burgershotUI",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				local BurgerCount=0
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Burgershot",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,380,215,false,Lakeside.Window[1])
				Lakeside.Tab[1]=dgsCreateTab("Burger",Lakeside.Tabpanel[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[4]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[5]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Burger.png",false,Lakeside.Tab[1])
				Lakeside.Label[1]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
				
				Lakeside.Button[6]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				Lakeside.Tab[1]=dgsCreateTab("more soon...",Lakeside.Tabpanel[1])
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[6],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Label[1])
							triggerServerEvent("buy:shopitem",lp,"Burger",amount)
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							BurgerCount=BurgerCount+2
							if(BurgerCount>=20)then
								BurgerCount=20
							end
							dgsSetText(Lakeside.Label[1],BurgerCount)
							dgsSetText(Lakeside.Button[6],"Buy x"..BurgerCount.." $"..BurgerCount*settings.shop.burgerPrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							BurgerCount=BurgerCount-2
							if(BurgerCount<=0)then
								BurgerCount=0
							end
							dgsSetText(Lakeside.Label[1],BurgerCount)
							dgsSetText(Lakeside.Button[6],"Buy x"..BurgerCount.." $"..BurgerCount*settings.shop.burgerPrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							BurgerCount=BurgerCount+1
							if(BurgerCount>=20)then
								BurgerCount=20
							end
							dgsSetText(Lakeside.Label[1],BurgerCount)
							dgsSetText(Lakeside.Button[6],"Buy x"..BurgerCount.." $"..BurgerCount*settings.shop.burgerPrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							BurgerCount=BurgerCount-1
							if(BurgerCount<=0)then
								BurgerCount=0
							end
							dgsSetText(Lakeside.Label[1],BurgerCount)
							dgsSetText(Lakeside.Button[6],"Buy x"..BurgerCount.." $"..BurgerCount*settings.shop.burgerPrice)
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