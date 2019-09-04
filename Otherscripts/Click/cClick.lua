--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function getCursor()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			showCursor(not(isCursorShowing()))
		end
	end
end
bindKey("m","down",getCursor)
addCommandHandler("cursor",getCursor)