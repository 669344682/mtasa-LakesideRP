--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local busPoint=0
local busRoute=0

local busRoutes={
	[1]={
		{1142.9,-1744.2,12.4,true},
		{1171.7,-1799.0,12.4,false},
		{1249.8,-1855.6,12.4,true},
		{1369.4,-1735.5,12.4,false},
		{1427.6,-1735.5,12.4,true},
		{1791.5,-1735.5,12.4,false},
		{1824.2,-1657.1,12.4,true},
		{1854.7,-1302.8,12.4,false},
		{1608.6,-1295.5,16.3,true},
		{1451.6,-1353.8,12.4,false},
		{1379.2,-1583.9,12.4,true},
		{1360.9,-1300.5,12.3,true},
		{1192.5,-1355.4,12.3,true},
		{1034.3,-1613.9,12.4,false},
		{1106.7,-1715.3,12.4,true},
	},
}
function createBusMarker(type)
	if(busRoute==0)then
		busRoute=math.random(1,#busRoutes)
	end
	if(isElement(busMarker))then
		destroyElement(busMarker)
	end
	if(isElement(busBlip))then
		destroyElement(busBlip)
	end
	
	if(type)then
		if(isPedInVehicle(lp))then
			if(busPoint<#busRoutes[busRoute])then
				local rdmTime=math.random(5,9)
				busPoint=busPoint+1
				local tbl=busRoutes[busRoute][busPoint]
				busMarker=createMarker(tbl[1],tbl[2],tbl[3],"cylinder",2,255,255,0,140)
				busBlip=createBlip(tbl[1],tbl[2],tbl[3],0,2,255,255,0)
				
				addEventHandler("onClientMarkerHit",busMarker,function(player)
					if(player==lp)then
						if(getElementModel(getPedOccupiedVehicle(lp))==431)then
							if(tbl[4]==true)then
								setElementFrozen(getPedOccupiedVehicle(lp),true)
								setTimer(function()
									if(isPedInVehicle(lp))then
										setElementFrozen(getPedOccupiedVehicle(lp),false)
										createBusMarker("create")
									end
								end,rdmTime*1000,1)
								triggerEvent("show:timerui",lp,"Busjob",rdmTime)
							elseif(tbl[4]==false)then
								createBusMarker("create")
							end
							triggerEvent("draw:infobox",lp,"info","Drive to the next Marker!",8000)
						end
					end
				end)
			else
				triggerServerEvent("give:jobmoney",lp,"Busdriver",600)
				refreshBusMarker()
				createBusMarker("create")
			end
		end
	end
end
addEvent("createBusMarker",true)
addEventHandler("createBusMarker",root,createBusMarker)

function refreshBusMarker()
	busRoute=0
	busPoint=0
end
addEvent("refreshBusMarker",true)
addEventHandler("refreshBusMarker",root,refreshBusMarker)











addEvent("open:busjob",true)
addEventHandler("open:busjob",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(syncClientGetElementData("IDcard")==1)then
					if(syncClientGetElementData("Joblevel")>=2)then
						setWindowData("add","cursor_clicked",true)
						Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,settings.general.servername.." - Job",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
						dgsWindowSetSizable(Lakeside.Window[1],false)
						dgsWindowSetMovable(Lakeside.Window[1],false)
						Lakeside.Button[1]=dgsCreateButton(314,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
						dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
						dgsCreateImage(0,0,340,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
						Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,255,255,255,255,Lakeside.Window[1])
						
						
						Lakeside.Image[1]=dgsCreateImage(5,5,330,140,":"..settings.general.scriptname.."/Files/Images/UI/Jobs/Busdriver.png",false,Lakeside.Window[1])
						dgsCreateLabel(5,145,100,20,"INFO: You get the money at the payday!",false,Lakeside.Window[1])
						dgsCreateLabel(5,160,100,20,"Jobmoney: $600 per round.(Complete a round to get money)",false,Lakeside.Window[1])
						
						Lakeside.Button[2]=dgsCreateButton(5,190,330,40,"Accept Busdriver-job",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
						
						addEventHandler("onDgsMouseClick",Lakeside.Button[2],
							function(btn,state)
								if(btn=="left" and state=="down")then
									if(syncClientGetElementData("Joblevel")>=2)then
										dgsCloseWindow(Lakeside.Window[1])
										setWindowData("remove","cursor_clicked",true)
										syncClientSetElementData("Job","Busdriver")
										triggerEvent("draw:infobox",lp,"success","You accepted the Busdriver Job!",8000)
									else
										triggerEvent("draw:infobox",lp,"error","You need Joblevel 2 or higher!",8000)
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
					else
						triggerEvent("draw:infobox",lp,"error","You need Joblevel 2 or higher!",8000)
					end
				else
					triggerEvent("draw:infobox",lp,"error","You do not have a ID card!",8000)
				end
			end
		end
	end
end)