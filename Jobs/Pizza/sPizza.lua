--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

pizzaObject={}
pizzaLoaded={}
pizzaFirst={}
isPizzaMarker={}
pizzaTimer={}

local pizzaVehicles={
	{2109.2,-1789.6,13.2,0,0,0},
	{2111.2,-1789.6,13.2,0,0,0},
	{2113.2,-1789.6,13.2,0,0,0},
	{2115.2,-1789.6,13.2,0,0,0},
	{2117.2,-1789.6,13.2,0,0,0},
	{2119.2,-1789.6,13.2,0,0,0},
	{2121.2,-1789.6,13.2,0,0,0},
	{2123.2,-1789.6,13.2,0,0,0},
}
local pizzaPickups={
	{370.6,-118.9,1001.5,5,60},
}

function createPizzaVehicles()
	local PIZZAvehicle={}
	for i,v in ipairs(pizzaVehicles)do
		local rdmPlate=math.random(1000000,99999999)
		PIZZAvehicle[i]=createVehicle(448,v[1],v[2],v[3],v[4],v[5],v[6],rdmPlate)
		
		setElementFrozen(PIZZAvehicle[i],true)
		setVehicleColor(PIZZAvehicle[i],0,80,200,0,80,200)
		setVehicleHandling(PIZZAvehicle[i],"maxVelocity",45.0)
		
		setElementData(PIZZAvehicle[i],"veh:jobpizza",true)
		setElementData(PIZZAvehicle[i],"Fuel",100)
		setElementData(PIZZAvehicle[i],"Plate",rdmPlate)
	end
end
addEventHandler("onResourceStart",resourceRoot,createPizzaVehicles)
function createPizzaPickups()
	local Pickup={}
	for i,v in ipairs(pizzaPickups)do
		Pickup[i]=createPickup(v[1],v[2],v[3],3,1239,50)
		setElementInterior(Pickup[i],v[4])
		setElementDimension(Pickup[i],v[5])
		
		addEventHandler("onPickupHit",Pickup[i],function(player)
			if(syncGetElementData(player,"Job")=="Pizzaboy")then
				setPlayerPizza(player)
			end
		end)
	end
end
addEventHandler("onResourceStart",resourceRoot,createPizzaPickups)

function hasPlayerPizza(player)
	if(isElement(pizzaObject[player]))then
		setElementInterior(pizzaObject[player],getElementInterior(player))
		setElementDimension(pizzaObject[player],getElementDimension(player))
	end
end

function setPlayerPizza(player)
	if(not(isElement(pizzaObject[player])))then
		createPlayerPizza(player)
		triggerClientEvent(player,"draw:infobox",root,"info","Get on a pizza-scooter to deliver the pizza.",8000)
		pizzaLoaded[player]=true
	else
		triggerClientEvent(player,"draw:infobox",root,"warning","You already have a pizza with you, which-\nyou have to deliver!",8000)
	end
end
function createPlayerPizza(player)
	pizzaObject[player]=createObject(1582,0,0,0)
	setElementInterior(pizzaObject[player],getElementInterior(player))
	setElementDimension(pizzaObject[player],getElementDimension(player))
	setObjectScale(pizzaObject[player],0.7)
	attachElements(pizzaObject[player],player,0,0.4,0.3)
	setElementCollisionsEnabled(pizzaObject[player],false)
	setPedAnimation(player,"CARRY","crry_prtial",50)
end

addEvent("trigger:pizzaserver",true)
addEventHandler("trigger:pizzaserver",root,function()
	if(pizzaLoaded[client]==true)then
		if(not(isPedInVehicle(client)))then
			if(isPedOnGround(client))then
				if(isElement(pizzaObject[client]))then
					destroyElement(pizzaObject[client])
				end
				local tip=math.random(1,6)
				local rdmexp=math.random(5,12)
				giveJobMoney("Pizzaboy",65+tip)
				uEXP(client,"Job",rdmexp)
				uLevel(client,"Job")
				triggerClientEvent(client,"createPizzaMarker",client)
				pizzaLoaded[client]=false
				setPedAnimation(client)
				isPizzaMarker[client]=false
				triggerClientEvent(client,"draw:infobox",root,"info","Pizza delivered successfully!\nDrive back and get a new Pizza!",20000)
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"warning","Leave your vehicle first!",8000)
		end
	end
end)


function destroyPizza(player)
	if(isElement(pizzaObject[player]))then
		destroyElement(pizzaObject[player])
	end
	triggerClientEvent(player,"createPizzaMarker",player)
	pizzaLoaded[player]=false
	pizzaFirst[player]=false
	isPizzaMarker[player]=false
end

addEventHandler("onPlayerQuit",root,function()
	destroyPizza(source)
end)
addEventHandler("onPlayerWasted",root,function()
	destroyPizza(source)
end)