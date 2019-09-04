--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local weaponLicenseQuestions={
{"What would you do if a person starts fighting with you and you have a gun on you?","Call the cops","Tell him to stop","Point my gun at him",1},
{"What would you do if a cop asks you if you have a gun on you?","Show him my permit and ask him if i can take it out slowly and give it to him","Run from the cop","Point the gun at him",1},
{"When you see and officer in a shoutout what do you do?","Ask if he needs help","Call the police","Hide",3},
{"Where do you store your gun?","In a safe at my house","In the kitchen","Somewhere where everybody can see it",1},
}

local Count=0
local WrongAnswerCount=0
addEvent("open:weaponlicenseUI",true)
addEventHandler("open:weaponlicenseUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			if(not isElement(Lakeside.Window[1]))then
				Count=Count+1
				setWindowData("add","cursor_clicked",false)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-280/2,600,280,"Gunlicense - questionnaire",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,600,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-600/2,GLOBALscreenY/2-280/2,600,280,255,255,255,255,Lakeside.Window[1])
				
				dgsCreateLabel(245,20,100,20,weaponLicenseQuestions[Count][1],false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				
				
				Lakeside.Radio[1]=dgsCreateRadioButton(60,100,11,11,"",false,Lakeside.Window[1])
				dgsCreateLabel(80,100,100,20,weaponLicenseQuestions[Count][2],false,Lakeside.Window[1])
				Lakeside.Radio[2]=dgsCreateRadioButton(60,120,11,11,"",false,Lakeside.Window[1])
				dgsCreateLabel(80,120,100,20,weaponLicenseQuestions[Count][3],false,Lakeside.Window[1])
				Lakeside.Radio[3]=dgsCreateRadioButton(60,140,11,11,"",false,Lakeside.Window[1])
				dgsCreateLabel(80,140,100,20,weaponLicenseQuestions[Count][4],false,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,210,590,40,"-->",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							if(not(dgsRadioButtonGetSelected(Lakeside.Radio[weaponLicenseQuestions[Count][5]])==true))then
								WrongAnswerCount=WrongAnswerCount+1
							end
							
							if(Count<#weaponLicenseQuestions)then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",false)
								triggerEvent("open:weaponlicenseUI",lp)
							else
								if(WrongAnswerCount<=1)then
									triggerServerEvent("give:weaponlicense",lp)
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",false)
								else
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",false)
									Count=0
									WrongAnswerCount=0
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