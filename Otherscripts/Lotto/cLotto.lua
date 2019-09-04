--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:lottoUI",true)
addEventHandler("open:lottoUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			if(not isElement(Lakeside.Window[1]))then
				setWindowData("add","cursor_clicked",false)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-395/2,GLOBALscreenY/2-280/2,395,280,settings.general.servername.." - Lotto",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(369,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,395,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-395/2,GLOBALscreenY/2-280/2,395,280,255,255,255,255,Lakeside.Window[1])
				
				dgsCreateLabel(10,10,100,20,"The lottery draw takes place daily at 02:00 PM. Jackpot: $"..Jackpot.."\n\nTicket price: $2.500",false,Lakeside.Window[1])
				dgsCreateLabel(5,120,100,20,"Type a number from 0-99 per field.",false,Lakeside.Window[1])
				
				Lakeside.Edit[1]=dgsCreateEdit(5,140,125,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Edit[2]=dgsCreateEdit(135,140,125,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Edit[3]=dgsCreateEdit(265,140,125,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				
				Lakeside.Button[2]=dgsCreateButton(5,210,385,40,"Buy a lotto ticket",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsEditSetMaxLength(Lakeside.Edit[1],2)
				dgsEditSetMaxLength(Lakeside.Edit[2],2)
				dgsEditSetMaxLength(Lakeside.Edit[3],2)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local number1=dgsGetText(Lakeside.Edit[1])
							local number2=dgsGetText(Lakeside.Edit[2])
							local number3=dgsGetText(Lakeside.Edit[3])
							if(number1~="" and isOnlyNumbers(number1)and number2~="" and isOnlyNumbers(number2)and number3~="" and isOnlyNumbers(number3))then
								triggerServerEvent("buy:lottoticket",lp,number1,number2,number3)
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