--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local validItemsTable={
["IDcard"]=true,
["VehicleKey"]=true,
["Apple"]=true,
["Burger"]=true,
["Pizza"]=true,
["Candycane"]=true,
["Cola"]=true,
["ChestWood"]=true,
["ChestIron"]=true,
["TicketSilver"]=true,
["TicketBronze"]=true,
["TicketGold"]=true,
["Repairkit"]=true,
["Cocaine"]=true,
["Weed"]=true,
["WeedSeeds"]=true,
["AppleSeeds"]=true,
["Cigarette"]=true,
["Armor"]=true,
["Pickaxe"]=true,
["Moonstone"]=true,
["Present"]=true,
["Fishingrod"]=true,
["Fishinghook"]=true,
["Bait"]=true,
["Trout"]=true
}

local itemTextsTable={
["IDcard"]="IDcard:\nto see all informations about you.",
["VehicleKey"]="VehicleKey:",
["Apple"]="Apple:\nto eat and fill your Hunger.",
["Burger"]="Burger:\nto eat and fill your Hunger.",
["Pizza"]="Pizza:\nto eat and fill your Hunger.",
["Candycane"]="Candycane:\nto eat and fill your Hunger or exchange it-\nfor prizes.",
["Cola"]="Cola:\nto drink and fill your Hunger.",
["ChestWood"]="Wood Chest:\na chest with a present.",
["ChestIron"]="Iron Chest:\na chest with a present.",
["TicketBronze"]="Bronze Ticket:",
["TicketSilver"]="Silver Ticket:",
["TicketGold"]="Gold Ticket:",
["Repairkit"]="Repairkit:\nto repair a vehicle.",
["Cocaine"]="Cocaine:\nto use or sell.",
["Weed"]="Weed:\nto use or sell.",
["WeedSeeds"]="Weed seeds:\nto plant and get Weed.",
["AppleSeeds"]="Apple seeds:\nto plant and get Apples.",
["Cigarette"]="Cigarette:\nto smoking.",
["Armor"]="Armor:\nto use and get 100% Armor.",
["Pickaxe"]="Pickaxe:\nto get stuff on the Moon.",
["Moonstone"]="Moonstone:\nto sell it on the Moon.",
["Present"]="Present:",
["Fishingrod"]="Fishingrod:\na fishrod to fish fish.",
["Fishinghook"]="Fishinghook:",
["Bait"]="Bait:\nto fishing.",
["Trout"]="Trout:\nto eat and fill your Hunger or to sell it."
}

local itemImagesTable={
["IDcard"]="IDcard.png",
["VehicleKey"]="VehicleKey.png",
["Apple"]="Apple.png",
["Burger"]="Burger.png",
["Pizza"]="Pizza.png",
["Candycane"]="Candycane.png",
["Cola"]="Cola.png",
["ChestWood"]="ChestWood.png",
["ChestIron"]="ChestIron.png",
["TicketBronze"]="TicketBronze.png",
["TicketSilver"]="TicketSilver.png",
["TicketGold"]="TicketGold.png",
["Repairkit"]="Repairkit.png",
["Cocaine"]="Cocaine.png",
["Weed"]="Weed.png",
["WeedSeeds"]="WeedSeeds.png",
["AppleSeeds"]="AppleSeeds.png",
["Cigarette"]="Cigarette.png",
["Armor"]="Armor.png",
["Pickaxe"]="Pickaxe.png",
["Moonstone"]="Moonstone.png",
["Present"]="Present.png",
["Fishingrod"]="Fishingrod.png",
["Fishinghook"]="Fishinghook.png",
["Bait"]="Bait.png",
["Trout"]="Trout.png"
}
local standartInventoryTXT="No item selected!"

bindKey("i","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getPedOccupiedVehicleSeat(lp)~=0)then
				if(getElementData(lp,"ElementClicked")==false)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-400/2,500,400,settings.general.servername.." - Inventory",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,500,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-500/2,GLOBALscreenY/2-400/2,500,400,255,255,255,255,Lakeside.Window[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,5,250,365,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					item=dgsGridListAddColumn(Lakeside.Gridlist[1],"Item",0.6)
					amount=dgsGridListAddColumn(Lakeside.Gridlist[1],"Amount",0.2)
					
					Lakeside.Label[1]=dgsCreateLabel(265,10,100,20,standartInventoryTXT,false,Lakeside.Window[1])
					
					
					dgsCreateLabel(270,215,100,10,"Enter a amount to use/destory a item",false,Lakeside.Window[1])
					Lakeside.Edit[1]=dgsCreateEdit(260,230,235,40,0,false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Button[2]=dgsCreateButton(260,275,235,45,"use item",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(260,325,235,45,"destroy item",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								local item1=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item1>0)then
									local selectedGrid,_=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
									local selectedItem=dgsGridListGetItemText(Lakeside.Gridlist[1],selectedGrid,item)
									if(selectedItem)then
										if(validItemsTable[selectedItem])then
											dgsSetText(Lakeside.Label[1],itemTextsTable[selectedItem])
											if(isElement(Lakeside.Image[1]))then
												Lakeside.Image[1]:destroy()
											end
											Lakeside.Image[1]=dgsCreateImage(315,70,120,120,":"..settings.general.scriptname.."/Files/Images/Inventory/"..itemImagesTable[selectedItem],false,Lakeside.Window[1])
											if(selectedItem=="IDcard" or selectedItem=="Repairkit" or selectedItem=="ChestWood" or selectedItem=="ChestIron" or selectedItem=="TicketBronze" or selectedItem=="TicketSilver" or selectedItem=="TicketGold" or selectedItem=="VehicleKey" or selectedItem=="Cocaine" or selectedItem=="Weed" or selectedItem=="WeedSeeds" or selectedItem=="AppleSeeds" or selectedItem=="Armor" or selectedItem=="Present" or selectedItem=="Fishingrod" or selectedItem=="Bait" or selectedItem=="Fishinghook")then
												dgsSetEnabled(Lakeside.Edit[1],false)
											else
												dgsSetEnabled(Lakeside.Edit[1],true)
											end
											if(selectedItem=="TicketBronze" or selectedItem=="TicketSilver" or selectedItem=="TicketGold" or selectedItem=="Bait" or selectedItem=="Fishinghook")then
												dgsSetEnabled(Lakeside.Button[2],false)
												dgsSetEnabled(Lakeside.Button[3],false)
											else
												dgsSetEnabled(Lakeside.Button[2],true)
												dgsSetEnabled(Lakeside.Button[3],true)
											end
										end
									end
								else
									if(isElement(Lakeside.Image[1]))then
										Lakeside.Image[1]:destroy()
									end
									dgsSetText(Lakeside.Label[1],standartInventoryTXT)
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item1=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item1>0)then
									local amount=tonumber(dgsGetText(Lakeside.Edit[1]))or 0
									if(isOnlyNumbers(amount)and tonumber(amount)>=1)then
										local selectedGrid,_=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
										local selectedItem=dgsGridListGetItemText(Lakeside.Gridlist[1],selectedGrid,item)
										if(selectedItem)then
											if(validItemsTable[selectedItem])then
												triggerServerEvent("destroy:item",lp,selectedItem,tonumber(amount))
												if(isElement(Lakeside.Image[1]))then
													Lakeside.Image[1]:destroy()
												end
												dgsSetText(Lakeside.Label[1],standartInventoryTXT)
											end
										end
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item1=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item1>0)then
									local selectedGrid,_=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
									local selectedItem=dgsGridListGetItemText(Lakeside.Gridlist[1],selectedGrid,item)
									if(selectedItem)then
										if(validItemsTable[selectedItem])then
											if(selectedItem=="IDcard")then
												dgsCloseWindow(Lakeside.Window[1])
												setWindowData("remove","cursor_clicked",true)
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="Repairkit")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="ChestWood")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="ChestIron")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="Cocaine")then
												triggerServerEvent("use:item",lp,selectedItem,2)
											elseif(selectedItem=="Weed")then
												triggerServerEvent("use:item",lp,selectedItem,3)
											elseif(selectedItem=="WeedSeeds")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="AppleSeeds")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="Armor")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="Present")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="Fishingrod")then
												triggerServerEvent("use:item",lp,selectedItem,1)
											elseif(selectedItem=="VehicleKey")then
												triggerServerEvent("use:item",lp,selectedItem,1)
												dgsCloseWindow(Lakeside.Window[1])
												setWindowData("remove","cursor_clicked",false)
											else
												local amount=dgsGetText(Lakeside.Edit[1])or 0
												if(isOnlyNumbers(amount)and math.floor(amount)>=1)then
													triggerServerEvent("use:item",lp,selectedItem,math.floor(amount))
													if(isElement(Lakeside.Image[1]))then
														Lakeside.Image[1]:destroy()
													end
													dgsSetText(Lakeside.Label[1],standartInventoryTXT)
												end
											end
										end
									end
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
							end
						end,
					false)
					fillInventoryList()
				end
			else
				triggerEvent("open:trunk",lp)
			end
		end
	end
end)

addEvent("open:trunk",true)
addEventHandler("open:trunk",root,function()
	if(isPedInVehicle(lp)and getPedOccupiedVehicleSeat(lp)==0)then
		if(getElementData(lp,"ElementClicked")==false)then
			local veh=getPedOccupiedVehicle(lp)
			if(getElementData(veh,"Owner")~="none" and getElementData(veh,"Slot")~=nil and getElementData(veh,"Slot")~=0)then
				if(getElementData(veh,"Owner")and getElementData(veh,"Slot"))then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-700/2,GLOBALscreenY/2-400/2,700,400,settings.general.servername.." - Trunk",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(674,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,700,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					
					dgsCreateLabel(60,4,100,10,"Your Inventory",false,Lakeside.Window[1])
					Lakeside.Gridlist[1]=dgsCreateGridList(5,20,210,350,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					item=dgsGridListAddColumn(Lakeside.Gridlist[1],"Item",0.62)
					amount=dgsGridListAddColumn(Lakeside.Gridlist[1],"Amount",0.22)
					
					dgsCreateLabel(280,4,100,10,"Vehicle Inventory",false,Lakeside.Window[1])
					Lakeside.Gridlist[2]=dgsCreateGridList(220,20,210,350,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					item=dgsGridListAddColumn(Lakeside.Gridlist[2],"Item",0.62)
					amount=dgsGridListAddColumn(Lakeside.Gridlist[2],"Amount",0.22)
					
					
					dgsCreateLabel(455,215,100,10,"Enter a amount to put in/out a item",false,Lakeside.Window[1])
					Lakeside.Edit[1]=dgsCreateEdit(435,230,260,40,0,false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Button[2]=dgsCreateButton(435,275,260,45,"put in",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(435,325,260,45,"put out",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					triggerServerEvent("get:trunkitems",lp,lp)
					fillInventoryList()
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
									if(clicked~="")then
										local amount=dgsGetText(Lakeside.Edit[1])
										if(isOnlyNumbers(amount)and tonumber(amount)>=1)then
											triggerServerEvent("trunk:putout",lp,getPlayerName(lp),clicked,amount)
										end
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										local amount=dgsGetText(Lakeside.Edit[1])
										if(isOnlyNumbers(amount)and tonumber(amount)>=1)then
											triggerServerEvent("trunk:putin",lp,getPlayerName(lp),clicked,amount)
										end
									end
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
							end
						end,
					false)
				end
			end
		end
	end
end)


addEvent("set:trunkitems",true)
addEventHandler("set:trunkitems",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[2])
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[2])
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,item,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,amount,v[2],false,false)
		end
	end
end)

function fillInventoryList()
	fillWithItems(Lakeside.Gridlist[1],item,amount)
end
addEvent("refresh:inventory",true)
addEventHandler("refresh:inventory",root,fillInventoryList)

function fillWithItems(grid,itemName,itemCount)
	dgsGridListClear(grid)
	
	local row=dgsGridListAddRow(grid)
	dgsGridListSetItemText(grid,row,itemName,"General",true,false)
	dgsGridListSetItemColor(grid,row,itemName,0,200,0,255)
	local IDcard=tonumber(syncClientGetElementData("IDcard"))
	if(IDcard>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"IDcard",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(IDcard),false,false)
	end
	local VehicleKey=tonumber(syncClientGetElementData("VehicleKey"))
	if(VehicleKey>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"VehicleKey",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(VehicleKey),false,false)
	end
	
	local row=dgsGridListAddRow(grid)
	dgsGridListSetItemText(grid,row,itemName,"Eat/Drinks",true,false)
	dgsGridListSetItemColor(grid,row,itemName,200,200,0,255)
	local Apple=tonumber(syncClientGetElementData("Apple"))
	if(Apple>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Apple",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Apple),false,false)
	end
	local Burger=tonumber(syncClientGetElementData("Burger"))
	if(Burger>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Burger",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Burger),false,false)
	end
	local Pizza=tonumber(syncClientGetElementData("Pizza"))
	if(Pizza>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Pizza",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Pizza),false,false)
	end
	local Candycane=tonumber(syncClientGetElementData("Candycane"))
	if(Candycane>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Candycane",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Candycane),false,false)
	end
	local Cola=tonumber(syncClientGetElementData("Cola"))
	if(Cola>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Cola",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Cola),false,false)
	end
	
	local row=dgsGridListAddRow(grid)
	dgsGridListSetItemText(grid,row,itemName,"Drugs",true,false)
	dgsGridListSetItemColor(grid,row,itemName,220,0,0,255)
	local Cocaine=tonumber(syncClientGetElementData("Cocaine"))
	if(Cocaine>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Cocaine",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Cocaine),false,false)
	end
	local Weed=tonumber(syncClientGetElementData("Weed"))
	if(Weed>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Weed",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Weed),false,false)
	end
	
	local row=dgsGridListAddRow(grid)
	dgsGridListSetItemText(grid,row,itemName,"Other",true,false)
	local Cigarette=tonumber(syncClientGetElementData("Cigarette"))
	if(Cigarette>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Cigarette",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Cigarette),false,false)
	end
	local Armor=tonumber(syncClientGetElementData("Armor"))
	if(Armor>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Armor",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Armor),false,false)
	end
	local ChestWood=tonumber(syncClientGetElementData("ChestWood"))
	if(ChestWood>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"ChestWood",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(ChestWood),false,false)
	end
	local ChestIron=tonumber(syncClientGetElementData("ChestIron"))
	if(ChestIron>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"ChestIron",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(ChestIron),false,false)
	end
	local TicketBronze=tonumber(syncClientGetElementData("TicketBronze"))
	if(TicketBronze>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"TicketBronze",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(TicketBronze),false,false)
	end
	local TicketSilver=tonumber(syncClientGetElementData("TicketSilver"))
	if(TicketSilver>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"TicketSilver",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(TicketSilver),false,false)
	end
	local TicketGold=tonumber(syncClientGetElementData("TicketGold"))
	if(TicketGold>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"TicketGold",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(TicketGold),false,false)
	end
	local Repairkit=tonumber(syncClientGetElementData("Repairkit"))
	if(Repairkit>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Repairkit",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Repairkit),false,false)
	end
	local Pickaxe=tonumber(syncClientGetElementData("Pickaxe"))
	if(Pickaxe>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Pickaxe",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Pickaxe),false,false)
	end
	local Moonstone=tonumber(syncClientGetElementData("Moonstone"))
	if(Moonstone>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Moonstone",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Moonstone),false,false)
	end
	
	local WeedSeeds=tonumber(syncClientGetElementData("WeedSeeds"))
	if(WeedSeeds>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"WeedSeeds",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(WeedSeeds),false,false)
	end
	local AppleSeeds=tonumber(syncClientGetElementData("AppleSeeds"))
	if(AppleSeeds>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"AppleSeeds",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(AppleSeeds),false,false)
	end
	local Present=tonumber(syncClientGetElementData("Present"))
	if(Present>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Present",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Present),false,false)
	end
	local Fishingrod=tonumber(syncClientGetElementData("Fishingrod"))
	if(Fishingrod>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Fishingrod",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Fishingrod),false,false)
	end
	local Fishinghook=tonumber(syncClientGetElementData("Fishinghook"))
	if(Fishinghook>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Fishinghook",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Fishinghook),false,false)
	end
	local Bait=tonumber(syncClientGetElementData("Bait"))
	if(Bait>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Bait",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Bait),false,false)
	end
	local Trout=tonumber(syncClientGetElementData("Trout"))
	if(Trout>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Trout",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Trout),false,false)
	end
end



addEvent("open:idcard",true)
addEventHandler("open:idcard",root,function()
	if(isLoggedin())then
		setWindowData("add","cursor_clicked",false)
		Lakeside.Window[1]=dgsCreateImage(GLOBALscreenX/2-460/2,GLOBALscreenY/2-300/2,460,300,"Files/Images/IDcard.png",false)
		
		Lakeside.Button[1]=dgsCreateButton(440,0,20,20,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		
		local pname=getPlayerName(lp)pname=pname:gsub("_"," ")
		local skin=getElementModel(lp)
		local bankpin=tonumber(syncClientGetElementData("Bankpin"))
		local carlicense=tonumber(syncClientGetElementData("CarLicense"))
		local bikelicense=tonumber(syncClientGetElementData("BikeLicense"))
		if(bankpin~=0)then
			bankpin=bankpin
		else
			bankpin="not found!"
		end
		if(carlicense==1)then
			carlicense="Yes"
		else
			carlicense="No"
		end
		if(bikelicense==1)then
			bikelicense="Yes"
		else
			bikelicense="No"
		end
		
		Lakeside.Label[1]=dgsCreateLabel(15,60,100,10,"Caracter name: "..pname,false,Lakeside.Window[1])
		Lakeside.Label[2]=dgsCreateLabel(15,80,100,10,"Birth date: "..syncClientGetElementData("BirthDate"),false,Lakeside.Window[1])
		Lakeside.Label[3]=dgsCreateLabel(15,100,100,10,"Bank-pin: "..bankpin,false,Lakeside.Window[1])
		Lakeside.Label[4]=dgsCreateLabel(15,180,100,10,"Licenses:",false,Lakeside.Window[1])
		Lakeside.Label[5]=dgsCreateLabel(15,210,100,10,"Car license: "..carlicense.." (Points: "..syncClientGetElementData("CarLicensePoints").."/15)",false,Lakeside.Window[1])
		Lakeside.Label[6]=dgsCreateLabel(15,230,100,10,"Bike license: "..bikelicense.." (Points: "..syncClientGetElementData("BikeLicensePoints").."/15)",false,Lakeside.Window[1])
		dgsLabelSetColor(Lakeside.Label[1],0,0,0)
		dgsLabelSetColor(Lakeside.Label[2],0,0,0)
		dgsLabelSetColor(Lakeside.Label[3],0,0,0)
		dgsLabelSetColor(Lakeside.Label[4],0,0,0)
		dgsLabelSetColor(Lakeside.Label[5],0,0,0)
		dgsLabelSetColor(Lakeside.Label[6],0,0,0)
		dgsSetProperty(Lakeside.Label[4],"textSize",{1.2,1.2})
		
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					Lakeside.Window[1]:destroy()
					setWindowData("remove","cursor_clicked",false)
				end
			end,
		false)
	end
end)














local lsdColorsTable={{255,0,255},{0,255,0},{255,255,255},{255,255,0},{151,255,255},{255,0,0},{255,20,147},{0,250,154},{0,255,255}}
local drugColorsTable={{0,200,0},{0,100,0},{0,220,0},{0,80,0}}
local drugLight

function drawDrugEffects_Func()
	for i=100,350,1 do
		local color,x,y=math.random(1,#drugColorsTable),math.random(3,15),math.random(3,17)
		local posx,posy=math.random(1,GLOBALscreenX-x),math.random(1,GLOBALscreenY-y)
		dxDrawRectangle(posx,posy,x,y,tocolor(drugColorsTable[color][1],drugColorsTable[color][2],drugColorsTable[color][3],math.random(1,160)),false,true)
	end
end

function drawCocaineEffects_Func()
	for i=800,1400,1 do
		local color,x,y=math.random(1,#drugColorsTable),math.random(6,20),math.random(10,23)
		local posx,posy=math.random(1,GLOBALscreenX-x),math.random(1,GLOBALscreenY-y)
		dxDrawRectangle(posx,posy,x,y,tocolor(drugColorsTable[color][1],drugColorsTable[color][2],drugColorsTable[color][3],math.random(1,160)),false,true)
	end
	
	local x,y,z=getElementPosition(lp)
	setSearchLightStartPosition(drugLight,x,y,z+10)
	setSearchLightEndPosition(drugLight,x,y,z-0.95)
end

addEvent("use:weedeffect",true)
addEventHandler("use:weedeffect",root,function()
	if(not(isTimer(CocaineTimer)))then
		if(not(isTimer(WeedTimer)))then
			local WeedCounter=0
			WeedTimer=setTimer(function()
				WeedCounter=WeedCounter+1
				if(WeedCounter==8)then
					local x,y,z=getElementPosition(lp)
					setGameSpeed(0.8)
					setElementHealth(lp,getElementHealth(lp)+1)
					addEventHandler("onClientRender",root,drawDrugEffects_Func)
				end
				if(WeedCounter==14)then
					setCameraShakeLevel(80)
					if(isElement(WeedSound))then
						WeedSound:destroy()
					end
					WeedSound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Weedeffects.mp3",true)
					setSoundVolume(WeedSound,1)
				end
				if(WeedCounter>=60)then
					setCameraShakeLevel(0)
					setGameSpeed(1)
					WeedTimer:destroy()
					if(isElement(WeedSound))then
						WeedSound:destroy()
					end
					removeEventHandler("onClientRender",root,drawDrugEffects_Func)
				end
			end,1000,61)
		end
	end
end)

addEvent("use:cocaineeffect",true)
addEventHandler("use:cocaineeffect",root,function()
	if(not(isTimer(WeedTimer)))then
		if(not(isTimer(CocaineTimer)))then
			local CocaineCounter=0
			CocaineTimer=setTimer(function()
				CocaineCounter=CocaineCounter+1
				if(CocaineCounter==8)then
					local x,y,z=getElementPosition(lp)
					setGameSpeed(0.5)
					drugLight=createSearchLight(x,y,z+20,x,y,z-0.95,0.1,5)
					setElementHealth(lp,getElementHealth(lp)+2)
					addEventHandler("onClientRender",root,drawCocaineEffects_Func)
				end
				if(CocaineCounter==10)then
					setCameraShakeLevel(165)
					if(isElement(CocaineSound))then
						CocaineSound:destroy()
					end
					CocaineSound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Weedeffects.mp3",true)
					setSoundVolume(CocaineSound,1)
				end
				if(CocaineCounter>=75)then
					destroyElement(drugLight)
					setCameraShakeLevel(0)
					setGameSpeed(1)
					CocaineTimer:destroy()
					if(isElement(CocaineSound))then
						CocaineSound:destroy()
					end
					removeEventHandler("onClientRender",root,drawCocaineEffects_Func)
				end
			end,1000,76)
		end
	end
end)