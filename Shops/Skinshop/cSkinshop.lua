--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local rdmDIM=math.random(20000,30000)

local MaleSkinListTable={
	{0,240},
	{1,120},
	{7,120},
	{14,120},
	{15,120},
	{18,120},
	{19,120},
	{20,120},
	{21,120},
	{22,120},
	{23,230},
	{24,230},
}
local FemaleSkinListTable={
	{11,240},
	{12,120},
	{31,120},
	{41,120},
	{55,120},
	{56,120},
	{63,120},
	{64,120},
	{69,250},
	{75,400},
	{76,350},
	{85,350},
	{87,350},
	{90,350},
	{91,350},
	{138,350},
	{139,350},
}

addEvent("open:skinshopUI",true)
addEventHandler("open:skinshopUI",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setElementDimension(lp,rdmDIM)
				
				showCursor(true)
				setElementFrozen(lp,true)
				toggleAllControls(false)
				Lakeside.Window[1]=dgsCreateWindow(100,100,300,480,settings.general.servername.." - Skin Shop",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(100,100,300,480,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(5,5,290,395,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				local skin=dgsGridListAddColumn(Lakeside.Gridlist[1]," skin",0.6)
				local price=dgsGridListAddColumn(Lakeside.Gridlist[1]," price",0.3)
				
				Lakeside.Button[2]=dgsCreateButton(5,405,290,45,"Buy this skin",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				if(syncClientGetElementData("Gender")=="Male")then
					for _,v in pairs(MaleSkinListTable)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[1])
						dgsGridListSetItemText(Lakeside.Gridlist[1],row,skin,v[1],false,false)
						dgsGridListSetItemText(Lakeside.Gridlist[1],row,price,v[2],false,false)
					end
				elseif(syncClientGetElementData("Gender")=="Female")then
					for _,v in pairs(FemaleSkinListTable)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[1])
						dgsGridListSetItemText(Lakeside.Gridlist[1],row,skin,v[1],false,false)
						dgsGridListSetItemText(Lakeside.Gridlist[1],row,price,v[2],false,false)
					end
				end
				
				addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(clicked~="")then
									setElementModel(lp,clicked)
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
									local price=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),2)
									if(price~="")then
										triggerServerEvent("buy:skin",lp,clicked,price)
										dgsCloseWindow(Lakeside.Window[1])
										setWindowData("remove","cursor_clicked",true)
										setElementFrozen(lp,false)
										toggleAllControls(true)
										setElementDimension(lp,60)
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
							setElementFrozen(lp,false)
							toggleAllControls(true)
							setElementDimension(lp,60)
							setElementModel(lp,getElementData(lp,"SkinID"))
						end
					end,
				false)
			end
		end
	end
end)