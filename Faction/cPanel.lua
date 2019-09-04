--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

bindKey("f3","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"Faction")~=0)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,settings.general.servername.." - Factionpanel ("..settings.faction.ranknames.levelnames[tonumber(getElementData(lp,"Faction"))]..")",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,500,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,255,255,255,255,Lakeside.Window[1])
					
					Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,480,335,false,Lakeside.Window[1])
					Lakeside.Tab[1]=dgsCreateTab("Main",Lakeside.Tabpanel[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,7,280,300,false,Lakeside.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					members=dgsGridListAddColumn(Lakeside.Gridlist[1],"Member",0.62)
					rank=dgsGridListAddColumn(Lakeside.Gridlist[1],"Rank",0.34)
					
					dgsCreateLabel(290,12,100,20,"Type a Name to invite",false,Lakeside.Tab[1])
					Lakeside.Edit[1]=dgsCreateEdit(290,30,185,35,"",false,Lakeside.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					Lakeside.Button[2]=dgsCreateButton(290,70,185,35,"Invite  [R4]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(290,110,185,35,"Uninvite  [R4]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[4]=dgsCreateButton(290,150,185,35,"Rank up  [R5]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[5]=dgsCreateButton(290,190,185,35,"Rank down  [R5]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[2]=dgsCreateTab("Notes",Lakeside.Tabpanel[1])
					
					Lakeside.Memo[1]=dgsCreateMemo(5,7,280,300,"",false,Lakeside.Tab[2],_,_,_,_,tocolor(50,50,50,255))
					Lakeside.Button[18]=dgsCreateButton(290,7,185,35,"Save notes  [R4]",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[3]=dgsCreateTab("Vehicles",Lakeside.Tabpanel[1])
					
					Lakeside.Gridlist[2]=dgsCreateGridList(5,7,280,300,false,Lakeside.Tab[3],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					vehid=dgsGridListAddColumn(Lakeside.Gridlist[2],"ID",0.15)
					vehs=dgsGridListAddColumn(Lakeside.Gridlist[2],"Vehicle",0.62)
					
					dgsCreateLabel(290,12,100,20,"Vehicle respawn costs: $2500",false,Lakeside.Tab[3])
					Lakeside.Button[26]=dgsCreateButton(290,30,185,35,"Respawn all vehicles  [R3]",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[4]=dgsCreateTab("Settings",Lakeside.Tabpanel[1])
					
					Lakeside.Label[8]=dgsCreateLabel(5,5,100,20,"Rank 1 salary:",false,Lakeside.Tab[4])
					Lakeside.Edit[8]=dgsCreateEdit(5,20,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[9]=dgsCreateLabel(5,60,100,20,"Rank 2 salary:",false,Lakeside.Tab[4])
					Lakeside.Edit[9]=dgsCreateEdit(5,75,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[10]=dgsCreateLabel(5,115,100,20,"Rank 3 salary:",false,Lakeside.Tab[4])
					Lakeside.Edit[10]=dgsCreateEdit(5,130,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[11]=dgsCreateLabel(5,170,100,20,"Rank 4 salary:",false,Lakeside.Tab[4])
					Lakeside.Edit[11]=dgsCreateEdit(5,185,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[12]=dgsCreateLabel(5,225,100,20,"Rank 5 salary:",false,Lakeside.Tab[4])
					Lakeside.Edit[12]=dgsCreateEdit(5,240,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					Lakeside.Button[40]=dgsCreateButton(110,20,120,30,"Change this\nrank salary",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[41]=dgsCreateButton(110,75,120,30,"Change this\nrank salary",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[42]=dgsCreateButton(110,130,120,30,"Change this\nrank salary",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[43]=dgsCreateButton(110,185,120,30,"Change this\nrank salary",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[44]=dgsCreateButton(110,240,120,30,"Change this\nrank salary",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					if(getElementData(lp,"Factionrank")>=5)then
						dgsSetEnabled(Lakeside.Button[5],true)
						dgsSetEnabled(Lakeside.Button[4],true)
						dgsSetEnabled(Lakeside.Button[40],true)
						dgsSetEnabled(Lakeside.Button[41],true)
						dgsSetEnabled(Lakeside.Button[42],true)
						dgsSetEnabled(Lakeside.Button[43],true)
						dgsSetEnabled(Lakeside.Button[44],true)
					else
						dgsSetEnabled(Lakeside.Button[5],false)
						dgsSetEnabled(Lakeside.Button[4],false)
						dgsSetEnabled(Lakeside.Button[40],false)
						dgsSetEnabled(Lakeside.Button[41],false)
						dgsSetEnabled(Lakeside.Button[42],false)
						dgsSetEnabled(Lakeside.Button[43],false)
						dgsSetEnabled(Lakeside.Button[44],false)
					end
					
					if(getElementData(lp,"Factionrank")>=4)then
						dgsSetEnabled(Lakeside.Edit[1],true)
						dgsSetEnabled(Lakeside.Button[2],true)
						dgsSetEnabled(Lakeside.Button[3],true)
						dgsSetEnabled(Lakeside.Button[18],true)
						dgsMemoSetReadOnly(Lakeside.Memo[1],false)
					else
						dgsSetEnabled(Lakeside.Edit[1],false)
						dgsSetEnabled(Lakeside.Button[2],false)
						dgsSetEnabled(Lakeside.Button[3],false)
						dgsSetEnabled(Lakeside.Button[18],false)
						dgsMemoSetReadOnly(Lakeside.Memo[1],true)
					end
					
					if(getElementData(lp,"Factionrank")>=3)then
						dgsSetEnabled(Lakeside.Button[26],true)
					else
						dgsSetEnabled(Lakeside.Button[26],false)
					end
					
					triggerServerEvent("get:factionpanelmembers",lp,lp)
					triggerServerEvent("load:factionvehicles",lp)
					triggerServerEvent("get:factionnotes",lp)
					triggerServerEvent("get:factionranksalary",lp)
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[44],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[12])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank5",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[43],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[11])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank4",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[42],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[10])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank3",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[41],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[9])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank2",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[40],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[8])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank1",amount)
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[26],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("respawn:factionvehicles",lp)
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[18],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local notes=dgsGetText(Lakeside.Memo[1])or ""
								triggerServerEvent("change:factionnotes",lp,notes)
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("rankdown:Fplayer",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("rankup:Fplayer",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("uninvite:Fplayer",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local target=dgsGetText(Lakeside.Edit[1])or ""
								if(target~="")then
									triggerServerEvent("invite:Fplayer",lp,target)
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
	end
end)


addEvent("refresh:factionpanel",true)
addEventHandler("refresh:factionpanel",root,function(member)
	dgsGridListClear(Lakeside.Gridlist[1])
	if(member and #member>=1)then
		for _,v in pairs(member)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[1])
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,members,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,rank,settings.faction.ranknames[v[2]][v[3]].."("..v[3]..")",false,false)
		end
	end
end)


addEvent("show:factionnotes",true)
addEventHandler("show:factionnotes",root,function(tbl)
	for _,v in pairs(tbl)do
		dgsSetText(Lakeside.Memo[1],v[1])
	end
end)

addEvent("show:factionvehicles",true)
addEventHandler("show:factionvehicles",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[2])
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[2])
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,vehid,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,vehs,v[2],false,false)
		end
	end
end)

addEvent("show:factionranksalary",true)
addEventHandler("show:factionranksalary",root,function(tbl)
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			dgsSetText(Lakeside.Label[8],"Rank 1 salary: $"..v[1])
			dgsSetText(Lakeside.Label[9],"Rank 2 salary: $"..v[2])
			dgsSetText(Lakeside.Label[10],"Rank 3 salary: $"..v[3])
			dgsSetText(Lakeside.Label[11],"Rank 4 salary: $"..v[4])
			dgsSetText(Lakeside.Label[12],"Rank 5 salary: $"..v[5])
		end
	end
end)