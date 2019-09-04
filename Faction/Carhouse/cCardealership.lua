--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("shop:gangcardealerUI",true)
addEventHandler("shop:gangcardealerUI",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-420/2,GLOBALscreenY/2-380/2,420,380,settings.general.servername.." - Gang-vehicle dealer",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(394,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,420,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-420/2,GLOBALscreenY/2-380/2,420,380,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(5,7,260,340,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				id=dgsGridListAddColumn(Lakeside.Gridlist[1],"ID",0.16)
				veh=dgsGridListAddColumn(Lakeside.Gridlist[1],"Vehicle",0.58)
				price=dgsGridListAddColumn(Lakeside.Gridlist[1],"Price",0.34)
				
				Lakeside.Button[2]=dgsCreateButton(270,7,145,35,"Buy this vehicle",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				triggerServerEvent("get:gangbuyablevehicles",lp)
				
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local id=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								local price=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
								if(id~="" and price~="")then
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",true)
									triggerServerEvent("buy:gangvehicle",lp,id,price)
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

addEvent("show:gangbuyablevehicles",true)
addEventHandler("show:gangbuyablevehicles",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[1])
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(Lakeside.Gridlist[1])
		dgsGridListSetItemText(Lakeside.Gridlist[1],row,id,v[1],false,false)
		dgsGridListSetItemText(Lakeside.Gridlist[1],row,veh,v[2],false,false)
		dgsGridListSetItemText(Lakeside.Gridlist[1],row,price,v[3],false,false)
	end
end)