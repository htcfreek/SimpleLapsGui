#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\images\appIcon.ico
#AutoIt3Wrapper_Outfile_x64=..\Release\SimpleLapsGui.exe
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Simple gui script for LAPS.
#AutoIt3Wrapper_Res_Fileversion=1.1
#AutoIt3Wrapper_Res_ProductName=Simple LAPS GUI
#AutoIt3Wrapper_Res_ProductVersion=1.1
#AutoIt3Wrapper_Res_CompanyName=htcfreek (Heiko Horwedel)
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author: htcfreek

 Script Function:
	Executable wrapper around the PowerShell-Script SimpleLapsGui.ps1

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <File.au3>


$tName =  _TempFile ("","","_SimpleLapsGui.ps1")
FileInstall(".\SimpleLapsGui.ps1", $tName)
RunWait('powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -STA -File "' & $tName & '"', @SystemDir, @SW_HIDE)
FileDelete($tName)