addEvent("open:farmsellUI",true)
addEventHandler("open:farmsellUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			local AppleCount=0
			local AppleSeedCount=0
			local WeedSeedCount=0
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Farm",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,255,255,255,255,Lakeside.Window[1])
			
			Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,380,215,false,Lakeside.Window[1])
			Lakeside.Tab[1]=dgsCreateTab("Apple",Lakeside.Tabpanel[1])
			
			Lakeside.Button[2]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[5]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Apple.png",false,Lakeside.Tab[1])
			Lakeside.Label[1]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[6]=dgsCreateButton(5,150,370,40,"Sell x0 $0",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Tab[2]=dgsCreateTab("Apple seeds",Lakeside.Tabpanel[1])
			
			Lakeside.Button[10]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[11]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[12]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[13]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/AppleSeeds.png",false,Lakeside.Tab[2])
			Lakeside.Label[2]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[2],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[14]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			Lakeside.Tab[3]=dgsCreateTab("Weed seeds",Lakeside.Tabpanel[1])
			
			Lakeside.Button[15]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[16]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[17]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[18]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/WeedSeeds.png",false,Lakeside.Tab[3])
			Lakeside.Label[3]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[3],_,_,_,_,_,_,"center",_)
			
			Lakeside.Button[19]=dgsCreateButton(5,150,370,40,"Buy x0 $0",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[19],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[3])
						triggerServerEvent("buy:farmitems",lp,"WeedSeeds",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[18],
				function(btn,state)
					if(btn=="left" and state=="down")then
						WeedSeedCount=WeedSeedCount+2
						if(WeedSeedCount>=20)then
							WeedSeedCount=20
						end
						dgsSetText(Lakeside.Label[3],WeedSeedCount)
						dgsSetText(Lakeside.Button[19],"Buy x"..WeedSeedCount.." $"..WeedSeedCount*settings.shop.farmItems.weedSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[17],
				function(btn,state)
					if(btn=="left" and state=="down")then
						WeedSeedCount=WeedSeedCount-2
						if(WeedSeedCount<=0)then
							WeedSeedCount=0
						end
						dgsSetText(Lakeside.Label[3],WeedSeedCount)
						dgsSetText(Lakeside.Button[19],"Buy x"..WeedSeedCount.." $"..WeedSeedCount*settings.shop.farmItems.weedSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[16],
				function(btn,state)
					if(btn=="left" and state=="down")then
						WeedSeedCount=WeedSeedCount+1
						if(WeedSeedCount>=20)then
							WeedSeedCount=20
						end
						dgsSetText(Lakeside.Label[3],WeedSeedCount)
						dgsSetText(Lakeside.Button[19],"Buy x"..WeedSeedCount.." $"..WeedSeedCount*settings.shop.farmItems.weedSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[15],
				function(btn,state)
					if(btn=="left" and state=="down")then
						WeedSeedCount=WeedSeedCount-1
						if(WeedSeedCount<=0)then
							WeedSeedCount=0
						end
						dgsSetText(Lakeside.Label[3],WeedSeedCount)
						dgsSetText(Lakeside.Button[19],"Buy x"..WeedSeedCount.." $"..WeedSeedCount*settings.shop.farmItems.weedSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[14],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[2])
						triggerServerEvent("buy:farmitems",lp,"AppleSeeds",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[13],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleSeedCount=AppleSeedCount+2
						if(AppleSeedCount>=20)then
							AppleSeedCount=20
						end
						dgsSetText(Lakeside.Label[2],AppleSeedCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..AppleSeedCount.." $"..AppleSeedCount*settings.shop.farmItems.appleSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[12],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleSeedCount=AppleSeedCount-2
						if(AppleSeedCount<=0)then
							AppleSeedCount=0
						end
						dgsSetText(Lakeside.Label[2],AppleSeedCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..AppleSeedCount.." $"..AppleSeedCount*settings.shop.farmItems.appleSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[11],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleSeedCount=AppleSeedCount+1
						if(AppleSeedCount>=20)then
							AppleSeedCount=20
						end
						dgsSetText(Lakeside.Label[2],AppleSeedCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..AppleSeedCount.." $"..AppleSeedCount*settings.shop.farmItems.appleSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[10],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleSeedCount=AppleSeedCount-1
						if(AppleSeedCount<=0)then
							AppleSeedCount=0
						end
						dgsSetText(Lakeside.Label[2],AppleSeedCount)
						dgsSetText(Lakeside.Button[14],"Buy x"..AppleSeedCount.." $"..AppleSeedCount*settings.shop.farmItems.appleSeedPrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[6],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local amount=dgsGetText(Lakeside.Label[1])
						triggerServerEvent("sell:farmitems",lp,"Apple",amount)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[5],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleCount=AppleCount+2
						if(AppleCount>=20)then
							AppleCount=20
						end
						dgsSetText(Lakeside.Label[1],AppleCount)
						dgsSetText(Lakeside.Button[6],"Sell x"..AppleCount.." $"..AppleCount*settings.shop.farmItems.applePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[4],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleCount=AppleCount-2
						if(AppleCount<=0)then
							AppleCount=0
						end
						dgsSetText(Lakeside.Label[1],AppleCount)
						dgsSetText(Lakeside.Button[6],"Sell x"..AppleCount.." $"..AppleCount*settings.shop.farmItems.applePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleCount=AppleCount+1
						if(AppleCount>=20)then
							AppleCount=20
						end
						dgsSetText(Lakeside.Label[1],AppleCount)
						dgsSetText(Lakeside.Button[6],"Sell x"..AppleCount.." $"..AppleCount*settings.shop.farmItems.applePrice)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						AppleCount=AppleCount-1
						if(AppleCount<=0)then
							AppleCount=0
						end
						dgsSetText(Lakeside.Label[1],AppleCount)
						dgsSetText(Lakeside.Button[6],"Sell x"..AppleCount.." $"..AppleCount*settings.shop.farmItems.applePrice)
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