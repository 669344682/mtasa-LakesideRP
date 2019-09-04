--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

soundsTable={}
function playSound3D_ogg_Func(player,sound,x,y,z,loop,volume)
	local vehicle=getPedOccupiedVehicle(player)
	if (soundsTable[sound]~=nil and isElement(soundsTable[sound]))then
		stopSound(soundsTable[sound])
		soundsTable[sound]=nil
	end
	if (loop==nil)then loop=false end
	if (volume==nil)then volume=0.6 end
	soundsTable[sound]=playSound3D("Files/Sounds/"..sound..".ogg",x,y,z,loop)
	setSoundVolume(soundsTable[sound],volume)
	if vehicle then
		attachElements(soundsTable[sound],vehicle)
	end
end
addEvent("playSound3D_ogg",true)
addEventHandler("playSound3D_ogg",root,playSound3D_ogg_Func)

addEvent("playSound_ogg",true)
addEventHandler("playSound_ogg", root, function(sound, loop, volume)
	if (soundsTable[sound] ~= nil and isElement(soundsTable[sound])) then
		stopSound(soundsTable[sound])
		soundsTable[sound] = nil
	end
	
	if (loop == nil) then loop = false end
	if (volume == nil) then volume = 0.6 end
	
	soundsTable[sound] = playSound("Files/Sounds/"..sound..".ogg", loop)
	setSoundVolume(soundsTable[sound], volume)
end)

function playSound3D_mp3_Func(player,sound,x,y,z,loop,volume)
	local vehicle=getPedOccupiedVehicle(player)
	if (soundsTable[sound]~=nil and isElement(soundsTable[sound]))then
		stopSound(soundsTable[sound])
		soundsTable[sound]=nil
	end
	if (loop==nil)then loop=false end
	if (volume==nil)then volume=0.6 end
	soundsTable[sound]=playSound3D("Files/Sounds/"..sound..".mp3",x,y,z,loop)
	setSoundVolume(soundsTable[sound],volume)
	if(not vehicle)then
	
	else
		attachElements(soundsTable[sound],vehicle)
	end
end
addEvent("playSound3D_mp3",true)
addEventHandler("playSound3D_mp3",root,playSound3D_mp3_Func)
function playSound3D_mp3_not_attach_Func(sound,x,y,z,loop,volume)
	if (soundsTable[sound]~=nil and isElement(soundsTable[sound]))then
		stopSound(soundsTable[sound])
		soundsTable[sound]=nil
	end
	if (loop==nil)then loop=false end
	if (volume==nil)then volume=0.6 end
	soundsTable[sound]=playSound3D("Files/Sounds/"..sound..".mp3",x,y,z,loop)
	setSoundVolume(soundsTable[sound],volume)
end
addEvent("playSound3D_mp3_not_attach",true)
addEventHandler("playSound3D_mp3_not_attach",root,playSound3D_mp3_not_attach_Func)

addEvent("playSound_mp3", true)
addEventHandler("playSound_mp3", root, function(sound,endung, loop, volume)
	if (soundsTable[sound] ~= nil and isElement(soundsTable[sound])) then
		stopSound(soundsTable[sound])
		soundsTable[sound] = nil
	end
	
	if (loop == nil) then loop = false end
	if (volume == nil) then volume = 0.6 end
	
	soundsTable[sound] = playSound("Files/Sounds/"..sound.."."..endung.."", loop)
	setSoundVolume(soundsTable[sound], volume)
end)

--// Weaponsounds
addEventHandler("onClientPlayerWeaponFire",root,function(weapon)
    local x,y,z=getPedWeaponMuzzlePosition(source)
    local dim=getElementDimension(source)
	local int=getElementInterior(source)
	
	local weaponSoundTable={
		[22]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/COLT45.mp3",
		[24]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/DEAGLE.mp3",
		[25]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/SHOTGUN.mp3",
		[29]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/MP5.mp3",
		[30]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/AK-47.mp3",
		[31]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/M4.mp3",
		[33]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/RIFLE.mp3",
		[34]=":"..settings.general.scriptname.."/Files/Sounds/Weapon/SNIPER.mp3",
		[51]=nil,
	}
	if(weaponSoundTable[weapon])then
		local sound=playSound3D(weaponSoundTable[weapon],x,y,z,false)
		setSoundMaxDistance(sound,20)
		setSoundVolume(sound,1)
		setElementDimension(sound,dim)
		setElementInterior(sound,int)
		attachElements(sound,source)
	end
end)
addEventHandler("onClientPlayerWeaponFire",root,function(weapon,ammo,ammoInClip,hitX,hitY,hitZ,hitElement)
	if(weapon==23)then
		local dim=getElementDimension(source)
		local int=getElementInterior(source)
		
		local sound=playSound3D(":"..settings.general.scriptname.."/Files/Sounds/Weapon/TAZER.mp3",hitX,hitY,hitZ,false)
		setSoundVolume(sound,100)
		setSoundMaxDistance(sound,16)
		setElementDimension(sound,dim)
		setElementInterior(sound,int)
	end
end)

local blockedTasksTable={
	"TASK_SIMPLE_IN_AIR",
	"TASK_SIMPLE_JUMP",
	"TASK_SIMPLE_LAND",
	"TASK_SIMPLE_GO_TO_POINT",
	"TASK_SIMPLE_NAMED_ANIM",
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE",
	"TASK_SIMPLE_CAR_GET_IN",
	"TASK_SIMPLE_CLIMB",
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD",
	"TASK_SIMPLE_FALL",
	"TASK_SIMPLE_GET_UP",
}
local function reloadWeapon()
	local task=getPedSimplestTask(lp)
	if(getPedWeapon(lp)~=0)then
		if(isPedReloadingWeapon(lp)==false)then
			for _,v in ipairs(blockedTasksTable)do
				if(task==v)then
					return
				end
			end
			
			triggerServerEvent("reload:weapon",resourceRoot)
			
			local playerWeapon=getPedWeapon(lp)
			local x,y,z=getElementPosition(lp)
			local sound=playSound3D(":"..settings.general.scriptname.."/Files/Sounds/Weapon/Reload/"..playerWeapon..".wav",x,y,z)
			setSoundMaxDistance(sound,5)
			attachElements(sound,lp)
			setSoundVolume(sound,1)
		end
	end
end

addCommandHandler("reloadweapon",function()
	setTimer(function()
		if(getPedControlState(lp,"aim_weapon"))then
			return
		end
		if(getPedTotalAmmo(lp)-getPedAmmoInClip(lp)<=0)then
			outputChatBox("No ammo left to reload!")
			return
		end
		
		reloadWeapon()
	end,50,1)
end)
bindKey("r","down","reloadweapon")

addEventHandler("onClientPlayerWeaponFire",lp,function(weapon)
	local x,y,z=getPedBonePosition(lp,26)
	if weapon==22 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==24 then
		createExplosion(x,y,z+10,12,false,0.2,false)
	elseif weapon==25 then
		createExplosion(x,y,z+10,12,false,0.4,false)
	elseif weapon==26 then
		createExplosion(x,y,z+10,12,false,0.5,false)
	elseif weapon==27 then
		createExplosion(x,y,z+10,12,false,0.3,false)
	elseif weapon==28 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==29 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==30 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==34 then
		createExplosion(x,y,z+40,40,false,1.0,false)
	elseif weapon==31 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==33 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==22 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==28 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==32 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==38 then
		createExplosion(x,y,z+10,12,false,0.4,false)
	elseif weapon==35 then
		createExplosion(x,y,z+100,50,false,50,false)
	end
end)


function disableSounds()
	setAmbientSoundEnabled("gunfire",false)
end
addEventHandler("onClientResourceStart",root,disableSounds)








function seatbeltSoundStart_Func()
	if(isPedInVehicle(lp))then
		if(getElementData(lp,"seatbelt")==false)then
			if(isElement(seatbeltsound))then
				stopSound(seatbeltsound)
			end
			seatbeltsound=playSound("Files/Sounds/Engaged.mp3",true)
			setSoundVolume(seatbeltsound,2)
		end
	end
end
addEvent("start:seatbeltsound",true)
addEventHandler("start:seatbeltsound",root,seatbeltSoundStart_Func)
function seatbeltClickSoundStart_Func()
	if(isPedInVehicle(lp)and(not isPedDead(lp)))then
		if(getElementData(lp,"seatbelt")==true)then
			if(isElement(seatbeltsoundclick))then
				stopSound(seatbeltsoundclick)
			end
			seatbeltsoundclick=playSound("Files/Sounds/EngagedClick.mp3",false)
			setSoundVolume(seatbeltsoundclick,2)
		end
	end
end
addEvent("start:seatbeltclicksound",true)
addEventHandler("start:seatbeltclicksound",root,seatbeltClickSoundStart_Func)

function seatbeltSoundStop_Func()
	if(isElement(seatbeltsound))then
		stopSound(seatbeltsound)
	end
end
addEvent("stop:seatbeltsound",true)
addEventHandler("stop:seatbeltsound",root,seatbeltSoundStop_Func)



function seatbeltClickSoundStart_Func()
	if(isPedInVehicle(lp)and(not isPedDead(lp)))then
		if(isElement(refuelsound))then
			stopSound(refuelsound)
		end
		refuelsound=playSound("Files/Sounds/Fuel.mp3",true)
		setSoundVolume(refuelsound,1)
	end
end
addEvent("start:refuelsound",true)
addEventHandler("start:refuelsound",root,seatbeltClickSoundStart_Func)

function seatbeltClickSoundStart_Func()
	if(isPedInVehicle(lp)and(not isPedDead(lp)))then
		if(isElement(refuelsound))then
			stopSound(refuelsound)
		end
	end
end
addEvent("stop:refuelsound",true)
addEventHandler("stop:refuelsound",root,seatbeltClickSoundStart_Func)