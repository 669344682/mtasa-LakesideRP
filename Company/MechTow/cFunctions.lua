--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:mechdutyUI",true)
addEventHandler("open:mechdutyUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-250/2,GLOBALscreenY/2-300/2,250,300,"Mech&Tow - Duty",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(224,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,250,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-250/2,GLOBALscreenY/2-300/2,250,300,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Button[2]=dgsCreateButton(5,175,240,45,"Go duty",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(5,225,240,45,"Go off-duty",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("go:mechonoffduty",lp,"Offduty")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("go:mechonoffduty",lp,"Onduty")
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

addEvent("open:towedvehiclelist",true)
addEventHandler("open:towedvehiclelist",root,function(tbl)
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			setWindowData("add","cursor_clicked",false)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-440/2,GLOBALscreenY/2-380/2,440,380,settings.general.servername.." - Towed Vehicle",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(414,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,440,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-440/2,GLOBALscreenY/2-380/2,440,380,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Gridlist[1]=dgsCreateGridList(5,5,430,305,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local veh=dgsGridListAddColumn(Lakeside.Gridlist[1],"vehicle",0.6)
			local slot=dgsGridListAddColumn(Lakeside.Gridlist[1],"slot",0.2)
			
			Lakeside.Button[2]=dgsCreateButton(5,315,430,35,"Buy out ($1500)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			if(#tbl>=1)then
				for _,v in pairs(tbl)do 
					local row=dgsGridListAddRow(Lakeside.Gridlist[1])
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,veh,v[1],false,false)
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,slot,v[2],false,false)
				end
			end
			
			dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),2)
							if(clicked~="")then
								triggerServerEvent("buyfree:vehicle",lp,clicked)
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if btn=="left" and state=="up" then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
		end
	end
end)



--//Tuning system
addEvent("open:mechTuningUI",true)
addEventHandler("open:mechTuningUI",root,function(veh)
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			if(getElementData(lp,"Company")==1)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,"Mech&Tow - Tuning",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,140,290,40,"Fix write-off ($2.500)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(5,185,290,40,"Install Sportengine +1 ($65.000)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[4]=dgsCreateButton(5,230,290,40,"Install Lowering +1 ($30.000)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				if(type(veh)=="table")then
					if(isElement(veh[1]))then
						aramp2=veh[1]
					end
				end
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							veh=aramp2
							triggerServerEvent("tune:privcar",lp,veh,"Lowering",30000)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							veh=aramp2
							triggerServerEvent("tune:privcar",lp,veh,"Sportmotor",65000)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							veh=aramp2
							triggerServerEvent("tune:privcar",lp,veh,"Totalloss",2500)
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