# This file is licensed under th MIT license.
# See the LICENSE file in the project root for more information.

# Name: CreateReleaseFile.ps1
# Version: 2.0 for SimpleLapsGui-Repo
# Description: Script to create the release file.
# Author: htcfreek (Heiko) - https://github.com/htcfreek
# Parameter: [Version]$ReleaseVersion, [[Switch]$NoHashCalculation=$False], [[Switch]$NoSetupBuild=$False]



# Parameter
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)][string]$ReleaseVersion,
    [Parameter(Mandatory=$false)][Switch]$NoHashCalculation=$false,
    [Parameter(Mandatory=$false)][Switch]$NoSetupBuild=$false
)

# Validate and convert version parameter
if ($ReleaseVersion -match '^\d{1,2}\.\d{1,2}(\.\d{1,2}){0,1}$') {
    $AppVersion = $ReleaseVersion
}
else {
    Write-Error "Version must be in the following format: d{1,2}.d{1,2}[.d{1,2}]"
    Exit
}


# Settings
[String]$RepoDir = Resolve-Path -LiteralPath "..\"
[String]$ReleaseDir = "\Release"
[string]$AppName = "Simple LAPS GUI"

[string]$CheckSumAlgo="SHA256"

[string]$FileNameAdmxZip = "Administrative Templates_$($AppName)_v$($AppVersion).zip"
[string]$FileNameAppZip = "$($AppName)_v$($AppVersion).zip"
[string]$FileNameSetup = "$($AppName)_v$($AppVersion)"
[string]$FileNameSetupWithExt = "$($AppName)_v$($AppVersion).exe"
[string]$FileNameReleaseTemplate = "ReleaseTextTemplate.txt"


# Clean up release dir
if (Test-Path -Path "$($RepoDir)\$($ReleaseDir)" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue) {
    Remove-Item -Path "$($RepoDir)\$($ReleaseDir)" -Recurse -Force
}
New-Item -Path $RepoDir -Name $ReleaseDir -ItemType Directory -Force | Out-Null


# Read release template
$releaseText = Get-Content -Path $FileNameReleaseTemplate
$releaseText = $releaseText.Replace("<RAppVersion>",$AppVersion)
$releaseText = $releaseText.Replace("<TAppVersion>",$AppVersion)


# Create ADMX Zip
Write-Host "Create ADMX Zip file..."
[String[]]$AdmxZipFiles = @(
    "$($RepoDir)\src\policy\Simple_LAPS_GUI.admx",
    "$($RepoDir)\src\policy\en-us"
)
Compress-Archive -Path $AdmxZipFiles -DestinationPath "$($RepoDir)$($ReleaseDir)\$($FileNameAdmxZip)"
if (-Not $NoHashCalculation) {
    Write-Host "Calculating hash for ADMX zip file..."
    [String]$hash = (Get-FileHash -Path "$($RepoDir)$($ReleaseDir)\$($FileNameAdmxZip)" -Algorithm $CheckSumAlgo).Hash
    "$hash *$FileNameAdmxZip" | Out-File -FilePath "$($RepoDir)$($ReleaseDir)\$($FileNameAdmxZip).$($CheckSumAlgo)"
    $releaseText = $releaseText.Replace("<ADMXZipName>",$FileNameAdmxZip).Replace("<ADMXZipHash>","sha256:$($hash.ToLower())")
}


# Create App Zip
Write-Host "Create App Zip file..."
[String[]]$AppZipFiles = @(
    "$($RepoDir)\src\SimpleLapsGui.ps1",
	"$($RepoDir)\src\Start_SimpleLapsGui.bat",
	"$($RepoDir)\src\Start_PS7_SimpleLapsGui.bat",
	"$($env:temp)\SimpleLapsGui.ico",
    "$($RepoDir)\LICENSE.txt"
)
Copy-Item "$($RepoDir)\src\images\appIcon.ico" "$($env:temp)\SimpleLapsGui.ico" -Force
Compress-Archive -Path $AppZipFiles -DestinationPath "$($RepoDir)$($ReleaseDir)\$($FileNameAppZip)"
if (-Not $NoHashCalculation) {
    Write-Host "Calculating hash for App zip file..."
    [String]$hash = (Get-FileHash -Path "$($RepoDir)$($ReleaseDir)\$($FileNameAppZip)" -Algorithm $CheckSumAlgo).Hash
    "$hash *$FileNameAppZip" | Out-File -FilePath "$($RepoDir)$($ReleaseDir)\$($FileNameAppZip).$($CheckSumAlgo)"
    $releaseText = $releaseText.Replace("<AppZipName>",$FileNameAppZip).Replace("<AppZipHash>","sha256:$($hash.ToLower())")
}


if (-Not $NoSetupBuild) {
    # Create Setup
    Write-Host "Compile setup ..."
    & 'C:\Program Files\Inno Setup 7\ISCC.exe' "-f""$($FileNameSetup)""" "-dMyAppVersion=$($AppVersion)" """$($RepoDir)\src\setup\Setup.iss"""
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Build setup failed!!"
		Exit
    }
    if (-Not $NoHashCalculation) {
        Write-Host "Calculating hash for setup file..."
        [String]$hash = (Get-FileHash -Path "$($RepoDir)$($ReleaseDir)\$($FileNameSetupWithExt)" -Algorithm $CheckSumAlgo).Hash
        "$hash *$FileNameSetupWithExt" | Out-File -FilePath "$($RepoDir)$($ReleaseDir)\$($FileNameSetupWithExt).$($CheckSumAlgo)"
        $releaseText = $releaseText.Replace("<SetupFileName>",$FileNameSetupWithExt).Replace("<SetupFileHash>","sha256:$($hash.ToLower())")
    }
}


# Create release text
Write-Host "Create release text..."
Out-File -FilePath "$($RepoDir)$($ReleaseDir)\$($FileNameReleaseTemplate)" -InputObject $releaseText