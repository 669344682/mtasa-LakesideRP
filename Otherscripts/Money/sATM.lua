--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function transferMoney(money,typ)
	local money=tonumber(money)
	if(money)then
		if(tonumber(money)>=1)then
			if(typ=="pay:inATM")then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(money))then
					syncSetElementData(client,"Bankmoney",syncGetElementData(client,"Bankmoney")+money)
					syncSetElementData(client,"Money",syncGetElementData(client,"Money")-money)
					infoShow(client,"minus","You have paid in $"..money)
					triggerEvent("set:task",client,client,"PayIn_Out")
				end
			elseif(typ=="pay:outATM")then
				if(tonumber(syncGetElementData(client,"Bankmoney"))>=tonumber(money))then
					syncSetElementData(client,"Bankmoney",syncGetElementData(client,"Bankmoney")-money)
					syncSetElementData(client,"Money",syncGetElementData(client,"Money")+money)
					infoShow(client,"plus","You have paid out $"..money)
					triggerEvent("set:task",client,client,"PayIn_Out")
				end
			end
			triggerClientEvent(client,"refresh:atm",client)
		end
	end
end
addEvent("transfer:money",true)
addEventHandler("transfer:money",root,transferMoney)