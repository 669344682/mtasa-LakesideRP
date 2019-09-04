--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:tuningpanel",true)
addEventHandler("open:tuningpanel",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			Tuningsystem.kameraPos=1
			
			setWindowData("add","cursor_clicked",true)
			if(not isElement(Lakeside.Music[1]))then
				Lakeside.Music[1]=playSound(":"..settings.general.scriptname.."/Files/Sounds/Tuningshop.mp3",true)
				setSoundVolume(Lakeside.Music[1],0.6)
			end
			Lakeside.Window[1]=dgsCreateWindow(5,5,600,410,settings.general.servername.." - Tuningsystem",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,600,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(5,5,600,410,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Image[1]=dgsCreateImage(460,280,115,85,":"..settings.general.scriptname.."/Files/Images/Logo.png",false,Lakeside.Window[1])
			
			Lakeside.Gridlist[1]=dgsCreateGridList(10,10,180,365,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			Lakeside.Gridlist[2]=dgsCreateGridList(200,10,235,365,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local category=dgsGridListAddColumn(Lakeside.Gridlist[1]," category",0.9)
			local id=dgsGridListAddColumn(Lakeside.Gridlist[2]," ID",0.25)
			local part=dgsGridListAddColumn(Lakeside.Gridlist[2]," part",0.49)
			local price=dgsGridListAddColumn(Lakeside.Gridlist[2]," price",0.3)
			
			for _,v in pairs(Tuningsystem["Categorys"])do
				local row=dgsGridListAddRow(Lakeside.Gridlist[1])
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,category,v,false,false)
			end
			
			Lakeside.Button[2]=dgsCreateButton(460,10,115,35,"install tuningpart",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(460,60,115,35,"uninstall tuningpart",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Label[1]=dgsCreateLabel(470,200,100,20,"Press <- or ->\nto move the camera",false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
			
			dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
			dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
			
			bindKey("arrow_r","down",bindRightTuningsys_Func)
			bindKey("arrow_l","down",bindLeftTuningsys_Func)
			setCameraTuningsys_Func()
			
			local veh=getPedOccupiedVehicle(lp)
			
			addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
							if(clicked~="")then
								if(clicked=="color")then
									dgsCloseWindow(Lakeside.Window[1])
									Lakeside.Window[2]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-375/2,300,375,settings.general.servername.." - Tuning Colorpicker",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
									Lakeside.CPicker[1]=dgsCreateColorPicker("HSVRing",5,25,285,265,false,Lakeside.Window[2])
									dgsWindowSetSizable(Lakeside.Window[2],false)
									dgsWindowSetMovable(Lakeside.Window[2],false)
									
									local CPr,CPg,CPb=dgsColorPickerGetColor(Lakeside.CPicker[1],"RGB")
									setVehicleColor(getPedOccupiedVehicle(lp),CPr,CPg,CPb,CPr,CPg,CPb)
									Lakeside.Label[2]=dgsCreateLabel(100,5,100,20,"R: "..CPr.." G: "..CPg.." B: "..CPb.."",false,Lakeside.Window[2],_,_,_,_,_,_,"center",_)
									
									Lakeside.Button[4]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[2],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
									dgsSetProperty(Lakeside.Button[4],"textSize",{1.6,1.6})
									dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[2],settings.general.guilinecolor)
									Lakeside.Blurbox[2]=exports.blur_box:createBlurBox(GLOBALscreenX/2-300/2,GLOBALscreenY/2-375/2,300,375,255,255,255,255,Lakeside.Window[2])
									
									Lakeside.Button[5]=dgsCreateButton(5,310,290,35,"change color (0$)",false,Lakeside.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									
									
									addEventHandler("onDgsColorPickerChange",Lakeside.CPicker[1],
										function()
											if(isElement(Lakeside.CPicker[1])and isElement(Lakeside.Label[2])and isElement(Lakeside.Window[2]))then
												local CPr,CPg,CPb=dgsColorPickerGetColor(Lakeside.CPicker[1],"RGB")
												setVehicleColor(getPedOccupiedVehicle(lp),CPr,CPg,CPb,CPr,CPg,CPb)
												setVehicleHeadLightColor(getPedOccupiedVehicle(lp),CPr,CPg,CPb)
												dgsSetText(Lakeside.Label[2],"R: "..CPr.." G: "..CPg.." B: "..CPb.."")
											end
										end
									)
									
									
									addEventHandler("onDgsMouseClick",Lakeside.Button[4],
										function(btn,state)
											if(btn=="left" and state=="down")then
												dgsCloseWindow(Lakeside.Window[2])
												setElementData(lp,"ElementClicked",false)
												triggerEvent("open:tuningpanel",lp)
												exports.blur_box:destroyBlurBox(Lakeside.Blurbox[2])
												triggerServerEvent("load:vehicletunings",lp,getPedOccupiedVehicle(lp))
											end
										end,
									false)
									addEventHandler("onDgsMouseClick",Lakeside.Button[5],
										function(btn,state)
											if(btn=="left" and state=="down")then
												local CPr,CPg,CPb=dgsColorPickerGetColor(Lakeside.CPicker[1],"RGB")
												triggerServerEvent("set:vehiclecolor",lp,CPr,CPg,CPb)
											end
										end,
									false)
								else
									dgsGridListClear(Lakeside.Gridlist[2])
									local model=getElementModel(getPedOccupiedVehicle(lp))
									for _,v in pairs(Tuningsystem["Tuningparts"][clicked])do
										if(isTuningteilAvailable(model,v))then
											local row=dgsGridListAddRow(Lakeside.Gridlist[2])
											dgsGridListSetItemText(Lakeside.Gridlist[2],row,id,v,false,false)
											dgsGridListSetItemText(Lakeside.Gridlist[2],row,part,Tuningsystem["Tuningnames"][v],false,false)
											dgsGridListSetItemText(Lakeside.Gridlist[2],row,price,Tuningsystem["Tuningpreise"][v],false,false)
										end
									end
								end
							end
						else
							dgsGridListClear(Lakeside.Gridlist[2])
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Gridlist[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
							if(clicked~="")then
								triggerServerEvent("load:vehicletunings",lp,getPedOccupiedVehicle(lp))
								triggerServerEvent("addremoveshow:tuningpart",lp,"normal","show",_,clicked)
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
							if(clicked~="")then
								triggerServerEvent("addremoveshow:tuningpart",lp,"normal","remove",_,clicked)
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
							if(clicked~="")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
								if(item>0)then
									local price=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),3)
									if(price~="")then
										triggerServerEvent("addremoveshow:tuningpart",lp,"normal","add",price,clicked)
									end
								end
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						if(Lakeside.Music[1])then
							Lakeside.Music[1]:destroy()
						end
					end
				end,
			false)
			
		end
	end
end)


function isTuningteilAvailable(model,id)
	local state=false
	for _,v in pairs(Tuningsystem["AvailableTunings"][model])do
		if(v==tonumber(id))then
			state=true
			break
		end
	end
	return state
end

function setCameraTuningsys_Func()
	local tbl=Tuningsystem["Kamera"][Tuningsystem.kameraPos]
	setCameraMatrix(tbl[1],tbl[2],tbl[3],tbl[4],tbl[5],tbl[6])
end

function bindRightTuningsys_Func()
	if(Tuningsystem.kameraPos<#Tuningsystem["Kamera"])then
		Tuningsystem.kameraPos=Tuningsystem.kameraPos+1
		setCameraTuningsys_Func()
	end
end

function bindLeftTuningsys_Func()
	if(Tuningsystem.kameraPos>1)then
		Tuningsystem.kameraPos=Tuningsystem.kameraPos-1
		setCameraTuningsys_Func()
	end
end