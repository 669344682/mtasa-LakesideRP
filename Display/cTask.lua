--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onClientRender",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"intchange")==false)then
			if(getElementData(lp,"ElementClicked")==false)then
				--if(getElementData(lp,"introstate")==false)then
					if(not isPedDead(lp))then
						if(isPlayerMapVisible(lp)==false)then
							if(tonumber(syncClientGetElementData("Task"))>=0 and tonumber(syncClientGetElementData("Task"))<=#globalTables["Tasks"])then
								dxDrawRectangle(1625*Gsx,455*Gsy,280*Gsx,120*Gsy,tocolor(0,0,0,140),false)
								dxDrawRectangle(1645*Gsx,490*Gsy,240*Gsx,2*Gsy,tocolor(255,255,255,255),false)
								dxDrawText("Task:",3325*Gsx,460*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
								
								dxDrawText(globalTables["Tasks"][syncClientGetElementData("Task")],3325*Gsx,505*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
								dxDrawText(tonumber(syncClientGetElementData("Task")).."/"..#globalTables["Tasks"].."",3560*Gsx,550*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),0.95*Gsx,dxFONT2,"center",_,_,_,false,_,_)
							end
						end
					end
				--end
			end
		end
	end
end)