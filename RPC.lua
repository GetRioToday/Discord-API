local cloneref = getgenv().cloneref or function(a) return a end
local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")

local function GetOpenPort(): number?
	if not WebSocket or not WebSocket.connect then
		return 6463
	end

	for Port = 6463, 6472 do
		local SocketAddr   = "127.0.0.1"
		local SocketPort   = tostring(Port)
		local SocketVer    = "1"
		local SocketFormat = "ws://" .. SocketAddr .. ":" .. SocketPort .. "/?v=" .. SocketVer .. "&encoding=json"

		local SocketConnection = nil
		local ConnectionThread = function()
			local _, Socket = pcall(WebSocket.connect, SocketFormat)
			SocketConnection = Socket
		end

		task.spawn(ConnectionThread)
		task.wait(1)

		if SocketConnection and type(SocketConnection) == "userdata" then
			local _, _ = pcall(function()
				return SocketConnection:Close()	-- indexing .Close(Self) is somehow broken on "Wave Executor", so namecall
			end)

			return Port
		end
	end
end

local function GetConnectionUrl(): string
	local Port = GetOpenPort()
	if Port then
		return "http://127.0.0.1:" .. tostring(Port) .. "/rpc?v=1"
	end
end

local function SendCommand(Url: string, Command: {[string]: string}): boolean
	local Payload = HttpService:JSONEncode(Command)
	local Headers = {
		["Content-Type"] = "application/json",
		["Origin"]       = "https://discord.com",
	}

	local Response = request({
		Url     = Url,
		Body    = Payload,
		Headers = Headers,
		Method  = "POST"
	})

	local _, Decoded = pcall(HttpService.JSONDecode, HttpService, Response.Body)

    local HasBody = Response.Body and #Response.Body > 1
    local HasJson = HasBody and Response.Body:sub(1, 1) == "{"
	local HasData = HasJson and Decoded ~= nil and Decoded['data'] ~= nil
	local NoError = HasData and Decoded['evt'] ~= "ERROR"

	return NoError
end

local function JoinServer(Url: string, InviteCode: string): boolean
	local Command = {
		["cmd"] = "INVITE_BROWSER",
		["nonce"] = HttpService:GenerateGUID(false),
		["args"] = {
			["code"] = InviteCode,
		}
	}

	return SendCommand(Url, Command)
end

return {
    GetConnectionUrl = GetConnectionUrl,
    SendCommand = SendCommand,
    JoinServer = JoinServer
}
