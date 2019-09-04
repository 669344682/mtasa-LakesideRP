--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function uLevel(player,typ)
	if(typ=="Job")then
		if(tonumber(syncGetElementData(player,"Joblevel"))<=9)then
			if(tonumber(syncGetElementData(player,"Jobexp"))>=settings.level.job[tonumber(syncGetElementData(player,"Joblevel"))])then
				syncSetElementData(player,"Joblevel",tonumber(syncGetElementData(player,"Joblevel"))+1)
				syncSetElementData(player,"Jobexp",tonumber(0))
				outputChatBox("Congratulations, you have just reached job-level "..tonumber(syncGetElementData(player,"Joblevel")).."!",player,255,255,255)
			end
		end
	end
end

function uEXP(player,typ,amount)
	if(typ=="Job")then
		if(tonumber(syncGetElementData(player,"Joblevel"))<=9)then
			syncSetElementData(player,"Jobexp",tonumber(syncGetElementData(player,"Jobexp"))+amount)
		end
	end
end