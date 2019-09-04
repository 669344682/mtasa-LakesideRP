--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function openRegisterLoginGUI_Func()
	triggerServerEvent("check:account",lp)
end
addEvent("cdn:onClientReady",true)
addEventHandler("cdn:onClientReady",resourceRoot,openRegisterLoginGUI_Func)

function RegisterLoginGUI(typ)
	if(not isElement(Lakeside.Window[1]))then
		if(typ=="Login")then
			setCameraMatrix(1468.9,-919.3,100.2,1468.4,-918.4,99.9)
			dgsSetInputMode("no_binds")
			dgsSetInputMode("no_binds_when_editing")
			fadeCamera(true)
			showChat(false)
			setElementDimension(lp,0)
			setElementInterior(lp,0)
			
			setWindowData("add","cursor_clicked",false)
			Lakeside.Image[22]=dgsCreateImage(GLOBALscreenX/2-585/2+120,0,350,180,":"..settings.general.scriptname.."/Files/Images/Banner.png",false)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-585/2,0,585,375,settings.general.servername.." - Login",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsMoveTo(Lakeside.Window[1],GLOBALscreenX/2-585/2,GLOBALscreenY/2-375/2,false,false,"OutBounce",1500)
			dgsMoveTo(Lakeside.Image[22],GLOBALscreenX/2-585/2+120,GLOBALscreenY/2-375/2-200,false,false,"OutBounce",1500)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			dgsCreateImage(0,0,585,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-585/2,GLOBALscreenY/2-375/2,585,375,255,255,255,255,Lakeside.Window[1])
			
			dgsCreateImage(515,7,65,65,":"..settings.general.scriptname.."/Files/Images/Logo.png",false,Lakeside.Window[1])
			
			dgsCreateLabel(10,65,100,20,"Your RP name: (Example: Firstname_Lastname)",false,Lakeside.Window[1])
			Lakeside.Edit[1]=dgsCreateEdit(5,80,180,45,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			dgsCreateLabel(10,150,100,20,"Your password:",false,Lakeside.Window[1])
			Lakeside.Edit[2]=dgsCreateEdit(5,165,180,45,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			Lakeside.Button[2]=dgsCreateButton(360,80,200,40,"Show changelogs",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[1]=dgsCreateButton(5,300,575,45,"Login into your RP account",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			triggerServerEvent("check:autologin",lp)
			
			dgsEditSetMasked(Lakeside.Edit[2],true)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						if(not isElement(Lakeside.Window[33]))then
							triggerServerEvent("get:changelogs",lp)
						else
							if(isElement(Lakeside.Window[33]))then
								dgsCloseWindow(Lakeside.Window[33])
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local username=dgsGetText(Lakeside.Edit[1])or ""
						local password=dgsGetText(Lakeside.Edit[2])or ""
						
						triggerServerEvent("account:login",lp,username,password)
					end
				end,
			false)
			
		elseif(typ=="Register")then
			setCameraMatrix(1468.9,-919.3,100.2,1468.4,-918.4,99.9)
			dgsSetInputMode("no_binds")
			dgsSetInputMode("no_binds_when_editing")
			fadeCamera(true)
			showChat(false)
			setElementDimension(lp,0)
			setElementInterior(lp,0)
			
			setWindowData("add","cursor_clicked",false)
			Lakeside.Image[22]=dgsCreateImage(GLOBALscreenX/2-585/2+120,0,350,180,":"..settings.general.scriptname.."/Files/Images/Banner.png",false)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-585/2,0,585,460,settings.general.servername.." - Account creation",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsMoveTo(Lakeside.Window[1],GLOBALscreenX/2-585/2,GLOBALscreenY/2-460/2,false,false,"OutBounce",1500)
			dgsMoveTo(Lakeside.Image[22],GLOBALscreenX/2-585/2+120,GLOBALscreenY/2-460/2-200,false,false,"OutBounce",1500)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			dgsCreateImage(0,0,585,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-585/2,GLOBALscreenY/2-460/2,585,460,255,255,255,255,Lakeside.Window[1])
			
			dgsCreateImage(515,5,65,65,":"..settings.general.scriptname.."/Files/Images/Logo.png",false,Lakeside.Window[1])
			dgsCreateLabel(5,5,100,20,"Welcome to "..settings.general.servername..". "..settings.general.servername.." is a Selfmade Reallife/Roleplay server in English.\nThe Definition from Reallife is the Script wise. The Definition from Roleplay is the Gameplay.\n\nWARNING: You can create only 1 caracter.",false,Lakeside.Window[1])
			
			dgsCreateLabel(10,85,100,20,"Firstname: (Example: Max)",false,Lakeside.Window[1])
			Lakeside.Edit[1]=dgsCreateEdit(5,100,180,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			dgsCreateLabel(10,150,100,20,"Lastname: (Example: Mustermann)",false,Lakeside.Window[1])
			Lakeside.Edit[2]=dgsCreateEdit(5,165,180,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			dgsCreateLabel(255,210,100,20,"E-mail: (Example: test@gmail.com)",false,Lakeside.Window[1])
			Lakeside.Edit[3]=dgsCreateEdit(250,225,180,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			dgsCreateLabel(255,85,100,20,"Password:",false,Lakeside.Window[1])
			Lakeside.Edit[4]=dgsCreateEdit(250,100,180,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			dgsCreateLabel(255,150,100,20,"Retype password:",false,Lakeside.Window[1])
			Lakeside.Edit[5]=dgsCreateEdit(250,165,180,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			dgsCreateLabel(10,210,100,20,"Choose a gender",false,Lakeside.Window[1])
			Lakeside.Radio[1]=dgsCreateRadioButton(15,235,11,11,"Male",false,Lakeside.Window[1])
			Lakeside.Radio[2]=dgsCreateRadioButton(15,255,11,11,"Female",false,Lakeside.Window[1])
			
			dgsCreateLabel(10,285,100,20,"Enter a RP date of birth",false,Lakeside.Window[1])
			dgsCreateLabel(10,310,100,20,"Day",false,Lakeside.Window[1])
			Lakeside.Edit[6]=dgsCreateEdit(5,330,50,30,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			dgsCreateLabel(70,310,100,20,"Month",false,Lakeside.Window[1])
			Lakeside.Edit[7]=dgsCreateEdit(65,330,50,30,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			dgsCreateLabel(130,310,100,20,"Year",false,Lakeside.Window[1])
			Lakeside.Edit[8]=dgsCreateEdit(125,330,50,30,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
			
			Lakeside.Button[1]=dgsCreateButton(5,385,575,45,"Create your RP account",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			--Lakeside.Image[1]=dgsCreateImage(30,170,40,40,":"..settings.general.scriptname.."/Files/Images/Hide.png",false,Lakeside.Window[1])
			
			dgsEditSetMasked(Lakeside.Edit[4],true)
			dgsEditSetMasked(Lakeside.Edit[5],true)
			dgsRadioButtonSetSelected(Lakeside.Radio[1],true)
			dgsEditSetMaxLength(Lakeside.Edit[6],2)
			dgsEditSetMaxLength(Lakeside.Edit[7],2)
			dgsEditSetMaxLength(Lakeside.Edit[8],4)
			
			--[[addEventHandler("onDgsMouseClick",Lakeside.Image[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						if(dgsEditGetMasked(Lakeside.Edit[3])==true)then
							dgsEditSetMasked(Lakeside.Edit[3],false)
							dgsEditSetMasked(Lakeside.Edit[4],false)
							dgsImageSetImage(Lakeside.Image[1],":"..settings.general.scriptname.."/Files/Images/View.png")
						else
							dgsEditSetMasked(Lakeside.Edit[3],true)
							dgsEditSetMasked(Lakeside.Edit[4],true)
							dgsImageSetImage(Lakeside.Image[1],":"..settings.general.scriptname.."/Files/Images/Hide.png")
						end
					end
				end,
			false)]]
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local firstname=dgsGetText(Lakeside.Edit[1])or ""
						local lastname=dgsGetText(Lakeside.Edit[2])or ""
						local email=dgsGetText(Lakeside.Edit[3])or ""
						local password=dgsGetText(Lakeside.Edit[4])or ""
						local password2=dgsGetText(Lakeside.Edit[5])or ""
						
						local bday=tonumber(dgsGetText(Lakeside.Edit[6]))or 0
						local bmonth=tonumber(dgsGetText(Lakeside.Edit[7]))or 0
						local byear=tonumber(dgsGetText(Lakeside.Edit[8]))or 0
						
						local birth_correct=0
						if(math.floor(bday)==bday and math.floor(bmonth)==bmonth and byear==math.floor(byear))then
							if(bday<32 and bday>0 and byear<2009 and byear>1900 and bmonth<13 and bmonth>0)then
								if(bday<29)then
									birth_correct=1
								elseif((bday==29 or bday==30)and bmonth~=2)then
									birth_correct=1
								elseif(bday==31 and(bmonth==1 or bmonth==3 or bmonth==5 or bmonth==7 or bmonth==8 or bmonth==10 or bmonth==12))then
									birth_correct=1
								elseif(bday==29 and bmonth==2 and math.floor((byear/4))==byear/4)then
									birth_correct=1
								end
							else
								birth_correct=0
							end
						else
							birth_correct=0
						end
						
						if(dgsRadioButtonGetSelected(Lakeside.Radio[1])==true)then
							gender="Male"
						elseif(dgsRadioButtonGetSelected(Lakeside.Radio[2])==true)then
							gender="Female"
						end
						
						if(birth_correct==1)then
							if(firstname:len()>=4 and lastname:len()>=4 and firstname:len()<=15 and lastname:len()<=15)then
								if(string.match(email,"^[%w+%.%-_]+@[%w+%.%-_]+%.%a%a+$")==email and email:len()>=7)then
									if(password:len()>=4)then
										if(password==password2)then
											triggerServerEvent("account:register",lp,firstname,lastname,password,email,gender,bmonth,bday,byear)
										end
									end
								else
									triggerEvent("draw:infobox",lp,"error","Enter a valid E-mail!",10000)
								end
							else
								triggerEvent("draw:infobox",lp,"error","Enter a RP name!",10000)
							end
						else
							triggerEvent("draw:infobox",lp,"error","Invalid birth date!",10000)
						end
					end
				end,
			false)
			
		end
	end
end
addEvent("open:registerlogin",true)
addEventHandler("open:registerlogin",root,RegisterLoginGUI)

addEvent("destroy:login",true)
addEventHandler("destroy:login",root,function()
	if(isElement(Lakeside.Window[33]))then
		dgsCloseWindow(Lakeside.Window[33])
	end
	if(isElement(Lakeside.Window[1]))then
		setTimer(function()
			if(isElement(Lakeside.Image[22]))then
				dgsMoveTo(Lakeside.Image[22],GLOBALscreenX/2-585/2+120,-1000,false,false,"OutBounce",3500)
			end
			dgsMoveTo(Lakeside.Window[1],GLOBALscreenX/2-585/2,-1000,false,false,"OutBounce",3500)
			setWindowData("remove","cursor_clicked",false)
		end,1000,1)
		setTimer(function()
			dgsCloseWindow(Lakeside.Window[1])
			showChat(true)
			if(isElement(Lakeside.Image[22]))then
				Lakeside.Image[22]:destroy()
			end
		end,2400,1)
	end
end)


addEvent("show:changelogs",true)
addEventHandler("show:changelogs",root,function(tbl)
	Lakeside.Window[33]=dgsCreateWindow(20,GLOBALscreenY/2-300/2,400,300,settings.general.servername.." - Updates/Changelogs",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
	dgsWindowSetSizable(Lakeside.Window[33],false)
	dgsWindowSetMovable(Lakeside.Window[33],true)
	dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[33],settings.general.guilinecolor)
	
	Lakeside.Gridlist[1]=dgsCreateGridList(5,5,390,265,false,Lakeside.Window[33],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	local version=dgsGridListAddColumn(Lakeside.Gridlist[1],"Version",0.18)
	local change=dgsGridListAddColumn(Lakeside.Gridlist[1],"Change/Update",1.65)
	
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(Lakeside.Gridlist[1])
		dgsGridListSetItemText(Lakeside.Gridlist[1],row,version,v[1],false,false)
		dgsGridListSetItemText(Lakeside.Gridlist[1],row,change,v[2],false,false)
	end
	
	dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
end)