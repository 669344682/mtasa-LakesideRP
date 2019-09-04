--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

companyVehiclesTable={}
companyNames={}
companyNames={[0]="",[1]="Mech&Tow",[2]="Drivingschool"}


for i=1,#companyNames do
	companyVehiclesTable[i]={}
end


function isMECHTOW(player)
	if(tonumber(syncGetElementData(player,"Company"))==1)then
		return true
	else
		return false
	end
end

function isDRIVINGSCHOOL(player)
	if(tonumber(syncGetElementData(player,"Company"))==2)then
		return true
	else
		return false
	end
end


function getCompanyMembersOnline(company)
	local counter=0
	for _,v in pairs(getElementsByType("player"))do
		if(syncGetElementData(v,company))then
			counter=counter+1
		end
	end
	return counter
end