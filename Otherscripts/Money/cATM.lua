--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onClientResourceStart",root,function()
	for _,v in pairs(getElementsByType("object"))do
		if(getElementModel(v)==2942)then
			local x,y,z=getElementPosition(v)
			ATMmarker=createMarker(x,y,z,"corona",1,0,0,0,0)
			
			addEventHandler("onClientMarkerHit",ATMmarker,function(player,dim)
				if(player==lp and dim)then
					if(tonumber(syncClientGetElementData("Bankpin"))~=0)then
						openATMpinUI(lp)
					else
						triggerEvent("draw:infobox",lp,"error","You do not have a bank account!",8000)
					end
				end
			end)
			
		end
	end
end)

function openATMpinUI()
	if(isLoggedin(lp))then
		if(not isPedInVehicle(lp))then
			if(not isElement(Lakeside.Window[1]))then
				local x,y,z=getElementPosition(lp)
				local location=getZoneName(x,y,z,true)
				
				setWindowData("add","cursor_clicked",true)
				guiSetInputMode("no_binds")
				guiSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-340/2,GLOBALscreenY/2-280/2,340,280,settings.general.servername.." - ATM - "..location,false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(314,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,340,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-340/2,GLOBALscreenY/2-280/2,340,280,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Image[1]=dgsCreateImage(5,5,330,130,":"..settings.general.scriptname.."/Files/Images/UI/TownhallBG.png",false,Lakeside.Window[1])
				
				dgsCreateLabel(6,140,100,10,"Enter your bank-account pin:",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(5,155,330,45,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[2]=dgsCreateButton(5,205,330,45,"enter to your bank-account",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local pin=dgsGetText(Lakeside.Edit[1])
							if(pin~="" and isOnlyNumbers(pin))then
								if(tonumber(syncClientGetElementData("Bankpin"))==tonumber(pin)and tonumber(pin)~=0)then
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",false)
									openAtmUI_Func()
								else
									triggerEvent("draw:infobox",lp,"error","The entered pin is not correct!",8000)
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

function openAtmUI_Func()
	if(isLoggedin(lp))then
		if(not isPedInVehicle(lp))then
			if(not isElement(Lakeside.Window[1]))then
				local x,y,z=getElementPosition(lp)
				local location=getZoneName(x,y,z,true)
				
				setWindowData("add","cursor_clicked",false)
				guiSetInputMode("no_binds")
				guiSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-350/2,GLOBALscreenY/2-320/2,350,320,"ATM - "..location,false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(324,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,350,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-350/2,GLOBALscreenY/2-320/2,350,320,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,325,270,false,Lakeside.Window[1])
				Lakeside.Tab[1]=dgsCreateTab("deposit",Lakeside.Tabpanel[1])
				Lakeside.Label[1]=dgsCreateLabel(60,5,200,20,"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")),false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
				Lakeside.Edit[1]=dgsCreateEdit(5,150,315,45,"",false,Lakeside.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[2]=dgsCreateButton(5,200,315,45,"pay in",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Tab[2]=dgsCreateTab("withdraw",Lakeside.Tabpanel[1])
				Lakeside.Label[2]=dgsCreateLabel(60,5,200,20,"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")),false,Lakeside.Tab[2],_,_,_,_,_,_,"center",_)
				Lakeside.Edit[2]=dgsCreateEdit(5,150,315,45,"",false,Lakeside.Tab[2],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[3]=dgsCreateButton(5,200,315,45,"pay out",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local money=dgsGetText(Lakeside.Edit[2])
							if(money~="" and isOnlyNumbers(money))then
								triggerServerEvent("transfer:money",lp,money,"pay:outATM")
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local money=dgsGetText(Lakeside.Edit[1])
							if(money~="" and isOnlyNumbers(money))then
								triggerServerEvent("transfer:money",lp,money,"pay:inATM")
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

addEvent("refresh:atm",true)
addEventHandler("refresh:atm",root,function()
	dgsSetText(Lakeside.Label[1],"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")))
	dgsSetText(Lakeside.Label[2],"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")))
end)