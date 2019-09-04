--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function saveUserdata_Func(player)
local onlineplayercount=0
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=4)then
			for _,v in ipairs(getElementsByType("player"))do
				RegisterLogin_saveDatas(v)
				onlineplayercount=onlineplayercount+1
			end
			triggerClientEvent(player,"draw:infobox",root,"info","You saved all playerdatas! ("..onlineplayercount..")",8000)
		end
	end
end
addCommandHandler("sud",saveUserdata_Func)

function mutePlayer_Func(player,cmd,kplayer,time,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local reason={...}
			local reason=table.concat(reason," ")
			local target=getPlayerFromName(kplayer)
			if(#time>=1)then
				if(#reason>=3)then
					if(not isElement(target))then
						triggerClientEvent(player,"draw:infobox",root,"warning","The player is offline!",8000)
						return false
					end
					
					outputChatBox("[ADMIN]: "..getPlayerName(target).." has been muted by "..getPlayerName(player).."! Reason: "..reason.." Time: "..time.."(minutes)",root,255,0,0)
					if(tonumber(syncGetElementData(target,"Mutedtime"))>30000)then
						syncSetElementData(target,"Mutedtime",30000)
					else
						syncSetElementData(target,"Mutedtime",tonumber(syncGetElementData(target,"Mutedtime"))+time)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Enter a reason with 3 characters or higher!",8000)
				end
			end
		end
	end
end
addCommandHandler("rmute",mutePlayer_Func)
function unMutePlayer_Func(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local target=getPlayerFromName(kplayer)
			if(not isElement(target))then
				triggerClientEvent(player,"draw:infobox",root,"warning","The player is offline!",8000)
				return false
			end
			if(tonumber(syncGetElementData(target,"Mutedtime"))>=1)then
				outputChatBox("[ADMIN]: "..getPlayerName(target).." has been unmuted by "..getPlayerName(player).."!",root,255,0,0)
				syncSetElementData(target,"Mutedtime",tonumber(0))
				triggerClientEvent(player,"draw:infobox",root,"success","The player is now unmuted!",8000)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","The player is not muted!",8000)
			end
		end
	end
end
addCommandHandler("runmute",unMutePlayer_Func)

function clearchat_Func(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			for i=1,250 do
				outputChatBox(" ")
			end
			clearChatBox(root)
		end
	end
end
addCommandHandler("cc",clearchat_Func)
addCommandHandler("clearchat",clearchat_Func)


local function rBan_Func(player,cmd,kplayer,...)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=3 and(not client or client==player))then
		if(kplayer)then
			local reason=table.concat({...}, " ")
			local target=getPlayerFromName(kplayer)
			if(#reason>=3)then
				if(not target)then
					if(kplayer)then
						local serial=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","userdata","Username",kplayer),-1)[1]["Serial"]
						outputChatBox("The player was banned. (offline)!",player,200,0,0)
						dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","userbans","Username","Admin","Reason","Serial",kplayer,getPlayerName(player),reason,serial)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","The player does not exist!",8000)
					end
				else
					local serial=getPlayerSerial(target)
					outputChatBox("[ADMIN]: "..getPlayerName(target).." has been banned from the server by "..getPlayerName(player).." permanently (Reason: "..tostring(reason)..")",root,255,0,0)
					dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","userbans","Username","Admin","Reason","Serial",kplayer,getPlayerName(player),reason,serial)
					kickPlayer(target,player,tostring(reason).." (banned!)")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Enter a reason with 3 characters or higher!",8000)
			end
		end
	end
end
addCommandHandler("rban",rBan_Func)
local function UnbanDB_Func(qh,player,kplayer) 
	local result=dbPoll(qh,0)
	if(result and result[1])then
		local name=result[1]["Username"]
		dbExec(handler,"DELETE FROM userbans WHERE Username LIKE ?",name)
		outputChatBox("[ADMIN]: "..getPlayerName(player).." has "..kplayer.." unbanned!",root,200,0,0)
		outputLog("Staff "..getPlayerName(player).." has "..kplayer.." unbanned!","Adminsystem")
	end
end
function Unban_Func(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=4)then
			dbQuery(UnbanDB_Func,{player,kplayer},handler,"SELECT ?? FROM ?? WHERE ??=?","Username","userbans","Username",kplayer)
		end
	end
end
addCommandHandler("unban",Unban_Func)
local function tBan_Func(player,cmd,kplayer,btime,...)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=2 and(not client or client==player))then
		if(kplayer and btime and tonumber(btime)~=nil)then
			if tonumber(btime)>=1 and tonumber(btime)<=10 then
				local reason=table.concat({...}," ")
				if(reason)then
					if(#reason>=3)then
						local target=getPlayerFromName(kplayer)
						if(not isElement(target))then
							local success=timebanPlayer(kplayer,tonumber(btime),getPlayerName(player),reason)			
							if(success==false)then
							end
							return
						end
						local name=getPlayerName(target)
						local savename=name
						local success=timebanPlayer(savename,tonumber(btime),getPlayerName(player),reason)
						if(success==false)then
						else
							outputChatBox("Player "..kplayer.." has been banned by "..getPlayerName(player).."! Reason: "..tostring(reason).." Time: "..btime,root,255,0,0)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Enter a reason with 3 characters or higher!",8000)
					end
				end
			end
		else
			notificationShow(player,"error","Use: /tban NAME TIME REASON")
		end
	else
		notificationShow(player,"error","You are not a Supporter!")
	end
end
addCommandHandler("tban",tBan_Func)

local function rKick_Func(player,cmd,kplayer,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=2 and(not client or client==player))then
			if(kplayer)then
				local reason={...}
				local reason=table.concat(reason," ")
				local target=getPlayerFromName(kplayer)
				if(#reason>=3)then
					if(not isElement(target))then
						--notificationShow(player,"error","The player is offline!")
						return
					end
					if(getAdminLevel(player)>getAdminLevel(target))then
						outputChatBox(getPlayerName(target).." has been kicked from the server by "..getPlayerName(player).."! Reason: "..reason,root,255,0,0)
						takeAllWeapons(target)
						kickPlayer(target,player,tostring(reason))	
					else
						--notificationShow(player,"error","The player has no lower admin rank than you!")
					end
				else
					--notificationShow(player,"error","Enter a reason with 3 characters or higher!")
				end
			end
		else
			--notificationShow(player,"error","You are not a Supporter!")
		end
	end
end
addCommandHandler("rkick",rKick_Func)

local function gotoXYZ_Func(player,cmd,x,y,z)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
		setElementPosition(player,tonumber(x),tonumber(y),tonumber(z))
	end
end
addCommandHandler("xyz",gotoXYZ_Func)


addEvent("set:faction_company",true)
addEventHandler("set:faction_company",root,function(target,typ,typ2)
	if(target)then
	local target=getPlayerFromName(target)
		if(tonumber(syncGetElementData(client,"AdminLvL"))>=3)then
			if(typ2)then
				if(typ=="Faction")then
					syncSetElementData(target,"Faction",typ2)
					if(tonumber(typ2)==0)then
						syncSetElementData(target,"Factionrank",0)
					else
						syncSetElementData(target,"Factionrank",5)
					end
				elseif(typ=="Company")then
					syncSetElementData(target,"Company",typ2)
					if(tonumber(typ2)==0)then
						syncSetElementData(target,"Companyrank",0)
					else
						syncSetElementData(target,"Companyrank",5)
					end
				end
			end
		end
	end
end)


function gotoPrivateCar(player,cmd,target,slot)
	if(target)then
		local target=getPlayerFromName(target)
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=3)then
			if(slot and #slot>=1)then
				if(Vehicles[getPlayerName(target)..slot])then
					local x,y,z=getElementPosition(Vehicles[getPlayerName(target)..slot])
					local dim=getElementDimension(Vehicles[getPlayerName(target)..slot])
					local int=getElementInterior(Vehicles[getPlayerName(target)..slot])
					
					setElementPosition(player,x,y,z+3)
					setElementDimension(player,dim)
					setElementInterior(player,int)
				end
			end
		end
	end
end
addCommandHandler("gotocar",gotoPrivateCar)
function getPrivateCar(player,cmd,target,slot)
	if(target)then
		local target=getPlayerFromName(target)
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=3)then
			if(slot and #slot>=1)then
				if(Vehicles[getPlayerName(target)..slot])then
					local x,y,z=getElementPosition(player)
					local dim=getElementDimension(player)
					local int=getElementInterior(player)
					
					setElementPosition(Vehicles[getPlayerName(target)..slot],x,y,z+3)
					setElementDimension(Vehicles[getPlayerName(target)..slot],dim)
					setElementInterior(Vehicles[getPlayerName(target)..slot],int)
				end
			end
		end
	end
end
addCommandHandler("getcar",getPrivateCar)