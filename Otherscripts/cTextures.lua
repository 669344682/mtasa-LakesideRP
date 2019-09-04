--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--


--[[
local FROMTO={
	{"Files/Textures/Pickaxe.dff","Files/Textures/Pickaxe"},
}

--fetchRemote( "http://luac.mtasa.com/?compile=1&debug=0&obfuscate=3", function(data) fileSave(TO,data) end, fileLoad(FROM), true )

for i=1,#FROMTO do
	fetchRemote("http://luac.mtasa.com/?compile=1&debug=0&obfuscate=3",function(data)
	fileWrite(FROMTO[i][2],data)
	--fileSave(FROMTO[i][2],data)
	end,
	fileClose(FROMTO[i][1]),
	true)
end]]



local modsTableCDN={
--{txdpfad="Files/Textures/Hospital.txd",dffpfad="Files/Textures/Hospital.dff",colpfad="Files/Textures/Hospital.col",modelid=5708},
{txdpfad="Files/Textures/Stopper.txd",dffpfad="Files/Textures/Stopper.dff",colpfad="Files/Textures/Stopper.col",modelid=3900},
{txdpfad="Files/Textures/Speedcamera.txd",dffpfad="Files/Textures/Speedcamera.dff",colpfad="Files/Textures/Speedcamera.col",modelid=3890},
{txdpfad="Files/Textures/Mall/LSMall.txd",dffpfad="Files/Textures/Mall/LSMall.dff",colpfad="Files/Textures/Mall/LSMall.col",modelid=2957},
{txdpfad="Files/Textures/Mall/LSMallW.txd",dffpfad="Files/Textures/Mall/LSMallW.dff",colpfad="Files/Textures/Mall/LSMallW.col",modelid=6130},
{txdpfad="Files/Textures/Mall/LSMallA.txd",dffpfad="Files/Textures/Mall/LSMallA.dff",colpfad=nil,modelid=3946},
{txdpfad="Files/Textures/Pickaxe.txd",dffpfad="Files/Textures/Pickaxe.dff",colpfad=nil,modelid=336},
}
local modsTableFile={
{txdpfad="Files/Textures/Skins/263.txd",dffpfad="Files/Textures/Skins/263.dff",colpfad=nil,modelid=263},
{txdpfad="Files/Textures/Skins/256.txd",dffpfad="Files/Textures/Skins/256.dff",colpfad=nil,modelid=256},
{txdpfad="Files/Textures/Skins/79.txd",dffpfad="Files/Textures/Skins/79.dff",colpfad=nil,modelid=79},
}

addEvent("cdn:onClientReady",true)
addEventHandler("cdn:onClientReady",resourceRoot,function()
	for i=1,#modsTableCDN do
		modelid=modsTableCDN[i].modelid
		if(modsTableCDN[i].txdpfad~=nil)then
			txd=engineLoadTXD(modsTableCDN[i].txdpfad)
			engineImportTXD(txd,modelid)
		end
		if(modsTableCDN[i].dffpfad~=nil)then
			dff=engineLoadDFF(modsTableCDN[i].dffpfad,modelid)
			engineReplaceModel(dff,modelid)
		end
		if(modsTableCDN[i].colpfad~=nil)then
			col=engineLoadCOL(modsTableCDN[i].colpfad,modelid)
			engineReplaceCOL(col,modelid)
		end
	end
end)
addEventHandler("onClientResourceStart",resourceRoot,function()
	for i=1,#modsTableFile do
		modelid=modsTableFile[i].modelid
		if(modsTableFile[i].txdpfad~=nil)then
			txd=engineLoadTXD(modsTableFile[i].txdpfad)
			engineImportTXD(txd,modelid)
		end
		if(modsTableFile[i].dffpfad~=nil)then
			dff=engineLoadDFF(modsTableFile[i].dffpfad,modelid)
			engineReplaceModel(dff,modelid)
		end
		if(modsTableFile[i].colpfad~=nil)then
			col=engineLoadCOL(modsTableFile[i].colpfad,modelid)
			engineReplaceCOL(col,modelid)
		end
	end
	for i,v in ipairs(getElementsByType("object"))do
		if(getElementModel(v)==16118)then
			local Texture1=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
			local Texture2=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Moon.png")
			dxSetShaderValue(Texture1,"Tex",Texture2)
			engineApplyShaderToWorldTexture(Texture1,"des_redrock1",v)
			engineApplyShaderToWorldTexture(Texture1,"des_redrock2",v)
		end
		if(getElementModel(v)==6959)then
			local Texture1=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
			local Texture2=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Moon.png")
			dxSetShaderValue(Texture1,"Tex",Texture2)
			engineApplyShaderToWorldTexture(Texture1,"greyground256128",v)
		end
	end
end)

local Texture1={}
local Texture2={}
addEventHandler("onClientResourceStart",resourceRoot,function()
	Texture1[1]=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
	Texture2[1]=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/FBI-Logo.png")
	dxSetShaderValue(Texture1[1],"Tex",Texture2[1])
	engineApplyShaderToWorldTexture(Texture1[1],"ws_airsecurity")
	
	Texture1[2]=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
	Texture2[2]=dxCreateTexture(":"..settings.general.scriptname.."/Files/Images/Transparent.png")
	dxSetShaderValue(Texture1[2],"Tex",Texture2[2])
	engineApplyShaderToWorldTexture(Texture1[2],"shad_ped")
end)

addEventHandler("onClientResourceStart",resourceRoot,function()
	for i,v in ipairs(getElementsByType("vehicle"))do
		if(getElementData(v,"texture:sapd")==1)then
			local Texture1=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
			local Texture2=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Police.png")
			dxSetShaderValue(Texture1,"Tex",Texture2)
			engineApplyShaderToWorldTexture(Texture1,"vehiclepoldecals128",v)
		end
		if(getElementData(v,"texture:patrol")==1)then
			local Texture1=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
			local Texture2=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/PolicePatrol.png")
			dxSetShaderValue(Texture1,"Tex",Texture2)
			engineApplyShaderToWorldTexture(Texture1,"vehiclepoldecals128",v)
		end
		if(getElementData(v,"texture:fbi")==1)then
			local Texture1=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
			local Texture2=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/FBI.png")
			dxSetShaderValue(Texture1,"Tex",Texture2)
			engineApplyShaderToWorldTexture(Texture1,"vehiclepoldecals128",v)
		end
		if(getElementData(v,"texture:swat")==1)then
			local Texture1=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Textures.fx")
			local Texture2=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Swat.png")
			dxSetShaderValue(Texture1,"Tex",Texture2)
			engineApplyShaderToWorldTexture(Texture1,"vehiclepoldecals128",v)
		end
	end
end)


addEventHandler("onClientResourceStart",resourceRoot,function()
	engineSetModelLODDistance(3890,100)
	engineSetModelLODDistance(3900,100)
	engineSetModelLODDistance(2957,100)
	engineSetModelLODDistance(6130,100)
	engineSetModelLODDistance(3946,100)
	engineSetModelLODDistance(1698,100)
	engineSetModelLODDistance(11293,100)
	engineSetModelLODDistance(3881,100)
	engineSetModelLODDistance(1676,100)
	engineSetModelLODDistance(967,100)
	engineSetModelLODDistance(966,100)
	engineSetModelLODDistance(983,100)
	engineSetModelLODDistance(1237,100)
end)