--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local isSound=false
local subTrackOnSoundDown=0.1
local subTrackOnSoundUp=0.1

addEvent("open:musicboxpanel",true)
addEventHandler("open:musicboxpanel",root,function()
	if(isLoggedin())then
        if(getElementData(lp,"ElementClicked")==false)then
            if(tonumber(getElementData(lp,"AdminLvL"))>=2)then
                setWindowData("add","cursor_clicked",false)
                dgsSetInputMode("no_binds")
                dgsSetInputMode("no_binds_when_editing")
                Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-340/2,500,340,settings.general.servername.." - Ghettoblaster",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
                dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,500,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=exports.blur_box:createBlurBox(GLOBALscreenX/2-500/2,GLOBALscreenY/2-340/2,500,340,255,255,255,255,Lakeside.Window[1])
				
				dgsCreateLabel(220,10,100,20,"Music uploader to streaming:\nkiwi6.com",false,Lakeside.Window[1])
				dgsCreateLabel(220,120,100,20,"Custom URL:",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(220,135,275,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[2]=dgsCreateButton(220,180,275,40,"play",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(220,225,275,40,"stop",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[4]=dgsCreateButton(360,270,135,40,"vol +",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[5]=dgsCreateButton(220,270,135,40,"vol -",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)

                Lakeside.Gridlist[1]=dgsCreateGridList(5,5,210,305,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
                streamGridlist=dgsGridListAddColumn(Lakeside.Gridlist[1]," Streams",0.9)
                
                for _,v in ipairs(globalTables["StreamNames"])do
					local row=dgsGridListAddRow(Lakeside.Gridlist[1])
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,streamGridlist,v,false,false)
                end
                
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
                
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[5],
                    function(btn,state)
                        if(btn=="left" and state=="up")then
							if(isSound~=false)then
								local toVol=math.round(getSoundVolume(Ghettoblaster[lp])-subTrackOnSoundDown,2)
								if(toVol>0.0)then
									triggerEvent("draw:infobox",lp,"info","Volume: "..math.floor(toVol*100).."%",8000)
									triggerServerEvent("change:premmusicboxvolume",lp,toVol)
								end
							end
                        end
                    end,
                false)
                addEventHandler("onDgsMouseClick",Lakeside.Button[4],
                    function(btn,state)
                        if(btn=="left" and state=="up")then
							if(isSound~=false)then
								local toVol=math.round(getSoundVolume(Ghettoblaster[lp])+subTrackOnSoundUp,2)
								if(toVol<=1.0)then
									triggerEvent("draw:infobox",lp,"info","Volume: "..math.floor(toVol*100).."%",8000)
									triggerServerEvent("change:premmusicboxvolume",lp,toVol) 
								end
							end
                        end
                    end,
                false)
                addEventHandler("onDgsMouseClick",Lakeside.Button[3],
                    function(btn,state)
                        if(btn=="left" and state=="up")then
                            triggerServerEvent("delete:premmusicbox",lp,lp)
							isSound=false
                        end
                    end,
                false)
                addEventHandler("onDgsMouseClick",Lakeside.Button[2],
                    function(btn,state)
                        if(btn=="left" and state=="down")then
                            local url=dgsGetText(Lakeside.Edit[1])
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("create:premmusicbox",lp,globalTables["StreamLinks"][clicked])
									isSound=true
								end
							else
								if(#url>=1)then
									triggerServerEvent("create:premmusicbox",lp,url)
									isSound=true
								end
                            end
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
	end
end)


addEvent("stop:premmusic",true)
addEventHandler("stop:premmusic",root,function(player)
	if(isElement(Ghettoblaster[player]))then
		Ghettoblaster[player]:destroy()
	end
end)

addEvent("play:premmusic",true)
addEventHandler("play:premmusic",root,function(player,link)
    local x,y,z=getElementPosition(player)
    if(player:getInterior()==0 and player:getDimension()==0)then
        if(isElement(Ghettoblaster[player]))then
            Ghettoblaster[player]:destroy()
        end
        Ghettoblaster[player]=playSound3D(link,x,y,z)
        attachElements(Ghettoblaster[player],player)
    end
end)


addEvent("change:premmusicboxvolumeC",true)
addEventHandler("change:premmusicboxvolumeC",root,function(vol) 
	if(isElement(Ghettoblaster[source]))then
		setSoundVolume(Ghettoblaster[source],tonumber(vol))
	end
end)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end