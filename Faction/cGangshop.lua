--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("shop:gangUI",true)
addEventHandler("shop:gangUI",root,function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(not isPedInVehicle(lp))then
				if(getElementData(lp,"ElementClicked")==false)then
					setWindowData("add","cursor_clicked",true)
					dgsSetInputMode("no_binds")
					dgsSetInputMode("no_binds_when_editing")
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-405/2,GLOBALscreenY/2-460/2,405,460,settings.general.servername.." - Gang-shop",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(379,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
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
					
					
					Lakeside.Button[2]=dgsCreateButton(5,100,90,40,"Buy this weapon\n$"..settings.faction.weaponprices.colt45.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(5,145,90,40,"Buy 1 magazin\n$"..settings.faction.weaponprices.ammo.colt45.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[4]=dgsCreateButton(100,100,90,40,"Buy this weapon\n$"..settings.faction.weaponprices.deagle.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[5]=dgsCreateButton(100,145,90,40,"Buy 1 magazin\n$"..settings.faction.weaponprices.ammo.deagle.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[6]=dgsCreateButton(195,100,90,40,"Buy this weapon\n$"..settings.faction.weaponprices.mp5.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[7]=dgsCreateButton(195,145,90,40,"Buy 1 magazin\n$"..settings.faction.weaponprices.ammo.mp5.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[8]=dgsCreateButton(290,100,90,40,"Buy this weapon\n$"..settings.faction.weaponprices.ak.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[9]=dgsCreateButton(290,145,90,40,"Buy 1 magazin\n$"..settings.faction.weaponprices.ammo.ak.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					Lakeside.Button[10]=dgsCreateButton(5,305,90,40,"Buy this weapon\n$"..settings.faction.weaponprices.m4.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[11]=dgsCreateButton(5,350,90,40,"Buy 1 magazin\n$"..settings.faction.weaponprices.ammo.m4.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[12]=dgsCreateButton(100,305,90,40,"Buy this weapon\n$"..settings.faction.weaponprices.sniper.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[13]=dgsCreateButton(100,350,90,40,"Buy 1 magazin\n$"..settings.faction.weaponprices.ammo.sniper.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[20]=dgsCreateButton(290,350,90,40,"Buy 1 Armor\n$100",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					Lakeside.Tab[2]=dgsCreateTab("Skins",Lakeside.Tabpanel[1])
					
					if(getElementData(lp,"Faction")==4)then
						if(syncClientGetElementData("Gender")=="Female")then
							dgsCreateImage(5,5,180,300,":"..settings.general.scriptname.."/Files/Images/Skin/13.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							--dgsCreateImage(200,5,180,320,":"..settings.general.scriptname.."/Files/Images/Skin/101.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							
							Lakeside.Button[20]=dgsCreateButton(5,310,180,80,"Choose this skin",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[20],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,13)
									end
								end,
							false)
						elseif(syncClientGetElementData("Gender")=="Male")then
							dgsCreateImage(5,5,180,300,":"..settings.general.scriptname.."/Files/Images/Skin/102.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							
							Lakeside.Button[21]=dgsCreateButton(5,310,180,80,"Choose this skin",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[21],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,102)
									end
								end,
							false)
						end
					end
					if(getElementData(lp,"Faction")==3)then
						if(syncClientGetElementData("Gender")=="Female")then
							dgsCreateImage(5,5,180,300,":"..settings.general.scriptname.."/Files/Images/Skin/207.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							--dgsCreateImage(200,5,180,320,":"..settings.general.scriptname.."/Files/Images/Skin/101.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							
							Lakeside.Button[20]=dgsCreateButton(5,310,180,80,"Choose this skin",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[20],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,207)
									end
								end,
							false)
						elseif(syncClientGetElementData("Gender")=="Male")then
							dgsCreateImage(5,5,180,300,":"..settings.general.scriptname.."/Files/Images/Skin/106.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							
							Lakeside.Button[21]=dgsCreateButton(5,310,180,80,"Choose this skin",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[21],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,106)
									end
								end,
							false)
						end
					end
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[20],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"armor")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[13],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"sniper")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[12],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"sniper",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[11],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"m4")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[10],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"m4",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[9],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"ak")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[8],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"ak",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[7],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"mp5")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[6],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"mp5",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"deagle")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"deagle",_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"colt45")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"colt45",_)
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
	end
end)