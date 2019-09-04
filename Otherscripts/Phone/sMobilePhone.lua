--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function callPlayer(number)
	if(number)then
		if(tonumber(syncGetElementData(client,"Mobilephone"))>=1)then
			for _,v in ipairs(getElementsByType("player"))do
				if(tonumber(syncGetElementData(v,"Telenr"))==tonumber(number))then
					if(tonumber(syncGetElementData(v,"Mobilephone"))>=1)then
						if(tonumber(syncGetElementData(v,"PhoneState"))==1)then
							if(tonumber(syncGetElementData(v,"Telenr"))~=0)then
								if(getElementData(client,"call")==false)then
									if(getElementData(v,"call")==false)then
										setElementData(client,"calls",getPlayerName(v))
										setElementData(v,"calledby",getPlayerName(client))
										setElementData(client,"call",true)
										outputChatBox(""..getPlayerName(client).." (Number: "..syncGetElementData(client,"Telenr")..") called you! Type /takeoff to hangup.",v,0,200,0)
									end
								end
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","The mobilephone of the player is turned off!",8000)
						end
					end
				end
			end
		end
	end
end
addEvent("call:player",true)
addEventHandler("call:player",root,callPlayer)

function acceptCall(player)
	local caller=getPlayerFromName(getElementData(player,"calledby"))
	setElementData(player,"calledby","none")
	if(caller)then
		setElementData(player,"call",true)
		setElementData(caller,"call",true)
		setElementData(player,"callswith",getPlayerName(caller))
		setElementData(caller,"callswith",player:getName())
		outputChatBox("Tippe /hangup, to end the call.",player,0,200,0)
		outputChatBox("Tippe /hangup, to end the call.",caller,0,200,0)
	end
end
addCommandHandler("takeoff",acceptCall)

function hangupCall(player)
	if(getElementData(player,"call")==true)then
		setElementData(getPlayerFromName(getElementData(player,"calls")),"calledby","none")
		local caller=getPlayerFromName(getElementData(player,"callswith"))
		
		if(caller)then
			setElementData(caller,"callswith","none")
			setElementData(caller,"call",false)
			setElementData(caller,"calls","none")
			setElementData(caller,"callswith","none")
			setElementData(caller,"calledby","none")
		end
		setElementData(player,"callswith","none")
		setElementData(player,"call",false)
		setElementData(player,"calls","none")
		setElementData(player,"callswith","none")
		setElementData(player,"calledby","none")
		outputChatBox("You have finished the call!",player,0,200,0)
		
		if(getPlayerPing(caller)~=false)then
			outputChatBox("Your conversation partner has finished the call!",caller,200,0,0)
		end
	end
end
addCommandHandler("hangup",hangupCall)
addEvent("call:denied",true)
addEventHandler("call:denied",root,hangupCall)