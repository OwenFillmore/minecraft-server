# Minecraft Server Management

This repository contains scripts to manage and update the Minecraft server.

## Updating the Server

To update Paper, Geyser, Floodgate, and ViaVersion to the latest versions, run the PowerShell script:

```powershell
.\update-server.ps1
```

This will download the latest jars and replace the old ones. Restart the server after updating.

## Starting the Server

Navigate to `C:\MinecraftServer\ActiveMinecraftServer` and run `start.bat`.

## Domain

The server is accessible at owenfillmore.com (assuming port forwarding is set up for port 25565).