--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local registerloginTable={
	["inventory"]={
		"Apple","Burger","Pizza","Candycane","Cola","IDcard","ChestWood","ChestIron","TicketBronze","TicketSilver","TicketGold","Repairkit","Cocaine","Weed","WeedSeeds","AppleSeeds","Cigarette","Mobilephone","VehicleKey","Armor","Pickaxe","Moonstone","Present","Fishingrod","Fishinghook","Bait","Trout"
	},
	["userdata"]={
		"BirthDate","Gender","AdminLvL","Faction","Factionrank","Company","Companyrank","Money","Bankmoney","Jobmoney","Armor","Health","Job","Hunger","Urin","SpawnX","SpawnY","SpawnZ","SpawnROT","SpawnINT","SpawnDIM","SkinID","Playtime","Mutedtime","Jailtime","Vehicleslots","Housekey","Task","Bankpin","Telenr","Wanteds","IntroCompleted","CarLicense","BikeLicense","CarLicensePoints","BikeLicensePoints","GunLicense"
	},
	["userlevel"]={
		"Joblevel","Jobexp"
	},
	["usersettings"]={
		"PhoneModel","PhoneBackground","PhoneState","Autologin","Radar","Snowshader","Blurshader"
	},
	["userstats"]={
		"Kills","Deaths"
	},
	["notallowedcaracter"]={"!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]","none","1","2","3","4","5","6","7","8","9","0"},
}

function Register_Func(firstname,lastname,password,email,gender,bmonth,bday,byear)
    local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Serial",getPlayerSerial(client)),-1)
    if(not result or not result[1])then
        local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Username",firstname.."_"..lastname),-1)
        if(not result or not result[1])then
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Email",email),-1)
			if(not result or not result[1])then
				local time=getRealTime()
				local year=time.year+1900
				local month=time.month+1
				local day=time.monthday
				local hour=time.hour
				local minute=time.minute
				
				if(day<10)then
					day="0"..day
				end
				if(month<10)then
					month="0"..month
				end
				if(year<10)then
					year="0"..year
				end
				if(bday<10)then
					bday="0"..bday
				end
				if(bmonth<10)then
					bmonth="0"..bmonth
				end
				if(byear<10)then
					byear="0"..byear
				end
				
				for _,v in ipairs(registerloginTable["notallowedcaracter"])do
					if(string.find(firstname,v,1,true))then
						if(string.lower(firstname,v,1,true))then
							triggerClientEvent(client,"draw:infobox",root,"error","There are no special characters or color codes allowed!",10000)
							return false
						end
					end
				end
				setPlayerName(client,firstname.."_"..lastname)
				setPlayerName(client,firstname.."_"..lastname)
				
				local LakeHash=md5(hash("sha512",password))
				local pname=getPlayerName(client)
				local pserial=getPlayerSerial(client)
				
				local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE UID=UID","UID","globalcounter"),-1)[1]["UID"]
				handler:exec("UPDATE ?? SET ??=?","globalcounter","UID",IDcounter+1)
				playerUID[pname]=IDcounter
				local BirthDate=tostring(bday.."."..bmonth.."."..byear)
				local RegisterDate=tostring(day.."."..month.."."..year..", "..hour..":"..minute)
				
				handler:exec("INSERT INTO inventory (UID,Username,Apple,Burger,Pizza,Candycane,Cola,IDcard,ChestWood,ChestIron,TicketBronze,TicketSilver,TicketGold,Repairkit,Cocaine,Weed,WeedSeeds,AppleSeeds,Cigarette,Mobilephone,VehicleKey,Armor,Pickaxe,Moonstone,Present,Fishingrod,Fishinghook,Bait,Trout) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,'0','5','5','0','5','0','0','0','1','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0')
				handler:exec("INSERT INTO userdata (UID,Username,Serial,Password,Email,RegisterDate,LastLoginDate,BirthDate,Gender,AdminLvL,Faction,Factionrank,Company,Companyrank,Money,Bankmoney,Jobmoney,Armor,Health,Job,Urin,Hunger,SpawnX,SpawnY,SpawnZ,SpawnROT,SpawnINT,SpawnDIM,SkinID,Playtime,Mutedtime,Jailtime,Vehicleslots,Housekey,Task,Bankpin,Telenr,Wanteds,IntroCompleted,CarLicense,BikeLicense,CarLicensePoints,BikeLicensePoints,GunLicense) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,pserial,LakeHash,email,RegisterDate,RegisterDate,BirthDate,gender,'0','0','0','0','0','5000','2500','0','0','100','none','0','100','1769.9','-1867.3','13.6','0','0','0','0','0','0','0','2','0','1','0','0','0','0','0','0','0','0','0')
				handler:exec("INSERT INTO userlevel (UID,Username,Joblevel,Jobexp) VALUES (?,?,?,?)",IDcounter,pname,'0','0')
				handler:exec("INSERT INTO usersettings (UID,Username,PhoneModel,PhoneBackground,PhoneState,Autologin,Radar,Snowshader,Blurshader) VALUES (?,?,?,?,?,?,?,?,?)",IDcounter,pname,'1','1','1','0','1','1','2')
				handler:exec("INSERT INTO userstats (UID,Username,Kills,Deaths) VALUES (?,?,?,?)",IDcounter,pname,'0','0')
				
				--//Other
				setElementFrozen(client,false)
				RegisterLogin_setDatas(client)
				setElementData(client,"introstate",true)
				triggerClientEvent(client,"open:skinselector",client)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","This Email is already exist!",10000)
			end
        else
			triggerClientEvent(client,"draw:infobox",root,"error","This RP name is already exist!",10000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Only 1 account per serial is allowed! (Old name: ".. result[1]["Username"] ..")",10000)
    end
end
addEvent("account:register",true)
addEventHandler("account:register",root,Register_Func)

function Login_Func(username,password)
	local LakeHash=md5(hash("sha512",password))
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","userdata","Username",username,"Password",LakeHash),-1)
	if(result and result[1])then
	setPlayerName(client,username)
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","UID",playerUID[getPlayerName(client)]),-1)
		if(result and result[1])then
			setElementData(client,"introstate",true)
			RegisterLogin_setDatas(client)
			triggerClientEvent(client,"destroy:login",client)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","The username/password combination\nis not correct or not available!",8000)
	end
end
addEvent("account:login",true)
addEventHandler("account:login",root,Login_Func)

function checkAccount()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Serial",getPlayerSerial(client)),-1)
	if(#result>=1)then
		triggerClientEvent(client,"open:registerlogin",client,"Login")
	else
		triggerClientEvent(client,"open:registerlogin",client,"Register")
	end
end
addEvent("check:account",true)
addEventHandler("check:account",root,checkAccount)

function RegisterLogin_setDatas(player)
	local pname=getPlayerName(player)
	local time=getRealTime()
	local year=time.year+1900
	local month=time.month+1
	local day=time.monthday
	local hour=time.hour
	local minute=time.minute
	
	if(hour<10)then
		hour="0"..hour
	end
	if(minute<10)then
		minute="0"..minute
	end
	if(month<10)then
		month="0"..month
	end
	if(day<10)then
		day="0"..day
	end
	
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","UID",playerUID[pname]),-1)
	if(result and result[1])then
		setCameraTarget(player,player)
		
		for i=1,#registerloginTable["userdata"] do
			syncSetElementData(player,registerloginTable["userdata"][i],getData("userdata","UID",playerUID[pname],registerloginTable["userdata"][i]))
		end
		
		for i=1,#registerloginTable["userlevel"] do
			syncSetElementData(player,registerloginTable["userlevel"][i],getData("userlevel","UID",playerUID[pname],registerloginTable["userlevel"][i]))
		end
		
		for i=1,#registerloginTable["usersettings"] do
			syncSetElementData(player,registerloginTable["usersettings"][i],getData("usersettings","UID",playerUID[pname],registerloginTable["usersettings"][i]))
		end
		
		for i=1,#registerloginTable["userstats"] do
			syncSetElementData(player,registerloginTable["userstats"][i],getData("userstats","UID",playerUID[pname],registerloginTable["userstats"][i]))
		end
		
		for i=1,#registerloginTable["inventory"] do
			syncSetElementData(player,registerloginTable["inventory"][i],getData("inventory","UID",playerUID[pname],registerloginTable["inventory"][i]))
		end
		
		local resulthouse=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","ID","houses","Owner",pname),-1)
		local Housekey=resulthouse[1] and resulthouse[1]["ID"] or false
		local key=getData("userdata","Username",pname,"Housekey")
		if(Housekey)then
			syncSetElementData(player,"Housekey",Housekey)
		elseif(key<=0)then
			syncSetElementData(player,"Housekey",key)
		else
			syncSetElementData(player,"Housekey",0)
		end
		
		if(isElement(houses["pickup"][getPlayerName(player)]))then
			local x,y,z=getElementPosition(houses["pickup"][getPlayerName(player)])
			houseBlip=createBlip(x,y,z,31,2,255,0,0,255,0,99999,player)
		end
		if(syncGetElementData(player,"Snowshader")==2)then
			triggerClientEvent("switchGoundSnow",resourceRoot,true)
		else
			triggerClientEvent("switchGoundSnow",resourceRoot,false)
		end
		if(syncGetElementData(player,"Blurshader")==1)then
			setPlayerBlurLevel(player,0)
		elseif(syncGetElementData(player,"Blurshader")==2)then
			setPlayerBlurLevel(player,36)
		end
		
		setElementData(player,"seatbelt",false)
		setElementData(player,"fishingstate",false)
		setElementData(player,"tazer",false)
		setElementData(player,"introstate",true)
		setElementData(player,"inRocket",false)
		setElementData(player,"onTheMoon",false)
		setElementData(player,"inpruefung",false)
		setElementData(player,"infahrpruefung",false)
		setElementData(player,"plantstate",false)
		setElementData(player,"AFK",false)
		syncSetElementData(player,"CopDuty",false)
		syncSetElementData(player,"MechTowDuty",false)
		syncSetElementData(player,"DrivingschoolDuty",false)
		setElementData(player,"ElementClicked",false)
		setElementData(player,"Loggedin",1)
		setElementData(player,"callswith","none")
		setElementData(player,"call",false)
		setElementData(player,"calls","none")
		setElementData(player,"callswith","none")
		setElementData(player,"calledby","none")
		toggleAllControls(player,true)
		RegisterLogin_spawn(player)
		jailCheck(player)
		startPaydayPlayerTimer(player)
		startHungerPlayerTimer(player)
		startPissPlayerTimer(player)
		loadVehicles(getPlayerName(player))
		refreshWeather(player)
		loadGangtagTextures(player)
		setPedStat(player,22,500)
		setPedStat(player,69,900)
		setPedStat(player,70,999)
		setPedStat(player,71,999)
		setPedStat(player,72,999)
		setPedStat(player,73,999)
		setPedStat(player,74,999)
		setPedStat(player,75,999)
		setPedStat(player,76,999)
		setPedStat(player,77,999)
		setPedStat(player,78,999)
		setPedStat(player,79,999)
		setPedStat(player,160,999)
		setPedStat(player,229,999)
		setPedStat(player,230,999)
		if(syncGetElementData(player,"Gender")=="Male")then
			setPedWalkingStyle(player,118)
		elseif(syncGetElementData(player,"Gender")=="Female")then
			setPedWalkingStyle(player,129)
		end
		
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		if(tonumber(syncGetElementData(player,"Faction"))~=0)then
			loadFactionVehicles(tonumber(syncGetElementData(player,"Faction")))
		end
		if(tonumber(syncGetElementData(player,"Company"))~=0)then
			loadCompanyVehicles(tonumber(syncGetElementData(player,"Company")))
		end
		
		if(tonumber(syncGetElementData(player,"Task"))==1)then
			outputChatBox("Follow the task-system to receive gifts. Do not buy before complete the task-system a item!",player,255,0,0)
			outputChatBox("Follow the task-system to receive gifts. Do not buy before complete the task-system a item!",player,255,0,0)
			outputChatBox("Follow the task-system to receive gifts. Do not buy before complete the task-system a item!",player,255,0,0)
			outputChatBox("Follow the task-system to receive gifts. Do not buy before complete the task-system a item!",player,255,0,0)
		end
		
		local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Weapons","userlogout","UID",playerUID[pname]),-1)
		if(result and result[1])then
			local weapons=result[1]["Weapons"]
			dbExec(handler,"DELETE FROM ?? WHERE ??=?","userlogout","UID",playerUID[pname])
			for i=1,12 do
				local wstring=gettok(weapons,i,string.byte("|"))
				if(wstring and #wstring>=3)then
					local weapon=tonumber(gettok(wstring,1,string.byte(",")))
					local ammo=tonumber(gettok(wstring,2,string.byte(",")))
					giveWeapon(player,weapon,ammo)
				end
			end
		end
		
		bindKey(player,"b","down","chatbox","OOC")
		bindKey(player,"y","down","chatbox","Teamchat")
		bindKey(player,"1","down",changeTazerToDeagle_changeDeagleToTazer)
		if(not isKeyBound(player,",","down",lockVehicle))then
			bindKey(player,",","down",lockVehicle)
		end
		if(not isKeyBound(player,".","down",parkVehicle))then
			bindKey(player,".","down",parkVehicle)
		end
		if(not isKeyBound(player,"f","down",removePlant))then
			bindKey(player,"f","down",removePlant)
		end
		
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","LastloginDate",day.."."..month.."."..year..", "..hour..":"..minute,"Username",pname)
		
		triggerClientEvent(player,"draw:infobox",root,"success","You have successfully loggedin!",8000)
		
		--triggerClientEvent(player,"open:caracterselection",player)
	end
end

function RegisterLogin_spawn(player)
	local pname=getPlayerName(player)
	local faction=tonumber(syncGetElementData(player,"Faction"))
	local company=tonumber(syncGetElementData(player,"Company"))
	if(faction~=0 and faction>=1)then
		local x,y,z,rot,int,dim=globalTables["Faction"][faction]["Spawn"][1],globalTables["Faction"][faction]["Spawn"][2],globalTables["Faction"][faction]["Spawn"][3],globalTables["Faction"][faction]["Spawn"][4],globalTables["Faction"][faction]["Spawn"][5],globalTables["Faction"][faction]["Spawn"][6]
		spawnPlayer(player,x,y,z,rot,getData("userdata","Username",pname,"SkinID"),int,dim)
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
	elseif(company~=0 and company>=1)then
		local x,y,z,rot,int,dim=globalTables["Company"][company]["Spawn"][1],globalTables["Company"][company]["Spawn"][2],globalTables["Company"][company]["Spawn"][3],globalTables["Company"][company]["Spawn"][4],globalTables["Company"][company]["Spawn"][5],globalTables["Company"][company]["Spawn"][6]
		spawnPlayer(player,x,y,z,rot,getData("userdata","Username",pname,"SkinID"),int,dim)
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
	else
		spawnPlayer(player,getData("userdata","Username",pname,"SpawnX"),getData("userdata","Username",pname,"SpawnY"),getData("userdata","Username",pname,"SpawnZ"),getData("userdata","Username",pname,"SpawnROT"),getData("userdata","Username",pname,"SkinID"),getData("userdata","Username",pname,"SpawnINT"),getData("userdata","Username",pname,"SpawnDIM"))
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
	end
	setElementFrozen(player,false)
	jailCheck(player)
end

function RegisterLogin_saveDatas(player)
	if(isLoggedin(player))then
		local pname=getPlayerName(player)
		
		--//Userdata
		for i=1,#registerloginTable["userdata"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata",registerloginTable["userdata"][i],syncGetElementData(player,registerloginTable["userdata"][i]),"UID",playerUID[pname])
		end
		
		handler:exec("UPDATE userdata SET ??=?,??=? WHERE ??=?","Armor",getPedArmor(player),"Health",getElementHealth(player),"UID",playerUID[pname])
		
		for i=1,#registerloginTable["userlevel"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userlevel",registerloginTable["userlevel"][i],syncGetElementData(player,registerloginTable["userlevel"][i]),"UID",playerUID[pname])
		end
		
		for i=1,#registerloginTable["usersettings"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","usersettings",registerloginTable["usersettings"][i],syncGetElementData(player,registerloginTable["usersettings"][i]),"UID",playerUID[pname])
		end
		
		for i=1,#registerloginTable["userstats"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userstats",registerloginTable["userstats"][i],syncGetElementData(player,registerloginTable["userstats"][i]),"UID",playerUID[pname])
		end
		
		for i=1,#registerloginTable["inventory"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","inventory",registerloginTable["inventory"][i],syncGetElementData(player,registerloginTable["inventory"][i]),"UID",playerUID[pname])
		end
		
		local x,y,z=getElementPosition(player)
		local rx,ry,rz=getElementRotation(player)
		local int=getElementInterior(player)
		local dim=getElementDimension(player)
		if(tonumber(syncGetElementData(player,"Faction"))==0 and tonumber(syncGetElementData(player,"Company"))==0 and tonumber(syncGetElementData(player,"Jailtime"))==0 and getElementData(player,"InTuninggarage")==false and getElementData(player,"onTheMoon")==false)then
			if(not isPedDead(player))then
				if(x)and(y)and(z)and(rz)and(int)and(dim)then
					handler:exec("UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?","userdata","SpawnX",x,"SpawnY",y,"SpawnZ",z,"SpawnROT",rz,"SpawnINT",int,"SpawnDIM",dim,"UID",playerUID[pname])
				end
			end
		end
		
	end
end

addEvent("check:autologin",true)
addEventHandler("check:autologin",root,function()
	local pname=getPlayerName(client)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Serial",getPlayerSerial(client)),-1)
	if(result and result[1])then
		if(getData("userdata","Username",pname,"Serial")==getPlayerSerial(client))then
			if(getData("usersettings","Username",pname,"Autologin")==1)then
				setPlayerName(client,pname)
				RegisterLogin_setDatas(client)
				triggerClientEvent(client,"destroy:login",client)
				setElementFrozen(client,false)
			end
		end
	end
end)

addEventHandler("onPlayerJoin",root,function()
	local rdm=math.random(1000,9999)
	setPlayerName(source,"Lakeside:RP_User_"..rdm)
	
	setElementData(source,"Loggedin",0)
end)

addEventHandler("onPlayerQuit",root,function()
	if(isLoggedin(source))then
		local pname=getPlayerName(source)
		RegisterLogin_saveDatas(source)
		if(getElementData(source,"callswith"))then
			if(getElementData(source,"callswith")~="none")then
				local caller=getPlayerFromName(getElementData(source,"callswith"))
				if(caller)then
					setElementData(caller,"callswith","none")
					setElementData(caller,"call",false)
					setElementData(caller,"calls","none")
					setElementData(caller,"callswith","none")
					setElementData(caller,"calledby","none")
					outputChatBox("*Crack* - The line is dead!",caller,200,0,0)
				end
				setElementData(source,"callswith","none")
				setElementData(source,"call",false)
				setElementData(source,"calls","none")
				setElementData(source,"callswith","none")
				setElementData(source,"calledby","none")
			end
		end
		
		local curWeaponsForSave="|"
		for i=1,11 do
			if(i~=10)then
				local weapon=getPedWeapon(source,i)
				local ammo=getPedTotalAmmo(source,i)
				if(weapon and ammo)then
					if(weapon>=1 and ammo>=1)then
						if(#curWeaponsForSave<=40)then
							curWeaponsForSave=curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		if(#curWeaponsForSave>=5)then
			handler:exec("INSERT INTO ?? (UID,Weapons) VALUES (?,?)","userlogout",playerUID[pname],curWeaponsForSave)
		end
		
	end
end)




addEvent("get:changelogs",true)
addEventHandler("get:changelogs",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? ORDER BY SortID","changelogs"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			table.insert(tbl,{v["Version"],v["Changes"]})
		end
		triggerClientEvent(client,"show:changelogs",client,tbl)
	end
end)