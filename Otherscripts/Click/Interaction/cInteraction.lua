--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local interaktionTable={
	["Items"]={
		{"Pizza","Pizza"},
		{"Burger","Burger"},
		{"Apple","Apple"},
		{"Cola","Cola"},
	},
}

addEvent("open:interactionUI",true)
addEventHandler("open:interactionUI",root,function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				if(getElementData(lp,"Faction")==1 and syncClientGetElementData("CopDuty")==true or getElementData(lp,"Faction")==2 and syncClientGetElementData("CopDuty")==true)then
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-305/2,GLOBALscreenY/2-205/2,305,205,"Interaction with "..getElementData(lp,"set:clickedplayer"),false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-305/2,GLOBALscreenY/2-205/2,305,205,255,255,255,255,Lakeside.Window[1])
				else
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-305/2,GLOBALscreenY/2-140/2,305,140,"Interaction with "..getElementData(lp,"set:clickedplayer"),false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-305/2,GLOBALscreenY/2-140/2,305,140,255,255,255,255,Lakeside.Window[1])
				end
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(279,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,305,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				
				Lakeside.Button[2]=dgsCreateButton(5,7,145,45,"Trade",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(155,7,145,45,"Licenses show",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				if(getElementData(lp,"Faction")==1 and syncClientGetElementData("CopDuty")==true or getElementData(lp,"Faction")==2 and syncClientGetElementData("CopDuty")==true)then
					Lakeside.Label[1]=dgsCreateLabel(7,65,100,5,"State functions:",false,Lakeside.Window[1])
					Lakeside.Button[10]=dgsCreateButton(5,80,145,45,"Looking for illegal-items",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[11]=dgsCreateButton(155,80,145,45,"Take illegal-items",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[12]=dgsCreateButton(5,130,145,45,"Take weapons",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[12],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("take:weapons",lp)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[11],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("take:illiegalitems",lp)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[10],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("look:illiegalitems",lp)
							end
						end,
					false)
				end
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							triggerServerEvent("show:license",lp)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",false)
							openTradeUI()
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

function openTradeUI()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			setWindowData("add","cursor_clicked",false)
			dgsSetInputMode("no_binds")
			dgsSetInputMode("no_binds_when_editing")
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-450/2,GLOBALscreenY/2-250/2,450,250,"Interaction(Trade) with "..getElementData(lp,"set:clickedplayer"),false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(0,-25,26,25,"<-",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			Lakeside.Button[2]=dgsCreateButton(424,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsSetProperty(Lakeside.Button[2],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,450,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-450/2,GLOBALscreenY/2-250/2,450,250,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Label[1]=dgsCreateLabel(235,10,100,5,"Target: "..getElementData(lp,"set:clickedplayer").."",false,Lakeside.Window[1])
			Lakeside.Label[1]=dgsCreateLabel(235,120,100,5,"Amount:",false,Lakeside.Window[1])
			Lakeside.Edit[1]=dgsCreateEdit(230,135,215,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			Lakeside.Button[3]=dgsCreateButton(230,180,215,40,"Give",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Gridlist[1]=dgsCreateGridList(5,5,220,215,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local item=dgsGridListAddColumn(Lakeside.Gridlist[1],"Item",0.5)
			local amount=dgsGridListAddColumn(Lakeside.Gridlist[1],"Amount",0.3)
			
			for i,_ in pairs(interaktionTable["Items"])do
				if(tonumber(syncClientGetElementData(interaktionTable["Items"][i][2]))>=1)then
					row=dgsGridListAddRow(Lakeside.Gridlist[1])
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,item,interaktionTable["Items"][i][1],false,false)
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,amount,math.floor(syncClientGetElementData(interaktionTable["Items"][i][2])),false,false)
				end
			end
			
			dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Edit[1])
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
							if(clicked~="" and #amount>=1)then
								if(isOnlyNumbers(amount))then
									triggerServerEvent("give:itemstouser",lp,clicked,amount)
								end
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",false)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",false)
						triggerEvent("open:interactionUI",lp)
					end
				end,
			false)
		end
	end
end