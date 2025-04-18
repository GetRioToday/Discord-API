# Discord-API
A roblox luau script that let's you send commands to the local Discord RPC server.

# What is this?
This script let's you send commands to the locally hosted [Discord RPC server](https://discord.com/developers/docs/topics/rpc).

It was primarily tested with the INVITE_BROWSER command to open an invite in the Discord app, which works by impersonating the discord.com origin, since Discord performs [origin checking on RPC requests.](https://discord.com/developers/docs/topics/rpc#connecting)

To use this, your environment must support the [Unified Naming Convention](https://github.com/unified-naming-convention/NamingStandard/), specifically the **request** function and **WebSocket** library.

Environments lacking a functional WebSocket library won't be able to use the port scanning feature, which identifies the port selected by the RPC server. Instead, they will revert to the default RPC port of 6463.

# Lua RPC Documentation

## Functions

### `GetConnectionUrl() : string?`
Performs a port scan in the range of port **6463** to port **6472**, if the WebSocket library is available. If the port scan yields no results, the return value will be `nil`, as it is presumed the Discord app is not running. 

**Returns:**  
A string like `http://127.0.0.1:6463/rpc?v=1` if successful, where `6463` is replaced with the current port the RPC server is using.

---

### `SendCommand(Url: string, Command: {[string]: string}) : boolean`
Sends a custom command to the RPC server. You can find all documented commands [right here.](https://discord.com/developers/docs/topics/rpc#commands-and-events)

**Returns:**  
- `true` if the message was sent to and received by the RPC server without a reported error.  
- `false` otherwise.

> ⚠️ **Note:** We only tested it with the `INVITE_BROWSER` command, which is undocumented; but theoretically, any documented command should work.

**Parameters:**  
- **Url:** The URL that represents an address the RPC server is currently bound to (e.g., `http://127.0.0.1:6463/rpc?v=1`).  
- **Command:** A Lua dictionary representing the data to be sent to the RPC server. Internally, it will be JSON encoded.

---

### `JoinServer(Url: string, InviteCode: string) : boolean`
Wraps the `SendCommand()` function to send a join server request to the user's Discord app. 

**Returns:**  
- `true` on success.  
- `false` on error.  

> **Note:** The return value does not indicate whether they accepted the invite, rather only if the message was sent to and received by the RPC server without a reported error.

**Parameters:**  
- **Url:** The URL that represents an address the RPC server is currently bound to (e.g., `http://127.0.0.1:6463/rpc?v=1`).  
- **InviteCode:** A valid Discord server invite code.
