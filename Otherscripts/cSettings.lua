--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function deleteAllUIItems()
	--//Grid 1
	if(isElement(Lakeside.Combo[1]))then
		Lakeside.Combo[1]:destroy()
	end
	if(isElement(Lakeside.Button[10]))then
		Lakeside.Button[10]:destroy()
	end
	if(isElement(Lakeside.Label[10]))then
		Lakeside.Label[10]:destroy()
	end
	--//Grid 4
	if(isElement(Lakeside.Button[40]))then
		Lakeside.Button[40]:destroy()
	end
	if(isElement(Lakeside.Label[40]))then
		Lakeside.Label[40]:destroy()
	end
	if(isElement(Lakeside.Button[41]))then
		Lakeside.Button[41]:destroy()
	end
	if(isElement(Lakeside.Label[41]))then
		Lakeside.Label[41]:destroy()
	end
end

addCommandHandler("settings",function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,settings.general.servername.." - Settings",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,500,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Gridlist[1]=dgsCreateGridList(5,5,200,465,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local gridlist=dgsGridListAddColumn(Lakeside.Gridlist[1],"Settings",0.92)
			local grid1=dgsGridListAddRow(Lakeside.Gridlist[1],"Radar")
			local grid4=dgsGridListAddRow(Lakeside.Gridlist[1],"Shader")
			
			
			dgsGridListSetItemText(Lakeside.Gridlist[1],grid1,gridlist,"Radar")
			dgsGridListSetItemText(Lakeside.Gridlist[1],grid4,gridlist,"Shader")
			
			dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
							if(item==grid1)then
								deleteAllUIItems()
								
								Lakeside.Label[10]=dgsCreateLabel(220,25,160,20,"Radar: n/a",false,Lakeside.Window[1])
								Lakeside.Combo[1]=dgsCreateComboBox(220,45,260,35,"select a radar",false,Lakeside.Window[1],20,tocolor(0,0,0,255),_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255))
								dgsComboBoxAddItem(Lakeside.Combo[1],"GTA:V")
								dgsComboBoxAddItem(Lakeside.Combo[1],"GTA:SA")
								
								Lakeside.Button[10]=dgsCreateButton(220,100,260,40,"set radar",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								
								if(tonumber(syncClientGetElementData("Radar"))==1)then
									dgsSetText(Lakeside.Label[10],"Radar: GTA:V")
								elseif(tonumber(syncClientGetElementData("Radar"))==2)then
									dgsSetText(Lakeside.Label[10],"Radar: GTA:SA")
								end
								
								
								addEventHandler("onDgsMouseClick",Lakeside.Button[10],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsComboBoxGetSelectedItem(Lakeside.Combo[1])
											if(tonumber(amount)>=1 and tonumber(amount)<=2)then
												triggerServerEvent("set:settings",lp,"Radar",tonumber(amount))
											end
										end
									end,
								false)
							elseif(item==grid4)then
								deleteAllUIItems()
								
								Lakeside.Label[40]=dgsCreateLabel(220,330,160,20,"Blurshader:",false,Lakeside.Window[1])
								Lakeside.Button[40]=dgsCreateButton(220,350,260,40,"Change Blurshader",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								Lakeside.Label[41]=dgsCreateLabel(220,405,160,20,"Snowshader:",false,Lakeside.Window[1])
								Lakeside.Button[41]=dgsCreateButton(220,425,260,40,"Change Snowshader",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								if(settings.general.christmas==true)then
									dgsSetEnabled(Lakeside.Button[41],true)
								else
									dgsSetEnabled(Lakeside.Button[41],false)
								end
								
								if(tonumber(syncClientGetElementData("Blurshader"))==1)then
									dgsSetText(Lakeside.Label[40],"Blurshader: Off")
								elseif(tonumber(syncClientGetElementData("Blurshader"))==2)then
									dgsSetText(Lakeside.Label[40],"Blurshader: On")
								end
								if(tonumber(syncClientGetElementData("Snowshader"))==1)then
									dgsSetText(Lakeside.Label[41],"Snowshader: Off")
								elseif(tonumber(syncClientGetElementData("Snowshader"))==2)then
									dgsSetText(Lakeside.Label[41],"Snowshader: On")
								end
								
								
								addEventHandler("onDgsMouseClick",Lakeside.Button[40],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Blurshader",_)
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",Lakeside.Button[41],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Snowshader",_)
										end
									end,
								false)
							end
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
end)


addEvent("refresh:settingsmenu",true)
addEventHandler("refresh:settingsmenu",root,function(typ)
	if(typ=="Radar")then
		if(tonumber(syncClientGetElementData("Radar"))==1)then
			dgsSetText(Lakeside.Label[10],"Radar: GTA:V")
		elseif(tonumber(syncClientGetElementData("Radar"))==2)then
			dgsSetText(Lakeside.Label[10],"Radar: GTA:SA")
		end
		elseif(typ=="Blurshader")then
		if(tonumber(syncClientGetElementData("Blurshader"))==1)then
			dgsSetText(Lakeside.Label[40],"Blurshader: Off")
		elseif(tonumber(syncClientGetElementData("Blurshader"))==2)then
			dgsSetText(Lakeside.Label[40],"Blurshader: On")
		end
	elseif(typ=="Snowshader")then
		if(tonumber(syncClientGetElementData("Snowshader"))==1)then
			dgsSetText(Lakeside.Label[41],"Snowshader: Off")
		elseif(tonumber(syncClientGetElementData("Snowshader"))==2)then
			dgsSetText(Lakeside.Label[41],"Snowshader: On")
		end
	end
end)