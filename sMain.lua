--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

setFPSLimit(64)

local function setInfosAtStart()
    setGameType(settings.general.servername.." RP v."..settings.general.scriptversion.."")
	setServerPassword("")
	
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			setElementData(v,"ElementClicked",false)
			setElementData(v,"Loggedin",0)
			local rdm=math.random(1000,9999)
			setPlayerName(v,"Lakeside:RP_User_"..rdm)
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,setInfosAtStart)
setTimer(setInfosAtStart,1000,1)

function changeServerSlots(player,cmd,amount)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
			setMaxPlayers(tonumber(amount))
			setServerConfigSetting("maxplayers",""..amount.."",true)
		end
	end
end
addCommandHandler("setslots",changeServerSlots)

function executeAdminServerCMD_func(cmd,arguments)
	executeCommandHandler(cmd,client,arguments)
end
addEvent("executeAdminServerCMD",true)
addEventHandler("executeAdminServerCMD",root,executeAdminServerCMD_func)

addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent()
end)

--//Loadingscreen
function fadeElementInterior(player,x,y,z,rot,int,dim,frozen)
	if(player and isElement(player)and getElementType(player)=="player")then
		if(getElementData(player,"intchange")==false)then
			setElementData(player,"intchange",true)
			triggerClientEvent(player,"draw:loadingscreen",player)
			
			if(frozen==true)then
				player:setFrozen(true)
				setTimer(setElementFrozen,3200,1,player,false)
			end
			
			setTimer(function()
				if(x)and(y)and(z)and(int)and(dim)and(rot)then
					player:setPosition(x,y,z)
					player:setInterior(int)
					player:setDimension(dim)
					player:setRotation(0,0,rot)
					setElementData(player,"intchange",false)
					hasPlayerPizza(player)
				end
			end,3000,1)
		end
	end
end

function timebanPlayer(pname,time,admin,reason)
	local player=getPlayerFromName(pname)
	
	if(pname)then
		local sec=getTBanSecTime(time)
		local serial=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","userdata","Username",pname),-1)[1]["Serial"]
		
		handler:exec("INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","userbans","Username","Admin","Reason","Serial","Time",pname,admin,reason,serial,sec)
		outputChatBox("[ADMIN]: Player "..pname.." has been banned by "..admin.." for "..time.." hours! (Reason: "..tostring(reason)..")",root,255,0,0)
		
		if(isElement(player))then
			kickPlayer(player,"You was banned for "..time..".hours by "..admin.."! (Reason: "..reason..")")
		end
		return true
	end
	return false
end

function giveVehicleSpecialUpgrade(veh)
	local vehmodel=getElementModel(veh)
	local thisveh=getOriginalHandling(vehmodel)
	
	local sportmotor=getElementData(veh,"Sportmotor")
	if(sportmotor and sportmotor>=1)then
		setVehicleHandling(veh,"maxVelocity",thisveh["maxVelocity"]+30/3*sportmotor)
		setVehicleHandling(veh,"engineAcceleration",thisveh["engineAcceleration"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*sportmotor))
		setVehicleHandling(veh,"engineInertia",thisveh["engineInertia"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*sportmotor))
	end
	
	local lowering=getElementData(veh,"Lowering")
	if(lowering and lowering>=1)then
		setVehicleHandling(veh,"suspensionLowerLimit",thisveh["suspensionLowerLimit"]+0.05*lowering)
	end
end


local rdmpw=math.random(100000,999999)
setTimer(function()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	local weekday=time.weekday+1
	if(weekday==07)then
		handler:exec("UPDATE ?? SET ??=?","factiontags","Owner",0)
	end
	
	if(hour==03 and minute==01)then
		sendDiscordMessage(10,"> Server was successfully restarted!\n> Version: "..settings.general.scriptversion.."")
		outputChatBox("ATTENTION: Server was successfully restarted!",root,0,200,0)
	elseif(hour==03 and minute==00)then
		--handler:exec("TRUNCATE TABLE DAILYREWARD")
		if(settings.general.christmas==false)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","usersettings","Snowshader",1,"Snowshader",2)
		end
		for _,v in pairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				RegisterLogin_saveDatas(v)
				setElementData(v,"ElementClicked",false)
				setElementData(v,"Loggedin",0)
				setElementData(v,"team",nil)
				local rdm=math.random(1000,9999)
				setPlayerName(v,"Lakeside:RP_User_"..rdm)
			end
		end
		getThisResource():restart()
		setServerPassword("")
	elseif(hour==02 and minute==59)then
		outputChatBox("ATTENTION: Server restart in 1 minute!",root,200,0,0)
	elseif(hour==02 and minute==58)then
		setServerPassword(rdmpw)
		outputChatBox("ATTENTION: Server restart in 2 minutes!",root,200,0,0)
	elseif(hour==02 and minute==57)then
		outputChatBox("ATTENTION: Server restart in 3 minutes!",root,200,0,0)
	elseif(hour==02 and minute==56)then
		outputChatBox("ATTENTION: Server restart in 4 minutes!",root,200,0,0)
	elseif(hour==02 and minute==55)then
		outputChatBox("ATTENTION: Server restart in 5 minutes!",root,200,0,0)
	elseif(hour==02 and minute==50)then
		outputChatBox("ATTENTION: Server restart in 10 minutes!",root,200,0,0)
	elseif(hour==02 and minute==45)then
		outputChatBox("ATTENTION: Server restart in 15 minutes!",root,200,0,0)
	end
	updateServerTime()
end,55*1000,0)

function updateServerTime()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	--setTimer(function()
		setTime(hour,minute)
	--end,60*1000,0)
end
addEventHandler("onResourceStart",resourceRoot,updateServerTime)