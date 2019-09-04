--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:taxijob",true)
addEventHandler("open:taxijob",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(syncClientGetElementData("IDcard")==1)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,settings.general.servername.." - Job",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(314,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,340,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,255,255,255,255,Lakeside.Window[1])
					
					
					Lakeside.Image[1]=dgsCreateImage(5,5,330,140,":"..settings.general.scriptname.."/Files/Images/UI/Jobs/Taxidriver.png",false,Lakeside.Window[1])
					dgsCreateLabel(5,145,100,20,"INFO: You get the money at the payday!",false,Lakeside.Window[1])
					dgsCreateLabel(5,160,100,20,"Jobmoney: $3 per 5sec.",false,Lakeside.Window[1])
					
					Lakeside.Button[2]=dgsCreateButton(5,190,330,40,"Accept Taxidriver-job",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
								syncClientSetElementData("Job","Taxidriver")
								triggerEvent("draw:infobox",lp,"success","You accepted the Taxidriver Job!",8000)
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
				else
					triggerEvent("draw:infobox",lp,"error","You do not have a ID card!",8000)
				end
			end
		end
	end
end)