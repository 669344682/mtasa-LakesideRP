--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local pizzaRouteMarkers={
	{2067.4,-1731.6,13.9},
	{2065.3,-1703.5,14.1},
	{2172.6,-1615.3,14.3},
	{2165.6,-1590.5,14.3},
	{2015.3,-1732.6,14.2},
	{2015.6,-1717.0,13.9},
	{2018.3,-1703.3,14.2},
	{1981.1,-1682.9,17.1},
}

addEvent("createPizzaMarker",true)
addEventHandler("createPizzaMarker",root,function(typ)
	if(isElement(pizzaMarker))then
		destroyElement(pizzaMarker)
	end
	if(isElement(pizzaBlip))then
		destroyElement(pizzaBlip)
	end
	if(typ=="create")then
		local rnd=math.random(1,#pizzaRouteMarkers)
		local x,y,z=pizzaRouteMarkers[rnd][1],pizzaRouteMarkers[rnd][2],pizzaRouteMarkers[rnd][3]
		pizzaMarker=createMarker(x,y,z,"cylinder",2,255,255,0,140)
		pizzaBlip=createBlip(x,y,z,0,2,255,255,0)
		
		addEventHandler("onClientMarkerHit",pizzaMarker,function(player)
			if(player==lp)then
				triggerServerEvent("trigger:pizzaserver",lp)
			end
		end)
	end
end)




addEvent("open:pizzajob",true)
addEventHandler("open:pizzajob",root,function()
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
					
					
					Lakeside.Image[1]=dgsCreateImage(5,5,330,140,":"..settings.general.scriptname.."/Files/Images/UI/Jobs/Pizzaboy.png",false,Lakeside.Window[1])
					dgsCreateLabel(5,145,100,20,"INFO: You get the money at the payday!",false,Lakeside.Window[1])
					dgsCreateLabel(5,160,100,20,"Jobmoney: $70 per delivery.",false,Lakeside.Window[1])
					
					Lakeside.Button[2]=dgsCreateButton(5,190,330,40,"Accept Pizza-job",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
								syncClientSetElementData("Job","Pizzaboy")
								triggerEvent("draw:infobox",lp,"success","You accepted the Pizza Job!",8000)
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