--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

lsTOsf=createObject(968,60.4,-1529,4.8,0,-90,264)
sfTOls=createObject(968,43.2,-1534.6,4.9,0,-90,84.24)
lsTOsf1=createObject(968,86.9,-1263.6,14.4,0,-90,304.3)
sfTOls1=createObject(968,102.4,-1284.4,14.1,0,-90,304.3)
lsTOlv=createObject(968,1726,437.9,30.8,0,-90,341.5)
lvTOls=createObject(968,1695.6,448.5,30.8,0,-90,161.5)
lsTOlv2=createObject(968,526.4,476.2,18.7,0,-90,35)
lvTOls2=createObject(968,514.8,468.8,18.7,0,-90,215)
lsTOlv3=createObject(968,-161.7,364,11.9,0,-90,345.25)
lvTOls3=createObject(968,-175,367.9,11.9,0,-90,165.5)

local mautMarkerTable={
{66.9,-1526.1,3.7,lsTOsf},
{37.5,-1537.3,4.1,sfTOls},
{89.9,-1257.5,13.2,lsTOsf1},
{95.7,-1285.1,12.7,sfTOls1},
{1720.2,434,29.8,lsTOlv},
{1700.9,451.5,29.8,lvTOls},
{526.4,469.6,17.8,lsTOlv2},
{515.2,474.6,17.8,lvTOls2},
{-166.8,360,10.9,lsTOlv3},
{-170.1,371.5,10.9,lvTOls3},
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Tollgate={}
	local TollgateTimer={}
	for i,v in pairs(mautMarkerTable)do
		Tollgate[i]=createMarker(v[1],v[2],v[3],"corona",4,0,0,0)
		Tollgate[i]:setAlpha(0)
		
		addEventHandler("onMarkerHit",Tollgate[i],function(player)
			if(getElementType(player)=="vehicle")then
				local veh=getVehicleOccupant(player,0)
				if(getElementData(v[4],"moved")==false)then
					if(tonumber(syncGetElementData(veh,"Wanteds"))==0)then
						if(getElementDimension(veh)==0)then
							if(tonumber(syncGetElementData(veh,"Money"))>=25)then
								syncSetElementData(veh,"Money",tonumber(syncGetElementData(veh,"Money"))-25)
								setElementData(v[4],"moved",true)
								local x,y,z=getElementPosition(v[4])
								moveObject(v[4],1700,x,y,z,0,90,0)
								mautGateMoved=true
								TollgateTimer[i]=setTimer(function()
									local x,y,z=getElementPosition(v[4])
									moveObject(v[4],1700,x,y,z,0,-90,0)
									mautGateMoved=false
								end,4500,1)
								TollgateTimer[i]=setTimer(function()
									setElementData(v[4],"moved",false)
								end,7200,1)
								triggerClientEvent(veh,"draw:infobox",root,"info","You can happen now!",8000)
							else
								triggerClientEvent(veh,"draw:infobox",root,"error","You do have not enough money! ($25)",8000)
							end
						end
					else
						triggerClientEvent(veh,"draw:infobox",root,"error","Since you have Wanted, you cannot pass a toll!",8000)
					end
				end
			end
		end)
	end
end)