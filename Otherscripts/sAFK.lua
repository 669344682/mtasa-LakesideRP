--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local AFKPlayerTable={}

setTimer(function()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			if(getPlayerIdleTime(v)>15*60*1000)then
				if(getElementData(v,"AFK")~=true)then
					AFKPlayerTable[v]=math.random(1000,9999)
					outputChatBox("You were set AFK! Type /afk "..AFKPlayerTable[v].." to exit the AFK mode.",v,255,255,255)
					setElementData(v,"AFK",true)
					if(isPedInVehicle(v))then
						local veh=getPedOccupiedVehicle(v)
						setElementFrozen(veh,true)
						
						addEventHandler("onVehicleStartExit",veh,function(player)
							if(getElementData(player,"AFK")~=false)then
								cancelEvent()
								triggerClientEvent(player,"draw:infobox",root,"info","You are AFK! Type /afk "..AFKPlayerTable[player].." to exit the AFK mode.",8000)
							end
						end)
					else
						setElementFrozen(v,true)
					end
				end
			end
		end
	end
end,1000*60,0)

addCommandHandler("afk",function(player,cmd,number)
	if(getElementData(player,"AFK")==true)then
		if(AFKPlayerTable[player])then
			if(number)then
				if(tonumber(number)==AFKPlayerTable[player])then
					setElementData(player,"AFK",false)
					setElementFrozen(player,false)
					triggerClientEvent(player,"draw:infobox",root,"info","You have left the AFK mode.",8000)
					if(isPedInVehicle(player))then
						setElementFrozen(getPedOccupiedVehicle(player),false)
					end
					AFKPlayerTable[player]=nil
				end
			end
		end
	end
end)