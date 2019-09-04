--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:christmas1_UI",true)
addEventHandler("open:christmas1_UI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Christmas",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,255,255,255,255,Lakeside.Window[1])
			
			dgsCreateImage(35,15,150,150,":"..settings.general.scriptname.."/Files/Images/Inventory/Present.png",false,Lakeside.Window[1])
			
			Lakeside.Button[2]=dgsCreateButton(35,180,150,40,"Buy this Present\n(x5 Candycane)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:shopitem",lp,"Present",1)
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








--//Snow Ground shader
local maxEffectDistance=400
local snowApplyList={
	"*"
}
local snowRemoveList={
	"",
	"vehicle*","?emap*","?hite*",
	"*92*","*wheel*","*interior*",
	"*handle*","*body*","*decal*",
	"*8bit*","*logos*","*badge*",
	"*plate*","*sign*",
	"headlight","headlight1",
	"shad*",
	"coronastar",
	"tx*",
	"lod*",
	"cj_w_grad",
	"*cloud*",
	"*smoke*",
	"sphere_cj",
	"particle*",
	"*water*","sw_sand","coral",
}
local treeApplyList={
	"sm_des_bush*","*tree*","*ivy*","*pine*",
	"veg_*","*largefur*","hazelbr*","weeelm",
	"*branch*","cypress*",
	"*bark*","gen_log","trunk5",
	"bchamae","vegaspalm01_128",
}

local naughtyTreeApplyList={
	"planta256","sm_josh_leaf","kbtree4_test","trunk3",
	"newtreeleaves128","ashbrnch","pinelo128","tree19mi",
	"lod_largefurs07","veg_largefurs05","veg_largefurs06",
	"fuzzyplant256","foliage256","cypress1","cypress2",
}



--[[addEventHandler("onClientResourceStart",resourceRoot,
function()
	if(settings.general.christmas==true)then
		triggerEvent("switchGoundSnow",resourceRoot,true)
	end
end)]]

function toggleGoundSnow()
	triggerEvent("switchGoundSnow",resourceRoot,not bEffectEnabled)
end

function switchGoundSnow(typ)
	if(typ)then
		enableGoundSnow()
	else
		disableGoundSnow()
	end
end
addEvent("switchGoundSnow",true)
addEventHandler("switchGoundSnow",resourceRoot,switchGoundSnow)



function enableGoundSnow()
	if(bEffectEnabled)then
		return
	end
	snowShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Snow/Ground.fx",0,maxEffectDistance)
	treeShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Snow/Trees.fx")
	naughtyTreeShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Snow/NaughtyTrees.fx")
	sNoiseTexture=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Snow.dds")
	
	if(not snowShader or not treeShader or not naughtyTreeShader or not sNoiseTexture)then
		return nil
	end
	
	dxSetShaderValue(treeShader,"sNoiseTexture",sNoiseTexture)
	dxSetShaderValue(naughtyTreeShader,"sNoiseTexture",sNoiseTexture)
	dxSetShaderValue(snowShader,"sNoiseTexture",sNoiseTexture)
	dxSetShaderValue(snowShader,"sFadeEnd",maxEffectDistance)
	dxSetShaderValue(snowShader,"sFadeStart",maxEffectDistance/2)
	
	for _,v in ipairs(snowApplyList) do
		engineApplyShaderToWorldTexture(snowShader,v)
	end

	for _,v in ipairs(snowRemoveList) do
		engineRemoveShaderFromWorldTexture(snowShader,v)
	end

	for _,v in ipairs(treeApplyList) do
		engineApplyShaderToWorldTexture(treeShader,v)
	end

	for _,v in ipairs(naughtyTreeApplyList) do
		engineApplyShaderToWorldTexture(naughtyTreeShader,v)
	end
	
	
	doneVehTexRemove={}
	vehTimer=setTimer(checkCurrentVehicle,100,0)
	removeVehTextures()
	bEffectEnabled=true
end


function disableGoundSnow()
	if(not bEffectEnabled)then
		return
	end
	sNoiseTexture:destroy()
	treeShader:destroy()
	naughtyTreeShader:destroy()
	snowShader:destroy()
	vehTimer:destroy()
	bEffectEnabled=false
end




function checkCurrentVehicle()
	local veh=getPedOccupiedVehicle(localPlayer)
	local id=veh and getElementModel(veh)
	if(lastveh~=veh or lastid~=id)then
		lastveh=veh
		lastid=id
		removeVehTexturesSoon()
	end
	if(nextCheckTime<getTickCount())then
		nextCheckTime=getTickCount()+5000
		removeVehTextures()
	end
end

function removeVehTexturesSoon()
    nextCheckTime=getTickCount()+200
end

function removeVehTextures ()
	if(not bHasFastRemove)then
		return
	end

	local veh=getPedOccupiedVehicle(localPlayer)
	if(veh)then
		local id=getElementModel(veh)
		local vis=engineGetVisibleTextureNames("*",id)
		if(vis)then	
			for _,removeMatch in pairs(vis)do
				if(not doneVehTexRemove[removeMatch])then
					doneVehTexRemove[removeMatch]=true
					engineRemoveShaderFromWorldTexture(snowShader,removeMatch)
				end
			end
		end
	end
end



_dxCreateShader=dxCreateShader
function dxCreateShader(filepath,priority,maxDistance,bDebug)
	priority=priority or 0
	maxDistance=maxDistance or 0
	bDebug=bDebug or false
	local build=getVersion().sortable:sub(9)
	local fullscreen=not dxGetStatus().SettingWindowed
	if(build<"03236" and fullscreen)then
		maxDistance=0
	end
	return _dxCreateShader(filepath,priority,maxDistance,bDebug)
end


--//Snowfall shader
