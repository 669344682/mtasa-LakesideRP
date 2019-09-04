--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local GangtagMarker={}
local GangtagObject={}
local GangtagPlayerTimer={}

function createGangtags()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM factiontags"),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			GangtagMarker[v["ID"]]=createMarker(v["SpawnX"],v["SpawnY"],v["SpawnZ"],"cylinder",1.5,0,0,0,0)
			GangtagObject[v["ID"]]=createObject(2717,v["SpawnOX"],v["SpawnOY"],v["SpawnOZ"],0,0,v["SpawnOROT"])
			
			setElementData(GangtagMarker[v["ID"]],"GangtagID",v["ID"])
			setElementData(GangtagMarker[v["ID"]],"GangtagOwner",v["Owner"])
			setElementData(GangtagMarker[v["ID"]],"gangtagstate",true)
			
			
			addEventHandler("onMarkerHit",GangtagMarker[v["ID"]],function(player)
				if(not isPedInVehicle(player)and isPedOnGround(player))then
					if(getElementDimension(player)==getElementDimension(source))then
						if(isEVIL(player))then
							if(getPedWeapon(player)==41)then
								if(getElementData(source,"gangtagstate")==true)then
									if(tonumber(syncGetElementData(player,"Faction"))~=getElementData(source,"GangtagOwner"))then
										local ID=getElementData(source,"GangtagID")
										setElementFrozen(player,true)
										toggleAllControls(player,false)
										setPedAnimation(player,"spraycan","spraycan_fire")
										setElementData(source,"gangtagstate",false)
										
										GangtagPlayerTimer[player]=setTimer(function(player,id)
											setElementData(GangtagMarker[id],"GangtagOwner",tonumber(syncGetElementData(player,"Faction")))
											
											handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiontags","Owner",getElementData(GangtagMarker[id],"GangtagOwner"),"ID",id)
											setElementFrozen(player,false)
											toggleAllControls(player,true)
											setPedAnimation(player)
											
											setTimer(function(marker)
												setElementData(marker,"gangtagstate",true)
											end,60*60*1000,1,GangtagMarker[id])
											
											for _,v in pairs(getElementsByType("player"))do
												loadGangtagTextures(v)
											end
										end,20000,1,player,ID)
									end
								end
							else
								triggerClientEvent(player,"draw:infobox",root,"error","First take a spraycan in your hand!",8000)
							end
						end
					end
				end
			end)
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,createGangtags)

function loadGangtagTextures(player)
	for i,v in pairs(GangtagMarker)do
		triggerClientEvent(player,"load:gangtagtextures",player,GangtagObject[i],getElementData(v,"GangtagOwner"))
	end
end


function killGangtagTimer(player)
	if(isTimer(GangtagPlayerTimer[player]))then
		GangtagPlayerTimer[player]:destroy()
	end
end

addEventHandler("onPlayerQuit",root,function()
	killGangtagTimer(source)
end)
addEventHandler("onPlayerWasted",root,function()
	killGangtagTimer(source)
end)