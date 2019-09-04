function meChat(player,cmd,...)
    if(isLoggedin(player))then
        if(...)then
            if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
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
                                outputChatBox("✪ "..getPlayerName(player):gsub("_"," ")..": "..stringTextWithAllParameters(...),v,230,25,140)
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
addCommandHandler("mee",meChat)