--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local customPickupTable={}

function createCmarker(x,y,z,int,dim,image,uimage,size,func)
	local pickup={x=x,y=y,z=z,int=int,dim=dim,image=image,uimage=uimage,size=size,func=func}
	if(uimage)then
		uimage=":"..settings.general.scriptname.."/Files/Images/cMarker/"..uimage..".png"
	else
		uimage=":"..settings.general.scriptname.."/Files/Images/Transparent.png"
	end
	local colShape=createColSphere(x,y,z,size)
	if(colShape)then
		setElementID(colShape,"customPickup")
		setElementData(colShape,"customPickup.image",image)
		setElementData(colShape,"customPickup.uimage",uimage)
		setElementData(colShape,"customPickup.positions",{x,y,z})
		addEventHandler("onColShapeHit",colShape,eventCustomPickup)
		pickup.colshape=colShape
		customPickupTable[tostring(colShape)]=pickup
	end
end

function eventCustomPickup(player)
    if(getElementID(source)=="customPickup" and getElementType(player)=="player")then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			customPickupTable[tostring(source)].func(player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Wait 30 seconds after the last hit/shot!",7500)
		end
    end
end