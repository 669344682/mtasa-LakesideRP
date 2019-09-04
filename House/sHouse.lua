--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

houses={}
houses["ID"]={}
houses["pickup"]={}

function houseCreation()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM houses"),-1)
	if(result and result[1])then
		local amount=#result
		for i=1,amount do
			local ID=tonumber(result[i]["ID"])
			local owner=result[i]["Owner"] or "none"
			local x=tonumber(result[i]["SpawnX"])
			local y=tonumber(result[i]["SpawnY"])
			local z=tonumber(result[i]["SpawnZ"])
			local cost=tonumber(result[i]["Price"])
			local int=tonumber(result[i]["Interior"])
			local cash=tonumber(result[i]["Cash"])
			local rent=tonumber(result[i]["Rent"])
			local state=result[i]["State"]
			createHouseNew(ID,x,y,z,owner,cost,int,cash,rent,state)
			
			--[[if(owner~="none")then
			outputChatBox("1")
				local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","LastLoginDate","userdata","Username",owner),-1)
				if(result)then
				outputChatBox("2")
					result=tonumber(result)
					if(result~=0)then
					outputChatBox("3")
						if((getMinTime()-result)/60/24>=60)then
						outputChatBox("4")
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","Owner",'none',"Owner",owner)
						end
					end
				end
			end]]
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,houseCreation)

function createHouse(player,cmd,price,int)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
		if(price and price~=nil and int and int~=nil)then
			local x,y,z=getElementPosition(player)
			local price=tonumber(price)
			local int=tonumber(int)
			
			local inserted,_,ID=dbPoll(dbQuery(handler,"INSERT INTO houses (Owner,Price,SpawnX,SpawnY,SpawnZ,Interior,Cash,Rent,State) VALUES (?,?,?,?,?,?,?)",'none',price,x,y,z,int,'0','0','false'),-1)
			if(not inserted)then
				triggerClientEvent(player,"draw:infobox",root,"error","[createHouse] Error executing the query",10000)
				return false
			else
				createHouseNew(ID,x,y,z,'none',price,int,'0','false')
				triggerClientEvent(player,"draw:infobox",root,"success","House: "..ID.." successfully created!",10000)
				return true
			end
		end
	end
end
addCommandHandler("newhouse",createHouse)
addCommandHandler("createhouse",createHouse)

function createHouseNew(ID,x,y,z,owner,cost,int,cash,rent,state)
	local img
	if(owner=="none")then
		img=1273
	elseif(owner~="none")then
		img=1272
	end
	
	local pickup=createPickup(x,y,z,3,img,200,0)
	addEventHandler("onPickupHit",pickup,housePickup)
	
	houses["ID"][pickup]=ID
	houses["pickup"][ID]=pickup
	if(owner~="0")then
		houses["pickup"][owner]=pickup
	end
	
	setElementData(pickup,"Owner",owner)
	setElementData(pickup,"State",state)
	setElementData(pickup,"Price",tonumber(cost))
	setElementData(pickup,"Interior",int)
	setElementData(pickup,"ID",ID)
	setElementData(pickup,"Cash",cash)
	setElementData(pickup,"Rent",rent)
	
	local intt=getElementData(pickup,"Interior")
	local int,intx,inty,intz=getInteriorData(intt)
	local outpickup=createPickup(intx,inty,intz,3,1273,200,0)
	setElementInterior(outpickup,int)
	setElementDimension(outpickup,getElementData(pickup,"ID"))
	addEventHandler("onPickupHit",outpickup,houseOutPickup)
end

function setHouseBought(pickup,owner)
	if(isElement(pickup))then
		local x,y,z=getElementPosition(pickup)
		local newpickup=createPickup(x,y,z,3,1272,200,0)
		
		local ID=houses["ID"][pickup]
		houses["ID"][newpickup]=ID
		houses["ID"][pickup]=nil
		
		houses["pickup"][ID]=newpickup
		houses["pickup"][owner]=newpickup
		
		setElementData(newpickup,"ID",ID)
		setElementData(newpickup,"Owner",owner)
		setElementData(newpickup,"State",getElementData(pickup,"State"))
		setElementData(newpickup,"Price",tonumber(getElementData(pickup,"Price")))
		setElementData(newpickup,"Interior",getElementData(pickup,"Interior"))
		setElementData(newpickup,"Cash",tonumber(getElementData(pickup,"Cash")))
		setElementData(newpickup,"Rent",tonumber(getElementData(pickup,"Rent")))
		
		if(isElement(houses["pickup"][owner]))then
			local x,y,z=getElementPosition(houses["pickup"][owner])
			houseBlip=createBlip(x,y,z,31,2,255,0,0,255,0,99999,getPlayerFromName(owner))
		end
		
		destroyElement(pickup)
		addEventHandler("onPickupHit",newpickup,housePickup)
	end
end
function setHouseSold(pickup,owner)
	if(isElement(pickup))then
		local x,y,z=getElementPosition(pickup)
		local newpickup=createPickup(x,y,z,3,1273,200,0)
		
		local ID=houses["ID"][pickup]
		houses["ID"][newpickup]=ID
		houses["ID"][pickup]=nil
		
		houses["pickup"][ID]=newpickup
		houses["pickup"][owner]=nil
		
		setElementData(newpickup,"ID",ID)
		setElementData(newpickup,"Owner","none")
		setElementData(newpickup,"State",getElementData(pickup,"State"))
		setElementData(newpickup,"Price",tonumber(getElementData(pickup,"Price")))
		setElementData(newpickup,"Interior",getElementData(pickup,"Interior"))
		setElementData(newpickup,"Cash",tonumber(getElementData(pickup,"Cash")))
		setElementData(newpickup,"Rent",tonumber(getElementData(pickup,"Rent")))
		
		destroyElement(pickup)
		addEventHandler("onPickupHit",newpickup,housePickup)
		
		if(isElement(houseBlip))then
			houseBlip:destroy()
		end
	end
end


function housePickup(player)
	if(getElementModel(source)==1273 or getElementModel(source)==1272)then
		if(getElementData(source,"Owner")=="none")then
			local x,y,z=getElementPosition(source)
			setElementData(player,"housex",x)
			setElementData(player,"housey",y)
			setElementData(player,"housez",z)
			setElementData(player,"house",source)
			if(getElementData(source,"Owner")~=getPlayerName(player))then
				triggerClientEvent(player,"open:housebuy",player)
			end
		elseif(getElementData(source,"Owner")~="none")then
			local x,y,z=getElementPosition(source)
			setElementData(player,"housex",x)
			setElementData(player,"housey",y)
			setElementData(player,"housez",z)
			setElementData(player,"house",source)
			if(getElementData(source,"Owner")==getPlayerName(player))then
				triggerClientEvent(player,"open:houseowner",player)
			else
				triggerClientEvent(player,"open:houserent",player)
			end
		end
	end
end
function houseOutPickup(player)
	if(getElementModel(source)==1273 or getElementModel(source)==1272)then
		executeCommandHandler("out",player)
	end
end

function rentHouse(player)
	local house=getElementData(player,"house")
	if(house)then
		local x1,y1,z1=getElementPosition(player)
		local x2,y2,z2=getElementPosition(house)
		local pname=getPlayerName(player)
		local rent=tonumber(getElementData(house,"Rent"))
		local cash=tonumber(getElementData(house,"Cash"))
		if(getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)<=5)then
			if(getElementData(house,"Rent")>=1 and getElementData(house,"Owner")~="none")then
				if(math.abs(syncGetElementData(player,"Housekey"))==0)then
					if(tonumber(syncGetElementData(player,"Money"))>=rent)then
						syncSetElementData(player,"Housekey",tonumber(getElementData(house,"ID"))*-1)
						syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-rent*-1)
						triggerClientEvent(player,"draw:infobox",root,"success","You have successfully rented!",8000)
						
						local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Cash","houses","ID",getElementDimension(player)),-1)
						if(result and result[1])then
							rent=tonumber(result[1]["Rent"])
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","Cash",cash+rent,"ID",getElementData(house,"ID"))
							setElementData(house,"Cash",cash+rent)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money! ($"..rent..")",8000)
					end
				elseif(syncGetElementData(player,"Housekey")<0)then
					triggerClientEvent(player,"draw:infobox",root,"error","You are already rented in a house!\nFirst unrent!",8000)
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You already own a house!\nFirst sell your house!",8000)
				end
			end
		end
	end
end
addEvent("rent:house",true)
addEventHandler("rent:house",root,rentHouse)
function unRentHouse(player)
	if(syncGetElementData(player,"Housekey")<0)then
		syncSetElementData(player,"Housekey",0)
		triggerClientEvent(player,"draw:infobox",root,"success","You have successfully unrented!",8000)
	end
end
addEvent("unrent:house",true)
addEventHandler("unrent:house",root,unRentHouse)


function inHouse(player)
	local house=getElementData(player,"house")
	if(isElement(house))then
		local px,py,pz=getElementPosition(player)
		local hx,hy,hz=getElementPosition(house)
		if(getDistanceBetweenPoints3D(px,py,pz,hx,hy,hz)<=3)then
		local hkey=syncGetElementData(player,"Housekey")
			if(getElementModel(house)==1273 or getElementModel(house)==1272 and getElementData(house,"Interior")>0)then
				if(getElementData(house,"State")=="true" or hkey==getElementData(house,"ID")or -hkey==getElementData(house,"ID"))then
					local intt=getElementData(house,"Interior")
					setElementData(player,"curIntIn",intt)
					local int,intx,inty,intz=getInteriorData(intt)
					local dim=getElementData(house,"ID")
					if(intt==0)then
						dim=0
					end
					fadeElementInterior(player,intx,inty,intz,0,int,dim,true)
				end
			end
		end
	end
end
addEvent("enter:house",true)
addEventHandler("enter:house",root,inHouse)
function outHouse(player)
	local dim=getElementDimension(player)
	local house=getElementData(player,"house")
	if(not isElement(house))then
		house=houses["pickup"][getElementDimension(player)]
	end
	if(isElement(house))then
		local i=getElementData(house,"Interior")
		local int,intx,inty,intz=getInteriorData(i)
		if(int)then
			local px,py,pz=getElementPosition(player)
			if(getDistanceBetweenPoints3D(px,py,pz,intx,inty,intz)<=3)then
				getElementData(player,"curIntIn",0)
				local dim=getElementDimension(player)
				local sx,sy,sz=getElementPosition(house)
				fadeElementInterior(player,sx,sy,sz,0,0,0,true)
			end
		end
	end
end
addCommandHandler("out",outHouse)

function lock_unlockHouse(player)
	local hkey=syncGetElementData(player,"Housekey")
	local house=getElementData(player,"house")
	if(hkey>0)then
		if(getElementData(houses["pickup"][hkey],"State")=="true")then
			setElementData(houses["pickup"][hkey],"State","false")
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","State","false","Owner",getPlayerName(player))
		else
			setElementData(houses["pickup"][hkey],"State","true")
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","State","true","Owner",getPlayerName(player))
		end
	end
end
addEvent("unlock_lock:house",true)
addEventHandler("unlock_lock:house",root,lock_unlockHouse)

function buyHouse(player,payment)
	if(payment=="bank" or payment=="bar")then
		if(getElementData(player,"housex")~=0)then
			if(getElementData(player,"housey")~=0)then
				local house=getElementData(player,"house")
				local x1,y1,z1=getElementPosition(player)
				local pname=getPlayerName(player)
				local x2=getElementData(player,"housex")
				local y2=getElementData(player,"housey")
				local z2=getElementData(player,"housez")
				if(getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)<3)then
					if(getElementData(house,"Owner")=="none")then
						if(tonumber(syncGetElementData(player,"Playtime"))>=180)then
							if(house~="none")then
								if(math.abs(syncGetElementData(player,"Housekey"))<=0)then
									local housecost=tonumber(getElementData(house,"Price"))
									if(payment=="bank")then
										if(syncGetElementData(player,"Bankmoney")>=housecost)then
											handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","Owner",pname,"ID",getElementData(house,"ID"))
											
											syncSetElementData(player,"Bankmoney",tonumber(syncGetElementData(player,"Bankmoney"))-housecost)
											syncSetElementData(player,"Housekey",getElementData(house,"ID"))
											setElementData(house,"Owner",pname)
											
											RegisterLogin_saveDatas(player)
											setHouseBought(house,pname)
										else
											triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money! ($"..housecost..")",8000)
										end
									elseif(payment=="bar")then
										if(syncGetElementData(player,"Money")>=housecost)then
											handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","Owner",pname,"ID",getElementData(house,"ID"))
											
											syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-housecost)
											syncSetElementData(player,"Housekey",getElementData(house,"ID"))
											setElementData(house,"Owner",pname)
											
											RegisterLogin_saveDatas(player)
											setHouseBought(house,pname)
										else
											triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money! ($"..housecost..")",8000)
										end
									end
								else
									triggerClientEvent(player,"draw:infobox",root,"error","You have already 1 House!",8000)
								end
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","You need at least 3 playhours!",8000)
						end
					end
				end
			end
		end
	end
end
addEvent("buy:house",true)
addEventHandler("buy:house",root,buyHouse)

function sellHouse(player)
	local ID=tonumber(syncGetElementData(player,"Housekey"))
	if(ID>0)then
		local house=houses["pickup"][ID]
		local pname=getPlayerName(player)
		
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","Owner","none","Owner",pname)
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Housekey",0,"Username",pname)
		syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+tonumber(syncGetElementData(house,"Price")))
		syncSetElementData(player,"Housekey",0)
		setHouseSold(house,pname)
	end
end
addEvent("sell:house",true)
addEventHandler("sell:house",root,sellHouse)

function lookInt(player,cmd,i)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
		local int,intx,inty,intz=getInteriorData(i)
		if(int)then
			setElementInterior(player,int,intx,inty,intz)
		end
	end
end
addCommandHandler("int",lookInt)













houseInteriors={}
houseInteriors["int"]={}
houseInteriors["x"]={}
houseInteriors["y"]={}
houseInteriors["z"]={}
local i=0
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=0,0,0,0
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=1,223.27027893066,1287.4304199219,1081.9130859375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=5,2233.8625488281,-1113.7662353516,1050.8828125
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=8,2365.224609375,-1135.1401367188,1050.875
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=11,2282.9448242188,-1139.9676513672,1050.8984375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=6,2196.373046875,-1204.3984375,1049.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=10,2270.2353515625,-1210.4715576172,1047.5625
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=6,2309.1716308594,-1212.6801757813,1049.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=1,2217.1474609375,-1076.2725830078,1050.484375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=2,2237.5483398438,-1081.1091308594,1049.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=9,2318.0712890625,-1026.2338867188,1050.2109375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=4,260.99948120117,1284.8186035156,1080.2578125
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=5,140.2495880127,1366.5075683594,1083.859375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=9,82.978126525879,1322.5451660156,1083.8662109375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=15,-284.0530090332,1471.0965576172,1084.375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=4,-260.75534057617,1456.6932373047,1084.3671875
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=8,-42.373157501221,1405.9846191406,1084.4296875
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=0,-68.801879882813,1351.6536865234,1080.2109375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=0,2333.0395507813,-1076.3621826172,1049.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=0,271.884979,306.631988,999.148437
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=3,291.282989,310.031982,999.148437
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=4,302.180999,300.72299,999.148437
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=5,322.197998,302.497985,999.148437
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=6,346.870025,309.259033,999.148437
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=3,513.882507,-11.269994,1001.565307
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=2,2454.717041,-1700.871582,1013.515197
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=1,2527.654052,-1679.388305,1015.515197
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=5,2350.339843,-1181.649902,1027.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=8,2807.619873,-1171.899902,1025.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=5,318.564971,1118.209960,1083.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=12,2324.419921,-1145.568359,1050.0234375
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=5,1298.8719482422,-796.77032470703,1083.6569824219
i=i+1
houseInteriors["int"][i],houseInteriors["x"][i],houseInteriors["y"][i],houseInteriors["z"][i]=0,-2170.5698242188,358.4921875,57.766414642334

function getInteriorData(int)
	int=tonumber(int)
	return houseInteriors["int"][int],houseInteriors["x"][int],houseInteriors["y"][int],houseInteriors["z"][int]
end

function isInUserHouse(player)
	if(getElementDimension(player)>=1)then
		local house=houses["pickup"][getElementDimension(player)]
		if(isElement(house))then
			local cint=syncGetElementData(house,"Interior")
			if(getElementInterior(player)==houseInteriors["int"][cint])then
				return true
			end
		end
	end
	return false
end