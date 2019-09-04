--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:moonrocketUI",true)
addEventHandler("open:moonrocketUI",root,function(id)
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-160/2,300,160,settings.general.servername.." - Moon rocket",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-300/2,GLOBALscreenY/2-160/2,300,160,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Label[1]=dgsCreateLabel(5,10,100,20,"Here you can fly to the Moon.\nPrice: $200.000",false,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,85,290,45,"Go to the moon",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				if(id==2)then
					dgsSetText(Lakeside.Label[1],"")
					dgsSetText(Lakeside.Button[2],"Go to the earth")
				end
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							triggerServerEvent("start:moonrocket",lp,dgsGetText(Lakeside.Button[2]))
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
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

addEvent("open:moonstonedealer",true)
addEventHandler("open:moonstonedealer",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			local PickCount=0
			local MoonCount=0
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Moon dealer",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,380,215,false,Lakeside.Window[1])
			Lakeside.Tab[1]=dgsCreateTab("Moonstone",Lakeside.Tabpanel[1])
			
			Lakeside.Button[2]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[5]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Moonstone.png",false,Lakeside.Tab[1])
			Lakeside.Label[1]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[6]=dgsCreateButton(5,150,370,40,"Sell x0 $0",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Tab[2]=dgsCreateTab("Pickaxe",Lakeside.Tabpanel[1])
			
			Lakeside.Button[10]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[11]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[12]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[13]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Pickaxe.png",false,Lakeside.Tab[2])
			Lakeside.Label[2]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[2],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[16]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[16],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[2])
						triggerServerEvent("buy:pickaxe",lp,amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[13],
				function(btn,state)
					if(btn=="left" and state=="down")then
						PickCount=PickCount+2
						if(PickCount>=20)then
							PickCount=20
						end
						dgsSetText(Lakeside.Label[2],PickCount)
						dgsSetText(Lakeside.Button[16],"Buy x"..PickCount.." $"..PickCount*settings.shop.pickaxePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[12],
				function(btn,state)
					if(btn=="left" and state=="down")then
						PickCount=PickCount-2
						if(PickCount<=0)then
							PickCount=0
						end
						dgsSetText(Lakeside.Label[2],PickCount)
						dgsSetText(Lakeside.Button[16],"Buy x"..PickCount.." $"..PickCount*settings.shop.pickaxePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[11],
				function(btn,state)
					if(btn=="left" and state=="down")then
						PickCount=PickCount+1
						if(PickCount>=20)then
							PickCount=20
						end
						dgsSetText(Lakeside.Label[2],PickCount)
						dgsSetText(Lakeside.Button[16],"Buy x"..PickCount.." $"..PickCount*settings.shop.pickaxePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[10],
				function(btn,state)
					if(btn=="left" and state=="down")then
						PickCount=PickCount-1
						if(PickCount<=0)then
							PickCount=0
						end
						dgsSetText(Lakeside.Label[2],PickCount)
						dgsSetText(Lakeside.Button[16],"Buy x"..PickCount.." $"..PickCount*settings.shop.pickaxePrice)
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[6],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Label[1])
							triggerServerEvent("sell:moonstone",lp,amount)
						end
					end,
				false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							MoonCount=MoonCount+2
							if(MoonCount>=20)then
								MoonCount=20
							end
							dgsSetText(Lakeside.Label[1],MoonCount)
							dgsSetText(Lakeside.Button[6],"Sell x"..MoonCount.." $"..MoonCount*settings.shop.moonstonePrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							MoonCount=MoonCount-2
							if(MoonCount<=0)then
								MoonCount=0
							end
							dgsSetText(Lakeside.Label[1],MoonCount)
							dgsSetText(Lakeside.Button[6],"Sell x"..MoonCount.." $"..MoonCount*settings.shop.moonstonePrice)
						end
					end,
				false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						MoonCount=MoonCount+1
						if(MoonCount>=20)then
							MoonCount=20
						end
						dgsSetText(Lakeside.Label[1],MoonCount)
						dgsSetText(Lakeside.Button[6],"Sell x"..MoonCount.." $"..MoonCount*settings.shop.moonstonePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						MoonCount=MoonCount-1
						if(MoonCount<=0)then
							MoonCount=0
						end
						dgsSetText(Lakeside.Label[1],MoonCount)
						dgsSetText(Lakeside.Button[6],"Sell x"..MoonCount.." $"..MoonCount*settings.shop.moonstonePrice)
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



function rocketStart(typ)
	if(isElement(moonSmokeEffect))then
		moonSmokeEffect:destroy()
	end
	if(isTimer(moonSmokeEffectTimer))then
		moonSmokeEffectTimer:destroy()
	end
	if(typ)then
		local x,y,z=getElementPosition(lp)
		moonSmokeEffect=createEffect("riot_smoke",x,y,z)
		attachEffect(moonSmokeEffect,lp,Vector3(0,4,4))
		
		moonSmokeEffectTimer=setTimer(function()
			rocketStart("create")
		end,10000,1)
	end
end
addEvent("start:moonrocket",true)
addEventHandler("start:moonrocket",root,rocketStart)

addEvent("activate:moonfeeling",true)
addEventHandler("activate:moonfeeling",root,function(typ)
	if(typ=="create")then
		setSkyGradient(0,0,0)
	else
		resetSkyGradient()
	end
end)

addEvent("start:pickaxesound",true)
addEventHandler("start:pickaxesound",root,function(typ)
	if(isTimer(farmingPickSound))then
		farmingPickSound:destroy()
	end
	if(typ)then
		farmingPickSound=setTimer(function()
			playSound(":"..settings.general.scriptname.."/Files/Sounds/Pickaxe.wav")
		end,960,15)
	end
end)