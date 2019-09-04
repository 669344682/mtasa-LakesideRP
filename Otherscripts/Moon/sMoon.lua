--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local farmingTimer={}
local lastFarmingMarker=0
playerOnMoon=nil

Rocket=createObject(1243,349.3,3110.5,7.8,0,180,0)
setElementFrozen(Rocket,true)
setElementDoubleSided(Rocket,true)

addEvent("start:moonrocket",true)
addEventHandler("start:moonrocket",root,function(typ)
	if(typ=="Go to the moon")then
		if(isElement(MoonMarker))then
			if(tonumber(syncGetElementData(client,"Money"))>=200000)then
				setTimer(function(client)
					if(isElement(client))then
						attachElements(client,Rocket,0,-4,3)
						setElementAlpha(client,0)
					end
				end,50,1,client)
				MoonMarker:destroy()
				playerOnMoon=getPlayerName(client)
				setElementData(client,"inRocket",true)
				setElementData(client,"onTheMoon",true)
				triggerClientEvent(client,"start:moonrocket",client,"create")
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-200000)
				
				moveObject(Rocket,60000,349.3,3110.5,1158.3)
				setTimer(function(client)
					fadeCamera(client,false)
				end,40000,1,client)
				
				setTimer(function(client)
					if(isElement(client))then
						detachElements(client,Rocket)
						setElementPosition(client,354.5,3110.6,1152.9)
						setPedRotation(client,270)
						createRocketMarker(2)
						setElementAlpha(client,255)
						setElementData(client,"inRocket",false)
						setPedGravity(client,0.004)
						triggerClientEvent(client,"activate:moonfeeling",client,"create")
						setElementModel(client,79)
						triggerClientEvent(client,"start:moonrocket",client)
						fadeCamera(client,true)
					else
						moveObject(Moon.rocket,60000,349.3,3110.5,7.8)
						setTimer(function()
							createRocketMarker(1)
						end,60000,1)
					end
				end,60000,1,client)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($25.000)",8000)
			end
		else
			outputChatBox("The rocket is already in the Sky!",client,200,0,0)
		end
	else
		fadeCamera(client,false)
		MoonMarker:destroy()
		
		setTimer(function()
			createRocketMarker(1)
			playerOnMoon=nil
		end,62000,1)
		
		setTimer(function(client)
			if(isElement(client))then
				setTimer(function(client)
					if(isElement(client))then
						attachElements(client,Rocket,0,-4,3)
						setElementAlpha(client,0)
					end
				end,50,1,client)
			
				setElementData(client,"inRocket",true)
				triggerClientEvent(client,"activate:moonfeeling",client,"destroy")
				triggerClientEvent(client,"start:moonrocket",client,"create")
				setTimer(function(client)
					if(isElement(client))then
						detachElements(client,Rocket)
						setElementPosition(client,348.85388183594,3106.1140136719,1.0490655899048)
						setPedRotation(client,0)
						setElementAlpha(client,255)
						setElementData(client,"inRocket",false)
						setElementData(client,"onTheMoon",false)
						setPedGravity(client,0.008)
						setElementModel(client,syncGetElementData(client,"SkinID"))
						triggerClientEvent(client,"start:moonrocket",client)
						fadeCamera(client,true)
					end
				end,60000,1,client)
			end
			moveObject(Rocket,60000,349.3,3110.5,7.8)
		end,2000,1,client)
	end
end)

addEvent("buy:pickaxe",true)
addEventHandler("buy:pickaxe",root,function(amount)
	local amount=tonumber(amount)
	if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.pickaxePrice)then
		syncSetElementData(client,"Pickaxe",tonumber(syncGetElementData(client,"Pickaxe"))+amount)
		syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.pickaxePrice)
		triggerClientEvent(client,"draw:infobox",root,"success","You have buyed x"..amount.." Pickaxe.",8000)
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..amount*settings.shop.pickaxePrice..")",8000)
	end
end)
addEvent("sell:moonstone",true)
addEventHandler("sell:moonstone",root,function(amount)
	local amount=tonumber(amount)
	if(tonumber(syncGetElementData(client,"Moonstone"))>=amount)then
		syncSetElementData(client,"Moonstone",tonumber(syncGetElementData(client,"Moonstone"))-amount)
		syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+amount*settings.shop.moonstonePrice)
		triggerClientEvent(client,"draw:infobox",root,"success","You have selled x"..amount.." Moonstone.\nYou get $"..amount*settings.shop.moonstonePrice.."",8000)
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough Moonstone! (x"..amount..")",8000)
	end
end)




MoonObjects={
	{6959,315.15780639648,3112.15625,1151.9168701172,0,0,0},
	{6959,315.14950561523,3072.1577148438,1151.9168701172,0,0,0},
	{6959,315.14041137695,3032.1589355469,1151.9168701172,0,0,0},
	{6959,273.81060791016,3112.1533203125,1151.9168701172,0,0,0},
	{6959,273.810546875,3072.1577148438,1151.9168701172,0,0,0},
	{6959,273.810546875,3032.1589355469,1151.9168701172,0,0,0},
	{6959,232.46380615234,3112.1528320313,1151.9168701172,0,0,0},
	{6959,232.4638671875,3072.1577148438,1151.9168701172,0,0,0},
	{6959,232.4638671875,3032.1589355469,1151.9168701172,0,0,0},
	{6959,336.02160644531,3076.9868164063,1151.9168701172,0,334,0},
	{6959,336.01989746094,3036.9892578125,1151.9168701172,0,333.99499511719,0},
	{6959,335.99371337891,2997.0422363281,1151.8918457031,0,333.99499511719,0},
	{6959,354.00961303711,3076.9755859375,1179.9895019531,0,90,0},
	{6959,354.01119995117,3037.0041503906,1179.9895019531,0,90,0},
	{6959,354.00891113281,2997.0241699219,1179.9895019531,0,90,0},
	{6959,336.51629638672,3012.2082519531,1151.9168701172,0,333.99499511719,270},
	{6959,296.54809570313,3012.1948242188,1151.9168701172,0,333.98999023438,270},
	{6959,256.55868530273,3012.1853027344,1151.9168701172,0,333.98999023438,270},
	{6959,216.56100463867,3012.2041015625,1151.9049072266,0,333.98999023438,270},
	{6959,334.41030883789,2994.2995605469,1179.9895019531,0,90,90},
	{6959,294.41900634766,2994.2985839844,1179.978515625,0,90,90},
	{6959,254.43350219727,2994.2978515625,1179.9685058594,0,90,90},
	{6959,214.5218963623,2994.2973632813,1179.9584960938,0,90,90},
	{6959,213.38609313965,3012.1618652344,1151.9168701172,0,333.98999023438,180},
	{6959,213.36090087891,3052.1586914063,1151.9178466797,0,333.98999023438,179.99499511719},
	{6959,213.37480163574,3092.1520996094,1151.9178466797,0,333.98999023438,179.99499511719},
	{6959,213.39210510254,3132.1496582031,1151.9178466797,0,333.98999023438,179.99499511719},
	{6959,213.76089477539,3129.9670410156,1151.9178466797,0,333.98999023438,90},
	{6959,253.64349365234,3129.9599609375,1151.9178466797,0,333.98999023438,90},
	{6959,293.62619018555,3129.9543457031,1151.9147949219,0,333.98999023438,90},
	{6959,333.58331298828,3129.9545898438,1151.9147949219,0,333.98999023438,90},
	{6959,354.00830078125,3116.9660644531,1179.9895019531,0,90,0},
	{6959,195.80059814453,3014.1813964844,1179.9584960938,0,90,0},
	{6959,195.80029296875,3054.1528320313,1179.9584960938,0,90,0},
	{6959,195.79730224609,3094.1271972656,1179.9584960938,0,90,0},
	{6959,195.79499816895,3134.1140136719,1179.9584960938,0,90,0},
	{6959,215.56140136719,3147.9584960938,1179.9584960938,0,90,270},
	{6959,255.44309997559,3147.9638671875,1179.9584960938,0,90,270},
	{6959,295.40939331055,3147.9680175781,1179.9584960938,0,90,270},
	{6959,335.37710571289,3147.9663085938,1179.9525146484,0,90,270},
	{6959,354.00970458984,3156.7722167969,1179.9895019531,0,90,0},
	{6959,1963.9783935547,-368.12149047852,1072.7543945313,90,0,0.25},
	{6959,1951.2658691406,-360.22650146484,1095.5603027344,310,180,90},
	{6959,1976.876953125,-356.75421142578,1095.5196533203,310,180,270},
	{6959,1958.9571533203,-378.23306274414,1096.3381347656,309.99572753906,180,180},
	{16118,360.32650756836,3064.3757324219,1153.0157470703,0,324,336},
	{16118,354.84588623047,3018.7692871094,1153.0157470703,0,345.99792480469,344},
	{16118,310.1162109375,2992.2976074219,1153.0157470703,0,345.99200439453,270},
	{16118,256.79409790039,2990.0251464844,1150.0339355469,0,3.9920043945313,277.9},
	{16118,213.01789855957,3003.4204101563,1149.5631103516,0,3.9880065917969,221.9},
	{16118,312.82888793945,3052.09765625,1148.7468261719,0,0,330},
	{16118,291.28369140625,3104.6813964844,1148.7468261719,0,0,73.996002197266},
	{16118,199.85369873047,3050.0869140625,1153.6848144531,0,16,359.99304199219},
	{16118,272.74841308594,3062.2348632813,1137.5257568359,1.9809875488281,8.0050048828125,11.7},
	{16118,245.78109741211,3025.1721191406,1137.5257568359,1.9779968261719,8.0039978027344,247.7},
	{16118,330.92849731445,3033.2333984375,1137.5257568359,1.9720153808594,7.9979858398438,137.7},
	{16118,283.3655090332,3027.7255859375,1137.5257568359,1.9670104980469,7.9929809570313,187.7},
	{16118,241.54530334473,3112.4516601563,1137.5257568359,1.9609985351563,7.9869995117188,109.7},
	{16118,342.11920166016,3079.2204589844,1146.0989990234,0,314,203.99603271484},
	{16118,249.671875,3059.2314453125,1149.2176513672,0,0,25.988006591797},
	{16118,197.52340698242,3109.3876953125,1153.6848144531,0,15.996002197266,343.98901367188},
	{16118,244.60650634766,3148.6193847656,1149.2176513672,0,4,95.988006591797},
	{16118,283.73919677734,3148.0354003906,1149.2176513672,0,17.996002197266,249.98797607422},
	{16118,348.97021484375,3147.1354980469,1151.6501464844,0,0,25.992980957031},
	{16118,356.52481079102,3126.4025878906,1148.8251953125,0,355.99993896484,269.98803710938},
	{16118,303.16970825195,3123.0627441406,1137.5257568359,1.9670104980469,7.9929809570313,245.7},
}
MoonMiningMarker={
	{331.40106201172,3092.7121582031,1152.9,258},
	{331.2578125,3080.0703125,1152.9,125},
	{338.86889648438,3078.2004394531,1154.3,280},
	{328.58016967773,3067.4799804688,1152.9,70},
	{350.39852905273,3060.8312988281,1159.9,260},
	{333.45953369141,3047.0454101563,1152.9,252},
	{323.85650634766,3040.0637207031,1152.9,211},
	{349.49197387695,3027.607421875,1159.4,280},
	{333.81420898438,3017.3361816406,1152.9,270},
	{337.16452026367,3002.2956542969,1157.7,180},
	{326.92849731445,3015.5505371094,1152.9,71},
	{315.83343505859,3000.609375,1158.5,142},
	{304.54241943359,3012.2204589844,1153.1,178},
	{293.77389526367,3013.6352539063,1153.0,118},
	{306.15585327148,3032.1809082031,1152.9,24},
	{313.35461425781,3023.400390625,1152.9,244},
	{319.6252746582,3031.431640625,1152.9,287},
	{285.88265991211,3033.8110351563,1152.9,151},
	{291.49951171875,3054.7958984375,1152.9,253},
	{282.60848999023,3063.4963378906,1152.9,87},
	{282.41912841797,3051.9331054688,1152.9,133},
	{281.64520263672,3040.5751953125,1153.0,82},
	{264.91571044922,3027.1638183594,1152.9,177},
	{257.86767578125,3039.0842285156,1152.9,16},
	{309.20690917969,3060.4155273438,1152.9,263},
	{294.8571472168,3083.2419433594,1152.9,356},
	{274.81909179688,3082.6101074219,1152.9,9},
	{277.56604003906,3095.8132324219,1152.9,21},
	{261.34530639648,3101.9514160156,1152.9,342},
	{265.70620727539,3117.9467773438,1152.9,194},
	{289.42553710938,3113.9169921875,1152.9,167},
	{296.27960205078,3120.3950195313,1152.9,266},
	{287.25143432617,3128.9208984375,1152.9,217},
	{275.58331298828,3143.2287597656,1159.4,356},
	{257.33190917969,3145.1437988281,1160.4,344},
	{250.29995727539,3128.8649902344,1152.9,338},
	{271.1259765625,3141.0979003906,1158.4,9},
	{291.45034790039,3137.77734375,1156.7,1},
	{250.76077270508,3117.3898925781,1152.9,338},
	{239.1096496582,3121.8132324219,1152.9,179},
	{225.14044189453,3113.337890625,1152.9,181},
	{226.0433807373,3133.2961425781,1154.5,310},
	{218.06455993652,3137.1689453125,1156.4,19},
	{209.59098815918,3127.7788085938,1154.8,86},
	{206.85975646973,3118.0981445313,1156.1,86},
	{203.1695098877,3102.9196777344,1157.9,86},
	{202.81834411621,3082.5310058594,1158.1,165},
	{228.17637634277,3077.1423339844,1152.9,292},
	{233.53051757813,3063.4421386719,1152.9,332},
	{235.03970336914,3052.595703125,1152.9,254},
	{242.08758544922,3037.6979980469,1152.9,353},
	{310.89678955078,3105.4340820313,1152.9,122},
	{312.57437133789,3112.3522949219,1152.9,322},
	{308.54592895508,3126.7185058594,1152.9,126},
	{308.74160766602,3144.2646484375,1159.9,99},
	{340.1325378418,3146.1452636719,1160.8,265},
	{334.29888916016,3125.8999023438,1152.9,255},
	{308.05285644531,3095.3884277344,1152.9,29},
}
MoonMarkerTable={
	[1]={349.3,3108.6,0.1},
	[2]={351.4,3110.5,1150.6},
}

function createMoonObjects()
	if(#MoonObjects>=1)then
		local MoonObject={}
		for i,v in pairs(MoonObjects)do
			MoonObject[i]=createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,createMoonObjects)

function createRocketMarker(id)
	MoonMarker=createMarker(MoonMarkerTable[id][1],MoonMarkerTable[id][2],MoonMarkerTable[id][3],"cylinder",1.2,200,200,0,120)
	
	addEventHandler("onMarkerHit",MoonMarker,function(player)
		if(getElementDimension(player)==getElementDimension(source))then
			triggerClientEvent(player,"open:moonrocketUI",player,id)
		end
	end)
end
createRocketMarker(1)

function createMoonFarmningMarker()
	if(isElement(MoonFarmingMarker))then
		MoonFarmingMarker:destroy()
	end
	local rnd=math.random(1,#MoonMiningMarker)
	if(rnd~=lastFarmingMarker)then
		lastFarmingMarker=rnd
		MoonFarmingMarker=createMarker(MoonMiningMarker[rnd][1],MoonMiningMarker[rnd][2],MoonMiningMarker[rnd][3],"cylinder",1,255,255,255,150)
		
		addEventHandler("onMarkerHit",MoonFarmingMarker,function(player)
			if(not(isPedInVehicle(player))and isPedOnGround(player))then
				if(getElementDimension(player)==getElementDimension(source))then
					setPedRotation(player,MoonMiningMarker[rnd][4])
					moonFarming(player)
				end
			end
		end)
	else
		createMoonFarmningMarker()
	end
end
createMoonFarmningMarker()


function moonFarming(player)
	if(tonumber(syncGetElementData(player,"Pickaxe"))>=1)then
		MoonFarmingMarker:destroy()
		giveWeapon(player,5,1,true)
		setElementFrozen(player,true)
		toggleAllControls(player,false)
		setPedAnimation(player,"baseball","Bat_4")
		triggerClientEvent(player,"start:pickaxesound",player,"create")
		farmingTimer=setTimer(function(player)
			setElementFrozen(player,false)
			toggleAllControls(player,true)
			setPedAnimation(player)
			local rdm=math.random(1,6)
			local rdm2=math.random(1,18)
			if(rdm==3)then
				syncSetElementData(player,"Moonstone",tonumber(syncGetElementData(player,"Moonstone"))+1)
				outputChatBox("You get x1 Moonstone.",player,0,200,0)
			else
				if(rdm2==7)then
					syncSetElementData(player,"Pickaxe",tonumber(syncGetElementData(player,"Pickaxe"))-1)
					outputChatBox("You get lost x1 Pickaxe.",player,200,0,0)
				else
					outputChatBox("Nothing.",player,200,0,0)
				end
			end
			takeWeapon(player,5)
			createMoonFarmningMarker()
		end,15000,1,player)
	end
end

function moonPlayerQuitOrWasted(player)
	if(playerOnMoon==getPlayerName(player))then
		if(isTimer(farmingTimer[player]))then
			farmingTimer[player]:destroy()
		end
		playerOnMoon=nil
		moveObject(Moon.rocket,60000,349.3,3110.5,7.8)
		setTimer(function()
			createRocketMarker()
		end,60000,1)
		setElementData(player,"inRocket",false)
		setPedGravity(player,0.008)
		triggerClientEvent(player,"activate:moonfeeling",player,"destroy")
		triggerClientEvent(player,"start:pickaxesound",player)
	end
end

addEventHandler("onPlayerWasted",root,function()
	moonPlayerQuitOrWasted(source)
end)
addEventHandler("onPlayerQuit",root,function()
	moonPlayerQuitOrWasted(source)
end)