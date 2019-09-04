--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local destroyItemAfterUseTable={}

addEvent("use:item",true)
addEventHandler("use:item",root,function(item,amount)
	if(not gotLastHit[client] or gotLastHit[client]+lastHitTimer<=getTickCount())then
		if(not isPedDead(client))then
			if(getElementData(client,"AFK")==false)then
				if(tonumber(syncGetElementData(client,item))>=amount)then
					if(not isTimer(destroyItemAfterUseTable[client]))then
						if(item=="Apple")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								local BurgerItem=createObject(2880,0,0,0)
								setElementDimension(BurgerItem,getElementDimension(client))
								setElementInterior(BurgerItem,getElementInterior(client))
								attachElementToBone(BurgerItem,client,12,-0.05,0.02,0.02,20,-90,-10)
								setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
								destroyItemAfterUseTable[client]=setTimer(function()
									if(isElement(BurgerItem))then
										detachElementFromBone(BurgerItem)
										destroyElement(BurgerItem)
										if(isTimer(destroyItemAfterUseTable[client]))then
											destroyItemAfterUseTable[client]:destroy()
										end
									end
								end,3400,1)
								setElementHealth(client,getElementHealth(client)+10*amount)
								syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+15*amount)
								syncSetElementData(client,"Urin",tonumber(syncGetElementData(client,"Urin"))+2*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You eating "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," eating a "..item.." x"..amount.."!")
								
								if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
									syncSetElementData(client,"Hunger",100)
								end
								if(tonumber(syncGetElementData(client,"Urin"))>=100)then
									syncSetElementData(client,"Urin",100)
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Burger")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								local BurgerItem=createObject(2880,0,0,0)
								setElementDimension(BurgerItem,getElementDimension(client))
								setElementInterior(BurgerItem,getElementInterior(client))
								attachElementToBone(BurgerItem,client,12,-0.05,0.02,0.02,20,-90,-10)
								setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
								destroyItemAfterUseTable[client]=setTimer(function()
									if(isElement(BurgerItem))then
										detachElementFromBone(BurgerItem)
										destroyElement(BurgerItem)
										if(isTimer(destroyItemAfterUseTable[client]))then
											destroyItemAfterUseTable[client]:destroy()
										end
									end
								end,3400,1)
								setElementHealth(client,getElementHealth(client)+10*amount)
								syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+15*amount)
								syncSetElementData(client,"Urin",tonumber(syncGetElementData(client,"Urin"))+2*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You eating "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," eating a "..item.." x"..amount.."!")
								
								if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
									syncSetElementData(client,"Hunger",100)
								end
								if(tonumber(syncGetElementData(client,"Urin"))>=100)then
									syncSetElementData(client,"Urin",100)
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Pizza")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								local PizzaItem=createObject(2881,0,0,0)
								setElementDimension(PizzaItem,getElementDimension(client))
								setElementInterior(PizzaItem,getElementInterior(client))
								attachElementToBone(PizzaItem,client,12,-0.05,0.02,0.02,20,-90,-10)
								setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
								destroyItemAfterUseTable[client]=setTimer(function()
									if(isElement(PizzaItem))then
										detachElementFromBone(PizzaItem)
										destroyElement(PizzaItem)
										if(isTimer(destroyItemAfterUseTable[client]))then
											destroyItemAfterUseTable[client]:destroy()
										end
									end
								end,3400,1)
								setElementHealth(client,getElementHealth(client)+12*amount)
								syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+17*amount)
								syncSetElementData(client,"Urin",tonumber(syncGetElementData(client,"Urin"))+2*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You eating "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," eating a "..item.." x"..amount.."!")
								
								if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
									syncSetElementData(client,"Hunger",100)
								end
								if(tonumber(syncGetElementData(client,"Urin"))>=100)then
									syncSetElementData(client,"Urin",100)
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Trout")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
								setElementHealth(client,getElementHealth(client)+12*amount)
								syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+17*amount)
								syncSetElementData(client,"Urin",tonumber(syncGetElementData(client,"Urin"))+2*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You eating "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," eating a "..item.." x"..amount.."!")
								
								if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
									syncSetElementData(client,"Hunger",100)
								end
								if(tonumber(syncGetElementData(client,"Urin"))>=100)then
									syncSetElementData(client,"Urin",100)
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Candycane")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
								setElementHealth(client,getElementHealth(client)+12*amount)
								syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+17*amount)
								syncSetElementData(client,"Urin",tonumber(syncGetElementData(client,"Urin"))+2*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You eating "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," eating a "..item.." x"..amount.."!")
								
								if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
									syncSetElementData(client,"Hunger",100)
								end
								if(tonumber(syncGetElementData(client,"Urin"))>=100)then
									syncSetElementData(client,"Urin",100)
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Cola")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								local ColaItem=createObject(1546,0,0,0)
								setElementDimension(ColaItem,getElementDimension(client))
								setElementInterior(ColaItem,getElementInterior(client))
								attachElementToBone(ColaItem,client,11,-0.02,0.06,0.14,20,90,-10)
								setPedAnimation(client,"vending","vend_drink2_p",-1,false,false,false,false)
								destroyItemAfterUseTable[client]=setTimer(function()
									if(isElement(ColaItem))then
										detachElementFromBone(ColaItem)
										destroyElement(ColaItem)
										if(isTimer(destroyItemAfterUseTable[client]))then
											destroyItemAfterUseTable[client]:destroy()
										end
									end
								end,3400,1)
								setElementHealth(client,getElementHealth(client)+12*amount)
								syncSetElementData(client,"Urin",tonumber(syncGetElementData(client,"Urin"))+8*amount)
								syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+4*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You drink "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," drink a "..item.." x"..amount.."!")
								
								if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
									syncSetElementData(client,"Hunger",100)
								end
								if(tonumber(syncGetElementData(client,"Urin"))>=100)then
									syncSetElementData(client,"Urin",100)
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Cigarette")then
							if(tonumber(syncGetElementData(client,"Hunger"))<100)then
								--[[local CigaretteItem=createObject(3027,0,0,0)
								setElementDimension(CigaretteItem,getElementDimension(client))
								setElementInterior(CigaretteItem,getElementInterior(client))
								attachElementToBone(CigaretteItem,client,11,-0.02,0.06,0.14,20,90,-10)]]
								setPedAnimation(client,"smoking","M_smkstnd_loop",-1,false,false,false,false)
								destroyItemAfterUseTable[client]=setTimer(function()
									if(isElement(CigaretteItem))then
										detachElementFromBone(CigaretteItem)
										destroyElement(CigaretteItem)
										if(isTimer(destroyItemAfterUseTable[client]))then
											destroyItemAfterUseTable[client]:destroy()
										end
									end
								end,3700,1)
								setElementHealth(client,getElementHealth(client)+8*amount)
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								triggerClientEvent(client,"draw:infobox",root,"info","You smoking "..item.." x"..amount.."!",8000)
								executeCommandHandler("mee",client," smoking a "..item.." x"..amount.."!")
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You have enough Hunger!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Cocaine")then
							if(tonumber(syncGetElementData(client,item))>=amount)then
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								executeCommandHandler("mee",client," use "..item.." x3")
								setPedAnimation(client,"smoking","M_smkstnd_loop",-1,false,false,false,false)
								triggerClientEvent(client,"use:cocaineeffect",client)
								triggerClientEvent(client,"refresh:inventory",client)
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You need this item x2 to use!",8000)
							end
						elseif(item=="Weed")then
							if(tonumber(syncGetElementData(client,item))>=amount)then
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
								executeCommandHandler("mee",client," use "..item.." x3")
								setPedAnimation(client,"smoking","M_smkstnd_loop",-1,false,false,false,false)
								triggerClientEvent(client,"use:weedeffect",client)
								triggerClientEvent(client,"refresh:inventory",client)
							else
								triggerClientEvent(client,"draw:infobox",root,"error","You need this item x3 to use!",8000)
							end
						elseif(item=="WeedSeeds")then
							createPlant(client,item)
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="AppleSeeds")then
							createPlant(client,item)
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Armor")then
							syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
							setPedArmor(client,100)
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="ChestWood")then
							syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
							executeCommandHandler("mee",client," opened a "..item.." x1")
							local rdm=math.random(1,350)
							
							if(rdm>=1 and rdm<=100)then
								local burger=math.random(1,10)
								syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+burger)
								triggerClientEvent(client,"draw:infobox",root,"info","You get x"..burger.." burger out of the wood chest!",8000)
								if(tonumber(syncGetElementData(client,"Burger"))>=50)then
									syncSetElementData(client,"Burger",50)
								end
							elseif(rdm>=101 and rdm<=220)then
								local money=math.random(1000,3500)
								syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
								triggerClientEvent(client,"draw:infobox",root,"info","You get $"..money.." out of the wood chest!",8000)
							elseif(rdm>=221 and rdm<=245)then
								local ticket=math.random(1,1)
								local ticket2=math.random(1,2)
								if(ticket2==1)then
									syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+ticket)
									triggerClientEvent(client,"draw:infobox",root,"info","You get x"..ticket.." Bronze ticket out of the wood chest!",8000)
								elseif(ticket2==2)then
									syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+ticket)
									triggerClientEvent(client,"draw:infobox",root,"info","You get x"..ticket.." Silver ticket out of the wood chest!",8000)
								end
							elseif(rdm>=246 and rdm<=350)then
								triggerClientEvent(client,"draw:infobox",root,"info","You get nothing out of the wood chest!",8000)
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="ChestIron")then
							syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
							executeCommandHandler("mee",client," opened a "..item.." x1")
							local rdm=math.random(1,300)
							
							if(rdm>=1 and rdm<=100)then
								local burger=math.random(3,15)
								syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+burger)
								triggerClientEvent(client,"draw:infobox",root,"info","You get x"..burger.." burger out of the iron chest!",8000)
								if(tonumber(syncGetElementData(client,"Burger"))>=50)then
									syncSetElementData(client,"Burger",50)
								end
							elseif(rdm>=101 and rdm<=280)then
								local money=math.random(2000,6500)
								syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
								triggerClientEvent(client,"draw:infobox",root,"info","You get $"..money.." out of the iron chest!",8000)
							elseif(rdm>=281 and rdm<=300)then
								local ticket=math.random(1,3)
								local ticket2=math.random(1,2)
								if(ticket2==1)then
									syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+ticket)
									triggerClientEvent(client,"draw:infobox",root,"info","You get x"..ticket.." Bronze ticket out of the iron chest!",8000)
								elseif(ticket2==2)then
									syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+ticket)
									triggerClientEvent(client,"draw:infobox",root,"info","You get x"..ticket.." Silver ticket out of the iron chest!",8000)
								end
							end
							triggerClientEvent(client,"refresh:inventory",client)
						elseif(item=="Present")then
							if(settings.general.christmas==true)then
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
								executeCommandHandler("mee",client," opened a "..item.." x1")
								local rdm=math.random(1,300)
								
								if(rdm>=1 and rdm<=100)then
									local money=math.random(1000,3500)
									syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
									triggerClientEvent(client,"draw:infobox",root,"info","You get $"..money.." out of the Present!",8000)
								elseif(rdm>=101 and rdm<=200)then
									local ticket=math.random(1,1)
									local ticket2=math.random(1,2)
									if(ticket2==1)then
										syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+ticket)
										triggerClientEvent(client,"draw:infobox",root,"info","You get x"..ticket.." Bronze ticket out of the Present!",8000)
									elseif(ticket2==2)then
										syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+ticket)
										triggerClientEvent(client,"draw:infobox",root,"info","You get x"..ticket.." Silver ticket out of the Present!",8000)
									end
								elseif(rdm>=201 and rdm<=205)then
									local rdmcode=math.random(1000000,9999999)
									outputChatbox("You have won a Hotring Racer 1. CODE: "..rdmcode..". Contact an admin!",client,255,0,0)
								elseif(rdm>=206 and rdm<=300)then
									local weed=math.random(3,10)
									syncSetElementData(client,"Weed",tonumber(syncGetElementData(client,"Weed"))+weed)
									triggerClientEvent(client,"draw:infobox",root,"info","You get x"..weed.." Weed out of the Present!",8000)
								end
								triggerClientEvent(client,"refresh:inventory",client)
							end
						elseif(item=="Repairkit")then
							if(not isPedInVehicle(client))then
								for _,v in pairs(getElementsByType("vehicle"))do
									local x,y,z=getElementPosition(v)
									local px,py,pz=getElementPosition(client)
									
									if(getDistanceBetweenPoints3D(x,y,z,px,py,pz)<=3)then
										syncSetElementData(client,item,syncGetElementData(client,item)-amount)
										executeCommandHandler("mee",client," using a "..item)
										setPedAnimation(client,"graffiti","spraycan_fire")
										fixVehicle(v)
										finisRepairkit(client)
										if(tonumber(getElementData(v,"Totalloss"))==1)then
											setElementData(v,"Totalloss",0)
											handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Totalloss",0,"Owner",getElementData(v,"Owner"),"Slot",getElementData(v,"Slot"))
											setVehicleDamageProof(v,false)
										end
									end
								end
							else
								triggerClientEvent(client,"draw:infobox",root,"error","Stand next to/in front of the vehicle!",8000)
							end
						elseif(item=="IDcard")then
							triggerClientEvent(client,"open:idcard",client)
						elseif(item=="VehicleKey")then
							openVehpanel(client)
						elseif(item=="Moonstone")then
							outputChatbox("You can sell it on the Moon!",client,200,0,0)
						end
					end
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"warning","Wait 2 minutes after the last damage-\nbefore you can eat/use items",8000)
	end
end)
addEvent("destroy:item",true)
addEventHandler("destroy:item",root,function(item,amount)
	if(not isPedDead(client))then
		if(tonumber(syncGetElementData(client,item))>=amount)then
			if(item~="TicketBronze" and item~="TicketSilver" and item~="TicketGold" and item~="IDcard" and item~="VehicleKey")then
				syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
				triggerClientEvent(client,"refresh:inventory",client)
				executeCommandHandler("mee",client," destroyed "..item.." x"..amount.."")
			else
				triggerClientEvent(client,"draw:infobox",root,"warning","You can't destroyed this Item!",8000)
			end
		end
	end
end)

function finisRepairkit(player)
	setTimer(function()
		triggerClientEvent(player,"draw:infobox",root,"success","This vehicle was successfully repaired.",8000)
		setPedAnimation(player)
	end,6500,1)
end





function getTrunkItems(player)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local trunk=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Trunk")
		if(trunk)then
			local tbl={}
			table.insert(tbl,{"Burger",gettok(trunk,1,string.byte("|"))})
			table.insert(tbl,{"Pizza",gettok(trunk,2,string.byte("|"))})
			table.insert(tbl,{"Cola",gettok(trunk,3,string.byte("|"))})
			table.insert(tbl,{"Repairkit",gettok(trunk,8,string.byte("|"))})
			table.insert(tbl,{"Weed",gettok(trunk,9,string.byte("|"))})
			table.insert(tbl,{"WeedSeeds",gettok(trunk,10,string.byte("|"))})
			table.insert(tbl,{"AppleSeeds",gettok(trunk,11,string.byte("|"))})
			table.insert(tbl,{"Cigarette",gettok(trunk,12,string.byte("|"))})
			table.insert(tbl,{"Armor",gettok(trunk,13,string.byte("|"))})
			triggerClientEvent(player,"set:trunkitems",player,tbl)
		end
	end
end
addEvent("get:trunkitems",true)
addEventHandler("get:trunkitems",root,getTrunkItems)


addEvent("trunk:putin",true)
addEventHandler("trunk:putin",root,function(owner,item,amount)
	local veh=getPedOccupiedVehicle(client)
	local amount=tonumber(amount)
	if(veh)then
		if(amount)then
			if(owner==getPlayerName(client))then
				if(syncGetElementData(client,item)>=amount)then
					local trunk=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Trunk")
					if(trunk)then
						if(item=="Burger" or item=="Pizza" or item=="Cola" or item=="Repairkit" or item=="Weed" or item=="WeedSeeds" or item=="AppleSeeds" or item=="Cigarette" or item=="Armor")then
							local Burger=gettok(trunk,1,string.byte("|"))
							local Pizza=gettok(trunk,2,string.byte("|"))
							local Cola=gettok(trunk,3,string.byte("|"))
							local Repairkit=gettok(trunk,8,string.byte("|"))
							local Weed=gettok(trunk,9,string.byte("|"))
							local WeedSeeds=gettok(trunk,10,string.byte("|"))
							local AppleSeeds=gettok(trunk,11,string.byte("|"))
							local Cigarette=gettok(trunk,12,string.byte("|"))
							local Armor=gettok(trunk,13,string.byte("|"))
							syncSetElementData(client,item,syncGetElementData(client,item)-amount)
							
							
							if(item=="Burger")then
								Burger=Burger+amount
							elseif(item=="Pizza")then
								Pizza=Pizza+amount
							elseif(item=="Cola")then
								Cola=Cola+amount
							elseif(item=="Repairkit")then
								Repairkit=Repairkit+amount
							elseif(item=="Weed")then
								Weed=Weed+amount
							elseif(item=="WeedSeeds")then
								WeedSeeds=WeedSeeds+amount
							elseif(item=="AppleSeeds")then
								AppleSeeds=AppleSeeds+amount
							elseif(item=="Cigarette")then
								Cigarette=Cigarette+amount
							elseif(item=="Armor")then
								Armor=Armor+amount
							else
								triggerClientEvent(client,"draw:infobox",root,"error","Your cant put in this item!",8000)
							end
							local string=Burger.."|"..Pizza.."|"..Cola.."|0|0|0|0|"..Repairkit.."|"..Weed.."|"..WeedSeeds.."|"..AppleSeeds.."|"..Cigarette.."|"..Armor.."|0|0|0|0|0|0|0|0|0|0|0|0"
							
							dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Trunk",string,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
							getTrunkItems(client)
						else
							triggerClientEvent(client,"draw:infobox",root,"error","You cant putin this item!",8000)
						end
					end
				end
			end
		end
	end
end)
addEvent("trunk:putout",true)
addEventHandler("trunk:putout",root,function(owner,item,amount)
	local veh=getPedOccupiedVehicle(client)
	if(veh)then
		if(amount)then
			if(owner==getPlayerName(client))then
				local trunk=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Trunk")
				if(trunk)then
					local Burger=gettok(trunk,1,string.byte("|"))
					local Pizza=gettok(trunk,2,string.byte("|"))
					local Cola=gettok(trunk,3,string.byte("|"))
					local Repairkit=gettok(trunk,8,string.byte("|"))
					local Weed=gettok(trunk,9,string.byte("|"))
					local WeedSeeds=gettok(trunk,10,string.byte("|"))
					local AppleSeeds=gettok(trunk,11,string.byte("|"))
					local Cigarette=gettok(trunk,12,string.byte("|"))
					local Armor=gettok(trunk,13,string.byte("|"))
					syncSetElementData(client,item,syncGetElementData(client,item)+amount)
					
					if(item=="Burger")then
						if(Burger<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="Pizza")then
						if(Pizza<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="Cola")then
						if(Cola<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="Repairkit")then
						if(Repairkit<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="Weed")then
						if(Weed<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="WeedSeeds")then
						if(WeedSeeds<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="AppleSeeds")then
						if(AppleSeeds<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="Cigarette")then
						if(Cigarette<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					elseif(item=="Armor")then
						if(Armor<amount)then
							triggerClientEvent(client,"draw:infobox",root,"error","Your vehicle doesn't have this item (x"..amount..")!",8000)
							return false
						end
					end
					
					
					if(item=="Burger")then
						Burger=Burger-amount
					elseif(item=="Pizza")then
						Pizza=Pizza-amount
					elseif(item=="Cola")then
						Cola=Cola-amount
					elseif(item=="Repairkit")then
						Repairkit=Repairkit-amount
					elseif(item=="Weed")then
						Weed=Weed-amount
					elseif(item=="WeedSeeds")then
						WeedSeeds=WeedSeeds-amount
					elseif(item=="AppleSeeds")then
						AppleSeeds=AppleSeeds-amount
					elseif(item=="Cigarette")then
						Cigarette=Cigarette-amount
					elseif(item=="Armor")then
						Armor=Armor-amount
					end
					local string=Burger.."|"..Pizza.."|"..Cola.."|0|0|0|0|"..Repairkit.."|"..Weed.."|"..WeedSeeds.."|"..AppleSeeds.."|"..Cigarette.."|"..Armor.."|0|0|0|0|0|0|0|0|0|0|0|0"
					
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Trunk",string,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
					getTrunkItems(client)
				end
			end
		end
	end
end)