local RPC = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/GetRioToday/Discord-API/refs/heads/main/RPC.lua"))()

local Connection = RPC.GetConnectionUrl()
if Connection then
	-- Join server example which wraps SendCommand()
	local Success = RPC.JoinServer(Connection, "roblox") -- "roblox" is the "https://discord.gg/roblox" vanity server code
	print("Displayed Server Invite:", Success)

	-- Send custom command example using the INVITE_BROWSER command (for more commands and their arguments, see: https://discord.com/developers/docs/topics/rpc#commands-and-events)
	local Command = {
		["cmd"] = "INVITE_BROWSER",
		["nonce"] = game:GetService("HttpService"):GenerateGUID(false),
		["args"] = {
			["code"] = "roblox",
		}
	}

	local Success = SendCommand(Connection, Command)
	print("Custom Command Result:", Success)
end
