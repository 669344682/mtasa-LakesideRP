--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local helpmenueText={
	["Welcome"]="Welcome to Lakeside.\nLakeside is a Reallife/Roleplay server in english.\n\nThe difinition from Reallife is the Script wise.\nThe difinition from Roleplay is the Gameplay.\n\n\n\nYou have suggestions? Then post it on our Discord.",
	["Binds/Commands"]="Binds:\n\n'M' - to show your cursor\n'I' - to open your Inventory or vehicle trunk\n'F' - to harvest a weed plant\n'T' - to write in the Local chat\n'B' - to write in the OOC chat\n',' - un/lock privat/faction-vehicles\n'.' - park your privat-vehicle\n'X'(hold) - start a vehicle\n'RALT'(hold) - to see vehicle-infos over a vehicle\n'Z' - to un/seatbelt\n'U' - to open your mobilephone(when you own it)\n'F3' - to open faction-panel\n'F4' - to open company-panel\n'F7' - to open the animation-panel\n'Numpad_1' - to turn on the left blinker\n'Numpad_2' - to turn on all blinker\n'Numpad_3' - to turn on the right blinker\n\nCommands:\n'/park' - park your privat-vehicle\n'/mee' - to write in the ME chat\n'/mv' or '/gate' - to open a faction-gate\n'/fpark' - to park a faction-vehicle\n'/urine' - to empty your bladder\n'/settings' - to open the settings-panel",
	["Dates"]="Our Discord: "..settings.general.discordurl.."",
}
local standartHelpmenuTXT="Helpmenu from Lakeside"

local function deleteAllUIItems()
	if(isElement(Lakeside.Button[2]))then
		Lakeside.Button[2]:destroy()
	end
	if(isElement(Lakeside.Button[3]))then
		Lakeside.Button[3]:destroy()
	end
	if(isElement(Lakeside.Button[4]))then
		Lakeside.Button[4]:destroy()
	end
end

bindKey("f1","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				triggerServerEvent("set:task",lp,lp,"OpenHelpmenue")
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-460/2,600,460,settings.general.servername.." - Helppanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,600,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-600/2,GLOBALscreenY/2-460/2,600,460,255,255,255,255,Lakeside.Window[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(5,7,205,422,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				local category=dgsGridListAddColumn(Lakeside.Gridlist[1],"category",0.9)
				local grid1=dgsGridListAddRow(Lakeside.Gridlist[1],"Welcome")
				local grid2=dgsGridListAddRow(Lakeside.Gridlist[1],"Binds/Commands")
				local grid3=dgsGridListAddRow(Lakeside.Gridlist[1],"Dates")
				
				Lakeside.Label[1]=dgsCreateLabel(220,15,160,200,standartHelpmenuTXT,false,Lakeside.Window[1])
				
				
				dgsGridListSetItemText(Lakeside.Gridlist[1],grid1,category,"Welcome")
				dgsGridListSetItemText(Lakeside.Gridlist[1],grid2,category,"Binds/Commands")
				dgsGridListSetItemText(Lakeside.Gridlist[1],grid3,category,"Dates")
				
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(helpmenueText[clicked])then
									dgsSetText(Lakeside.Label[1],helpmenueText[clicked])
									if(item==grid3)then
										deleteAllUIItems()
										Lakeside.Button[2]=dgsCreateButton(490,10,100,20,"Copy Discord URL",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
										addEventHandler("onDgsMouseClick",Lakeside.Button[2],
											function(btn,state)
												if(btn=="left" and state=="up")then
													setClipboard(settings.general.discordurl)
													notificationShow("info","Copied!")
												end
											end,
										false)
									else
										deleteAllUIItems()
									end
								end
							else
								dgsSetText(Lakeside.Label[1],standartHelpmenuTXT)
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