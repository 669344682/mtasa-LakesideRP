--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onPlayerClick",root,function(btn,state,elem)
	if(isLoggedin(source))then
		if(not isPedDead(source))then
			if(state=="down" and btn=="left")then
				if(elem and isElement(elem))then
					if(getElementData(source,"ElementClicked")==false)then
						local x,y,z=getElementPosition(source)
						local ox,oy,oz=getElementPosition(elem)
						local model=getElementModel(elem)
						if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3.5)then
							if(getElementDimension(source)==getElementDimension(elem))then
								if(getElementType(elem)=="ped")then
									if(getElementData(elem,"scooterPED")==true)then
										triggerClientEvent(source,"open:vehiclerental",source)
									elseif(getElementData(elem,"townhallPED")==true)then
										triggerClientEvent(source,"open:townhall",source)
									elseif(getElementData(elem,"townhallPinPED")==true)then
										triggerClientEvent(source,"open:townhallpin",source)
									elseif(getElementData(elem,"tankstationPED")==true)then
										triggerClientEvent(source,"open:tankstation",source)
									elseif(getElementData(elem,"mechtow:buyoutcarPED")==true)then
										openTowedVehpanel(source)
									--//Job peds
									elseif(getElementData(elem,"jobPED")==true)then
										triggerClientEvent(source,"open:job",source)
									elseif(getElementData(elem,"job:busPED")==true)then
										triggerClientEvent(source,"open:busjob",source)
									elseif(getElementData(elem,"job:pizzaPED")==true)then
										triggerClientEvent(source,"open:pizzajob",source)
									elseif(getElementData(elem,"job:taxiPED")==true)then
										triggerClientEvent(source,"open:taxijob",source)
									--//Christmas peds
									elseif(getElementData(elem,"Christmas1PED")==true)then
										triggerClientEvent(source,"open:christmas1_UI",source)
									--//Shop peds
									elseif(getElementData(elem,"shop:burgershotPED")==true)then
										triggerClientEvent(source,"open:burgershotUI",source)
									elseif(getElementData(elem,"shop:pizzastackPED")==true)then
										triggerClientEvent(source,"open:pizzastackUI",source)
									elseif(getElementData(elem,"shop:chestdealerPED")==true)then
										triggerClientEvent(source,"open:chestdealer",source)
									elseif(getElementData(elem,"shop:moonstonedealerPED")==true)then
										triggerClientEvent(source,"open:moonstonedealer",source)
									elseif(getElementData(elem,"shop:fishingPED")==true)then
										triggerClientEvent(source,"open:fishingUI",source)
									elseif(getElementData(elem,"shop:farmPED")==true)then
										triggerClientEvent(source,"open:farmsellUI",source)
									elseif(getElementData(elem,"shop:electroPED")==true)then
										triggerClientEvent(source,"open:electroUI",source)
									elseif(getElementData(elem,"shop:normalPED")==true)then
										triggerClientEvent(source,"open:normalshopUI",source)
									elseif(getElementData(elem,"shop:ammunationPED")==true)then
										triggerClientEvent(source,"open:ammunationshopUI",source)
									elseif(getElementData(elem,"shop:skinPED")==true)then
										if(syncGetElementData(source,"DrivingschoolDuty")==false and syncGetElementData(source,"MechTowDuty")==false and syncGetElementData(source,"CopDuty")==false)then
											triggerClientEvent(source,"open:skinshopUI",source)
										else
											triggerClientEvent(source,"draw:infobox",root,"error","First go off duty!",8000)
										end
									elseif(getElementData(elem,"shop:factionPED")==true)then
										if(isEVIL(source))then
											triggerClientEvent(source,"shop:gangUI",source)
										end
									elseif(getElementData(elem,"shop:gangcardealerPED")==true)then
										if(isEVIL(source))then
											triggerClientEvent(source,"shop:gangcardealerUI",source)
										end
										
									elseif(getElementData(elem,"dealer:buyweedPED")==true)then
										triggerClientEvent(source,"open:buyweedpedUI",source,weedBuyPrice,weedBuyAmount)
									elseif(getElementData(elem,"dealer:sellweedPED")==true)then
										triggerClientEvent(source,"open:sellweedpedUI",source,weedSellPrice,weedSellAmount)
									end
								elseif(getElementType(elem)=="player")then
									if(tonumber(getElementData(elem,"Wanteds"))>=1)then
										if(isTimer(TazerTimer[elem])and isSTATE(source))then
											if(isPedInVehicle(source)and getPedOccupiedVehicleSeat(source)==0)then
												local veh=getPedOccupiedVehicle(source)
												for i=1,3 do
													if(getVehicleOccupant(veh,i)==false)then
														if(isTimer(TazerTimer[elem]))then
															killTimer(TazerTimer[elem])
														end
														toggleAllControls(elem,false,true,true) 
														warpPedIntoVehicle(elem,veh,i)
														takeAllWeapons(elem)
														break
													end
												end
											end
										end
									end
									if(not isTimer(TazerTimer[elem]))then
										if(elem~=source)then
											setElementData(source,"set:clickedplayer",getPlayerName(elem))
											triggerClientEvent(source,"open:interactionUI",source)
										end
									end
								elseif(getElementType(elem)=="object")then
									if(getElementData(elem,"PlantID"))then
										local plantID=getElementData(elem,"PlantID")
										local plantIDTime=getData("userplants","ID",plantID,"Time")
										local rdm=math.random(8,11)
										if(plantIDTime~=0 and plantIDTime-getSecTime(0)<=0 or isSTATE(source)and syncGetElementData(source,"CopDuty")==true or tonumber(syncGetElementData(source,"AdminLvL"))>=3)then
											local model=getElementModel(elem)
											syncSetElementData(source,plantItemID[model],syncGetElementData(source,plantItemID[model])+rdm)
											triggerClientEvent(source,"draw:infobox",root,"info","You harvested the plant. (x"..rdm..")",8000)
											dbExec(handler,"DELETE FROM ?? WHERE ??=?","userplants","ID",plantID)
											destroyElement(elem)
										else
											triggerClientEvent(source,"draw:infobox",root,"error","This plant can not be harvested yet!",8000)
											--triggerClientEvent(source,"draw:infobox",root,"error","This plant needs "..math.floor(((plantIDTime-getSecTime(0))/60)*100)/100 .." hours to grow until it can be harvested!",8000)
										end
									end
									if(model==2977 and getElementData(elem,"weaponbox")==true)then
										openWeaponbox(source)
									elseif(model==2332 and getElementData(elem,"factiondepot")==true)then
										if(tonumber(syncGetElementData(source,"Faction"))>=1)then
											loadDepotState(source)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)