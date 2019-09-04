--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("load:gangtagtextures",true)
addEventHandler("load:gangtagtextures",root,function(object,id)
	local MyShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Shader.fx")
	local MyTexture=dxCreateTexture(":"..settings.general.scriptname.."/Files/Shaders/Gangtags/"..id..".png")
	dxSetShaderValue(MyShader,"Tex0",MyTexture)
	engineApplyShaderToWorldTexture(MyShader,"cj_don_post_2",object)
end)