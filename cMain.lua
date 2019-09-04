--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

GLOBALscreenX,GLOBALscreenY=guiGetScreenSize()
Gsx=GLOBALscreenX/1920
Gsy=GLOBALscreenY/1080

setOcclusionsEnabled(false)
setWorldSoundEnabled(5,false)

loadstring(exports.dgs:dgsImportFunction())()
lp=getLocalPlayer()

Lakeside={Window={},Button={},Gridlist={},GridlistColumn={},Label={},Edit={},Image={},Tabpanel={},Tab={},Music={},Memo={},Combo={},ComboItem={},CPicker={},Radio={},Blurbox={},Probar={},Browser={}}

dxFONT=dxCreateFont("Files/Fonts/BEBAS.ttf",14)
dxFONT2=dxCreateFont("Files/Fonts/SEGOEUI.ttf",10)
dxFONT3=dxCreateFont("Files/Fonts/Arial.ttf",12)
dxFONT4=dxCreateFont("Files/Fonts/Roboto-Thin.ttf",11)

function isMouseInPosition(x,y,width,height)
	if(not isCursorShowing())then
		return false
	end
    local cx,cy=getCursorPosition()
    local cx,cy=(cx*GLOBALscreenX),(cy*GLOBALscreenY)
    if((cx>=x and cx<=x+width)and(cy>=y and cy<=y+height))then
        return true
    else
        return false
    end
end

addEventHandler("onClientResourceStart",resourceRoot,function()
	lrVersion=settings.general.servername.." v."..settings.general.scriptversion
	versionLabel=guiCreateLabel(1,1,0.3,0.3,lrVersion,true)
	guiSetSize(versionLabel,guiLabelGetTextExtent(versionLabel),guiLabelGetFontHeight(versionLabel),false)
	x,y=guiGetSize(versionLabel,true)
	guiSetPosition(versionLabel,1-x,1-y*1.8,true)
	guiSetAlpha(versionLabel,0.5)
end)

function isPedAiming(ped)
	if(ped and isElement(ped))then
		if(getElementType(ped)=="player" or getElementType(ped)=="ped")then
			if(getPedTask(ped,"secondary",0)=="TASK_SIMPLE_USE_GUN")then
				return true
			end
		end
	end
	return false
end


local OnlyNumbersTable={"a","b","c","d","e","f","g","h","i","j","k","l","m","o","p","y","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","O","P","Q","R","S","T","U","V","W","X","Y","Z","ä","ü","ö","Ä","Ü","Ö"," ",",","#","'","+","*","~",":",";","=","}","?","\\","{","&","/","§","\"","!","°","@","|","`","´","-","+"};

function isOnlyNumbers(text)
	local counter=0
	for _,v in ipairs(OnlyNumbersTable)do
		if(string.find(text,v))then
			counter=counter+1
			break
		end
	end
	if(counter>=1)then
		triggerEvent("draw:infobox",lp,"error","Please enter only numbers!",10000)
		return false
	else
		return true
	end
end



function getPOS()
	x,y,z=getElementPosition(lp)
	xr,yr,zr=getElementRotation(lp)
	outputChatBox("Your Position: "..x..", " ..y..", " ..z,239,100,0,true)
	outputChatBox("Your Rotation: "..xr..", " ..yr..", " ..zr,239,100,0,true)
	
	setClipboard(x..","..y..","..z)
end
addCommandHandler("pos",getPOS)




local ScreenSource=dxCreateScreenSource(GLOBALscreenX,GLOBALscreenY)
local blurStrength=7
function createBlurShader()
	if(fileExists(":"..settings.general.scriptname.."/Files/Shaders/Blur.fx"))then
		blurShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Blur.fx")
	else
		setTimer(function()
			createBlurShader()
		end,1000,1)
	end
end
createBlurShader()

function renderBlur()
	if(blurShader)then
		dxUpdateScreenSource(ScreenSource)
		dxSetShaderValue(blurShader,"ScreenSource",ScreenSource)
		dxSetShaderValue(blurShader,"BlurStrength",blurStrength)
		dxSetShaderValue(blurShader,"UVSize",GLOBALscreenX,GLOBALscreenY)
		dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,blurShader)
	end
end

function setWindowData(typ,typ2,typ3)
	if(typ=="add")then
		if(typ2=="blur")then
			removeEventHandler("onClientRender",root,renderBlur)
			addEventHandler("onClientRender",root,renderBlur)
		end
		if(typ2=="cursor_clicked")then
			showCursor(true)
			setElementData(lp,"ElementClicked",true)
		end
		if(typ3==true)then
			local sound=playSound(":"..settings.general.scriptname.."/Files/Sounds/UI/Open.mp3")
			setSoundVolume(sound,0.6)
		end
	end
	if(typ=="remove")then
		if(typ2=="blur")then
			removeEventHandler("onClientRender",root,renderBlur)
		end
		if(typ2=="cursor_clicked")then
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
			if(isElement(Lakeside.Blurbox[1])or isElement(Lakeside.Blurbox[2]))then
				exports.blur_box:destroyBlurBox(Lakeside.Blurbox[1])
			end
		end
		if(typ3==true)then
			local sound=playSound(":"..settings.general.scriptname.."/Files/Sounds/UI/Close.mp3")
			setSoundVolume(sound,0.6)
		end
		
		if(getElementData(lp,"InTuninggarage")~=false)then
			triggerServerEvent("spawn:tuninggarage",lp)
			unbindKey("arrow_r","down",bindRightTuningsys_Func)
			unbindKey("arrow_l","down",bindLeftTuningsys_Func)
		end
	end
end


addEventHandler("onClientPlayerWasted",lp,function()
	if(isElement(Lakeside.Window[1]))then
		dgsCloseWindow(Lakeside.Window[1])
		setWindowData("remove","cursor_clicked",false)
		setWindowData("remove","blur")
	end
	if(isElement(Lakeside.Window[2]))then
		dgsCloseWindow(Lakeside.Window[2])
		setWindowData("remove","cursor_clicked",false)
		setWindowData("remove","blur")
	end
end)

--//Loadingscreen
function drawLoadingScreen_Func()
	if(loadscreenAlpha<255)then
		loadscreenAlpha=loadscreenAlpha+0.85
	end
	dxDrawRectangle(0,0,GLOBALscreenX,GLOBALscreenY,tocolor(0,0,0,loadscreenAlpha),true)
	dxDrawText("Loading...",950*Gsx,430*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),1.3*Gsx,dxFONT4,"center","center",_,_,false,_,_)
	dxDrawText("Did you know already?\n\n"..loadscreenFakt,950*Gsx,800*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),1.0*Gsx,dxFONT4,"center","center",_,_,false,_,_)
end

addEvent("draw:loadingscreen",true)
addEventHandler("draw:loadingscreen",root,function()
	loadscreenFakt=globalTables["facts"][math.random(1,#globalTables["facts"])]
	loadscreenAlpha=0
	fadeCamera(false)
	showChat(false)
	removeEventHandler("onClientRender",root,drawLoadingScreen_Func)
	addEventHandler("onClientRender",root,drawLoadingScreen_Func)
	
	setTimer(function()
		fadeCamera(true)
		showChat(true)
		removeEventHandler("onClientRender",root,drawLoadingScreen_Func)
	end,3000,1)
end)










local attachedEffects={}

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end

function attachEffect(effect, element, pos)
	attachedEffects[effect] = { effect = effect, element = element, pos = pos }
	addEventHandler("onClientElementDestroy", effect, function() attachedEffects[effect] = nil end)
	addEventHandler("onClientElementDestroy", element, function() attachedEffects[effect] = nil end)
	return true
end

addEventHandler("onClientPreRender", root, 	
	function()
		for fx, info in pairs(attachedEffects) do
			local x, y, z = getPositionFromElementOffset(info.element, info.pos.x, info.pos.y, info.pos.z)
			setElementPosition(fx, x, y, z)
		end
	end
)