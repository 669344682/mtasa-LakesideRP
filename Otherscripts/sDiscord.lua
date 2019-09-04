--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local Webhook1URL="https://discordapp.com/api/webhooks/607990490830340114/hnY-LN4fyz6PzI-Ql4tDPKL8Inb8nJ9vWFpmMvO-vuoF7u75Ol_OhsXlwh6DCfOgK632"--Local-Chatlog
local Webhook2URL="https://discordapp.com/api/webhooks/607993207153754112/evEP6L8AyW9bV0ilvtfwgVuEOqzPT6PgEJkqEHYKbbaYAWu5vpIgGz-3FElh2a1GQH9v"--OOC-Chatlog
local Webhook9URL="https://discordapp.com/api/webhooks/610541344099926027/HIaHOAwwTegVsAYsMi7ZpK6eE9skeluKOYg4OSAU6yI_s2WvMnEBg7hrZjh9t1s61d94"--Updates/Changelogs
local Webhook10URL="https://discordapp.com/api/webhooks/607999323367800862/r2EzdI03vzfeMZD6AJ5W0OOgSqlkU6V_NjdgY90DgFolzvgecY4ghm6OiQpar9wHxWo_"--Restart

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