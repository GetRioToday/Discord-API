# Discord-API
A roblox luau script that let's you send commands to the local Discord RPC server.

# What is this?
This script let's you send commands to the locally hosted [Discord RPC server](https://discord.com/developers/docs/topics/rpc).

It was primarily tested with the INVITE_BROWSER command to open an invite in the Discord app, which works by impersonateing the discord.com origin, since Discord performs [origin checking on RPC requests.](https://discord.com/developers/docs/topics/rpc#connecting)

To use this, your environment must support the [Unified Naming Convention](https://github.com/unified-naming-convention/NamingStandard/), specifically the **request** function and **WebSocket** library.

Environments lacking a functional WebSocket library won't be able to use the port scanning feature, which identifies the port selected by the RPC server. Instead, they will revert to the default RPC port of 6463.
