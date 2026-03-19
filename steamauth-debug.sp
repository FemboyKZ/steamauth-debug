#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
    name        = "Steam Auth Debug",
    author      = "jvnipers",
    description = "Prints whether SteamAuth is valid on all client join stages",
    version     = "1.0.4",
    url         = "https://github.com/FemboyKZ/steamauth-debug"
};

public void OnPluginStart()
{
    PrintToServer("[SteamAuth] Plugin loaded successfully.");
}

// --- 1. OnClientConnected (earliest, no Steam data yet) ---
public void OnClientConnected(int client)
{
    if (IsFakeClient(client))
        return;

    char name[MAX_NAME_LENGTH];
    GetClientName(client, name, sizeof(name));

    char auth[64];
    bool isSteamAuthed = GetClientAuthId(client, AuthId_Steam2, auth, sizeof(auth));

    if (isSteamAuthed && auth[0] != '\0')
    {
        PrintToServer("[SteamAuth][OnClientConnected] \"%s\" - SteamAuth is VALID. (SteamID: %s)", name, auth);
    }
    else
    {
        PrintToServer("[SteamAuth][OnClientConnected] \"%s\" - SteamAuth is INVALID (not yet authenticated).", name);
    }
}

// --- 2. OnClientAuthorized (Steam has validated the client) ---
public void OnClientAuthorized(int client, const char[] auth)
{
    if (IsFakeClient(client))
        return;

    char name[MAX_NAME_LENGTH];
    GetClientName(client, name, sizeof(name));

    if (auth[0] != '\0' && !StrEqual(auth, "STEAM_ID_PENDING", false))
    {
        PrintToServer("[SteamAuth][OnClientAuthorized] \"%s\" - SteamAuth is VALID. (SteamID: %s)", name, auth);
        if (IsClientInGame(client)) {
            PrintToChat(client, "\x04[SteamAuth]\x01 OnClientAuthorized: Steam authentication is \x04valid\x01. (%s)", auth);
        }
    }
    else
    {
        PrintToServer("[SteamAuth][OnClientAuthorized] \"%s\" - SteamAuth is INVALID.", name);
        if (IsClientInGame(client)) {
            PrintToChat(client, "\x04[SteamAuth]\x01 OnClientAuthorized: Steam authentication is \x02invalid\x01.");
        }
    }
}

// --- 3. OnClientPutInServer (client entity is now in the game) ---
public void OnClientPutInServer(int client)
{
    if (IsFakeClient(client))
        return;

    char name[MAX_NAME_LENGTH];
    char auth[64];
    char steam64[32];

    GetClientName(client, name, sizeof(name));
    bool isSteamAuthed = GetClientAuthId(client, AuthId_Steam2, auth, sizeof(auth));
    GetClientAuthId(client, AuthId_SteamID64, steam64, sizeof(steam64));

    if (isSteamAuthed && auth[0] != '\0')
    {
        PrintToServer("[SteamAuth][OnClientPutInServer] \"%s\" - SteamAuth is VALID. (Steam: %s | Steam64: %s)", name, auth, steam64);
        if (IsClientInGame(client)) {
            PrintToChat(client, "\x04[SteamAuth]\x01 OnClientPutInServer: Steam authentication is \x04valid\x01. (%s)", auth);
        }
    }
    else
    {
        PrintToServer("[SteamAuth][OnClientPutInServer] \"%s\" - SteamAuth is INVALID.", name);
        if (IsClientInGame(client)) {
            PrintToChat(client, "\x04[SteamAuth]\x01 OnClientPutInServer: Steam authentication is \x02invalid\x01.");
        }
    }
}

// --- 4. OnClientPostAdminCheck (admin check complete, fully joined) ---
public void OnClientPostAdminCheck(int client)
{
    if (IsFakeClient(client))
        return;

    char name[MAX_NAME_LENGTH];
    char auth[64];
    char steam64[32];

    GetClientName(client, name, sizeof(name));
    bool isSteamAuthed = GetClientAuthId(client, AuthId_Steam2, auth, sizeof(auth));
    GetClientAuthId(client, AuthId_SteamID64, steam64, sizeof(steam64));

    if (isSteamAuthed && auth[0] != '\0')
    {
        PrintToServer("[SteamAuth][OnClientPostAdminCheck] \"%s\" - SteamAuth is VALID. (Steam: %s | Steam64: %s)", name, auth, steam64);
        if (IsClientInGame(client)) {
            PrintToChat(client, "\x04[SteamAuth]\x01 OnClientPostAdminCheck: Steam authentication is \x04valid\x01. (%s)", auth);
        }
    }
    else
    {
        PrintToServer("[SteamAuth][OnClientPostAdminCheck] \"%s\" - SteamAuth is INVALID.", name);
        if (IsClientInGame(client)) {
            PrintToChat(client, "\x04[SteamAuth]\x01 OnClientPostAdminCheck: Steam authentication is \x02invalid\x01.");
        }
    }
}
