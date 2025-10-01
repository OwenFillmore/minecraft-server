# Minecraft Server Management

This repository contains scripts to manage and update the Minecraft server.

## Server Service
The Minecraft server is set up as a Windows service named "MinecraftServer" for automatic startup and reliability.

### Managing the Service
- **Start**: `nssm start MinecraftServer`
- **Stop**: `nssm stop MinecraftServer`
- **Restart**: `nssm restart MinecraftServer`
- **Status**: `Get-Service MinecraftServer` (PowerShell)

The service automatically restarts if the server crashes.

## Updating the Server

To update Paper, Geyser, Floodgate, and ViaVersion to the latest versions, run the PowerShell script:

```powershell
.\update-server.ps1
```

This will download the latest jars and replace the old ones. Restart the service after updating:

```powershell
nssm restart MinecraftServer
```

## Starting the Server Manually

If needed, navigate to `C:\MinecraftServer\ActiveMinecraftServer` and run `start.bat`.

## Domain

The server is accessible at owenfillmore.com (assuming port forwarding is set up for port 25565).