--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

nameSphere=createColSphere(0,0,0,15)

nameTagPlayers={}
nameTagVisible={}
nameTagHP={}
nameTagImages={}
nameTagAimTarget=lp

local players=getElementsByType("player")
for _,v in pairs(players)do
	setPlayerNametagShowing(v,false)
end
addEventHandler("onClientPlayerJoin",root,function()
	setPlayerNametagShowing(source,false)
end)

function nameTagSpawn()
	detachElements(nameSphere)
	if(isElement(lp))then
		attachElements(nameSphere,lp)
	end
end
setTimer(nameTagSpawn,500,0)

function nameTagSphereHit(element)
	--if(getElementType(element)=="player" and not(element==lp))then
	if(getElementType(element)=="player")then
		nameTagPlayers[element]=true
		nameTagImages[element]={}
		nameTagCheckPlayerSight(element)
	end
end
addEventHandler("onClientColShapeHit",nameSphere,nameTagSphereHit)

function nameTagCheckPlayerSight(player)
	if(isElement(player))then
		local x1,y1,z1=getPedBonePosition(player,8)
		local x2,y2,z2=getPedBonePosition(lp,8)
		local hit=processLineOfSight(x1,y1,z1,x2,y2,z2,true,false,false,true,false)
		nameTagVisible[player]=not hit
		if(nameTagVisible[player])then
			nameTagHP[player]=getElementHealth(lp)
		end
		if(not nameTagImages[player])then
			nameTagImages[player]={}
		end
		nameTagImages[player]["AFK.png"]=false
		nameTagImages[player]["Seatbelt.png"]=false
		nameTagImages[player]["Typing.png"]=false
		
		if(getElementData(player,"AFK")==true)then
			nameTagImages[player]["AFK.png"]=true
		end
		if(getElementData(player,"seatbelt")==true)then
			nameTagImages[player]["Seatbelt.png"]=true
		end
		if(getElementData(player,"isChatBoxInputActive")==true)then
			nameTagImages[player]["Typing.png"]=true
		end
		
	else
		nameTagPlayers[player]=nil
		nameTagVisible[player]=nil
		nameTagHP[player]=nil
	end
end

function nameTagSphereLeave(element)
	nameTagPlayers[element]=nil
	nameTagVisible[element]=nil
	nameTagHP[element]=nil
end
addEventHandler("onClientColShapeLeave",nameSphere,nameTagSphereLeave)

function drawNametag()
	for i,_ in pairs(nameTagVisible)do
		if(getElementData(i,"Loggedin")==1)then
			if(getElementData(lp,"Loggedin")==1)then
				--if(getElementData(lp,"introstate")==false)then
					if(getElementData(lp,"inRocket")==false)then
						if(isElement(i))then
							if(getElementDimension(i)==getElementDimension(lp))then
								if(nameTagVisible[i])then
									local x,y,z=getElementPosition(i)
									if(x)and(y)and(z)then
										local sx,sy=getScreenFromWorldPosition(x,y,z+1.1,1000,true)
										if(sx)and(sy)then
											local r,g,b=calcRGBByHP(i)
											local name=getPlayerName(i):gsub("_"," ")
											local nametag=""
											local armour=math.floor(getPedArmor(i))
											
											if(isChatBoxInputActive())then
												setElementData(lp,"isChatBoxInputActive",true)
											else
												setElementData(lp,"isChatBoxInputActive",false)
											end
										
											if(tonumber(getElementData(i,"AdminLvL"))>=2)then
												nametag="[LS]"
											end
											
											dxDrawText(nametag.." "..name,sx+14,sy,sx,sy,tocolor(0,0,0,255),1.2,dxFONT2,"center","center",false,false,false,true)
											dxDrawText(nametag.." "..name,sx+16,sy-2,sx,sy,tocolor(r,g,b,255),1.2,dxFONT2,"center","center",false,false,false,true)
											if(armour>0)then
												dxDrawRectangle(sx-70,sy+1+14,137,16,tocolor(0,0,0,200),false)
												dxDrawRectangle(sx-70,sy+1+14,(1.37*armour),16,tocolor(180,180,180,200),false)
												
												dxDrawText(armour.."%",sx-2,sy+3+45,sx,sy,tocolor(255,255,255,255),0.8,"default-bold","center","center",_,_,false,_,_)
											end
											
											local img,drawn=0,0
											for _,v in pairs(nameTagImages[i])do
												if(v)then
													img=img+1
												end
											end
											for k,v in pairs(nameTagImages[i])do
												if(v)then
													local imgpath=":"..settings.general.scriptname.."/Files/Images/Nametag/"..k
													if(img/2==math.floor(img/2))then
														dxDrawImage(sx+20*(drawn)-img*20+20,sy+38,20,20,imgpath)
														drawn=drawn+1
													else
														dxDrawImage(sx+20*(drawn)-img*20/2,sy+38,20,20,imgpath)
														drawn=drawn+1
													end
												end
											end
											
										end
									end
								end
							end
						else
							nameTagCheckPlayerSight(i)
						end
					end
				--end
			end
		end
	end
end
addEventHandler("onClientRender",root,drawNametag)

function calcRGBByHP ( player )
	local hp = getElementHealth ( player )
	if hp <= 0 then
		return 0, 0, 0
	else
		hp = math.abs ( hp - 0.01 )
		return ( 100 - hp ) * 2.55 / 2, ( hp * 2.55 ), 0
	end
end

function reCheckNameTag ()
	if(isElement(getCameraTarget()))then
		detachElements ( nameSphere )
		attachElements ( nameSphere, getCameraTarget () )
	end
	setElementInterior ( nameSphere, getElementInterior ( lp ) )
	setElementDimension ( nameSphere, getElementDimension ( lp ) )
	if isPedAiming ( lp ) and getPedWeaponSlot ( lp ) == 6 then
		local x1, y1, z1 = getPedTargetStart ( lp )
		local x2, y2, z2 = getPedTargetEnd ( lp )
		local boolean, x, y, z, hit = processLineOfSight ( x1, y1, z1, x2, y2, z2 )
		if boolean then
			if isElement ( hit ) then
				if getElementType ( hit ) == "player" then
					nameTagAimTarget = hit
					nameTagPlayers[nameTagAimTarget] = nameTagAimTarget
				end
			end
		end
	end
	for i,_ in pairs ( nameTagPlayers ) do
		nameTagCheckPlayerSight ( i )
	end
end
setTimer ( reCheckNameTag, 500, 0 )