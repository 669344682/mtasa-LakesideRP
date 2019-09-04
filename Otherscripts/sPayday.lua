--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local paydayPlayerTimerTable={}
local hungerPlayerTimerTable={}
local pissPlayerTimerTable={}

function startPaydayPlayerTimer(player)
	if(not(isTimer(paydayPlayerTimerTable[player])))then
		paydayPlayerTimerTable[player]=setTimer(function()
			triggerPlayerPayday(player)
		end,1*60*1000,0)
	end
end
function startHungerPlayerTimer(player)
	if(not(isTimer(hungerPlayerTimerTable[player])))then
		local rdm=math.random(40,80)
		hungerPlayerTimerTable[player]=setTimer(function()
			hungerLoss(player)
		end,rdm*1000,0)
	end
end
function startPissPlayerTimer(player)
	if(not(isTimer(pissPlayerTimerTable[player])))then
		local rdm=math.random(60,120)
		pissPlayerTimerTable[player]=setTimer(function()
			pissFill(player)
		end,rdm*1000,0)
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(paydayPlayerTimerTable[source]))then
		paydayPlayerTimerTable[source]:destroy()
	end
	if(isTimer(hungerPlayerTimerTable[source]))then
		hungerPlayerTimerTable[source]:destroy()
	end
	if(isTimer(pissPlayerTimerTable[source]))then
		pissPlayerTimerTable[source]:destroy()
	end
end)

function triggerPlayerPayday(player)
	if(isElement(player))then
		if(isLoggedin(player))then
			if(syncGetElementData(player,"AFK")==false)then
				syncSetElementData(player,"Playtime",tonumber(syncGetElementData(player,"Playtime"))+1)
				
				if(tonumber(syncGetElementData(player,"Mutedtime"))>=1)then
					syncSetElementData(player,"Mutedtime",tonumber(syncGetElementData(player,"Mutedtime"))-1)
					if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
						outputChatBox("You are now unmuted!",player,200,0,0)
					end
				end
				
				if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
					syncSetElementData(player,"Jailtime",tonumber(syncGetElementData(player,"Jailtime"))-1)
					if(tonumber(syncGetElementData(player,"Jailtime"))==0)then
						fadeElementInterior(player,globalTables["Faction"][1]["Jailoutspawn"][1],globalTables["Faction"][1]["Jailoutspawn"][2],globalTables["Faction"][1]["Jailoutspawn"][3],globalTables["Faction"][1]["Jailoutspawn"][4],0,0,true)
					end
				end
				
				
				if(math.floor(syncGetElementData(player,"Playtime")/60)==(syncGetElementData(player,"Playtime")/60))then
					rent=0
					if(syncGetElementData(player,"Housekey")<0)then
						local Cash=tonumber(dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Cash","houses","ID",ID),-1)[1]["Cash"])
						local ID=syncGetElementData(player,"Housekey")
						local house=houses["pickup"][ID]
						rent=getElementData(house,"miete")
						handler:exec("UPDATE ?? SET ??=? WHERE ID=?","houses","Cash",Cash+rent,ID)
					end
					miete=rent
					
					local factionmoney=0
					if(tonumber(syncGetElementData(player,"Faction"))>=1)then
						local FacMoney=getData("factiondepots","Faction",tonumber(syncGetElementData(player,"Faction")),"Money")
						local Salary=getData("factiondepots","Faction",tonumber(syncGetElementData(player,"Faction")),"Rang"..tonumber(syncGetElementData(player,"Factionrank")).."")
						if(FacMoney>=Salary)then
							factionmoney=factionmoney+Salary
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",FacMoney-Salary,"Faction",tonumber(syncGetElementData(player,"Faction")))
						end
					end
					
					local vehCount=0
					local costsVeh=125
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","Owner",getPlayerName(player)),-1)
					if(#result>=1)then
						for _,v in pairs(result)do
							vehCount=vehCount+1
						end
					end
					vehPrice=vehCount*costsVeh
					
					jobmoney=tonumber(syncGetElementData(player,"Jobmoney"))
				
					outputChatBox("___________| PAYDAY |___________",player,255,255,255)
					outputChatBox("Income: ",player,0,200,0)
					outputChatBox("Jobmoney: $"..jobmoney,player,255,255,255)
					outputChatBox("Faction: $"..factionmoney,player,255,255,255)
					outputChatBox("Expenses: ",player,200,0,0)
					outputChatBox("Vehicle: $"..vehPrice.." Rent: $"..miete,player,255,255,255)
					outputChatBox("_______________________________",player,255,255,255)
					paydayCash=jobmoney+factionmoney-vehPrice-miete
					outputChatBox("Receipts: $"..paydayCash,player,255,255,255)
					triggerClientEvent(player,"show:desktopnotify",player,"info","Payday: $"..paydayCash)
					
					syncSetElementData(player,"Bankmoney",tonumber(syncGetElementData(player,"Bankmoney"))+paydayCash)
					syncSetElementData(player,"Jobmoney",0)
					
					if(settings.general.christmas==true)then
						outputChatBox("__________| Christmas |__________",player,255,255,255)
						outputChatBox("Candycane: +1",player,220,0,0)
						outputChatBox("______________________________",player,255,255,255)
						syncSetElementData(player,"Candycane",tonumber(syncGetElementData(player,"Candycane"))+1)
					end
					
					RegisterLogin_saveDatas(player)
				end
			end
		end
	end
end

function hungerLoss(player)
	if(isElement(player))then
		if(isLoggedin(player))then
			if(syncGetElementData(player,"AFK")==false)then
				local hunger=tonumber(syncGetElementData(player,"Hunger"))
				syncSetElementData(player,"Hunger",hunger-1)
				if(hunger<25)then
					setElementHealth(player,getElementHealth(player)-math.floor((25-hunger)/2*20)/10)
				end
				if(hunger<1)then
					killPed(player)
					syncSetElementData(player,"Hunger",25)
					outputChatBox("You died because of hunger!",player,200,0,0)
				end
				if(hunger==20)then
					outputChatBox("You get hungry!",player,200,0,0)
				elseif(hunger==15)then
					outputChatBox("You get hungry!",player,200,0,0)
				elseif(hunger==10)then
					outputChatBox("You get hungry!",player,200,0,0)
				end
			end
		end
	end
end

function pissFill(player)
	if(isElement(player))then
		if(isLoggedin(player))then
			if(syncGetElementData(player,"AFK")==false)then
				local piss=tonumber(syncGetElementData(player,"Urin"))
				syncSetElementData(player,"Urin",piss+1)
				if(piss>=75)then
					setElementHealth(player,getElementHealth(player)-math.floor((25-piss)/2*20)/10)
				end
				if(piss>=100)then
					killPed(player)
					syncSetElementData(player,"Urin",50)
					outputChatBox("You died because of urethritis!",player,200,0,0)
				end
			end
		end
	end
end