--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local hudTable={"ammo","armour","clock","health","money","weapon","wanted","area_name","vehicle_name","breath","clock","ammo","radar"}
function disableComponents()
	for i=1,#hudTable do
		setPlayerHudComponentVisible(hudTable[i],false)
	end
	toggleControl("radar",false)
end
addEventHandler("onClientRender",root,disableComponents)

function drawHud()
	if(isLoggedin())then
		--if(getElementData(lp,"introstate")==false)then
			if(getElementData(lp,"intchange")==false)then
				if(getElementData(lp,"inRocket")==false)then
					if(not lp:isDead())then
						if(isPlayerMapVisible(lp)==false)then
							if not CDN:getReady()then
								return
							end
							
							local time=getRealTime()
							local hour=time.hour
							local minute=time.minute
							if(hour<10)then
								hour="0"..hour
							end
							if(minute<10)then
								minute="0"..minute
							end
							
							local skin=getElementModel(lp)
							local armor=math.floor(getPedArmor(lp))or 0
							local armor1=math.floor(getPedArmor(lp))or 0
							local health=math.floor(getElementHealth(lp))or 0
							local health1=math.floor(getElementHealth(lp))or 0
							local hunger=getElementData(lp,"Hunger")or 0
							local hunger1=getElementData(lp,"Hunger")or 0
							local piss=getElementData(lp,"Urin")or 0
							local piss1=getElementData(lp,"Urin")or 0
							local wanted=getElementData(lp,"Wanteds")or 0
							local weaponID=getPedWeapon(lp)or 0
							local armor=216/100*armor
							local health=216/100*health
							local hunger=216/100*hunger
							local piss=216/100*piss
							local currentTick=getTickCount()/1500
							
							dxDrawImage(1655*Gsx,17*Gsy,20*Gsx,20*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Health.png",0,0,0,tocolor(114,171,116,255),false)
							dxDrawRectangle(1680*Gsx,15*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
							if(health1>=25)then
								dxDrawRectangle(1682*Gsx,17*Gsy,health*Gsx,21*Gsy,tocolor(114,171,116,255),false)
							elseif(health1<=25)then
								dxDrawRectangle(1682*Gsx,17*Gsy,health*Gsx,21*Gsy,tocolor(114,171,116,currentTick*255),false)
							end
							
							dxDrawRectangle(1680*Gsx,46*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
							dxDrawImage(1655*Gsx,48*Gsy,20*Gsx,20*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Armor.png",0,0,0,tocolor(60,125,160,255),false)
							if(armor1>=25)then
								dxDrawRectangle(1682*Gsx,48*Gsy,armor*Gsx,21*Gsy,tocolor(60,125,160,255),false)
							elseif(armor1<=25)then
								dxDrawRectangle(1682*Gsx,48*Gsy,armor*Gsx,21*Gsy,tocolor(60,125,160,currentTick*255),false)
							end
							
							dxDrawRectangle(1680*Gsx,76*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
							dxDrawImage(1655*Gsx,78*Gsy,20*Gsx,20*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Hunger.png",0,0,0,tocolor(166,148,75,255),false)
							if(hunger1>=25)then
								dxDrawRectangle(1682*Gsx,78*Gsy,hunger*Gsx,21*Gsy,tocolor(166,148,75,255),false)
							elseif(hunger1<=25)then
								dxDrawRectangle(1682*Gsx,78*Gsy,hunger*Gsx,21*Gsy,tocolor(166,148,75,currentTick*255),false)
							end
							
							dxDrawRectangle(1680*Gsx,106*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
							dxDrawImage(1655*Gsx,108*Gsy,20*Gsx,20*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Piss.png",0,0,0,tocolor(166,148,75,255),false)
							if(piss1<=80)then
								dxDrawRectangle(1682*Gsx,108*Gsy,piss*Gsx,21*Gsy,tocolor(170,255,255,255),false)
							elseif(piss1>=80)then
								dxDrawRectangle(1682*Gsx,108*Gsy,piss*Gsx,21*Gsy,tocolor(170,255,255,currentTick*255),false)
							end
							
							dxDrawRectangle(1680*Gsx,136*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
							dxDrawText("$ "..convertNumber(mymoney),1685*Gsx,138*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),0.90*Gsx,dxFONT,"left",_,_,_,false,_,_)
							
							dxDrawRectangle(1535*Gsx,15*Gsy,88*Gsx,88*Gsy,tocolor(0,0,0,100),false)
							dxDrawImage(1535*Gsx,15*Gsy,88*Gsx,88*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..tostring(weaponID)..".png",0.0,0.0,0.0,tocolor(255,255,255,200),false)
							dxDrawRectangle(1535*Gsx,108*Gsy,88*Gsx,25*Gsy,tocolor(0,0,0,100),false)
							if(weaponID==0)then
								dxDrawText("Fist",1565*Gsx,110*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
							else
								dxDrawText(getPedAmmoInClip(lp).." | "..getPedTotalAmmo(lp)-getPedAmmoInClip(lp),1565*Gsx,110*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
							end
							
							if(wanted>=1)then
								local wantedY=0
								for i=1,wanted do
									dxDrawImage(1676*Gsx+wantedY+5*Gsx,170*Gsy,35*Gsx,35*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Wanted.png",0,0,0,tocolor(240,240,0,255),false)
									wantedY=wantedY+37*Gsx
								end
							end
							
							dxDrawImage(820*Gsx,0*Gsy,280*Gsx,40*Gsy,":"..settings.general.scriptname.."/Files/Images/Hud/Time.png",0,0,0,tocolor(150,0,0,200),false)
							dxDrawText(hour..":"..minute,1725*Gsx,5*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.40*Gsx,dxFONT3,"center",_,_,_,false,_,_)
							
							if(tonumber(syncClientGetElementData("Jailtime"))>=1)then
								dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,80*Gsy,tocolor(0,0,0,140),false)
								dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,21*Gsy,tocolor(0,0,0,140),false)
								dxDrawText("Jailtime",1725*Gsx,61.5*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT3,"center",_,_,_,false,_,_)
								dxDrawImage(820*Gsx,80*Gsy,280*Gsx,2*Gsy,":"..settings.general.scriptname.."/Files/Images/White.png",0,0,0,tocolor(150,0,0,200),false)
								dxDrawText(tonumber(syncClientGetElementData("Jailtime")).." minutes",1725*Gsx,100*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.30*Gsx,dxFONT3,"center",_,_,_,false,_,_)
							end
						end
					end
				end
			end
		--end
	end
end
addEventHandler("onClientRender",root,drawHud)

function convertNumber(number)
    local formatted=number
    while true do
        formatted,k=string.gsub(formatted,"^(-?%d+)(%d%d%d)",'%1.%2')
        if(k==0)then
            break
        end
    end
    return formatted
end