--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local animationListTable={
	"Fuck you",
	"Handsup",
	"Laugh",
	"Show something",
	"Wank",
}

bindKey("f7","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(not isPedInVehicle(lp))then
				if(getElementData(lp,"ElementClicked")==false)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(20,GLOBALscreenY/2-400/2,300,400,settings.general.servername.." - Animations",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-300/2,GLOBALscreenY/2-400/2,300,400,255,255,255,255,Lakeside.Window[1])
					
					dgsCreateLabel(5,5,100,10,"Doubleclick on a animation to start it.\nPress space to stop it.",false,Lakeside.Window[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,40,290,330,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					local anim=dgsGridListAddColumn(Lakeside.Gridlist[1],"Animation",0.95)
					
					for i,_ in pairs(animationListTable)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[1])
						dgsGridListSetItemText(Lakeside.Gridlist[1],row,anim,animationListTable[i],false,false)
					end
					
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("start:animation",lp,clicked)
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