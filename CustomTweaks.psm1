##########
# Win 10 / Server 2016 / Server 2019 Initial Setup Script - Custom Tweak library
# Author: Daniel Berntsson <dberntsson.dev@gmail.com>
# Version: v0.1.0, 2020-09-05
# Source: https://github.com/daniel-berntsson/Win10-Initial-Setup-Script
##########

function SetExecutionPolicy {
    Write-Output "Setting Powershell Execution Policy to RemoteSigned for current user..."
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
}

function SetScoopEnvVars {
    Write-Output "Setting environment variables for Scoop installation..."

    # SCOOP
    $env:SCOOP='C:\Scoop'
    [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
    Write-Output "Scoop apps will now install to "$env:SCOOP"."

    #SCOOP_GLOBAL
    $env:SCOOP_GLOBAL='C:\Applications'
    [Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
    Write-Output "Globally installed Scoop apps will now install to "$env:SCOOP_GLOBAL"."
}

function InstallScoop {
    Write-Output "Installing Scoop..."
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')    
}

function InstallScoopDeps {
    Write-Output "Installing vital apps..."
    scoop install git innounp 7zip aria2 sudo
}

function AddScoopBuckets {
    Write-Output "Vital apps installed, adding buckets..."
    scoop bucket add extras 'https://github.com/lukesampson/scoop-extras.git'
    scoop bucket add Ash258 'https://github.com/Ash258/Scoop-Ash258.git'
    scoop bucket add scoop-nerd-fonts 'https://github.com/matthewjberger/scoop-nerd-fonts.git'
    scoop bucket add spotify 'https://github.com/TheRandomLabs/Scoop-Spotify.git'
}

function InstallCommonApps {
    Write-Output "Buckets added, installing common apps..."
    scoop install discord element ffmpeg firefox hexchat notion pwsh qbittorrent quicklook steam syncthing vlc vscode windows-terminal youtube-dl
}

function InstallNerdFonts {
    Write-Output "Common apps installed, installing fonts"
    sudo scoop install cascadia-code FiraCode Open-Sans
}

function InstallSpotify {
    Write-Output "Fonts installed, installing Spotify..."
    scoop install spotify-latest
    scoop install blockthespot
    scoop install spicetify-cli
    scoop install google-spicetify

    Write-Output "Spotify installed, configuring..."
    spicetify config current_theme google-spicetify
    spicetify config color_scheme Spotify
    spicetify-enable-devtool

    spicetify-apply
    Write-Output "Success! All apps installed."
}