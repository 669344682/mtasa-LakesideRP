--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Bonus        ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

elementData={}
local syncDataToClient={

--//Inventory
["Apple"]=true,
["AppleSeeds"]=true,
["Burger"]=true,
["Pizza"]=true,
["Candycane"]=true,
["Cola"]=true,
["ChestWood"]=true,
["ChestIron"]=true,
["Cigarette"]=true,
["TicketBronze"]=true,
["TicketSilver"]=true,
["TicketGold"]=true,
["Repairkit"]=true,
["Mobilephone"]=true,
["VehicleKey"]=true,
["Cocaine"]=true,
["Weed"]=true,
["WeedSeeds"]=true,
["Armor"]=true,
["Pickaxe"]=true,
["Moonstone"]=true,
["Present"]=true,
["Fishingrod"]=true,
["Fishinghook"]=true,
["Bait"]=true,
["Trout"]=true,

--//Userdata
["Bankmoney"]=true,
["Gender"]=true,
["Bankpin"]=true,
["Mutedtime"]=true,
["CarLicense"]=true,
["BikeLicense"]=true,
["CarLicensePoints"]=true,
["BikeLicensePoints"]=true,
["GunLicense"]=true,
["Vehicleslots"]=true,
["Jobmoney"]=true,
["Housekey"]=true,
["Task"]=true,
["IntroCompleted"]=true,
["Job"]=true,
["IDcard"]=true,
["Telenr"]=true,
["BirthDate"]=true,
["Jailtime"]=true,

--//Userlevel
["Joblevel"]=true,
["Jobexp"]=true,

--//Userstats
["Kills"]=true,
["Deaths"]=true,

--//Usersettings
["PhoneModel"]=true,
["PhoneBackground"]=true,
["PhoneState"]=true,
["Radar"]=true,
["Snowshader"]=true,
["Blurshader"]=true,

--//Other
["CopDuty"]=true,
["MechTowDuty"]=true,
["DrivingschoolDuty"]=true,
}

local syncDataNotToClient={

--//Userdata
["SpawnX"]=true,
["SpawnY"]=true,
["SpawnZ"]=true,
["SpawnROT"]=true,
["SpawnINT"]=true,
["SpawnDIM"]=true,
["UID"]=true,
["curIntIn"]=true,
}


function syncSetElementData(player,dataString,value)
	if(player and dataString and value~=nil)then	
		if(not elementData[player])then
			elementData[player]={}
		end
		elementData[player][dataString]=value
		if(dataString=="Money")then
			local value=math.floor(value)
			triggerClientEvent(player,"sync:money",player,value)
			setElementData(player,dataString,value,true)
			elementData[player][dataString]=value
		elseif(syncDataToClient[dataString])then
			triggerClientEvent(player,"trigger:clientData",player,dataString,value)
		elseif(not syncDataNotToClient[dataString] and isElement(player))then
			setElementData(player,dataString,value)
		end
	else
		return nil
	end
end

function syncGetElementData(player,dataString)
	if(player and dataString)then
		if(not elementData[player])then
			elementData[player]={}
		end
		if(elementData[player][dataString])then
			return elementData[player][dataString]
		elseif(not elementData[player][dataString] and dataString~="AdminLvL" and dataString~="Loggedin" and not syncDataNotToClient[dataString])then
			elementData[player][dataString]=getElementData(player,dataString)
			return elementData[player][dataString]
		else
			return nil
		end
	else
		return nil
	end
end

function freeElementData()
	if(elementData)then
		if(getElementType(source)~="player")then
			if(elementData[source])then
				elementData[source]=nil
			end
		end
	end
end
addEventHandler("onElementDestroy",root,freeElementData)

addEvent("change:clientData",true)
addEventHandler("change:clientData",root,function(dataString,value)
	elementData[client][dataString]=value
end)