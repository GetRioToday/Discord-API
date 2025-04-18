local RPC = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/GetRioToday/Discord-API/refs/heads/main/RPC.lua"))()

local Connection = RPC.GetConnectionUrl()
if Connection then
	local Success = RPC.JoinServer(Connection, "roblox") -- "roblox" is the "https://discord.gg/roblox" vanity server code
	print("Displayed Server Invite:", Success)
end
