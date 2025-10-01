# Minecraft Server Update Script
# This script downloads the latest versions of Paper, Geyser, Floodgate, and ViaVersion
# and updates the server.

param(
    [string]$ServerPath = "C:\MinecraftServer\ActiveMinecraftServer"
)

Write-Host "Updating Minecraft Server at $ServerPath"

# Function to get latest Paper version
function Get-LatestPaper {
    $versions = Invoke-RestMethod -Uri "https://api.papermc.io/v2/projects/paper/versions" -Method Get
    $latestVersion = $versions.versions | Sort-Object -Descending | Select-Object -First 1
    $builds = Invoke-RestMethod -Uri "https://api.papermc.io/v2/projects/paper/versions/$latestVersion/builds" -Method Get
    $latestBuild = $builds.builds | Sort-Object build -Descending | Select-Object -First 1
    return @{
        Version = $latestVersion
        Build = $latestBuild.build
    }
}

# Get latest Paper
$paper = Get-LatestPaper
$paperUrl = "https://api.papermc.io/v2/projects/paper/versions/$($paper.Version)/builds/$($paper.Build)/downloads/paper-$($paper.Version)-$($paper.Build).jar"
Write-Host "Downloading Paper $paperUrl"
Invoke-WebRequest -Uri $paperUrl -OutFile "$ServerPath\paper-new.jar"

# Download Geyser
$geyserUrl = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
Write-Host "Downloading Geyser $geyserUrl"
Invoke-WebRequest -Uri $geyserUrl -OutFile "$ServerPath\plugins\Geyser-Spigot-new.jar"

# Download Floodgate
$floodgateUrl = "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
Write-Host "Downloading Floodgate $floodgateUrl"
Invoke-WebRequest -Uri $floodgateUrl -OutFile "$ServerPath\plugins\floodgate-spigot-new.jar"

# Download ViaVersion
$viaVersionUrl = "https://github.com/ViaVersion/ViaVersion/releases/latest/download/ViaVersion.jar"
Write-Host "Downloading ViaVersion $viaVersionUrl"
Invoke-WebRequest -Uri $viaVersionUrl -OutFile "$ServerPath\plugins\ViaVersion-new.jar"

# Backup and replace
Write-Host "Backing up old jars"
Move-Item "$ServerPath\paper.jar" "$ServerPath\paper-old.jar" -Force
Move-Item "$ServerPath\paper-new.jar" "$ServerPath\paper.jar"

Move-Item "$ServerPath\plugins\Geyser-Spigot.jar" "$ServerPath\plugins\Geyser-Spigot-old.jar" -Force
Move-Item "$ServerPath\plugins\Geyser-Spigot-new.jar" "$ServerPath\plugins\Geyser-Spigot.jar"

Move-Item "$ServerPath\plugins\floodgate-spigot.jar" "$ServerPath\plugins\floodgate-spigot-old.jar" -Force
Move-Item "$ServerPath\plugins\floodgate-spigot-new.jar" "$ServerPath\plugins\floodgate-spigot.jar"

# For ViaVersion, find the current one
$viaOld = Get-ChildItem "$ServerPath\plugins" -Filter "ViaVersion-*.jar" | Where-Object { $_.Name -notlike "*-old.jar" -and $_.Name -notlike "*-new.jar" }
if ($viaOld) {
    Move-Item $viaOld.FullName "$ServerPath\plugins\ViaVersion-old.jar" -Force
}
Move-Item "$ServerPath\plugins\ViaVersion-new.jar" "$ServerPath\plugins\ViaVersion.jar"

Write-Host "Update complete. Restart the server to apply changes."