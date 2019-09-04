--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("draw:fishingbar",true)
addEventHandler("draw:fishingbar",root,function(typ)
	removeEventHandler("onClientRender",root,drawFishingDisplay)
	if(typ=="create")then
		fishingPoints=15
		bindKey("space","down",fishingSpaceFunction)
		fishingPointsTimer=setTimer(function()
			fishingPoints=fishingPoints-1
			if(fishingPoints==0)then
				if(isTimer(fishingPointsTimer))then
					fishingPointsTimer:destroy()
				end
				unbindKey("space","down",fishingSpaceFunction)
				removeEventHandler("onClientRender",root,drawFishingDisplay)
			end
		end,250,0)
		addEventHandler("onClientRender",root,drawFishingDisplay)
	else
		removeEventHandler("onClientRender",root,drawFishingDisplay)
	end
end)

function fishingSpaceFunction()
	fishingPoints=fishingPoints+2
	if(fishingPoints>=100)then
		fishingPointsTimer:destroy()
		unbindKey("space","down",fishingSpaceFunction)
		removeEventHandler("onClientRender",root,drawFishingDisplay)
		triggerServerEvent("get:fishingloot",lp)
	end
end

function drawFishingDisplay()
	if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
		local x,y,z=getElementPosition(lp)
		local sx,sy=getScreenFromWorldPosition(x,y,z,1000,true)
		dxDrawRectangle(sx-70,sy-155,137,16,tocolor(0,0,0,255),false)
		dxDrawRectangle(sx-70,sy-155,(1.37*fishingPoints),16,tocolor(0,255,0,255),false)
	end
end




addEvent("open:fishingUI",true)
addEventHandler("open:fishingUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			local FishingrodCount=0
			local FishinghookCount=0
			local TroutCount=0
			local BaitsCount=0
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Fishing",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,380,215,false,Lakeside.Window[1])
			Lakeside.Tab[1]=dgsCreateTab("Fishingrod",Lakeside.Tabpanel[1])
			
			Lakeside.Button[2]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[5]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Fishingrod.png",false,Lakeside.Tab[1])
			Lakeside.Label[1]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[6]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Tab[2]=dgsCreateTab("Fishinghook",Lakeside.Tabpanel[1])
			
			Lakeside.Button[10]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[11]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[12]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[13]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Fishinghook.png",false,Lakeside.Tab[2])
			Lakeside.Label[2]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[2],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[14]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Tab[3]=dgsCreateTab("Bait",Lakeside.Tabpanel[1])
			
			Lakeside.Button[16]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[17]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[18]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[19]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Bait.png",false,Lakeside.Tab[3])
			Lakeside.Label[3]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[3],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[20]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Tab[4]=dgsCreateTab("Trout",Lakeside.Tabpanel[1])
			
			Lakeside.Button[21]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[22]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[23]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[24]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Trout.png",false,Lakeside.Tab[4])
			Lakeside.Label[4]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[4],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[25]=dgsCreateButton(5,150,370,40,"Sell x0 $0",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[25],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[4])
						triggerServerEvent("sell:fishingitems",lp,"Trout",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[24],
				function(btn,state)
					if(btn=="left" and state=="down")then
						TroutCount=TroutCount+2
						if(TroutCount>=20)then
							TroutCount=20
						end
						dgsSetText(Lakeside.Label[4],TroutCount)
						dgsSetText(Lakeside.Button[25],"Sell x"..TroutCount.." $"..TroutCount*settings.shop.troutPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[23],
				function(btn,state)
					if(btn=="left" and state=="down")then
						TroutCount=TroutCount-2
						if(TroutCount<=0)then
							TroutCount=0
						end
						dgsSetText(Lakeside.Label[4],TroutCount)
						dgsSetText(Lakeside.Button[25],"Sell x"..TroutCount.." $"..TroutCount*settings.shop.troutPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[22],
				function(btn,state)
					if(btn=="left" and state=="down")then
						TroutCount=TroutCount+1
						if(TroutCount>=20)then
							TroutCount=20
						end
						dgsSetText(Lakeside.Label[4],TroutCount)
						dgsSetText(Lakeside.Button[25],"Sell x"..TroutCount.." $"..TroutCount*settings.shop.troutPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[21],
				function(btn,state)
					if(btn=="left" and state=="down")then
						TroutCount=TroutCount-1
						if(TroutCount<=0)then
							TroutCount=0
						end
						dgsSetText(Lakeside.Label[4],TroutCount)
						dgsSetText(Lakeside.Button[25],"Sell x"..TroutCount.." $"..TroutCount*settings.shop.troutPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[20],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[3])
						triggerServerEvent("buy:fishingitems",lp,"Baits",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[19],
				function(btn,state)
					if(btn=="left" and state=="down")then
						BaitsCount=BaitsCount+2
						if(BaitsCount>=20)then
							BaitsCount=20
						end
						dgsSetText(Lakeside.Label[3],BaitsCount)
						dgsSetText(Lakeside.Button[20],"Buy x"..BaitsCount.." $"..BaitsCount*settings.shop.baitsPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[18],
				function(btn,state)
					if(btn=="left" and state=="down")then
						BaitsCount=BaitsCount-2
						if(BaitsCount<=0)then
							BaitsCount=0
						end
						dgsSetText(Lakeside.Label[3],BaitsCount)
						dgsSetText(Lakeside.Button[20],"Buy x"..BaitsCount.." $"..BaitsCount*settings.shop.baitsPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[17],
				function(btn,state)
					if(btn=="left" and state=="down")then
						BaitsCount=BaitsCount+1
						if(BaitsCount>=20)then
							BaitsCount=20
						end
						dgsSetText(Lakeside.Label[3],BaitsCount)
						dgsSetText(Lakeside.Button[20],"Buy x"..BaitsCount.." $"..BaitsCount*settings.shop.baitsPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[16],
				function(btn,state)
					if(btn=="left" and state=="down")then
						BaitsCount=BaitsCount-1
						if(BaitsCount<=0)then
							BaitsCount=0
						end
						dgsSetText(Lakeside.Label[3],BaitsCount)
						dgsSetText(Lakeside.Button[20],"Buy x"..BaitsCount.." $"..BaitsCount*settings.shop.baitsPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[14],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[2])
						triggerServerEvent("buy:fishingitems",lp,"Fishinghook",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[13],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishinghookCount=FishinghookCount+2
						if(FishinghookCount>=20)then
							FishinghookCount=20
						end
						dgsSetText(Lakeside.Label[2],FishinghookCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..FishinghookCount.." $"..FishinghookCount*settings.shop.fishinghookPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[12],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishinghookCount=FishinghookCount-2
						if(FishinghookCount<=0)then
							FishinghookCount=0
						end
						dgsSetText(Lakeside.Label[2],FishinghookCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..FishinghookCount.." $"..FishinghookCount*settings.shop.fishinghookPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[11],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishinghookCount=FishinghookCount+1
						if(FishinghookCount>=20)then
							FishinghookCount=20
						end
						dgsSetText(Lakeside.Label[2],FishinghookCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..FishinghookCount.." $"..FishinghookCount*settings.shop.fishinghookPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[10],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishinghookCount=FishinghookCount-1
						if(FishinghookCount<=0)then
							FishinghookCount=0
						end
						dgsSetText(Lakeside.Label[2],FishinghookCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..FishinghookCount.." $"..FishinghookCount*settings.shop.fishinghookPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[6],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[1])
						triggerServerEvent("buy:fishingitems",lp,"Fishingrod",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[5],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishingrodCount=FishingrodCount+2
						if(FishingrodCount>=20)then
							FishingrodCount=20
						end
						dgsSetText(Lakeside.Label[1],FishingrodCount)
						dgsSetText(Lakeside.Button[6],"Buy x"..FishingrodCount.." $"..FishingrodCount*settings.shop.fishingrodPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[4],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishingrodCount=FishingrodCount-2
						if(FishingrodCount<=0)then
							FishingrodCount=0
						end
						dgsSetText(Lakeside.Label[1],FishingrodCount)
						dgsSetText(Lakeside.Button[6],"Buy x"..FishingrodCount.." $"..FishingrodCount*settings.shop.fishingrodPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishingrodCount=FishingrodCount+1
						if(FishingrodCount>=20)then
							FishingrodCount=20
						end
						dgsSetText(Lakeside.Label[1],FishingrodCount)
						dgsSetText(Lakeside.Button[6],"Buy x"..FishingrodCount.." $"..FishingrodCount*settings.shop.fishingrodPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						FishingrodCount=FishingrodCount-1
						if(FishingrodCount<=0)then
							FishingrodCount=0
						end
						dgsSetText(Lakeside.Label[1],FishingrodCount)
						dgsSetText(Lakeside.Button[6],"Buy x"..FishingrodCount.." $"..FishingrodCount*settings.shop.fishingrodPrice)
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
end)