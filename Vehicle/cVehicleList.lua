--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:uservehpanel",true)
addEventHandler("open:uservehpanel",root,function(tbl)
	if(isLoggedin())then
		setWindowData("add","cursor_clicked",false)
		Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-440/2,GLOBALscreenY/2-440/2,440,440,settings.general.servername.." - Vehicle keys",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
		dgsWindowSetSizable(Lakeside.Window[1],false)
		dgsWindowSetMovable(Lakeside.Window[1],false)
		Lakeside.Button[1]=dgsCreateButton(414,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
		dgsCreateImage(0,0,440,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
		Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-440/2,GLOBALscreenY/2-440/2,440,440,255,255,255,255,Lakeside.Window[1])
		
		Lakeside.Gridlist[1]=dgsCreateGridList(5,5,300,405,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		local id=dgsGridListAddColumn(Lakeside.Gridlist[1],"ID",0.15)
		local veh=dgsGridListAddColumn(Lakeside.Gridlist[1],"vehicle",0.4)
		local slot=dgsGridListAddColumn(Lakeside.Gridlist[1],"slot",0.1)
		local totalloss=dgsGridListAddColumn(Lakeside.Gridlist[1],"write-off",0.17)
		
		Lakeside.Label[1]=dgsCreateLabel(310,5,0,0,"Doubleclick on a vehicle\nto locate it.",false,Lakeside.Window[1])
		
		if(#tbl>=1)then
			for _,v in pairs(tbl)do 
				local row=dgsGridListAddRow(Lakeside.Gridlist[1])
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,id,v[1],false,false)
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,veh,v[2],false,false)
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,slot,v[3],false,false)
				if(v[4]==1)then
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,totalloss,"Yes",false,false)
				elseif(v[4]==0)then
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,totalloss,"No",false,false)	
				end
			end
		end
		
		dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
		
		
		addEventHandler("onDgsMouseDoubleClick",Lakeside.Gridlist[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							triggerServerEvent("locate:pivvehicle",lp,clicked)
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
end)