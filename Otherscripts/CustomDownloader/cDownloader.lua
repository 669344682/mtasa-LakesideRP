--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Lars         ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local cdn={}

downloadMusicState=false

function downloadMusicP()
	downloadMusic=playSound(":"..settings.general.scriptname.."/Files/Sounds/Downloading.mp3",true)
	setSoundVolume(downloadMusic,1.2)
	downloadMusicState=true
end

function downloadMusic_Func()
	if(downloadMusicState~=false)then
		downloadMusic:stop()
		unbindKey("m","down",downloadMusic_Func)
		downloadMusicState=false
	end
end
bindKey("m","down",downloadMusic_Func)

function cdn.new()
    local self=setmetatable({},{__index=cdn})
    self.m_Counter=0
    self.m_Max=0
    self.m_Content={}
    self.m_Ready=false
	
	downloadMusicP()
	
    addEvent("cdn:receiveContent",true)
    addEvent("cdn:receiveFile",true)
    addEvent("cdn:onClientReady",true)
    addEventHandler("cdn:receiveContent",root,function(...)self:receiveContent(...)end)
    addEventHandler("cdn:receiveFile",root,function(...)self:receiveFile(...)end)
    self.m_fRender=function(...)self:renderMain(...)end
    self.m_ScreenX,self.m_ScreenY=guiGetScreenSize()
    self.m_Width,self.m_Heigth=320,40
    triggerServerEvent("cdn:requireContent",lp)
    return self
end

function cdn:receiveContent(list)
    local demanded={}
    for _,v in pairs(list)do
        if fileExists(v[1])then
            local file=fileOpen(v[1],true)
            if(file)then
                if(md5(fileRead(file,fileGetSize(file)))~=v[2])then
                    self.m_Max=self.m_Max+1
                    demanded[self.m_Max]=v[1]
                end
                fileClose(file)
            end
        else
            self.m_Max=self.m_Max+1
            demanded[self.m_Max]=v[1]
        end
    end
    if self.m_Max>0 then
        self.m_Content=demanded
        addEventHandler("onClientRender",root,self.m_fRender)
        triggerServerEvent("cdn:requireFiles",lp,self.m_Content)
    else
        self:setReady()
    end
end

function cdn:receiveFile(data,path,counter)
    local file=fileCreate(path)
    if(file)then
        fileWrite(file,data)
        fileClose(file)
        self.m_Counter=counter
        if(self.m_Counter==self.m_Max)then
            self:setReady()
        else
            triggerServerEvent("cdn:requestNextFile",lp,lp)
        end
    end
end

function cdn:setReady()
    triggerEvent("cdn:onClientReady",root,resourceRoot)
    removeEventHandler("onClientRender",root,self.m_fRender)
    self.m_Ready=true
	if(downloadMusicState~=false)then
		downloadMusic:stop()
	end
	unbindKey("m","down",downloadMusic_Func)
	downloadMusicState=false
end

function cdn:getReady()
    return self.m_Ready
end

function cdn:renderMain(delta)
	if(self.m_Counter>0)then
		showChat(false)
		fadeCamera(true)
		setElementDimension(lp,0)
		setElementInterior(lp,0)
		setCameraMatrix(1468.9,-919.3,100.2,1468.4,-918.4,99.9)
		
		dxDrawImage(920*Gsx,340*Gsy,100*Gsx,100*Gsy,":"..settings.general.scriptname.."/Files/Images/Logo.png",0,0,0,tocolor(255,255,255,200),false)
		dxDrawRectangle(780*Gsx,460*Gsy,360*Gsx,240*Gsy,tocolor(0,0,0,140),false)
		dxDrawRectangle(780*Gsx,460*Gsy,360*Gsx,20*Gsy,tocolor(0,0,0,140),false)
		dxDrawImage(780*Gsx,480*Gsy,360*Gsx,2*Gsy,":"..settings.general.scriptname.."/Files/Images/White.png",0,0,0,tocolor(150,0,0,200),false)
		dxDrawText("Downloading files...",1730*Gsx,460.5*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT3,"center",_,_,_,false,_,_)
		
		dxDrawText("Welcome to Lakeside RP.\nA new generation of Roleplay Server.",790*Gsx,490*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.10*Gsx,"default-bold","left",_,_,_,false,_,_)
		
		--dxDrawText("Total MB on this Server: 200",900*Gsx,640*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT3,"left",_,_,_,false,_,_)
		dxDrawText(self.m_Counter.."/"..self.m_Max.."",790*Gsx,640*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT3,"left",_,_,_,false,_,_)
		dxDrawRectangle(785*Gsx,665*Gsy,350*Gsx,30*Gsy,tocolor(0,0,0,140),false)
		dxDrawRectangle(785*Gsx,665*Gsy,self.m_Counter*350/self.m_Max*Gsx,30*Gsy,tocolor(150,0,0,140),false)
		
		if(downloadMusicState~=false)then
			dxDrawText("Press 'm' to stop the music",950*Gsx,1100*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),1.2*Gsx,"bankgothic","center","center",_,_,false,_,_)
		end
	end
end

addEventHandler("onClientResourceStart",resourceRoot,function()
    _G["CDN"]=cdn.new()
end)