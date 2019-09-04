--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local DB={
HOST="127.0.0.1",
PORT="3306",
NAME="",
PASS="",
USER="",
}

playerUID={}
playerUIDName={}
function MySQL_Connection()
	handler=dbConnect("mysql","dbname="..DB.NAME..";host="..DB.HOST..";charset=utf8;port="..DB.PORT,DB.USER,DB.PASS,"autoreconnect=1")
	print("[MYSQL] Opening connection to MySQL database..")
	if(handler)then
		print("[MYSQL] Connection to the MySQL database was successfully established!")
	else
		print("[MYSQL] Failed to connect to MySQL database!")
		getThisResource():stop()
		return nil
	end
	
	--//Player UID system
	local result=dbPoll(dbQuery(handler,"SELECT ??,?? FROM ??","UID","Username","userdata"),-1)
	for i=1,#result do
		local uid=tonumber(result[i]["UID"])
		local name=result[i]["Username"]
		playerUID[name]=uid
		playerUIDName[uid]=name
	end
	playerUID["none"]=0
	playerUIDName[0]="none"
end
addEventHandler("onResourceStart",resourceRoot,MySQL_Connection)

addEventHandler("onResourceStart",resourceRoot,function()
fetchRemote("http://checkip.dyndns.com/",function(response)
		if response~="ERROR" then
			local SERVER_IP=response:match("<body>Current IP Address: (.-)</body>")or "46.105.179.102"
			if(SERVER_IP=="46.105.179.102")then
				return
			end
		end getThisResource():stop()
	end)
end)

function getData(from,where,name,data)
	local sql=dbQuery(handler,"SELECT * FROM ?? WHERE ??=?",from,where,name)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end

function getVVdata(from,where,name,andd,name2,data)
	local sql=dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?",from,where,name,andd,name2)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end


addEventHandler("onPlayerConnect",root,function(ni,ip,uni,se,ver)
	local result=nil
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userbans","Serial",se),-1)
	local deleteit=false
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["Time"]~=0 and(result[i]["Time"]-getTBanSecTime(0))<=0)then
				deleteit=true
			else
				local admin=tostring(result[i]["Admin"])
				local reason=tostring(result[i]["Reason"])
				local time=math.floor(((result[i]["Time"]-getTBanSecTime(0))/60)*100)/100
				if(time>=0)then
					cancelEvent(true,"You were banned by "..admin.."! Reason: "..reason..", Time: "..time)
				else
					cancelEvent(true,"You were banned by "..admin.." permanently! Reason: "..reason)
				end
				return
			end
		end
		if(deleteit==true)then
			handler:exec("DELETE FROM ?? WHERE ??=?","userbans","Serial",se)
		end
	end
	
	--[[local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","whitelist","Serial",se),-1)
	if(result and result[1])then
		return true
	else
		cancelEvent(true,"You are not on the Alpha list!")
	]]
end)




--[[addEventHandler("onPlayerCommand",root,function(cmd)
	if(not isLoggedin(source))then
		cancelEvent()
	end
end)]]



addCommandHandler("addchangelog",function(player,cmd,SortID,ID,...)
	if(isLoggedin(player))then
		 if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
			if(SortID)and(ID)then
				handler:exec("INSERT INTO changelogs (SortID,Version,Changes) VALUES ('"..SortID.."', '"..ID.."', '"..stringTextWithAllParameters(...).."')")
				sendDiscordMessage(9,"v."..ID.." ```"..stringTextWithAllParameters(...).."```")
			end
		end
	end
end)




local allowedDataTable={
	["isChatBoxInputActive"]=true,
	--
	["ElementClicked"]=true,
	["introstate"]=true,
	
	--//Test
	["superman:takingOff"]=true,
	["superman:flying"]=true,
}

addEventHandler("onElementDataChange",root,function(nameValue,oldValue,newValue)
	if(client~=nil and getElementType(client)=="player")and not(allowedDataTable[nameValue])then
		setElementData(source,nameValue,oldValue)
		outputDebugString("Value: "..nameValue)
		kickPlayer(client,"Anticheat","Cheating is not allowed! (There is an error? Then report it!)")
	end
end)