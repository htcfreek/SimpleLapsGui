# This file is licensed under th GNU LGPL v3 license.
# See the LICENSE file in the project root for more information.

# Name: CreateReleaseFile.ps1
# Version: 1.3 for SimpleLapsGui-Repo
# Description: Script to create the release file.
# Author: htcfreek (Heiko) - https://github.com/htcfreek
# Parameter: [String]$ReleaseName, [String]$ReleaseVersion, [[Switch]$NoHashCalculation=$False]



# Parameter
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)][String]$ReleaseName,
    [Parameter(Mandatory=$true)][String]$ReleaseVersion,
    [Parameter(Mandatory=$false)][Switch]$NoHashCalculation=$false
)


# Settings
[String]$RepoDir=Resolve-Path -LiteralPath "..\"
[String]$ReleaseDir="\Release\zip"

[String[]]$CompressFiles1 = @(
    "$($RepoDir)\src\SimpleLapsGui.ps1",
	"$($RepoDir)\src\Start_SimpleLapsGui.bat",
	"$($env:temp)\SimpleLapsGui.ico",
    "$($RepoDir)\LICENSE.md"
)
[String]$OutFileName1="$($ReleaseName)_v$($ReleaseVersion)_Exe.zip"
[String]$HashFile1="$($RepoDir)$($ReleaseDir)\$($OutFileName1).sha256"

# Create Zip
Copy-Item "$($RepoDir)\src\appIcon.ico" "$($env:temp)\SimpleLapsGui.ico" -Force
if (-Not (Test-Path -Path "$($RepoDir)$($ReleaseDir)" -ErrorAction SilentlyContinue)) {
    Write-Host "Creating release dir..."
    New-Item -Path "$($RepoDir)$($ReleaseDir)" -Type Directory | Out-Null
}

if (Test-Path -Path "$($RepoDir)$($ReleaseDir)\$($OutFileName1)" -ErrorAction SilentlyContinue) {
    Write-Error "Release-File 1 already existing."
    Break
}

Write-Host "Creating zip file..."
Compress-Archive -Path $CompressFiles1 -DestinationPath "$($RepoDir)$($ReleaseDir)\$($OutFileName1)"


# Calc. Hash
if (-Not $NoHashCalculation) {
    Write-Host "Calculating hash 1..."
    [String]$hash = (Get-FileHash -Path "$($RepoDir)$($ReleaseDir)\$($OutFileName1)" -Algorithm SHA256).Hash
    "$hash *$OutFileName" | Out-File -FilePath $HashFile1 -Append
}
