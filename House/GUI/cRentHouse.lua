--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:houserent",true)
addEventHandler("open:houserent",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			if(Lakeside.Window[1])then Lakeside.Window[1]:destroy()end
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,settings.general.servername.." - Rent house",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Button[2]=dgsCreateButton(5,235,135,35,"Rent house",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(5,195,135,35,"Unrent house",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(160,235,135,35,"Enter house",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			local house=getElementData(lp,"house")
			id=getElementData(house,"ID")
			locked=getElementData(house,"State")
			price=getElementData(house,"Price")
			rent=getElementData(house,"Rent")
			
			
			if(locked=="true")then
				locked="Open"
			elseif(locked=="false")then
				locked="Closed"
			end
			
			
			dgsCreateLabel(10,10,200,40,"Housenumber: "..id,false,Lakeside.Window[1])
			dgsCreateLabel(10,40,200,40,"House Price: $"..price,false,Lakeside.Window[1])
			dgsCreateLabel(10,70,200,40,"Door state: "..locked,false,Lakeside.Window[1])
			dgsCreateLabel(10,100,200,40,"Rent: $"..rent,false,Lakeside.Window[1])
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[4],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("enter:house",lp,lp)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("unrent:house",lp,lp)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("rent:house",lp,lp)
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
		end
	end
end)