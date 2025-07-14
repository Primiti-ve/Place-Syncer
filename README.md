# Place Syncer
A utility tool that combines two Roblox places into one.

This tool supports both file paths and place IDs! As long as place.rbxlx is the same as the place with the ID 1233, `lune run src/Sync Output 2 1233 1234` and `lune run src/Sync Output 2 place.rbxlx 1234` work the same!

This tool also supports **Service Overrides**. Add an attribute named "Service" to the folder you want to override and make the attribute's value into the service's name. It also supports nested services, such as StarterPlayer.StarterPlayerScripts, as long as they are wrote as "StarterPlayer|StarterPlayerScripts"!

## Instructions
1. If you haven't already, [install](https://lune-org.github.io/docs/getting-started/1-installation) the [Lune runtime](https://github.com/lune-org/lune) before reading the next steps.
2. Create a folder named "Files" in the same directory as Module.luau.
3. Open the Place-Syncer folder in a terminal of your choice.
4. Have fun!
5. [OPTIONAL] You can extract the Module, Maps and Remodel files for your own personal use!