# This file is licensed under th GNU LGPL v3 license.
# See the LICENSE file in the project root for more information.

# Name: CreateReleaseFile.ps1
# Version: 1.1
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
[String]$SrcDir="\Release\compiled"
[String]$ReleaseDir="\Release\zip"
[String]$OutFileName="$($ReleaseName)_v$($ReleaseVersion).zip"
[String[]]$CompressFiles = @(
    "$($RepoDir)$($SrcDir)\*",
    "$($RepoDir)\LICENSE.md"
)
[String]$HashFile="$($RepoDir)$($ReleaseDir)\$($OutFileName).sha256"


# Create Zip
if (-Not (Test-Path -Path "$($RepoDir)$($SrcDir)" -ErrorAction SilentlyContinue)) {
    Write-Error "Source path not available."
    Break
}

if (-Not (Test-Path -Path "$($RepoDir)$($ReleaseDir)" -ErrorAction SilentlyContinue)) {
    Write-Host "Creating release dir..."
    New-Item -Path "$($RepoDir)$($ReleaseDir)" -Type Directory | Out-Null
}

if (Test-Path -Path "$($RepoDir)$($ReleaseDir)\$($OutFileName)" -ErrorAction SilentlyContinue) {
    Write-Error "Release-File already existing."
    Break
}

Write-Host "Creating zip file..."
Compress-Archive -Path $CompressFiles -DestinationPath "$($RepoDir)$($ReleaseDir)\$($OutFileName)"


# Calc. Hash
if (-Not $NoHashCalculation) {
    Write-Host "Calculating hash..."
    [String]$hash = (Get-FileHash -Path "$($RepoDir)$($ReleaseDir)\$($OutFileName)" -Algorithm SHA256).Hash
    "$hash *$OutFileName" | Out-File -FilePath $HashFile -Append
}
