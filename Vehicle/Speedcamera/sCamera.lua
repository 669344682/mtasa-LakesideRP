--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Lars-Marcel  ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local stadtlimit=55
local blitzer={ -- Format: {Blitzer-X, Blitzer-Y, Blitzer-Z, Blitzer-RotZ, Colshape-X, Colshape-Y, Colshape-Z, Colshape-Radius, Max speed}
	{
		pos={1455.9,-1726.6,12.4,74,1482.8,-1729.9,13.6,4.0,stadtlimit},--Townhall
	},
	{
		pos={1363.3,-1349.1,12.5,350,1357.6,-1375.6,13.6,5.5,stadtlimit},--LS Ammunation
	},
	{
		pos={1189.6,-1357.6,12.5,160,1201,-1340.3,13.6,9,stadtlimit},--LS Hospital
	},
	{
		pos={524.3,-1709.3,11.7,70,548.7,-1717.9,13,5.5,stadtlimit},--LS Strand
	},
}


for i,v in ipairs(blitzer)do
	local oX,oY,oZ,orZ,cX,cY,cZ,cS,maxSpeed=unpack(v.pos)
	v.object=createObject(3890,oX,oY,oZ,0,0,orZ)
	
	local bin=createObject(1668,0,0,0)
	attachElements(bin,v.object,0.8,-0.7,6)
	local eX,eY,eZ=getElementPosition(bin)
	detachElements(bin,v.object)
	bin:destroy()
	
	v.colsphere=createColSphere(cX,cY,cZ,cS)
	addEventHandler("onColShapeHit",v.colsphere,function(ele,dim)
		if(dim and getElementType(ele)=="player")then
			local veh=getPedOccupiedVehicle(ele)
			if(veh and getPedOccupiedVehicleSeat(ele)==0)then
				if(syncGetElementData(ele,"CopDuty")==false and getVehicleSirensOn(veh)==false)then
					if(getElementModel(veh)~=462)then
						if(veh:getVehicleType()=="Automobile" or veh:getVehicleType()=="Bike" or veh:getVehicleType()=="Quad" or veh:getVehicleType()=="Monster Truck")then
							local speed=getElementSpeed(veh)
							if((speed-3)>maxSpeed)then
								local effectCol=createColSphere(cX,cY,cZ,100)
								triggerClientEvent(ele,"radarEffect",ele,eX,eY,eZ,true)
								for _,v in pairs(getElementsByType("player"))do
									if(v~=ele)then
										triggerClientEvent(v,"radarEffect",v,eX,eY,eZ)
									end
								end
								effectCol:destroy()
								
								
								local over=math.ceil(speed)-maxSpeed
								local points=math.ceil(over/40)
								local price=math.ceil(over*20)
								
								local hasLicense=false
								if(veh:getVehicleType()=="Automobile" and tonumber(syncGetElementData(ele,"CarLicense"))==1)then
									hasLicense="CarLicense"
								elseif((veh:getVehicleType()=="Bike" or veh:getVehicleType()=="Quad")and tonumber(syncGetElementData(ele,"BikeLicense"))==1)then
									hasLicense="BikeLicense"
								--elseif((veh:getVehicleType()=="Monster Truck" or veh:getVehicleType()=="truck")and tonumber(syncGetElementData(ele,"LKWlicense"))==1)then
								--	hasLicense="LKWlicense"
								end
								
								local fix=""
								if(hasLicense~=false)then
									if(hasLicense=="CarLicense")then
										syncSetElementData(ele,"CarLicensePoints",tonumber(syncGetElementData(ele,"CarLicensePoints"))+points)
										if(tonumber(syncGetElementData(ele,"CarLicensePoints"))>=15)then
											outputChatBox("You have "..tonumber(syncGetElementData(ele,"CarLicensePoints")).." Car-license points, your driver's license has been withdrawn. You now have to repeat the driver's license exam at the driving school.",ele,200,0,0)
											syncSetElementData(ele,"CarLicensePoints",0)
											syncSetElementData(ele,hasLicense,0)
										end
										fix="Driving-license Points: "..points
									elseif(hasLicense=="BikeLicense")then
										syncSetElementData(ele,"BikeLicensePoints",tonumber(syncGetElementData(ele,"BikeLicensePoints"))+points)
										if(tonumber(syncGetElementData(ele,"BikeLicensePoints"))>=15)then
											outputChatBox("You have "..tonumber(syncGetElementData(ele,"BikeLicensePoints")).." Bike-license points, your driver's license has been withdrawn. You now have to repeat the driver's license exam at the driving school.",ele,200,0,0)
											syncSetElementData(ele,"BikeLicensePoints",0)
											syncSetElementData(ele,hasLicense,0)
										end
										fix="Driving-license Points: "..points
									end
								else
									fix="\nSince you do not have a driver's license, you will\nreceive a Wanted."
									syncSetElementData(ele,"Wanteds",tonumber(syncGetElementData(ele,"Wanteds"))+1)
								end
								if(tonumber(syncGetElementData(ele,"Wanteds"))>=6)then
									syncSetElementData(ele,"Wanteds",6)
								end
								--infoShow(ele, "info", "Du wurdest mit "..math.ceil(speed).." km/h bei erlaubten "..maxSpeed.." km/h geblitzt.\nGeldbuße: "..price.." "..settings.general.waehrung.."\n"..fix)
								triggerClientEvent(ele,"draw:infobox",root,"warning","You were flashed at "..math.ceil(speed).." km/h at a permitted "..maxSpeed.." km/h.\nFine: $"..price.."\n"..fix,20000)
								
								if(tonumber(syncGetElementData(ele,"Money"))>=price)then
									syncSetElementData(ele,"Money",tonumber(syncGetElementData(ele,"Money"))-price)
								else
									syncSetElementData(ele,"Bankmoney",tonumber(syncGetElementData(ele,"Bankmoney"))-price)
								end
							end
						end
					end
				end
			end
		end
	end)
end