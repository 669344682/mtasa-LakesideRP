--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local antiSpamMSG={}
setTimer(function()
	for _,v in ipairs(getElementsByType("player"))do
		antiSpamMSG[v]=0
	end
end,5000,0)

addEventHandler("onPlayerPrivateMessage",root,
function()
    cancelEvent()
end)

function localChat(message,messageTyp)
	if(isLoggedin(source))then
		if(not isPedDead(source))then
			if(tonumber(syncGetElementData(source,"Mutedtime"))==0)then
				if(messageTyp==0)then
					if(not(antiSpamMSG[source]))then
						antiSpamMSG[source]=0
					end
					antiSpamMSG[source]=antiSpamMSG[source]+1
					
					if(antiSpamMSG[source]<=3)then
						local x,y,z=getElementPosition(source)
						local interior=getElementInterior(source)
						local dimension=getElementDimension(source)
						local pname=getPlayerName(source):gsub("_"," ")
						
						local nearbyPlayers=getElementsByType("player")
						for _,v in ipairs(nearbyPlayers)do
							if(isLoggedin(v))then
								local vx,vy,vz=getElementPosition(v)
								local vinterior=getElementInterior(v)
								local vdimension=getElementDimension(v)
								
								if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10)then
									if(interior==vinterior and dimension==vdimension)then
										if(getElementData(source,"call"))then
											outputChatBox("[Handy]: "..pname.." says: "..message,v,255,255,255)
										else
											if(isPedInVehicle(source))then
												outputChatBox("[Local - In Car]: "..pname.." says: "..message,v,255,255,255)
											else
												outputChatBox("[Local]: "..pname.." says: "..message,v,255,255,255)
											end
										end
									end
								end
							end
						end
					else
						triggerClientEvent(source,"draw:infobox",root,"error","Please dont spam!",8000)
					end
				elseif(messageTyp==1)then
					if(antiSpamMSG[source]<=3)then
						local x,y,z=getElementPosition(source)
						local interior=getElementInterior(source)
						local dimension=getElementDimension(source)
						local pname=getPlayerName(source):gsub("_"," ")
						
						local nearbyPlayers=getElementsByType("player")
						for _,v in ipairs(nearbyPlayers)do
							if(isLoggedin(v))then
								local vx,vy,vz=getElementPosition(v)
								local vinterior=getElementInterior(v)
								local vdimension=getElementDimension(v)
								
								if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=16)then
									if(interior==vinterior and dimension==vdimension)then
										outputChatBox("✪ "..pname..": "..message,v,230,25,140)
									end
								end
							end
						end
					else
						triggerClientEvent(source,"draw:infobox",root,"error","Please dont spam!",8000)
					end
				elseif(messageTyp==2)then
					executeCommandHandler("t",source,message)
				end
			else
				triggerClientEvent(source,"draw:infobox",root,"error","You are muted! ("..tonumber(syncGetElementData(source,"Mutedtime")).." minutes)",10000)
			end
		end
	end
	cancelEvent()
end
addEventHandler("onPlayerChat",root,localChat)


function mChat(player,cmd,...)
    if(isLoggedin(player))then
        if(...)then
			local veh=getPedOccupiedVehicle(player)
			if(veh)then
				local id=getElementModel(veh)
				if(syncGetElementData(player,"CopDuty")==true)then
					if(id==597 or id==596 or id==490 or id==528)then
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
									
									if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=30)then
										if(int==vint and dim==vdim)then
											outputChatBox("["..settings.faction.ranknames[tonumber(syncGetElementData(player,"Faction"))][tonumber(syncGetElementData(player,"Factionrank"))].."] "..getPlayerName(player):gsub("_"," ")..": "..stringTextWithAllParameters(...),v,255,255,0)
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
        end
    end
end
addCommandHandler("m",mChat)
addCommandHandler("megaphone",mChat)