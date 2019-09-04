--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

bindKey("f10","down",function()
	if(isLoggedin())then
		if(tonumber(getElementData(lp,"AdminLvL"))>=1)then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,settings.general.servername.." - Adminpanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(674,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,700,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(10,10,200,410,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				playerGridlist=dgsGridListAddColumn(Lakeside.Gridlist[1]," Online players",0.9)
				
				
				Lakeside.Button[2]=dgsCreateButton(450,10,115,30,"kick player",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(450,90,115,30,"ban player",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[4]=dgsCreateButton(450,50,115,30,"tempban player",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[5]=dgsCreateButton(575,10,115,30,"mute player",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[6]=dgsCreateButton(575,50,115,30,"unmute player",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[10]=dgsCreateButton(450,170,115,30,"set adminlvl",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[11]=dgsCreateButton(575,170,115,30,"set premiumlvl",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[12]=dgsCreateButton(450,210,115,30,"set faction leader",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[13]=dgsCreateButton(575,210,115,30,"set company leader",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				Lakeside.Edit[1]=dgsCreateEdit(450,355,240,35,"Kick/Ban/Mute reason",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				dgsCreateLabel(450,400,100,20,"ban-time in hours (example: 1=1hour)\nmute-time in minutes (example: 1=1minute)",false,Lakeside.Window[1])
				Lakeside.Edit[2]=dgsCreateEdit(450,430,240,35,"Ban/Mute time",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Edit[3]=dgsCreateEdit(450,280,240,35,"Admin/Premiumlevel/ Faction/Company ID",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				
				
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
				
				for _,v in ipairs(getElementsByType("player"))do
					local row=dgsGridListAddRow(Lakeside.Gridlist[1])
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,playerGridlist,getPlayerName(v),false,false)
				end
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(Lakeside.Edit[1])
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(reason~="")then
									triggerServerEvent("executeAdminServerCMD",lp,"rkick",clicked.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(Lakeside.Edit[1])
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(reason~="")then
									triggerServerEvent("executeAdminServerCMD",lp,"rban",clicked.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(Lakeside.Edit[1])
							local time=dgsGetText(Lakeside.Edit[2])
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(tonumber(time)>=1 and(reason~=""))then
									triggerServerEvent("executeAdminServerCMD",lp,"tban",clicked.." "..time.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(Lakeside.Edit[1])
							local time=dgsGetText(Lakeside.Edit[2])
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(reason~="")then
									triggerServerEvent("executeAdminServerCMD",lp,"rmute",clicked.." "..time.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[6],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								triggerServerEvent("executeAdminServerCMD",lp,"runmute",clicked)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[10],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Edit[3])or 0
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								triggerServerEvent("executeAdminServerCMD",lp,"setadminlvl",clicked.." "..amount)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[11],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Edit[3])or 0
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								triggerServerEvent("executeAdminServerCMD",lp,"setpremiumlvl",clicked.." "..amount)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[12],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local faction=dgsGetText(Lakeside.Edit[3])or 0
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("set:faction_company",lp,clicked,"Faction",tonumber(faction))
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[13],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local company=dgsGetText(Lakeside.Edit[3])or 0
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("set:faction_company",lp,clicked,"Company",tonumber(company))
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
	end
end)

addCommandHandler("dev",function()
	if(tonumber(getElementData(lp,"AdminLvL"))>=5)then
		local boolean=not getDevelopmentMode()
		setDevelopmentMode(boolean)
	end
end)