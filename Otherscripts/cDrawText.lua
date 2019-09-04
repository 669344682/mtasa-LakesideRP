--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onClientRender",root,function()
	if(isLoggedin())then
		if(not(isPedDead(lp)))then
			if(getKeyState("ralt")==true)then
				for _,v in pairs(getElementsByType("vehicle"))do
					if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
						--if(getElementData(v,"Owner")and getElementData(v,"Slot"))then
							local px,py,pz=getElementPosition(lp)
							local x,y,z=getElementPosition(v)
							if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=10)then
								local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
								if(sx and sy)then
								local model=getElementModel(v)
								local vid=getElementData(v,"ID")or "not found"
								local cplate=getElementData(v,"Plate")or "not found"
									if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
										dxDrawRectangle(sx-150,sy+10,300,100,tocolor(0,0,0,140),false)
										dxDrawRectangle(sx-150,sy+10,300,20,tocolor(0,0,0,200),false)
										dxDrawRectangle(sx-150,sy+30,300,2,settings.general.guilinecolor,false)
										dxDrawText("Model: "..getVehicleNameFromModel(model).." ("..model..")",sx+20,sy+100,sx,sy,tocolor(255,255,255,255),1.2,dxFONT2,"center","center")
										dxDrawText("ID: "..vid,sx+20,sy+135,sx,sy,tocolor(255,255,255,255),1.2,dxFONT2,"center","center")
										dxDrawText("Plate: "..cplate,sx+20,sy+170,sx,sy,tocolor(255,255,255,255),1.2,dxFONT2,"center","center")
									end
								end
							end
						--end
					end
				end
			end
			for _,v in pairs(getElementsByType("ped"))do
				if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
					if(getElementData(v,"set:pedtext"))then
						local px,py,pz=getPedBonePosition(v,8)
						local x,y,z=getPedBonePosition(lp,8)
						
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=8 and isLineOfSightClear(px,py,pz,x,y,z,true,false,false,true,false))then
							local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true)
							
							if(sx and sy)then
							local peddescription=getElementData(v,"set:peddescription")
							if(peddescription)then
								peddescription=getElementData(v,"set:peddescription")
							else
								peddescription="-"
							end
								if(isPlayerMapVisible(lp)==false)then
									dxDrawText(getElementData(v,"set:peddescription"),sx,sy-30,sx,sy,tocolor(255,255,255,255),1.0,"default","center","center")
									dxDrawText(getElementData(v,"set:pedtext"),sx,sy,sx,sy,tocolor(0,80,200,255),1.5,"default","center","center")
								end
							end
						end
					end
				end
			end
			for _,v in pairs(getElementsByType("object"))do
				if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
					local px,py,pz=getElementPosition(lp)
					local x,y,z=getElementPosition(v)
					if(getElementModel(v)==1257)then
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=10)then
							local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
							if(sx and sy)then
								if(isPlayerMapVisible(lp)==false)then
									dxDrawRectangle(sx-100,sy-40,200,100,tocolor(0,0,0,140),false)
									dxDrawRectangle(sx-100,sy-40,200,20,tocolor(0,0,0,200),false)
									dxDrawRectangle(sx-100,sy-20,200,2,settings.general.guilinecolor,false)
									dxDrawText("Bus stop",sx,sy-42,sx,sy,tocolor(255,255,255,255),1.2,dxFONT3,"center")
								end
							end
						end
					end
					if(getElementModel(v)==3409 and getElementData(v,"PlantID"))then
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=2)then
							local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
							if(sx and sy)then
								if(isPlayerMapVisible(lp)==false)then
									dxDrawRectangle(sx-100,sy-40,200,100,tocolor(0,0,0,140),false)
									dxDrawRectangle(sx-100,sy-40,200,20,tocolor(0,0,0,200),false)
									dxDrawRectangle(sx-100,sy-20,200,2,settings.general.guilinecolor,false)
									dxDrawText("Weed",sx,sy-42,sx,sy,tocolor(255,255,255,255),1.2,dxFONT3,"center")
									dxDrawText("ID: "..getElementData(v,"PlantID"),sx,sy-5,sx,sy,tocolor(255,255,255,255),1.0,dxFONT3,"center")
								end
							end
						end
					end
				end
			end
		end
	end
end)