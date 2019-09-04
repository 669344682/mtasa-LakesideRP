--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local wantedReason={
	{"Hooliganism", 1},
	{"Riots", 1},
	{"Driving without license", 2},
	{"Driving under the influence", 2},
	{"Bribery", 3},
	{"Assault", 4},
	{"Stalking", 4},
	{"Gang member", 5},
	{"Drug buyer", 5},
	{"Drug dealer", 5},
	{"Thief", 5},
	{"Kidnapping", 6},
	{"Murder", 6},
}

addEvent("open:wantedpc",true)
addEventHandler("open:wantedpc",root,function()
	if(isLoggedin())then
		local veh=getPedOccupiedVehicle(lp)
		local id=getElementModel(veh)
		if(id==597 or id==596 or id==490 or id==528)then
			if(getElementData(lp,"ElementClicked")==false)then
				if(not isElement(Lakeside.Window[1]))then
					setWindowData("add","cursor_clicked",true)
					dgsSetInputMode("no_binds")
					dgsSetInputMode("no_binds_when_editing")
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-880/2,GLOBALscreenY/2-600/2,880,600,settings.general.servername.." - Wanted PC",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(854,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,880,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-880/2,GLOBALscreenY/2-600/2,880,600,255,255,255,255,Lakeside.Window[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,7,270,560,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					local players=dgsGridListAddColumn(Lakeside.Gridlist[1],"player",0.62)
					local wanteds=dgsGridListAddColumn(Lakeside.Gridlist[1],"wanteds",0.2)
					
					Lakeside.Gridlist[2]=dgsCreateGridList(280,7,265,560,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					local wantedss=dgsGridListAddColumn(Lakeside.Gridlist[2],"wanteds",0.3)
					local reason=dgsGridListAddColumn(Lakeside.Gridlist[2],"reason",0.75)
					
					Lakeside.Button[2]=dgsCreateButton(550,7,160,40,"Wanted(s) give",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(715,7,160,40,"Wanted(s) clear  [R3]",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[4]=dgsCreateButton(550,50,160,40,"Locate player",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					if(getElementData(lp,"Factionrank")>=3)then
						dgsSetEnabled(Lakeside.Button[3],true)
					else
						dgsSetEnabled(Lakeside.Button[3],false)
					end
					
					
					for _,v in pairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							local row=dgsGridListAddRow(Lakeside.Gridlist[1])
							dgsGridListSetItemText(Lakeside.Gridlist[1],row,players,getPlayerName(v),false,false)
							dgsGridListSetItemText(Lakeside.Gridlist[1],row,wanteds,tonumber(getElementData(v,"Wanteds")),false,false)
						end
					end
					
					for i,_ in ipairs(wantedReason)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[2])
						dgsGridListSetItemText(Lakeside.Gridlist[2],row,reason,wantedReason[i][1],false,false)
						dgsGridListSetItemText(Lakeside.Gridlist[2],row,wantedss,wantedReason[i][2],false,false)
					end
					
					dgsGridListSetSortColumn(Lakeside.Gridlist[1],1)
					--dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					--dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("locate:player",lp,clicked)
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
										triggerServerEvent("delete:wanteds",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										local item2=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
										if(item2>0)then
											local reason=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),2)
											if(reason~="")then
												local item3=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
												if(item3>0)then
													local amount=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
													if(amount~="")then
														triggerServerEvent("give:wanteds",lp,clicked,reason,amount)
													end
												end
											end
										end
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
	end
end)

addEvent("create:locateblip",true)
addEventHandler("create:locateblip",root,function(target)
	if(isElement(locateBlip))then
		locateBlip:destroy()
	end
	if(not locateTimer)then
		locateBlip=createBlipAttachedTo(target,0,2,255,0,200)
		locateTimer=setTimer(function()
			locateBlip:destroy()
		end,25*1000,1)
		triggerEvent("draw:infobox",lp,"info","You have located "..getPlayerName(target).." for 25sek.",8000)
	end
end)