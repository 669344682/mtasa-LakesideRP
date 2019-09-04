--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:drivingschoolUI",true)
addEventHandler("open:drivingschoolUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-250/2,GLOBALscreenY/2-300/2,250,300,"Drivingschool - Duty",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(224,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,250,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-250/2,GLOBALscreenY/2-300/2,250,300,255,255,255,255,Lakeside.Window[1])
			
			dgsCreateImage(85,10,80,80,":"..settings.general.scriptname.."/Files/Images/CompanyLogo/Drivingschool.png",false,Lakeside.Window[1])
			
			
			Lakeside.Button[2]=dgsCreateButton(5,145,240,25,"Informations",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(5,175,240,45,"Go duty",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(5,225,240,45,"Go off-duty",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[4],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("go:driveonoffduty",lp,"Offduty")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("go:driveonoffduty",lp,"Onduty")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						Lakeside.Window[2]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-300/2,400,300,"Drivingschool - Informations",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
						dgsWindowSetSizable(Lakeside.Window[2],false)
						dgsWindowSetMovable(Lakeside.Window[2],false)
						Lakeside.Button[1]=dgsCreateButton(0,-25,26,25,"<-",false,Lakeside.Window[2],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
						Lakeside.Button[2]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[2],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
						dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
						dgsSetProperty(Lakeside.Button[2],"textSize",{1.6,1.6})
						dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[2],settings.general.guilinecolor)
						
						Lakeside.Tabpanel[1]=dgsCreateTabPanel(5,5,390,265,false,Lakeside.Window[2])
						Lakeside.Tab[1]=dgsCreateTab("Prices/Licenses",Lakeside.Tabpanel[1])
						
						Lakeside.Label[1]=dgsCreateLabel(10,10,20,20,"Car license - $"..settings.company.ranknames[2].carlicensePrice.."",false,Lakeside.Tab[1])
						Lakeside.Label[2]=dgsCreateLabel(10,30,20,20,"Bike license - $"..settings.company.ranknames[2].bikelicensePrice.."",false,Lakeside.Tab[1])
						--Lakeside.Label[3]=dgsCreateLabel(10,50,20,20,"LKW license - $7500",false,Lakeside.Tab[1])
						
						Lakeside.Tab[2]=dgsCreateTab("Commands",Lakeside.Tabpanel[1])
						
						Lakeside.Label[1]=dgsCreateLabel(10,10,20,20,"/exam TARGET - to send a drivingtest-invite",false,Lakeside.Tab[2])
						Lakeside.Label[2]=dgsCreateLabel(10,30,20,20,"/examend TARGET LICENSE(Car,Bike) - to give the license",false,Lakeside.Tab[2])
						
						
						addEventHandler("onDgsMouseClick",Lakeside.Button[2],
							function(btn,state)
								if(btn=="left" and state=="down")then
									dgsCloseWindow(Lakeside.Window[2])
									setWindowData("remove","cursor_clicked",true)
								end
							end,
						false)
						addEventHandler("onDgsMouseClick",Lakeside.Button[1],
							function(btn,state)
								if(btn=="left" and state=="down")then
									dgsCloseWindow(Lakeside.Window[2])
									setWindowData("remove","cursor_clicked",false)
									triggerEvent("open:drivingschoolUI",lp)
								end
							end,
						false)
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