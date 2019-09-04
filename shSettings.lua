--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

settings={
	general={
		servername="Lakeside",
		scriptname="Lakeside",
		scriptversion="4.1",
		
		discordurl="https://discord.gg/wmprdMA",
		
		christmas=false,
		
		guimaincolor=tocolor(0,0,0,200),
		guilinecolor=tocolor(150,0,0,200),
	},
	admin={
		levelnames={
			[5]="Project Leader",
			[4]="Administrator",
			[3]="Moderator",
			[2]="Supporter",
			[1]="Trial-Supporter",
			[0]="Player",
		},
		levelRGBcolors={
			[5]={255,120,120},
			[4]={200,0,0},
			[3]={0,147,255},
			[2]={255,250,125},
			[1]={255,76,238},
			[0]={255,255,255},
		},
		colorToHASH={
			[5]="#ff7878",
			[4]="#c80000",
			[3]="#0093ff",
			[2]="#fffa7d",
			[1]="#ff4cee",
			[0]="#ffffff",
		},
	},
	faction={
		ranknames={
			levelnames={
				[0]="Civilian",
				[1]="L.S.P.D",
				[2]="F.B.I",
				[3]="Grove",
				[4]="Ballas",
			},
			[1]={
				[0]="Police Officer",
				[1]="Detective",
				[2]="Sergeant",
				[3]="Lieutenant",
				[4]="Captain",
				[5]="Chief of police",
			},
			[2]={
				[0]="Trainee",
				[1]="Agent",
				[2]="Special Agent Trainee",
				[3]="Special Agent",
				[4]="Assistant Director",
				[5]="Director",
			},
			[3]={
				[0]="Newbie",
				[1]="Dealer",
				[2]="Bro",
				[3]="Rider",
				[4]="BigSmoke",
				[5]="Sweet",
			},
			[4]={
				[0]="Newbie",
				[1]="Dealer",
				[2]="Bro",
				[3]="Hustler",
				[4]="Thug",
				[5]="Banger",
			},
		},
		weaponprices={
			colt45=150,
			deagle=280,
			mp5=400,
			ak=750,
			m4=850,
			sniper=1200,
			ammo={
				colt45=20,
				deagle=50,
				mp5=45,
				ak=70,
				m4=80,
				sniper=120,
			},
		},
	},
	company={
		ranknames={
			levelnames={
				[0]="-",
				[1]="Mech&Tow",
				[2]="Drivingschool",
			},
			[1]={
				[0]="",
				[1]="",
				[2]="",
				[3]="",
				[4]="",
				[5]="",
			},
			[2]={
				[0]="",
				[1]="",
				[2]="",
				[3]="",
				[4]="",
				[5]="",
				carlicensePrice=3200,
				bikelicensePrice=1250,
			},
		},
	},
	vehicle={
		literprice=5,
		
		rentPrice=100,
	},
	level={
		job={
			[0]=150,
			[1]=300,
			[2]=550,
			[3]=750,
			[4]=1050,
			[5]=1300,
			[6]=1550,
			[7]=1800,
			[8]=2050,
			[9]=2800,
			[10]=1,
		},
	},
	shop={
		burgerPrice=15,
		pizzaPrice=15,
		colaPrice=9,
		cigarettePrice=4,
		
		appleseedPrice=12,
		repairkitPrice=5000,
		
		moonstonePrice=450,
		pickaxePrice=200,
		
		mobilephonePrice=500,
		
		fishingrodPrice=170,
		fishinghookPrice=15,
		baitsPrice=5,
		troutPrice=11,
		
		farmItems={
			applePrice=6,
			appleSeedPrice=62,
			weedSeedPrice=25,
		},
		
		weaponprices={
			colt45=250,
			deagle=320,
			mp5=480,
			ak=900,
			m4=1100,
			ammo={
				colt45=40,
				deagle=70,
				mp5=55,
				ak=85,
				m4=100,
			},
		},
	},
}
lastHitTimer=2*60*1000
lastHitMarkerTimer=30*1000


function isLoggedin(player)
	if(not player)then
		player=lp
	end
	if(isElement(player))then
		return tonumber(getElementData(player,"Loggedin"))==1
	end
end
function getAdminLevel(player)
	local alevel=tonumber(getElementData(player,"AdminLvL"))
	if(not alevel or alevel==nil)then
		return 0
	end
	if(isElement(player))then
		return tonumber(alevel)
	end
end

function getElementSpeed(element,unit)
	if(unit==nil)then
		unit=0
	end
	if(isElement(element))then
		local x,y,z=getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit=="1")then
			return(x^2+y^2+z^2)^0.5*100
		else
			return(x^2+y^2+z^2)^0.5*1.91*100
		end
	else
		return false
	end
end
function setElementSpeed(element,unit,speed)
	if(unit==nil)then unit=0 end
	if(speed==nil)then speed=0 end
	speed=tonumber(speed)
	local acSpeed=getElementSpeed(element,unit)
	if(acSpeed~=false)then
		local diff=speed/acSpeed
		local x,y,z=getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
	return false
end

function getSecTime ( duration )
	if not duration then
		duration = 0
	end
	local time = getRealTime()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	
	local total = year * 365 * 24 * 60 + day * 24 * 60 + ( hour + duration ) * 60 + minute
	
	return total
end

function getMinTime ()
	return getSecTime ( 0 )
end

function getSecondTime ( duration )
	local time = getRealTime ()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	local seconds = time.second
	
	local total = 0
	total = year * 365 * 24 * 60 * 60
	total = total + day * 24 * 60 * 60
	total = total + hour * 60 * 60
	total = total + minute * 60
	total = total + seconds + duration
	
	return total
end

function getTBanSecTime(duration)
	return getSecTime(duration)
end


function sortArray(tbl)
	local array = {}
	local size = table.size ( tbl )
	local curBiggest = 0
	local curID = 0
	
	for k = 1, size do
		for i = 1, size do
			if tbl[i] > curBiggest then
				curBiggest = tbl[i]
				curID = i
			end
		end
		array[k] = curBiggest
		tbl[curID] = 0
		curBiggest = 0
	end
	
	return array
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do
		length = length + 1
	end
    return length
end

function table.reverse(t) 
    local reversedTable = {} 
    local itemCount = #t  
    for k, v in ipairs(t) do 
        reversedTable[itemCount + 1 - k] = v  
    end 
    return reversedTable  
end 

function tableMerge(t1, t2)
    for k,v in pairs(t2) do
    	if type(v) == "table" then
    		if type(t1[k] or false) == "table" then
    			tableMerge(t1[k] or {}, t2[k] or {})
    		else
    			t1[k] = v
    		end
    	else
    		t1[k] = v
    	end
    end
    return t1
end

if (not lp) then
	function infoShow(player, typ, msg, args)
		triggerClientEvent(player, "infoShow", player, typ, msg, args)
	end
end