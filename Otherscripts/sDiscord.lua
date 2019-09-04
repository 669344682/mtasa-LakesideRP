--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local Webhook1URL=""--Local-Chatlog
local Webhook2URL=""--OOC-Chatlog
local Webhook9URL=""--Updates/Changelogs
local Webhook10URL=""--Restart

function sendDiscordMessage(typ,msg)
	sendOptions={
		formFields={
			content=" "..msg..""
		},
	}
	if(typ==1)then--Local-Chatlog
		fetchRemote(Webhook1URL,sendOptions,callback)
	elseif(typ==2)then--Local-Chatlog
		fetchRemote(Webhook2URL,sendOptions,callback)
	elseif(typ==9)then
		fetchRemote(Webhook9URL,sendOptions,callback)
	elseif(typ==10)then
		fetchRemote(Webhook10URL,sendOptions,callback)
	end
end
function callback(msg)
end