--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function spawnPlayerAfterIntro()
	RegisterLogin_spawn(client)
	setCameraTarget(client,client)
	setElementFrozen(client,false)
	syncSetElementData(client,"IntroCompleted",1)
	setElementData(client,"ElementClicked",false)
end
addEvent("spawn:playerafterintro",true)
addEventHandler("spawn:playerafterintro",root,spawnPlayerAfterIntro)