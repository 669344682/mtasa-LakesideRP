--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function adminChat(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
		local message=table.concat({...}," ") 
			if(not isPedDead(player))then
				for _,v in ipairs(getElementsByType("player"))do
					if(isLoggedin(v))then
						if(tonumber(syncGetElementData(v,"AdminLvL"))>=1)then
							if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
								outputChatBox("#ffffff[#c80000Admin#ffffff]: "..settings.admin.colorToHASH[syncGetElementData(player,"AdminLvL")].." "..getPlayerName(player):gsub("_"," ").."#ffffff: "..message.."",v,255,255,255,true)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("adminchat",adminChat)
addCommandHandler("a",adminChat)