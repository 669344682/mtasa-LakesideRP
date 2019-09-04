--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Hade         ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function drawScoreboard()
	if(isLoggedin())then
		if(isPlayerMapVisible(lp)==false)then
			if(getElementData(lp,"ElementClicked")==false)then
				--if(getElementData(lp,"introstate")==false)then
					if(not isElement(Lakeside.Window[20]))then
						Lakeside.Window[20]=dgsCreateWindow(GLOBALscreenX/2-350/2,GLOBALscreenY/2-450/2,350,450,settings.general.servername.." Reallife/Roleplay",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
						dgsWindowSetSizable(Lakeside.Window[20],false)
						dgsWindowSetMovable(Lakeside.Window[20],false)
						dgsCreateImage(0,0,350,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[20],settings.general.guilinecolor)
						dgsSetAlpha(Lakeside.Window[20],0)
						dgsAlphaTo(Lakeside.Window[20],1,false,"OutQuad",900)
						
						Lakeside.Label[1]=dgsCreateLabel(5,5,100,20,"Players: "..#getElementsByType("player").."/444",false,Lakeside.Window[20])
						dgsSetProperty(Lakeside.Label[1],"textSize",{1.2,1.2})
						
						scoreboardGridlist=dgsCreateGridList(5,30,340,390,false,Lakeside.Window[20],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
						player=dgsGridListAddColumn(scoreboardGridlist,"Name",0.55)
						playtime=dgsGridListAddColumn(scoreboardGridlist,"Play time",0.25)
						ping=dgsGridListAddColumn(scoreboardGridlist,"Ping",0.1)
						
						dgsGridListSetSortColumn(scoreboardGridlist,1)
						
						
						dgsGridListSetSortEnabled(scoreboardGridlist,false)
						updateScoreboard(scoreboardGridlist,player,playtime,ping)
						
						updateScoreboardTimer=setTimer(function()
							updateScoreboard(scoreboardGridlist,player,playtime,ping)
						end,500,0)
					end
				--end
			end
		end
	end
end
bindKey("tab","down",drawScoreboard)

function hideScoreboard()
	if(isLoggedin())then
		if(isElement(Lakeside.Window[20]))then
			dgsAlphaTo(Lakeside.Window[20],0,false,"OutQuad",900)
			Lakeside.Window[20]:destroy()
			--[[setTimer(function()
				Lakeside.Window[20]:destroy()
			end,500,1)]]
			updateScoreboardTimer:destroy()
		end
	end
end
bindKey("tab","up",hideScoreboard)

function updateScoreboard(scoreboardGridlist,player,playtime,ping)
	dgsGridListClear(scoreboardGridlist)
	
	local players=getElementsByType("player")
	for _,v in ipairs(players)do
		if(isLoggedin(v))then
			local playingtime=tonumber(getElementData(v,"Playtime"))or 0
			local playingtime=math.floor(playingtime/60).."h "..(playingtime-math.floor(playingtime/60)*60).."m"
			local stafflevel=getElementData(v,"AdminLvL")or 0
			local rRr,gGg,bBb=settings.admin.levelRGBcolors[stafflevel][1],settings.admin.levelRGBcolors[stafflevel][2],settings.admin.levelRGBcolors[stafflevel][3]
			
			local row=dgsGridListAddRow(scoreboardGridlist)
			dgsGridListSetItemText(scoreboardGridlist,row,player,getPlayerName(v):gsub("_"," "))
			dgsGridListSetItemText(scoreboardGridlist,row,playtime,playingtime)
			dgsGridListSetItemColor(scoreboardGridlist,row,playtime,255,255,255,255)
			dgsGridListSetItemText(scoreboardGridlist,row,ping,getPlayerPing(v))
			dgsGridListSetItemColor(scoreboardGridlist,row,ping,getPingColor(getPlayerPing(v)))
			
			if(stafflevel~=nil and stafflevel>0)then
				dgsGridListSetItemColor(scoreboardGridlist,row,player,rRr,gGg,bBb,255)
			else
				dgsGridListSetItemColor(scoreboardGridlist,row,player,255,255,255,255)
			end
		else
			local row=dgsGridListAddRow(scoreboardGridlist)
			dgsGridListSetItemText(scoreboardGridlist,row,player,"Register/Login client ...")
			dgsGridListSetItemColor(scoreboardGridlist,row,player,255,255,255,255)
			dgsGridListSetItemText(scoreboardGridlist,row,playtime,"0h 0m")
			dgsGridListSetItemColor(scoreboardGridlist,row,playtime,255,255,255,255)
			dgsGridListSetItemText(scoreboardGridlist,row,ping,getPlayerPing(v))
			dgsGridListSetItemColor(scoreboardGridlist,row,ping,getPingColor(getPlayerPing(v)))
		end
	end
end

function getPingColor(ping)
	if(ping<=50)then
		return 0,200,0
	elseif(ping<=150)then
		return 200,200,0
	else
		return 200,0,0
	end
end