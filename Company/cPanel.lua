--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

bindKey("f4","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"Company")~=0)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,settings.general.servername.." - Companypanel ("..settings.company.ranknames.levelnames[tonumber(getElementData(lp,"Company"))]..")",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,500,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,255,255,255,255,Lakeside.Window[1])
					
					Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,480,335,false,Lakeside.Window[1])
					Lakeside.Tab[1]=dgsCreateTab("Main",Lakeside.Tabpanel[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,7,280,305,false,Lakeside.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					members=dgsGridListAddColumn(Lakeside.Gridlist[1],"Member",0.62)
					rank=dgsGridListAddColumn(Lakeside.Gridlist[1],"Rank",0.34)
					
					dgsCreateLabel(300,12,100,20,"Type a Name to invite",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
					Lakeside.Edit[1]=dgsCreateEdit(290,30,185,35,"",false,Lakeside.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					Lakeside.Button[2]=dgsCreateButton(290,70,185,35,"Invite  [R4]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(290,110,185,35,"Uninvite  [R4]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[4]=dgsCreateButton(290,150,185,35,"Rank up  [R5]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[5]=dgsCreateButton(290,190,185,35,"Rank down  [R5]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[2]=dgsCreateTab("more soon...",Lakeside.Tabpanel[1])
					
					
					
					if(getElementData(lp,"Companyrank")==5)then
						dgsSetEnabled(Lakeside.Button[5],true)
						dgsSetEnabled(Lakeside.Button[4],true)
					else
						dgsSetEnabled(Lakeside.Button[5],false)
						dgsSetEnabled(Lakeside.Button[4],false)
					end
					
					if(getElementData(lp,"Companyrank")>=4)then
						dgsSetEnabled(Lakeside.Edit[1],true)
						dgsSetEnabled(Lakeside.Button[2],true)
						dgsSetEnabled(Lakeside.Button[3],true)
					else
						dgsSetEnabled(Lakeside.Edit[1],false)
						dgsSetEnabled(Lakeside.Button[2],false)
						dgsSetEnabled(Lakeside.Button[3],false)
					end
					
					triggerServerEvent("get:companypanelmembers",lp,lp)
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("rankdown:Cplayer",lp,clicked)
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
										triggerServerEvent("rankup:Cplayer",lp,clicked)
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
										triggerServerEvent("uninvite:Cplayer",lp,clicked)
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
									triggerServerEvent("invite:Cplayer",lp,target)
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


addEvent("refresh:companypanel",true)
addEventHandler("refresh:companypanel",root,function(member)
	dgsGridListClear(Lakeside.Gridlist[1])
	if(member and #member>=1)then
		for _,v in pairs(member)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[1])
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,members,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,rank,settings.company.ranknames[v[2]][v[3]].."("..v[3]..")",false,false)
		end
	end
end)