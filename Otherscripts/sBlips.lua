--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local blipTable={
--//Burgershots
{1199.2,-918.4,43.1,10,2,300},
{1872.5,2071.9,11.1,10,2,300},
{810.7,-1616.2,13.5,10,2,300},
{1173.4,-1439.7,15.8,10,2,300},
--//Pizza stacks
{2105.2,-1806.5,13.6,29,2,300},
--//Normal shops
{1352.4,-1759.1,13.5,50,2,300},
{1000.3,-920,42.3,50,2,300},
--//Skin shops
{2244.4,-1665.2,15.5,45,2,300},
--//Tuningshops
{2645.0,-2045.8,12.6,27,2,300},
{1041.8,-1013.0,32.1,27,2,300},
{2386.5,1051.7,9.9,27,2,300},
{-2725.2,217.6,4.5,27,2,300},
{-1935.8,246.9,34.5,27,2,300},
--//Tankstations
{1003.4,-936.2,42.3,42,2,300},
{1941.3,-1772.9,13.6,42,2,300},
--//Ammunation
{1368.8,-1280.5,13.5,6,2,300},
--//Carhouses
{2131.2,-1151.3,24.1,55,2,300},--CaS
{546.6,-1276.7,17.2,55,2,300},--Grotti
{-65.4,-1573.9,2.6,55,2,300},--Gang dealer
--//PayNsprays
{-1904.3,285.5,41.4,63,2,300},
{1976.6,2162.4,9.6,63,2,300},
{-99.8,1118.4,18.3,63,2,300},
{2061.2,-1831.6,13.5,63,2,300},
{720.2,-455.8,16.3,63,2,300},
{1024.9,-1023.7,32.1,63,2,300},
{487.3,-1741.6,11.2,63,2,300},
--//Other
{1172.1,-1323.3,15.4,22,2,300},--Hospital
{1480.7,-1772.3,18.8,56,2,300},--Townhall
{1164.6,-1452,15.8,47,2,300},--Electro
{912.4,-1233.3,17,37,2,300},--Towed
{1366.2,-1668.6,13.5,38,2,300},--Drivingschool
{382.4,-2061.7,7.8,46,2,300},--Fishing
{1107.8,-303.6,74,61,2,300},--Farm
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Element={}
	for i,v in pairs(blipTable)do
		Element[i]=createBlip(v[1],v[2],v[3],v[4],v[5],255,255,255,255,0,v[6],root)
	end
end)