--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local state=false

function openHandy()
	if(isLoggedin())then
		if(not isElement(Lakeside.Window[1]))then
			if(syncClientGetElementData("Mobilephone")==1)then
				if(not isTimer(TimerOnOFF))then
					if(isElement(Lakeside.Window[10]))then
						Lakeside.Window[10]:destroy()
					end
					if(isElement(Lakeside.Window[11]))then
						Lakeside.Window[11]:destroy()
					end
					if(isElement(Lakeside.Window[12]))then
						Lakeside.Window[12]:destroy()
					end
					if(isElement(Lakeside.Window[13]))then
						Lakeside.Window[13]:destroy()
					end
					if(isElement(Lakeside.Window[14]))then
						Lakeside.Window[14]:destroy()
					end
					if(state==false)then
						state=true
						setWindowData("add","cursor_clicked",false)
						if(isElement(Lakeside.Window[10]))then
							Lakeside.Window[10]:destroy()
						end
						if(syncClientGetElementData("PhoneState")==1)then
							Lakeside.Window[10]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
							Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[10])
							guiMoveToBack(Lakeside.Image[1])
							Lakeside.Button[1]=guiCreateStaticImage(25,65,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Call.png",false,Lakeside.Window[10])
							Lakeside.Label[1]=guiCreateLabel(42,120,100,15,"Call",false,Lakeside.Window[10])
							Lakeside.Button[2]=guiCreateStaticImage(95,65,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Settings.png",false,Lakeside.Window[10])
							Lakeside.Label[2]=guiCreateLabel(100,120,100,15,"Settings",false,Lakeside.Window[10])
							Lakeside.Button[3]=guiCreateStaticImage(170,65,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Youtube.png",false,Lakeside.Window[10])
							Lakeside.Label[3]=guiCreateLabel(172,120,100,15,"Youtube",false,Lakeside.Window[10])
							--[[Lakeside.Button[4]=guiCreateStaticImage(25,150,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Notes.png",false,Lakeside.Window[10])
							Lakeside.Label[4]=guiCreateLabel(36,200,100,15,"Notes",false,Lakeside.Window[10])]]
							
							Timer1=setTimer(function()
								if(getElementData(lp,"call")==true)then
									if(isElement(Lakeside.Window[10]))then
										Lakeside.Button[6]=guiCreateStaticImage(175,345,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/CallDenied.png",false,Lakeside.Window[10])
										
										addEventHandler("onClientGUIClick",Lakeside.Button[6],
											function()
												triggerServerEvent("call:denied",lp,lp)
											end,
										false)
									end
								else
									if(isElement(Lakeside.Window[10]))then
										if(isElement(Lakeside.Button[6]))then
											Lakeside.Button[6]:destroy()
										end
									end
								end
							end,1000,0)
							
							
							addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
								function()
									guiMoveToBack(Lakeside.Image[1])
								end,
							false)
							
							--[[addEventHandler("onClientGUIClick",Lakeside.Button[4],
								function()
									openNotesFunction()
								end,
							false)]]
							addEventHandler("onClientGUIClick",Lakeside.Button[3],
								function()
									openYoutubeFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[2],
								function()
									openSettingsFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[1],
								function()
									openCallFunction()
								end,
							false)
						elseif(syncClientGetElementData("PhoneState")==0)then
							Lakeside.Window[10]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
							Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/PhoneOFF.png",false,Lakeside.Window[10])
						end
						
						
						
						Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[10])
						guiSetAlpha(Lakeside.Button[20],0)
						
						
						addEventHandler("onClientGUIClick",Lakeside.Button[20],
							function()
								if(Lakeside.Button[20])then
									if(syncClientGetElementData("PhoneState")==1)then
										syncClientSetElementData("PhoneState",0)
										--triggerEvent("draw:infobox",lp,"info","Changed Mobilephone state to off!",8000)
										if(isElement(Lakeside.Button[1]))then
											Lakeside.Button[1]:destroy()
										end
										if(isElement(Lakeside.Button[2]))then
											Lakeside.Button[2]:destroy()
										end
										if(isElement(Lakeside.Button[3]))then
											Lakeside.Button[3]:destroy()
										end
										if(isElement(Lakeside.Label[1]))then
											Lakeside.Label[1]:destroy()
										end
										if(isElement(Lakeside.Label[2]))then
											Lakeside.Label[2]:destroy()
										end
										if(isElement(Lakeside.Label[3]))then
											Lakeside.Label[3]:destroy()
										end
										if(isElement(Lakeside.Image[1]))then
											Lakeside.Image[1]:destroy()
										end
										Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/PhoneOFF.png",false,Lakeside.Window[10])
										guiMoveToBack(Lakeside.Image[1])
									else
										--triggerEvent("draw:infobox",lp,"info","Changed Mobilephone state to on!",8000)
										if(isElement(Lakeside.Image[1]))then
											Lakeside.Image[1]:destroy()
										end
										Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[10])
										guiMoveToBack(Lakeside.Image[1])
										Lakeside.Label[20]=guiCreateLabel(90,120,100,15,"Booting...",false,Lakeside.Image[1])
										Lakeside.Image[2]=guiCreateStaticImage(75,180,80,80,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Boot.png",false,Lakeside.Image[1])
										if(isTimer(TimerOnOFF))then
											TimerOnOFF:destroy()
										end
										TimerOnOFF=setTimer(function()
											if(isElement(Lakeside.Label[20]))then
												Lakeside.Label[20]:destroy()
											end
											if(isElement(Lakeside.Image[2]))then
												Lakeside.Image[2]:destroy()
											end
											if(isTimer(TimerOnOFF))then
												TimerOnOFF:destroy()
											end
											syncClientSetElementData("PhoneState",1)
											state=false
											openHandy()
										end,4000,1)
									end
								end
							end,
						false)
					elseif(state==true)then
						state=false
						if(isElement(Lakeside.Window[10]))then
							Lakeside.Window[10]:destroy()
						end
						if(isTimer(TimerOnOFF))then
							TimerOnOFF:destroy()
						end
						setWindowData("remove","cursor_clicked",false)
						if(isTimer(Timer1))then
							Timer1:destroy()
						end
					end
				end
			end
		end
	end
end
bindKey("u","down",openHandy)

function openCallFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	Lakeside.Window[11]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[11])
	
	Lakeside.Edit[1]=guiCreateEdit(30,60,185,40,"",false,Lakeside.Window[11])
	guiEditSetReadOnly(Lakeside.Edit[1],true)
	
	Lakeside.Button[1]=guiCreateButton(30,105,45,45,"1",false,Lakeside.Window[11])
	Lakeside.Button[2]=guiCreateButton(100,105,45,45,"2",false,Lakeside.Window[11])
	Lakeside.Button[3]=guiCreateButton(170,105,45,45,"3",false,Lakeside.Window[11])
	Lakeside.Button[4]=guiCreateButton(30,165,45,45,"4",false,Lakeside.Window[11])
	Lakeside.Button[5]=guiCreateButton(100,165,45,45,"5",false,Lakeside.Window[11])
	Lakeside.Button[6]=guiCreateButton(170,165,45,45,"6",false,Lakeside.Window[11])
	Lakeside.Button[7]=guiCreateButton(30,225,45,45,"7",false,Lakeside.Window[11])
	Lakeside.Button[8]=guiCreateButton(100,225,45,45,"8",false,Lakeside.Window[11])
	Lakeside.Button[9]=guiCreateButton(170,225,45,45,"9",false,Lakeside.Window[11])
	Lakeside.Button[10]=guiCreateButton(30,285,45,45,"0",false,Lakeside.Window[11])
	Lakeside.Button[11]=guiCreateButton(100,285,115,45,"clear\nnumberfield",false,Lakeside.Window[11])
	Lakeside.Button[12]=guiCreateButton(30,345,185,25,"call player",false,Lakeside.Window[11])
	Lakeside.Button[13]=guiCreateButton(30,375,185,25,"copy your number",false,Lakeside.Window[11])
	
	
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[11])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	addEventHandler("onClientGUIClick",Lakeside.Button[13],
		function()
			if(Lakeside.Button[13])then
				if(syncClientGetElementData("Telenr")~=0)then
					setClipboard(syncClientGetElementData("Telenr"))
				end
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[12],
		function()
			if(guiGetText(Lakeside.Edit[1])~="" and isOnlyNumbers(guiGetText(Lakeside.Edit[1])))then
				triggerServerEvent("call:player",lp,guiGetText(Lakeside.Edit[1]))
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[11],
		function()
			if(Lakeside.Button[11])then
				guiSetText(Lakeside.Edit[1],"")
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[10],
		function()
			if(Lakeside.Button[10])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."0")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/0.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[9],
		function()
			if(Lakeside.Button[9])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."9")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/9.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[8],
		function()
			if(Lakeside.Button[8])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."8")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/8.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[7],
		function()
			if(Lakeside.Button[7])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."7")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/7.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[6],
		function()
			if(Lakeside.Button[6])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."6")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/6.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[5],
		function()
			if(Lakeside.Button[5])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."5")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/5.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[4],
		function()
			if(Lakeside.Button[4])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."4")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/4.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[3],
		function()
			if(Lakeside.Button[3])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."3")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/3.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[2],
		function()
			if(Lakeside.Button[2])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."2")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/2.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[1])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."1")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/1.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openSettingsFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	Lakeside.Window[12]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
	
	Lakeside.Tabpanel[1]=guiCreateTabPanel(20,65,210,275,false,Lakeside.Window[12])
	Lakeside.Tab[1]=guiCreateTab("Backgrounds",Lakeside.Tabpanel[1])
	
	Lakeside.Button[1]=guiCreateButton(5,5,95,45,"Background\nXperia Z3",false,Lakeside.Tab[1])
	Lakeside.Button[2]=guiCreateButton(110,5,95,45,"Background\nNexus",false,Lakeside.Tab[1])
	Lakeside.Button[3]=guiCreateButton(5,55,95,45,"Background\nOnePlus 3T",false,Lakeside.Tab[1])
	Lakeside.Button[4]=guiCreateButton(110,55,95,45,"Background\nXperia X",false,Lakeside.Tab[1])
	Lakeside.Button[5]=guiCreateButton(5,105,95,45,"Background\niOS 10",false,Lakeside.Tab[1])
	Lakeside.Button[6]=guiCreateButton(110,105,95,45,"Background\niOS 7",false,Lakeside.Tab[1])
	Lakeside.Button[7]=guiCreateButton(5,155,95,45,"Background\nGoogle Pixle",false,Lakeside.Tab[1])
	Lakeside.Button[8]=guiCreateButton(110,155,95,45,"Background\nGirl 1",false,Lakeside.Tab[1])
	Lakeside.Button[9]=guiCreateButton(5,205,95,45,"Background\nGirl 2",false,Lakeside.Tab[1])
	
	Lakeside.Tab[2]=guiCreateTab("more soon...",Lakeside.Tabpanel[1])
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[12])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Tabpanel[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[9],
		function()
			if(Lakeside.Button[9])then
				syncClientSetElementData("PhoneBackground",9)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[8],
		function()
			if(Lakeside.Button[8])then
				syncClientSetElementData("PhoneBackground",8)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[7],
		function()
			if(Lakeside.Button[7])then
				syncClientSetElementData("PhoneBackground",7)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[6],
		function()
			if(Lakeside.Button[6])then
				syncClientSetElementData("PhoneBackground",6)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[5],
		function()
			if(Lakeside.Button[5])then
				syncClientSetElementData("PhoneBackground",5)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[4],
		function()
			if(Lakeside.Button[4])then
				syncClientSetElementData("PhoneBackground",4)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[3],
		function()
			if(Lakeside.Button[3])then
				syncClientSetElementData("PhoneBackground",3)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[2],
		function()
			if(Lakeside.Button[2])then
				syncClientSetElementData("PhoneBackground",2)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[2])then
				syncClientSetElementData("PhoneBackground",1)
				triggerEvent("draw:infobox",lp,"success","You have changed the Background successfully!",8000)
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
				guiMoveToBack(Lakeside.Image[1])
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openYoutubeFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	Lakeside.Window[13]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,620,320,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Right.png",false)
	Lakeside.Image[1]=guiCreateStaticImage(63,15,490,289,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[13])
	
	Lakeside.Browser[1]=guiCreateBrowser(63,15,490,289,false,false,false,Lakeside.Window[13])
	theBrowserHandy=guiGetBrowser(Lakeside.Browser[1])
	
	Lakeside.Button[15]=guiCreateStaticImage(562,60,38,40,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/VolumeUp.png",false,Lakeside.Window[13])
	Lakeside.Button[16]=guiCreateStaticImage(562,225,38,40,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/VolumeDown.png",false,Lakeside.Window[13])
	
	Lakeside.Button[20]=guiCreateButton(562,130,38,40,"",false,Lakeside.Window[13])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	requestBrowserDomains({"youtube.com/tv"})
	addEventHandler("onClientBrowserCreated",theBrowserHandy, 
		function()
			loadBrowserURL(source,"https://youtube.com/tv")
			focusBrowser(source)
			--setBrowserProperty(theBrowserHandy,"mobile","1")
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[15],
		function()
			if(Lakeside.Button[15])then
				setBrowserVolume(theBrowserHandy,getBrowserVolume(theBrowserHandy)+2/100)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[16],
		function()
			if(Lakeside.Button[16])then
				setBrowserVolume(theBrowserHandy,getBrowserVolume(theBrowserHandy)-2/100)
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openNotesFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	Lakeside.Window[14]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[14])
	
	Lakeside.Memo[1]=guiCreateMemo(25,60,200,280,"",false,Lakeside.Window[14])
	loadHandyNotes()
	
	Lakeside.Button[1]=guiCreateButton(25,350,200,35,"save notes",false,Lakeside.Window[14])
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[14])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[20])then
				saveHandyNotes()
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end







function loadHandyNotes()
	local noteHandyList=xmlLoadFile(":"..settings.general.scriptname.."/handynotes.xml")
	if(not noteHandyList)then
		local noteHandyList=xmlCreateFile(":"..settings.general.scriptname.."/handynotes.xml","handynotes")
		local notesHandy=xmlCreateChild(noteHandyList,"noteHandyText")
		xmlNodeSetValue(notesHandy,"")
		xmlSaveFile(noteHandyList)
		guiSetText(Lakeside.Memo[1],notesHandy)
	else
		local notesHandy=xmlNodeGetChildren(noteHandyList,0)
		local notesHandy=xmlNodeGetValue(notesHandy)
		guiSetText(Lakeside.Memo[1],notesHandy)
	end
end
function saveHandyNotes()
	if(Lakeside.Memo[1])then
		local noteHandyText=guiGetText(Lakeside.Memo[1])
		local fileHandyNotes=xmlLoadFile(":"..settings.general.scriptname.."/handynotes.xml" )
		local node=xmlNodeGetChildren(fileHandyNotes,0)
		xmlNodeSetValue(node,noteHandyText)
		xmlSaveFile(fileHandyNotes)
	end
end