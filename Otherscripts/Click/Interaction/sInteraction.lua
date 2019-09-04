--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local interactionTable={
	["Items"]={
		["Pizza"]="Pizza",
		["Burger"]="Burger",
		["Apple"]="Apple",
		["Cola"]="Cola",
	},
	["License"]={
		[1]={"IDcard","ID card"},
		[2]={"CarLicense","Car license"},
		[3]={"BikeLicense","Bike license"},
	},
}

addEvent("show:license",true)
addEventHandler("show:license",root,function()
	local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
	if(isElement(target)and isLoggedin(target))then
		outputChatBox("You have "..getPlayerName(target).." shown your licenses.",client,0,255,0)
		outputChatBox("Licenses from "..getPlayerName(client)..":",target,255,255,255)
		for i=1,#interactionTable["License"] do
			if(tonumber(syncGetElementData(client,interactionTable["License"][i][1]))==1)then
				outputChatBox(interactionTable["License"][i][2]..": Available",target,0,150,0)
			else
				outputChatBox(interactionTable["License"][i][2]..": Unavailable",target,150,0,0)
			end
		end
	end
end)

addEvent("give:itemstouser",true)
addEventHandler("give:itemstouser",root,function(item,amount)
	if(tonumber(syncGetElementData(client,interactionTable["Items"][item]))>=tonumber(amount))then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		syncSetElementData(client,interactionTable["Items"][item],syncGetElementData(client,interactionTable["Items"][item])-amount)
		syncSetElementData(target,interactionTable["Items"][item],syncGetElementData(target,interactionTable["Items"][item])+amount)
		outputChatBox("You gave "..getPlayerName(target).." "..item .." x"..amount..".",client,0,200,0)
		outputChatBox(getPlayerName(client).." gave you "..item.." x"..amount..".",target,0,200,0)
	end
end)