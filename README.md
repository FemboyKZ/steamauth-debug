# SteamAuth Debug

Simple SM plugin that prints Steam Auth status on different client join stages.

## Exmaple

```bash
[SteamAuth][OnClientConnected] "jupi" - SteamAuth is INVALID (not yet authenticated).
[SteamAuth][OnClientAuthorized] "jupi" - SteamAuth is VALID. (SteamID: STEAM_1:0:154151695)
[SteamAuth][OnClientPutInServer] "jupi" - SteamAuth is VALID. (Steam: STEAM_1:0:154151695 | Steam64: 76561198268569118)
[SteamAuth][OnClientPostAdminCheck] "jupi" - SteamAuth is VALID. (Steam: STEAM_1:0:154151695 | Steam64: 76561198268569118)
```
