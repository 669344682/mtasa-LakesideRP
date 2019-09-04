--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:factiondepot",true)
addEventHandler("open:factiondepot",root,function(Money,Weed)
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-250/2,GLOBALscreenY/2-380/2,250,380,settings.general.servername.." - Faction Depot",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(224,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,250,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-250/2,GLOBALscreenY/2-380/2,250,380,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Label[1]=dgsCreateLabel(25,20,200,60,"Money: "..Money.."\nWeed: "..Weed,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				
				Lakeside.Radio[1]=dgsCreateRadioButton(90,110,11,11,"Money",false,Lakeside.Window[1])
				Lakeside.Radio[2]=dgsCreateRadioButton(90,130,11,11,"Weed",false,Lakeside.Window[1])
				
				dgsCreateLabel(7,190,100,20,"Amount",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(5,205,240,45,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[2]=dgsCreateButton(5,255,240,45,"pay in",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(5,305,240,45,"pay out  [R4]",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				if(getElementData(lp,"Factionrank")>=4)then
					dgsSetEnabled(Lakeside.Button[3],true)
				else
					dgsSetEnabled(Lakeside.Button[3],false)
				end
				
				
				dgsRadioButtonSetSelected(Lakeside.Radio[1],true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Edit[1])
							
							if(amount~="" and isOnlyNumbers(amount))then
								if(dgsRadioButtonGetSelected(Lakeside.Radio[1]))then
									triggerServerEvent("payin_payout:factionitems",lp,"payout","Money",amount)
								elseif(dgsRadioButtonGetSelected(Lakeside.Radio[2]))then
									triggerServerEvent("payin_payout:factionitems",lp,"payout","Weed",amount)
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Edit[1])
							
							if(amount~="" and isOnlyNumbers(amount))then
								if(dgsRadioButtonGetSelected(Lakeside.Radio[1]))then
									triggerServerEvent("payin_payout:factionitems",lp,"payin","Money",amount)
								elseif(dgsRadioButtonGetSelected(Lakeside.Radio[2]))then
									triggerServerEvent("payin_payout:factionitems",lp,"payin","Weed",amount)
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
end)

addEvent("refresh:factiondepot",true)
addEventHandler("refresh:factiondepot",root,function(Money,Weed)
	if(isElement(Lakeside.Window[1]))then
		dgsSetText(Lakeside.Label[1],"Money: "..Money.."\nWeed: "..Weed)
	end
end)