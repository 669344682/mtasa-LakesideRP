--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Hade         ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function oocChat(player,cmd,...)
    if(isLoggedin(player))then
        if(...)then
            if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
				if(not isPedDead(player))then
					local x,y,z=getElementPosition(player)
					local int=getElementInterior(player)
					local dim=getElementDimension(player)
					
					local nearbyPlayers=getElementsByType("player")
							
					for _,v in ipairs(nearbyPlayers)do
						if(isLoggedin(v))then
							local vx,vy,vz=getElementPosition(v)
							local vint=getElementInterior(v)
							local vdim=getElementDimension(v)
							
							if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=16)then
								if(int==vint and dim==vdim)then
									outputChatBox("(( OOC "..getPlayerName(player):gsub("_"," ")..": "..stringTextWithAllParameters(...).." ))",v,210,210,210)
								end
							end
						end
					end
                end
            else
                triggerClientEvent(player,"draw:infobox",root,"error","You are muted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." minutes)",10000)
            end
        end
    end
end
addCommandHandler("OOC",oocChat)