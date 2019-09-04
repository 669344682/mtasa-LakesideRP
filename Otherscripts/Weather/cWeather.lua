--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local Strength,Phase=0,0
local screenSource=dxCreateScreenSource(GLOBALscreenX,GLOBALscreenY)
EarthquakeShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Earthquake.fx")
EarthquakeShaderTarget=dxCreateRenderTarget(GLOBALscreenX,GLOBALscreenY,true)

function renderErdbeben()
	screenSource:update()
	EarthquakeShader:setValue("screenSource",screenSource)
	EarthquakeShader:setValue("Strength",Strength)
	dxSetRenderTarget(EarthquakeShaderTarget,true)
	dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,EarthquakeShader)
	dxSetRenderTarget()
	dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,EarthquakeShaderTarget)
end

function getShakeValue()
	Phase=Phase+65*math.pi/256
	if(Phase>=65*math.pi)then
		Phase=Phase-65*math.pi
	end
	return(math.sin(0.5*Phase)-0.5)/120
end

addEvent("trigger:earthquake",true)
addEventHandler("trigger:earthquake",root,function()
	Strength=12
	addEventHandler("onClientHUDRender",root,renderErdbeben)
	setTimer(function()
		Strength=0
		removeEventHandler("onClientHUDRender",root,renderErdbeben)
	end,15000,1)
end)


addEvent("refresh:weather",true)
addEventHandler("refresh:weather",root,function(id)
	setWeather(tonumber(id))
end)