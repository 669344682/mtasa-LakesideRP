--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function buySkin(skin,price)
	if(syncGetElementData(client,"DrivingschoolDuty")==false and syncGetElementData(client,"MechTowDuty")==false and syncGetElementData(client,"CopDuty")==false)then
		if(tonumber(syncGetElementData(client,"Money"))>=tonumber(price))then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","SkinID",skin,"UID",playerUID[getPlayerName(client)])
			setElementModel(client,skin)
			syncSetElementData(client,"SkinID",skin)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..price..")",8000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","First go off duty!",8000)
	end
end
addEvent("buy:skin",true)
addEventHandler("buy:skin",root,buySkin)