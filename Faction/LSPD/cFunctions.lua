--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function cTazer_Func(attacker,weapon)
	if(attacker and weapon==23)then
		if(getElementData(attacker,"Faction")==1 or getElementData(attacker,"Faction")==2)then
			triggerServerEvent("tazer:target",lp)
			cancelEvent()
		end
	end
end
addEventHandler("onClientPlayerDamage",lp,cTazer_Func)

addEvent("open:dutyUI",true)
addEventHandler("open:dutyUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			if(not isElement(Lakeside.Window[1]))then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-250/2,GLOBALscreenY/2-300/2,250,300,"SAPD - Duty",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(224,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,250,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-250/2,GLOBALscreenY/2-300/2,250,300,255,255,255,255,Lakeside.Window[1])
				
				dgsCreateImage(85,10,80,100,":"..settings.general.scriptname.."/Files/Images/FactionLogo/SAPD.png",false,Lakeside.Window[1])
				
				
				Lakeside.Button[2]=dgsCreateButton(5,125,240,45,"Go duty",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(5,175,240,45,"Go off-duty",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[4]=dgsCreateButton(5,225,240,45,"Armory",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",false)
							openStaatArmoryUI()
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							triggerServerEvent("go:onoffduty",lp,"Offduty")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							triggerServerEvent("go:onoffduty",lp,"Onduty")
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

function openStaatArmoryUI()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(not isElement(Lakeside.Window[1]))then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-405/2,GLOBALscreenY/2-460/2,405,460,settings.general.servername.." - Staat-shop",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(0,-25,26,25,"<-",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					Lakeside.Button[2]=dgsCreateButton(379,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsSetProperty(Lakeside.Button[2],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,405,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-405/2,GLOBALscreenY/2-460/2,405,460,255,255,255,255,Lakeside.Window[1])
					
					Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,385,415,false,Lakeside.Window[1])
					Lakeside.Tab[1]=dgsCreateTab("Guns",Lakeside.Tabpanel[1])
					
					Lakeside.Image[1]=dgsCreateImage(5,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/22.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[2]=dgsCreateImage(100,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/24.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[3]=dgsCreateImage(195,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/29.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[4]=dgsCreateImage(290,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/30.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[5]=dgsCreateImage(5,210,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/31.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[6]=dgsCreateImage(100,210,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/34.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					
					
					Lakeside.Button[3]=dgsCreateButton(5,100,90,40,"Buy this weapon",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[4]=dgsCreateButton(5,145,90,40,"Buy 1 magazin",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[5]=dgsCreateButton(100,100,90,40,"Buy this weapon",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[6]=dgsCreateButton(100,145,90,40,"Buy 1 magazin",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[7]=dgsCreateButton(195,100,90,40,"Buy this weapon",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[8]=dgsCreateButton(195,145,90,40,"Buy 1 magazin",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[9]=dgsCreateButton(290,100,90,40,"Buy this weapon",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[10]=dgsCreateButton(290,145,90,40,"Buy 1 magazin",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					Lakeside.Button[11]=dgsCreateButton(5,305,90,40,"Buy this weapon",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[12]=dgsCreateButton(5,350,90,40,"Buy 1 magazin",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[13]=dgsCreateButton(100,305,90,40,"Buy this weapon",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[14]=dgsCreateButton(100,350,90,40,"Buy 1 magazin",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[20]=dgsCreateButton(290,350,90,40,"Buy 1 Armor\n$100",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[20],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"armor")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[14],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"sniper")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[13],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,"sniper",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[12],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"m4")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[11],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,"m4",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[10],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"ak")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[9],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,"ak",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[8],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"mp5")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[7],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,"mp5",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[6],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"deagle")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,"deagle",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,_,"colt45")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:staatweapons",lp,"colt45",_)
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="up")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",false)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",false)
								triggerEvent("open:dutyUI",lp)
							end
						end,
					false)
				end
			end
		end
	end
end