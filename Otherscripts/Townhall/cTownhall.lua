--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:townhall",true)
addEventHandler("open:townhall",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-380/2,GLOBALscreenY/2-300/2,380,300,settings.general.servername.." - Townhall",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(354,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,380,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-380/2,GLOBALscreenY/2-300/2,380,300,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(5,5,200,265,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				
				item=dgsGridListAddColumn(Lakeside.Gridlist[1],"Item",0.6)
				price=dgsGridListAddColumn(Lakeside.Gridlist[1],"Price",0.2)
				
				for i,v in pairs(townhallItem)do
					local row=dgsGridListAddRow(Lakeside.Gridlist[1])
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,item,i,false,false)
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,price,"$"..townhallItemPrice[v],false,false)
				end
				
				Lakeside.Button[2]=dgsCreateButton(210,235,165,35,"buy item",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(clicked~="")then
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",true)
									triggerServerEvent("buy:townhallitem",lp,clicked)
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

addEvent("open:townhallpin",true)
addEventHandler("open:townhallpin",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,settings.general.servername.." - Bank account",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(314,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,340,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Image[1]=dgsCreateImage(5,5,330,180,":"..settings.general.scriptname.."/Files/Images/UI/TownhallBG.png",false,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,190,330,40,"create bank account",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							triggerServerEvent("set:bankpin",lp)
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

addEvent("open:job",true)
addEventHandler("open:job",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-340/2,GLOBALscreenY/2-360/2,340,360,settings.general.servername.." - Job center",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(314,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,340,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-340/2,GLOBALscreenY/2-360/2,340,360,255,255,255,255,Lakeside.Window[1])
				
				--dgsCreateLabel(7,5,100,20,"Your Joblevel: "..syncClientGetElementData("Joblevel").."         EXP: "..syncClientGetElementData("Jobexp").."/"..settings.level.job[syncClientGetElementData("Jobexp")],false,Lakeside.Window[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(5,25,330,260,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				local job=dgsGridListAddColumn(Lakeside.Gridlist[1],"Job",0.6)
				local level=dgsGridListAddColumn(Lakeside.Gridlist[1],"Level",0.3)
				
				Lakeside.Button[2]=dgsCreateButton(5,290,330,40,"Set a marker to this Job",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				for i,v in pairs(JobTable["Jobs"])do
					local row=dgsGridListAddRow(Lakeside.Gridlist[1])
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,job,v[1],false,false)
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,level,v[2],false,false)
				end
				
				
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local job=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								local level=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),2)
								if(job~="" and level~="")then
									if(syncClientGetElementData("IDcard")==1)then
										if(syncClientGetElementData("Joblevel")>=tonumber(level))then
											if(isTimer(jobBlip))then
												jobBlip:destroy()
											end
											if(isTimer(jobTimer))then
												jobTimer:destroy()
											end
											jobBlip=createBlip(JobTable["JobPositions"][job][1],JobTable["JobPositions"][job][2],JobTable["JobPositions"][job][3],0,2.2,255,0,0)
											jobTimer=setTimer(function()
												jobTimer:destroy()
											end,5*60*1000,1)
											outputChatBox("The position of the job has been marked for 5 Minutes!",200,0,0)
										end
									else
										triggerEvent("draw:infobox",lp,"error","You do not have a ID card!",8000)
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
end)