--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local xmasObjectList={
	{3861,1487.7,-1709.2,14.2,0,0,270},
	{2513,1487,-1708.2,13.95,0,0,300},
	{2474,1486.8,-1709.6,13.84,0,0,20},
}
local XMASpedTable={
	{256,1488.1,-1709.2,14.1,90,"Christmas1_PED","Madeleine Elliott [NPC]","Christmas"},
}

addEventHandler("onResourceStart",resourceRoot,function()
	if(settings.general.christmas==true)then
		local XMASobject={}
		for i,v in pairs(xmasObjectList)do
			XMASobject[i]=createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			setElementDoubleSided(XMASobject[i],true)
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	if(settings.general.christmas==true)then
		local XmasPeds={}
		for i,v in pairs(XMASpedTable)do
			if(#XMASpedTable>=1)then
				XmasPeds[i]=createPed(v[1],v[2],v[3],v[4],v[5])
				
				if(v[6]=="Christmas1_PED")then
					setElementData(XmasPeds[i],"Christmas1PED",true)
				end
				
				
				if(v[7])then
					setElementData(XmasPeds[i],"set:pedtext",v[7])
				end
				if(v[8])then
					setElementData(XmasPeds[i],"set:peddescription",v[8])
				end
			end
		end
	end
end)