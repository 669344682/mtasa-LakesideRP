--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function teamChat(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Faction"))>=1)then
			if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
				if(not isPedDead(player))then
					for _,v in ipairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							if(tonumber(syncGetElementData(v,"Faction"))==tonumber(syncGetElementData(player,"Faction")))then
								outputChatBox("[Team]#ffffff: "..getPlayerName(player):gsub("_"," ")..": "..stringTextWithAllParameters(...),v,255,255,255,true)
							end
						end
					end
				end
			else
				notificationShow(player,"error","You are muted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." minutes)")
			end
		end
	end
end
addCommandHandler("Teamchat",teamChat)