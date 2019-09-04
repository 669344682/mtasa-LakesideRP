--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Hade         ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function RegisterLogin_SelectSkin_Func(skin)
	handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","SkinID",skin,"Serial",getPlayerSerial(client))
	
	setElementModel(client,skin)
	
	setElementFrozen(client,false)
	triggerClientEvent(client,"destroy:login",client)
	RegisterLogin_setDatas(client)
end
addEvent("select:skin",true)
addEventHandler("select:skin",root,RegisterLogin_SelectSkin_Func)