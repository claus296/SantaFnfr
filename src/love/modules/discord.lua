discordRPC.initialize(appId, true)
function updatePres(state, details)
    if useDiscordRPC then 
		local now = os.time(os.date("*t"))
		presence = {
			state = state,
			details = details,
			largeImageKey = "logo",
			startTimestamp = now,
		}
		nextPresenceUpdate = 0
	end
end